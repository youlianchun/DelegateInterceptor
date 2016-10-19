//
//  DelegateInterceptor.h
//  DelegateInterceptor
//
//  Created by YLCHUN on 16/8/4.
//  Copyright © 2016年 ylchun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DelegateInterceptor<DelegateType> : NSObject
/**
 *  代理源
 */
@property (nonatomic, readwrite, weak) DelegateType receiver;
/**
 *  代理中介
 */
@property (nonatomic, readwrite, weak) id middleMan;

@property (nonatomic, readonly) DelegateType mySelf;

@end
