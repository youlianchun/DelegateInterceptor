//
//  ViewController.m
//  DelegateInterceptor_Demo
//
//  Created by YLCHUN on 16/8/4.
//  Copyright © 2016年 ylchun. All rights reserved.
//

#import "ViewController.h"
#import "DelegateInterceptor.h"
#import "InterceptorObj.h"

@interface ViewController ()<UITextViewDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)InterceptorObj*obj;

@property (nonatomic, strong)InterceptorObj2*obj2;

@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.obj = [[InterceptorObj alloc] initWithOriginal:self];
    
    
    self.obj2 = [[InterceptorObj2 alloc] init];
    
    self.textView.delegate = (id<UITextViewDelegate>)self.obj;
    
    self.tableView.dataSource = (id<UITableViewDataSource>)self.obj;
    self.tableView.delegate = self.obj.mySelf;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [[UITableViewCell alloc]init];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    NSLog(@"rturn_YES");
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView{
    NSLog(@"textViewDidChange_in_ViewController");
}

@end
