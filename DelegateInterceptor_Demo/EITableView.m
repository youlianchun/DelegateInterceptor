//
//  EITableView.m
//  DelegateInterceptor_Demo
//
//  Created by YLCHUN on 16/8/4.
//  Copyright © 2016年 ylchun. All rights reserved.
//

#import "EITableView.h"
#import "DelegateInterceptor.h"
@interface  EITableView()
@property(nonatomic)DelegateInterceptor<id<UITableViewDataSource>> *delegateInterceptor;
@end

@implementation EITableView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)setDataSource:(id<UITableViewDataSource>)dataSource{
    if (!self.delegateInterceptor) {
        self.delegateInterceptor=[[DelegateInterceptor alloc]init];
    }
    self.delegateInterceptor.receiver=dataSource;
    self.delegateInterceptor.middleMan=self;
    [super setDataSource:self.delegateInterceptor.mySelf];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.delegateInterceptor.receiver tableView:tableView numberOfRowsInSection:section];
}

@end
