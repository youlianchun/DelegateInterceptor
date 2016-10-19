//
//  NSObject+DelegateInterceptorProtocol.m
//  DelegateInterceptor
//
//  Created by YLCHUN on 16/8/11.
//  Copyright © 2016年 ylchun. All rights reserved.
//

#import "DelegateInterceptorProtocol.h"
#import <objc/runtime.h>

@interface NSObject (DelegateInterceptorProtocol)

@property (nonatomic, readwrite, weak) id receiver;

@end

@implementation NSObject (DelegateInterceptorProtocol)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [NSObject class];
        
        SEL originalSelector = @selector(respondsToSelector:);
        SEL swizzledSelector = @selector(DI_respondsToSelector:);
        
        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        
        BOOL success = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
                if (success) {
                    class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
                } else {
                    method_exchangeImplementations(originalMethod, swizzledMethod);
                }
        
        originalSelector = @selector(forwardingTargetForSelector:);
        swizzledSelector = @selector(DI_forwardingTargetForSelector:);
        originalMethod = class_getInstanceMethod(class, originalSelector);
        swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        
        success = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
        if (success) {
            class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    });
}

- (BOOL) DI_respondsToSelector:(SEL)aSelector {
    if ([[self class] conformsToProtocol:@protocol(DelegateInterceptorProtocol)]){
        
        NSString*aSelectorName=NSStringFromSelector(aSelector);
        BOOL bS=false;
        BOOL bR=false;
        if (![aSelectorName hasPrefix:@"keyboardInput"] ) {//键盘输入代理过滤

            bS = [self DI_respondsToSelector:aSelector];
            
            bR = [self.receiver respondsToSelector:aSelector];

        }
        return bS||bR;
        
    }else{
        
        return [self DI_respondsToSelector:aSelector];
        
    }
}

/**
 *  转发目标选择器
 *
 *  @param aSelector 被响应选择器
 *
 *  @return 用来响应选择器的类
 */
- (id) DI_forwardingTargetForSelector:(SEL)aSelector {
    if ([[self class] conformsToProtocol:@protocol(DelegateInterceptorProtocol)]){
        
        if ([self DI_respondsToSelector:aSelector])
            return [self DI_forwardingTargetForSelector:aSelector];
        
        if ([self.receiver respondsToSelector:aSelector])
            return self.receiver;
            
        return nil;
        
    }else{
        
        return [self DI_forwardingTargetForSelector:aSelector];
        
    }
}


-(id)receiver{
    return objc_getAssociatedObject(self, _cmd);
}

-(void)setReceiver:(id)receiver{
    objc_setAssociatedObject(self, @selector(receiver), receiver, OBJC_ASSOCIATION_RETAIN);
}

@end
