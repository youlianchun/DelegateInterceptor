//
//  BaseDelegateInterceptor.m
//  DelegateInterceptor_Demo
//
//  Created by YLCHUN on 2016/10/28.
//  Copyright © 2016年 ylchun. All rights reserved.
//

#import "BaseDelegateInterceptor.h"


@implementation BaseDelegateInterceptor


- (id)forwardingTargetForSelector:(SEL)aSelector {
    if ([super respondsToSelector:aSelector]) {
        return self;
    }
    if (self.receiver && [self.receiver respondsToSelector:aSelector]) {
        return self.receiver;
    }
    return nil;
}

- (BOOL)respondsToSelector:(SEL)aSelector {
    NSString*selName=NSStringFromSelector(aSelector);
    if (![selName hasPrefix:@"keyboardInput"] ) {//键盘输入代理过滤
        if ([super respondsToSelector:aSelector]) {
            return YES;
        }
        if (self.receiver && [self.receiver respondsToSelector:aSelector]) {
            return YES;
        }
    }
    return false;
}

@end
