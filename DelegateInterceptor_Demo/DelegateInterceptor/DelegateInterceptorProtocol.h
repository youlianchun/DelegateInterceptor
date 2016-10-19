//
//  NSObject+DelegateInterceptorProtocol.h
//  DelegateInterceptor
//
//  Created by YLCHUN on 16/8/11.
//  Copyright © 2016年 ylchun. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol DelegateInterceptorProtocol <NSObject>
@optional
/**
 *  代理源
 */
@property (nonatomic, readwrite, weak) id receiver;

@end


