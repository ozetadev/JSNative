//
//  NSWatchDog.h
//  test
//
//  Created by Philip Bernstein on 5/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSWatchDog : NSObject <UIWebViewDelegate>
{
    bool loaded;
}
@property (nonatomic, retain) NSMutableDictionary *selectors;
@property (nonatomic, retain) UIWebView *webKit;
@property (nonatomic, retain) NSMutableDictionary *objects;
-(void)setSelector:(NSString *)method forObject:(id)object;
-(id)initWithWebKit:(UIWebView *)web;
-(void)performAction:(NSString *)action;
-(void)setObject:(id)object forKey:(id)aKey info:(NSDictionary *)info;
@end
