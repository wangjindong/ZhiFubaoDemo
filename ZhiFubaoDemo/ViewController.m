//
//  ViewController.m
//  ZhiFubaoDemo
//
//  Created by 王金东 on 2017/7/19.
//  Copyright © 2017年 王金东. All rights reserved.
//

#import "ViewController.h"
#import "ZhiFuBaoScrollView.h"
#import "UIScrollBView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    ZhiFuBaoScrollView *s = [[ZhiFuBaoScrollView alloc] init];
    s.backgroundColor = [UIColor redColor];
    s.contentSize = CGSizeMake(self.view.frame.size.width, 2000);
    s.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:s];
    
    NSArray *constraints1 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[s]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(s)];
    NSArray *constraints2=[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[s]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(s)];
    [self.view addConstraints:constraints1];
    [self.view addConstraints:constraints2];
    
    
    s.headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 300)];
    s.headView.backgroundColor = [UIColor whiteColor];
    
    s.contentView = [[UIScrollBView alloc] init];
    s.contentView.backgroundColor = [UIColor yellowColor];
    
    
    UIView *v = [[UIView alloc ]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 10000)];
    v.backgroundColor = [UIColor brownColor];
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    [btn setTitle:@"测试点击" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [v addSubview:btn];
    
    [s.contentView addSubview:v];
    s.contentView.contentSize = CGSizeMake(v.frame.size.width, v.frame.size.height);
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)btnClick:(id)sender{
    NSLog(@"test");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
