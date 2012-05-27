//
//  NSRenderingEngine.h
//  test
//
//  Created by Philip Bernstein on 5/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSButton.h"
#import "NSWatchDog.h"

typedef enum {
    JSHeader,
    JSView,
    JSScroller,
    JSWebView,
    JSViewController,
    JSToolBar,
    JSImageView,
    JSImage,
    JSButtonItem,
    JSBarButtonItem,
    JSNull = -1
} ObjectType;

@interface NSRenderingEngine : NSObject
{
    
}

@property (nonatomic, retain) UIWebView *webKit;
@property (nonatomic, retain) NSWatchDog *watchDog;
-(id)initWithWebKit:(UIWebView *)web;

// HELPER METHODS
-(void)render:(NSArray *)view intoContext:(UIView *)context;
-(ObjectType)determineType:(NSDictionary *)object;
-(CGRect)frameWithArray:(NSArray *)frame;
-(CGSize)sizeWithArray:(NSArray *)size;
-(UIColor *)colorFromString:(NSString *)color;

// OBJECT RENDERING
-(UINavigationBar *)renderHeader:(NSDictionary *)header;
-(UIScrollView *)renderScrollView:(NSDictionary *)scrollView;
-(UIButton *)renderButton:(NSDictionary *)button;
-(UIWebView *)renderWebView:(NSDictionary *)web;
-(UIViewController *)createViewController:(NSDictionary *)controller;
-(UIView *)renderView:(NSDictionary *)view;
-(UIBarButtonItem *)renderBarButtonItem:(NSDictionary *)button;

@end
