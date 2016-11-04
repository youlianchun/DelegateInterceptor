//
//  ViewController.m
//  DelegateInterceptor_Demo
//
//  Created by YLCHUN on 16/8/4.
//  Copyright © 2016年 ylchun. All rights reserved.
//

#import "ViewController.h"
#import "DelegateInterceptor.h"
#import "DelegateDistribute.h"
#import "InterceptorObj.h"
@interface ViewController ()<UITextViewDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic)InterceptorObj*obj;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic)DelegateInterceptor* textViewDelegateInterceptor;
@property(nonatomic)DelegateDistribute* textViewDelegateDistribute;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.obj=[[InterceptorObj alloc]init];
    self.obj.receiver=self;
    
    
    self.textViewDelegateInterceptor =[[DelegateInterceptor alloc]init];;
    self.textViewDelegateInterceptor.middleMan=self.obj;
    self.textViewDelegateInterceptor.receiver=self;
//    self.textView.delegate=(id<UITextViewDelegate>)self.textViewDelegateInterceptor;
    
    self.textViewDelegateDistribute = [[DelegateDistribute alloc]init];
    self.textViewDelegateDistribute.receivers = @[self,self.obj];
    self.textView.delegate=(id<UITextViewDelegate>)self.textViewDelegateDistribute;

//    self.textView.delegate=self;
    
    self.tableView.dataSource=(id<UITableViewDataSource>)self.obj;
//    self.tableView.dataSource=self;
    self.tableView.delegate=self;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"return 40");
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [[UITableViewCell alloc]init];
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    NSLog(@"rturn_true");
    return true;
}
- (void)textViewDidChange:(UITextView *)textView{
    NSLog(@"textViewDidChange_in_ViewController");
}
@end
