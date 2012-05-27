//
//  NSRenderingEngine.m
//  test
//
//  Created by Philip Bernstein on 5/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NSRenderingEngine.h"

@implementation NSRenderingEngine
@synthesize watchDog, webKit;

-(id)initWithWebKit:(UIWebView *)web
{
    self = [super init];
    
    if (self)
    {
        self.webKit = web;
        self.watchDog = [[NSWatchDog alloc] initWithWebKit:self.webKit];
    }
    
    return self;
}
-(void)render:(NSArray *)view intoContext:(UIView *)context
{
    for (NSDictionary *object in view)
    {
        ObjectType type = [self determineType:object];
        UIView *toRender;
        
        if (type == JSHeader)
            toRender = [self renderHeader:object];
        else if (type == JSScroller)
            toRender = [self renderScrollView:object];
        else if (type == JSButtonItem)
            toRender = [self renderButton:object];
        else if (type == JSWebView)
            toRender = [self renderWebView:object];
        
        [context addSubview:toRender];
    }
}
-(ObjectType)determineType:(NSDictionary *)object
{
    NSString *type = [object objectForKey:@"kind"];
    if (!type)
        return JSView;
    if ([[type uppercaseString] isEqualToString:@"HEADER"])
        return JSHeader;
    if ([[type uppercaseString] isEqualToString:@"VIEW"])
        return JSView;
    if ([[type uppercaseString] isEqualToString:@"SCROLLVIEW"])
        return JSScroller;
    if ([[type uppercaseString] isEqualToString:@"WEBVIEW"])
        return JSWebView;
    if ([[type uppercaseString] isEqualToString:@"VIEWCONTROLLER"])
        return JSViewController;
    if ([[type uppercaseString] isEqualToString:@"TOOLBAR"])
        return JSToolBar;
    if ([[type uppercaseString] isEqualToString:@"IMAGEVIEW"])
        return JSImageView;
    if ([[type uppercaseString] isEqualToString:@"IMAGE"])
        return JSImage;
    if ([[type uppercaseString] isEqualToString:@"BUTTON"])
        return JSButtonItem;
    
    return JSView;
}
-(UINavigationBar *)renderHeader:(NSDictionary *)header
{
    UINavigationBar *navigationBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    UINavigationItem *item = [[UINavigationItem alloc] init];
    [navigationBar pushNavigationItem:item animated:NO];
    if ([header objectForKey:@"frame"])
    {
        NSArray *frame = [header objectForKey:@"frame"];
        navigationBar.frame = [self frameWithArray:frame];
    }
    if ([header objectForKey:@"name"])
        [watchDog setObject:navigationBar forKey:[header objectForKey:@"name"] info:header];
    if ([header objectForKey:@"tint"])
    {
        navigationBar.tintColor = [self colorFromString:[header objectForKey:@"tint"]];
    }
    if ([header objectForKey:@"title"])
        navigationBar.topItem.title = [header objectForKey:@"title"];
    if ([header objectForKey:@"components"])
        [self render:[header objectForKey:@"components"] intoContext:navigationBar];
    if ([header objectForKey:@"rightBarButtonItem"])
        navigationBar.topItem.rightBarButtonItem = [self renderBarButtonItem:[header objectForKey:@"rightBarButtonItem"]];
    if ([header objectForKey:@"leftBarButtonItem"])
        navigationBar.topItem.leftBarButtonItem = [self renderBarButtonItem:[header objectForKey:@"leftBarButtonItem"]];
    
    return navigationBar;
}
-(UIScrollView *)renderScrollView:(NSDictionary *)scrollView
{
    UIScrollView *scroller = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    if ([scrollView objectForKey:@"name"])
        [watchDog setObject:scroller forKey:[scrollView objectForKey:@"name"] info:scrollView];
    if ([scrollView objectForKey:@"frame"])
        scroller.frame = [self frameWithArray:[scrollView objectForKey:@"frame"]];
    if ([scrollView objectForKey:@"contentSize"])
        scroller.contentSize = [self sizeWithArray:[scrollView objectForKey:@"contentSize"]];
    if ([scrollView objectForKey:@"components"])
        [self render:[scrollView objectForKey:@"components"] intoContext:scroller];
    
    return scroller;
}
-(JSButton *)renderButton:(NSDictionary *)button
{
    JSButton *tempButton = [JSButton buttonWithType:UIButtonTypeRoundedRect];
    [tempButton addTarget:watchDog action:@selector(performAction:) forControlEvents:UIControlEventTouchUpInside];
    if ([button objectForKey:@"name"])
        [watchDog setObject:tempButton forKey:[button objectForKey:@"name"] info:button];
    if ([button objectForKey:@"frame"])
        tempButton.frame = [self frameWithArray:[button objectForKey:@"frame"]];
    if ([button objectForKey:@"title"])
        [tempButton setTitle:[button objectForKey:@"title"] forState:UIControlStateNormal];
    if ([button objectForKey:@"textColor"])
        tempButton.titleLabel.textColor = [self colorFromString:[button objectForKey:@"textColor"]];
    if ([button objectForKey:@"onclick"])
    {
        [watchDog setSelector:[button objectForKey:@"onclick"] forObject:tempButton];
    }
    if ([button objectForKey:@"components"])
        [self render:[button objectForKey:@"components"] intoContext:tempButton];
    
    return tempButton;
}
-(CGRect)frameWithArray:(NSArray *)frame;
{
    int x = 0, y = 0, w = 0, h = 0;
    x = [[frame objectAtIndex:0] intValue];
    y = [[frame objectAtIndex:1] intValue];
    w = [[frame objectAtIndex:2] intValue];
    h = [[frame objectAtIndex:3] intValue];
    return CGRectMake(x, y, w, h);
}
-(UIColor *)colorFromString:(NSString *)color
{
    SEL colorMethod = NSSelectorFromString([color stringByAppendingString:@"Color"]);
    UIColor *tempColor = nil;
    if ([UIColor respondsToSelector: colorMethod])
        tempColor  = [UIColor performSelector:colorMethod];
    else
        tempColor = [UIColor clearColor];

    return tempColor;
}
-(CGSize)sizeWithArray:(NSArray *)size
{
    int w = 0, h = 0;
    w = [[size objectAtIndex:0] intValue];
    h = [[size objectAtIndex:1] intValue];
    
    return CGSizeMake(w, h);
}
-(UIWebView *)renderWebView:(NSDictionary *)web
{
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    webView.delegate = self.watchDog;
    if ([web objectForKey:@"frame"])
        webView.frame = [self frameWithArray:[web objectForKey:@"frame"]];
    if ([web objectForKey:@"name"])
        [watchDog setObject:webView forKey:[web objectForKey:@"name"] info:web];
    if ([web objectForKey:@"location"])
    {
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[web objectForKey:@"location"]]];
        [webView loadRequest:request];
    }
    
    
    return webView;
}
-(UIView *)renderView:(NSDictionary *)view
{
    UIView *tempView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    if ([view objectForKey:@"frame"])
        tempView.frame = [self frameWithArray:[view objectForKey:@"frame"]];
    if ([view objectForKey:@"name"])
        [watchDog setObject:tempView forKey:[view objectForKey:@"name"] info:view];
    if ([view objectForKey:@"backgroundColor"])
        tempView.backgroundColor = [self colorFromString:[view objectForKey:@"backgroundColor"]];
    if ([view objectForKey:@"components"])
        [self render:[view objectForKey:@"components"] intoContext:tempView];
    return tempView;
}
-(UIBarButtonItem *)renderBarButtonItem:(NSDictionary *)button
{
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] init];
    if ([button objectForKey:@"title"])
        barButton.title = [button objectForKey:@"title"];
    if ([button objectForKey:@"name"])
        [self.watchDog setObject:barButton forKey:[button objectForKey:@"name"] info:button];
    if ([button objectForKey:@"onclick"])
    {
        [self.watchDog setSelector:[button objectForKey:@"onclick"] forObject:barButton];
        [barButton setAction:@selector(performAction:)];
        [barButton setTarget:self.watchDog];
    }
    
    return barButton;
}
-(UIViewController *)createViewController:(NSDictionary *)controller
{
    UIViewController *viewController = [[UIViewController alloc] init];
    if ([controller objectForKey:@"name"])
        [self.watchDog setObject:viewController forKey:[controller objectForKey:@"name"] info:controller];
    NSDictionary *view = [controller objectForKey:@"view"];
    viewController.view = [self renderView:view];
    return viewController;
}
@end
