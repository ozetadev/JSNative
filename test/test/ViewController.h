//
//  ViewController.h
//  test
//
//  Created by Philip Bernstein on 5/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSRenderingEngine.h"
#import "NSWatchDog.h"

@interface ViewController : UIViewController <UIWebViewDelegate>
{
    bool loaded;
}
@property (nonatomic, retain) UIWebView *webKit;
@property (nonatomic, retain) NSRenderingEngine *renderingEngine;
-(void)handleMethod:(NSDictionary *)method;
@end
