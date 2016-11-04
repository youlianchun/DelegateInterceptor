//
//  DelegateDistribute.h
//  DelegateInterceptor_Demo
//
//  Created by YLCHUN on 16/11/4.
//  Copyright © 2016年 ylchun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DelegateDistribute : NSObject

/**
 *  代理源数组，按下标依次分发，有返回值取最后一个
 */
@property (nonatomic, readwrite) NSArray *receivers;

@end
