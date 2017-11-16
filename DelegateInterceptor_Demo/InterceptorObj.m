//
//  InterceptorObj.m
//  DelegateInterceptor_Demo
//
//  Created by YLCHUN on 16/8/11.
//  Copyright © 2016年 ylchun. All rights reserved.
//

#import "InterceptorObj.h"
#import <UIKit/UIKit.h>
@implementation InterceptorObj

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height;
    if ([self originalRespondsToSelector:_cmd]) {
        height = [self.original tableView:tableView heightForRowAtIndexPath:indexPath];
        if (indexPath.row %2 == 0) {
            height += height;
        }
    }else{
        height = 44;
    }
    return height;
}

//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return 10;
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [self.original tableView:tableView cellForRowAtIndexPath:indexPath];
    if (indexPath.row%2 == 1) {
        cell.backgroundColor = [UIColor redColor];
    }
    return cell;
}

- (void)textViewDidChange:(UITextView *)textView{
    NSLog(@"textViewDidChange_in_InterceptorObj");
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    NSLog(@"rturn_NO");
    return NO;
}

@end

@implementation InterceptorObj2

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height;
    if ([self originalRespondsToSelector:_cmd]) {
        height = [self.original tableView:tableView heightForRowAtIndexPath:indexPath];
        if (indexPath.row %2 == 0) {
            height += height;
        }
    }else{
        height = 44;
    }
    return height;
}

//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return 10;
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [self.original tableView:tableView cellForRowAtIndexPath:indexPath];
    if (indexPath.row%2 == 1) {
        cell.backgroundColor = [UIColor greenColor];
    }
    return cell;
}

//- (void)textViewDidChange:(UITextView *)textView{
//    NSLog(@"textViewDidChange_in_InterceptorObj");
//}
//
//- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
//    NSLog(@"rturn_NO");
//    return NO;
//}

@end
