//
//  RegisterViewController.m
//  TRProject
//
//  Created by 钟至大 on 16/8/24.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "RegisterViewController.h"
#import <BmobSDK/Bmob.h>
#import "NSObject+HUD.h"
#import "TRTabBarController.h"
#import "LeftMenuViewController.h"
@interface RegisterViewController ()<UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *secret;
@property (weak, nonatomic) IBOutlet UITextField *e_Mail;
@property (weak, nonatomic) IBOutlet UITextField *tel;
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (nonatomic) BOOL isLogin;
@property (weak, nonatomic) IBOutlet UITextField *loginUser;
@property (weak, nonatomic) IBOutlet UITextField *loginSecret;

@end

@implementation RegisterViewController
#pragma mark - 方法 Methods
//注册
- (IBAction)register:(id)sender {
    BmobUser *user = [BmobUser new];
    [user setUsername:self.userName.text];
    [user setPassword:self.secret.text];
    [user setEmail:self.e_Mail.text];
    [user setObject:self.name.text forKey:@"name"];
    [user setMobilePhoneNumber:self.tel.text];
    [user signUpInBackgroundWithBlock:^(BOOL isSuccessful, NSError *error) {
        if(isSuccessful){
            [self setHUDWithTitle:@"注册成功！"];
            id navi = [TRTabBarController defaultTabBar];
            [self.sideMenuViewController setContentViewController:navi animated:YES];
        }else{
            NSLog(@"%@",error);
        }
    }];
}
//登录
- (IBAction)login:(id)sender {
    [BmobUser loginWithUsernameInBackground:self.loginUser.text password:self.loginSecret.text block:^(BmobUser *user, NSError *error) {
        if (user) {
            [self setHUDWithTitle:@"登录成功！"];
            self.isLogin = YES;
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            [userDefaults setObject:@(self.isLogin) forKey:@"login"];

            id navi = [TRTabBarController defaultTabBar];
            [self.sideMenuViewController setContentViewController:navi animated:YES];
            LeftMenuViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"LeftMenuViewController"];
            [self.sideMenuViewController setLeftMenuViewController:vc];
            
        }else{
            [self setHUDWithTitle:@"该用户不存在，请重新登录！"];
        }
    }];
}
//忘记密码
- (IBAction)forgetPassword:(id)sender {
   UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"请输入验证邮箱" message:@"收到邮件后请到邮箱重置密码" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
    UITextField *tf = [alertView textFieldAtIndex:0];
    tf.placeholder = @"请输入邮箱";
    [alertView show];
}

- (void)backVC{
    id navi = [TRTabBarController defaultTabBar];
    [self.sideMenuViewController setContentViewController:navi animated:YES];
}
#pragma mark - UIAlertView Delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    [BmobUser requestPasswordResetInBackgroundWithEmail:[alertView textFieldAtIndex:0].text block:^(BOOL isSuccessful, NSError *error) {
        if (isSuccessful) {
            [self setHUDWithTitle:@"发送成功"];
        }else{
            [self setHUDWithTitle:@"发送失败，邮箱格式错误"];
        }
    }];
}
#pragma mark - 生命周期 Life Circle


- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"Back@2xpng"] forState:UIControlStateNormal];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = item;
    button.frame = CGRectMake(0, 0, 15, 25);
    [button addTarget:self action:@selector(backVC) forControlEvents:UIControlEventTouchUpInside];

    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"背景"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
