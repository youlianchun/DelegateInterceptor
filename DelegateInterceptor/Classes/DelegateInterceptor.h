//
//  DelegateInterceptor.h
//  DelegateInterceptor
//
//  Created by YLCHUN on 16/8/4.
//  Copyright © 2016年 ylchun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DelegateInterceptor<DelegateType> : NSObject

@property (nonatomic, readonly) DelegateType mySelf;

/**
 代理源
 */
@property (nonatomic, readonly, weak) id original;

/**
 拦截者
 */
@property (nonatomic, readonly, weak) id accepter;

- (instancetype) initWithOriginal:(DelegateType)original accepter:(id)accepter;

- (instancetype) initWithOriginal:(DelegateType)original;

- (bool) originalRespondsToSelector:(SEL)aSelector;

- (bool) accepterRespondsToSelector:(SEL)aSelector;

@end
