//
//  InterceptorObj.m
//  DelegateInterceptor_Demo
//
//  Created by YLCHUN on 16/8/11.
//  Copyright © 2016年 ylchun. All rights reserved.
//

#import "InterceptorObj.h"

@implementation InterceptorObj

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"return 10");
//    return [self.receiver tableView:tableView numberOfRowsInSection:section];
    return 10;
}


- (void)textViewDidChange:(UITextView *)textView{
    NSLog(@"textViewDidChange_in_InterceptorObj");
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    NSLog(@"rturn_false");
    return false;
}

@end
