//
//  ViewController.m
//  test
//
//  Created by Philip Bernstein on 5/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize webKit, renderingEngine;
- (void)viewDidLoad
{
    [super viewDidLoad];
    loaded = false;
    webKit = [[UIWebView alloc] init];
    webKit.delegate = self;
    renderingEngine = [[NSRenderingEngine alloc] initWithWebKit:webKit];
	// Do any additional setup after loading the view, typically from a nib.
    NSError *viewError;
       
    NSString *html = @"<html><head><script type=\"text/javascript\">";
    NSString *include = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] 
                                                       pathForResource:@"include" ofType:@"js"] encoding:NSUTF8StringEncoding error:&viewError];
    html = [html stringByAppendingString:include];
    html = [html stringByAppendingString:@"</script><script type=\"text/javascript\">"];
    NSString *js = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] 
                                                       pathForResource:@"default" ofType:@"js"] encoding:NSUTF8StringEncoding error:&viewError];
    html = [html stringByAppendingString:js];
    html = [html stringByAppendingString:@"</script></head><body></body></html>"];
    NSLog(@"HTML: %@", html);
    [webKit loadHTMLString:html baseURL:[NSURL URLWithString:@"http://jsiphone.com"]];
      

    
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    if ([request.URL.absoluteString rangeOfString:@"http://"].location != NSNotFound)
        return YES;

    NSLog(@"METHOD CALL");
    NSString *requestString = [request.URL.absoluteString stringByReplacingOccurrencesOfString:@"appkit://?" withString:@""];
    
    NSArray *objectsAndKeys = [requestString componentsSeparatedByString:@"&"];
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    for (NSString *both in objectsAndKeys)
    {
        NSArray *param = [both componentsSeparatedByString:@"="];
        [parameters setObject:[param objectAtIndex:1] forKey:[param objectAtIndex:0]];
    }
    NSLog(@"%@", parameters);
    [self handleMethod:parameters];
    return NO;
}
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
   if (!loaded)
   {
       NSError *viewError;
       NSData *defaultView = [[NSString stringWithContentsOfFile:[[NSBundle mainBundle] 
                                                                  pathForResource:@"default" ofType:@"json"] encoding:NSUTF8StringEncoding error:&viewError] dataUsingEncoding:NSUTF8StringEncoding];
       NSArray *interfaceArray = [NSJSONSerialization JSONObjectWithData:defaultView options:0 error:&viewError];
       
       if (!viewError)
           [renderingEngine render:interfaceArray intoContext:self.view];

   }
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}
-(void)handleMethod:(NSDictionary *)method
{
    NSString *request = [method objectForKey:@"method"];
    NSString *parameters = [method objectForKey:@"parameters"];
    parameters = [parameters stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSDictionary *array = [NSJSONSerialization JSONObjectWithData:[parameters dataUsingEncoding:NSUTF8StringEncoding] options:0 error:nil];
    NSLog(@"%@", array);
    
    if ([request isEqualToString:@"render"])
    {
        
        UIView *context = self.view;
        
        if ([array objectForKey:@"context"])
        {
            NSString *object = [array objectForKey:@"context"];
            if ([self.renderingEngine.watchDog.objects objectForKey:object])
            {
                context = [self.renderingEngine.watchDog.objects objectForKey:object];
            }
        }
         
        NSArray *toRender = [NSArray arrayWithObject:array];
        [renderingEngine render:toRender intoContext:context];

    }
    else if ([request isEqualToString:@"alert"])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[array objectForKey:@"title"] message:[array objectForKey:@"message"] delegate:nil cancelButtonTitle:[array objectForKey:@"button"] otherButtonTitles: nil];
        [alert show];
    }
    else if ([request isEqualToString:@"present"])
    {
        UIViewController *viewController = [renderingEngine createViewController:array];
        [self presentModalViewController:viewController animated:[[array objectForKey:@"animated"] intValue]];
    }
    else if ([request isEqualToString:@"dismiss"])
    {
        [self dismissModalViewControllerAnimated:true];
    }

    
}

@end
