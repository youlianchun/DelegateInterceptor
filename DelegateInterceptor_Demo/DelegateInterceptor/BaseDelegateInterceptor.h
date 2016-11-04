//
//  BaseDelegateInterceptor.h
//  DelegateInterceptor_Demo
//
//  Created by YLCHUN on 2016/10/28.
//  Copyright © 2016年 ylchun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseDelegateInterceptor<DelegateType> : NSObject
/**
 *  代理源
 */
@property (nonatomic, readwrite, weak) DelegateType receiver;


@end
