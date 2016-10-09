//
//  CleanCrashViewController.m
//  TRProject
//
//  Created by 钟至大 on 16/8/24.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "CleanCrashViewController.h"
#import "TRTabBarController.h"

@interface CleanCrashViewController ()

@end

@implementation CleanCrashViewController
#pragma mark - 方法 Methods

//清除缓存
- (IBAction)cleanCrash:(id)sender {
    [UIAlertView bk_showAlertViewWithTitle:@"确定要清除缓存数据吗？" message:nil cancelButtonTitle:@"取消" otherButtonTitles:@[@"确定"] handler:^(UIAlertView *alertView, NSInteger buttonIndex) {
        if (buttonIndex == 1) {
            NSArray *arr = [[NSFileManager defaultManager] subpathsAtPath:kDocPath];
            NSError *error = nil;
            for (NSString *path  in arr) {
                [[NSFileManager defaultManager]removeItemAtPath:[kDocPath stringByAppendingPathComponent:path] error:&error];
            }
            arr = [[NSFileManager defaultManager] subpathsAtPath:kDocPath];
            if (arr.count == 0) {
                [self setHUDWithTitle:@"清除成功！"];
            }
        }
    }];
}
- (void)backVC{
    id navi = [TRTabBarController defaultTabBar];
    [self.sideMenuViewController setContentViewController:navi animated:YES];
}
#pragma mark - 生命周期 Life Circle


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"背景"]];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"Back@2xpng"] forState:UIControlStateNormal];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = item;
    button.frame = CGRectMake(0, 0, 15, 25);
    [button addTarget:self action:@selector(backVC) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

@end
