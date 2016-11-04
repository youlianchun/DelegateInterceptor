//
//  DelegateInterceptor.m
//  DelegateInterceptor
//
//  Created by YLCHUN on 16/8/4.
//  Copyright © 2016年 ylchun. All rights reserved.
//

#import "DelegateInterceptor.h"

@implementation DelegateInterceptor

- (BOOL) respondsToSelector:(SEL)aSelector {
    
    NSString*aSelectorName=NSStringFromSelector(aSelector);
    
    if (![aSelectorName hasPrefix:@"keyboardInput"] ) {//键盘输入代理过滤
        
        if ([_middleMan respondsToSelector:aSelector])
            return YES;
        
        if ([_receiver respondsToSelector:aSelector])
            return YES;
    }
    
    return [super respondsToSelector:aSelector];
    
}

/**
 *  转发目标选择器
 *
 *  @param aSelector 被响应选择器
 *
 *  @return 用来响应选择器的类
 */
- (id) forwardingTargetForSelector:(SEL)aSelector {
    
    if ([_middleMan respondsToSelector:aSelector])
        return _middleMan;
    
    if ([_receiver respondsToSelector:aSelector])
        return _receiver;
    
    return	[super forwardingTargetForSelector:aSelector];
}

-(id)mySelf {
    return self;
}



@end
