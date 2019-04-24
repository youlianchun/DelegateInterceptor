//
//  DelegateDistribute.m
//  DelegateInterceptor_Demo
//
//  Created by YLCHUN on 16/11/4.
//  Copyright © 2016年 ylchun. All rights reserved.
//

#import "DelegateDistribute.h"

@implementation DelegateDistribute

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector{
    NSMethodSignature *signature = [super methodSignatureForSelector:aSelector];
    if (!signature) {
        for (id receiver in self.receivers) {
            signature = [receiver methodSignatureForSelector:aSelector];
            if (signature) {
                break;
            }
        }
    }
    return signature;
}

- (void)forwardInvocation:(NSInvocation *)anInvocation{
    for (id receiver in self.receivers) {
        if ([receiver respondsToSelector:anInvocation.selector]) {
            [anInvocation invokeWithTarget:receiver];
        }
    }
}

- (BOOL)respondsToSelector:(SEL)aSelector{
    if ([super respondsToSelector:aSelector]) {
        return true;
    }
    for (id receiver in self.receivers) {
        if ([receiver respondsToSelector:aSelector]) {
            return true;
        }
    }
    
    return false;
}

@end
