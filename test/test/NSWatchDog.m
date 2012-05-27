//
//  NSWatchDog.m
//  test
//
//  Created by Philip Bernstein on 5/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NSWatchDog.h"

@implementation NSWatchDog
@synthesize webKit, selectors, objects;
-(id)initWithWebKit:(UIWebView *)web
{
    self = [super init];
    
    if (self)
    {
        loaded = false;
        self.objects = [[NSMutableDictionary alloc] init];
        self.webKit = web;
        self.selectors = [[NSMutableDictionary alloc] init];
    }
    return self;
}
-(void)setObject:(id)object forKey:(id)aKey info:(NSDictionary *)info
{
    [self.objects setObject:object forKey:aKey];
    NSString *script = [NSString stringWithFormat:@"var %@ = new %@(); %@.name = \"%@\";", [info objectForKey:@"name"], [info objectForKey:@"kind"], [info objectForKey:@"name"], [info objectForKey:@"name"]];
    
    NSLog(@"%@", script);
    [webKit stringByEvaluatingJavaScriptFromString:script];
    
    if (!loaded)
    {
        loaded = YES;
        [webKit stringByEvaluatingJavaScriptFromString:@"viewLoaded();"];
    }
   
}
-(void)setSelector:(NSString *)method forObject:(id)object
{
    NSLog(@"SET SELECTOR");
    [selectors setObject:method forKey:[NSString stringWithFormat:@"%@", object]];
}
-(void)performAction:(id)object
{
    NSString *method = [selectors objectForKey:[NSString stringWithFormat:@"%@", object]];
    method = [NSString stringWithFormat:@"%@(\"%@\");", method,
              @""];
    NSLog(@"METHOD: %@", method);
    if (method)
        [webKit stringByEvaluatingJavaScriptFromString:method];
}

@end
