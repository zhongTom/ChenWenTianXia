//
//  InfoViewController.m
//  TRProject
//
//  Created by 钟至大 on 16/8/24.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "InfoViewController.h"
#import "ResetInfroViewController.h"
#import "TRTabBarController.h"
@interface InfoViewController ()

@end

@implementation InfoViewController
#pragma mark - 方法 Methods
- (void)backVC{
    id navi = [TRTabBarController defaultTabBar];
    [self.sideMenuViewController setContentViewController:navi animated:YES];
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
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 2){
        ResetInfroViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ResetInfroImage"];
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        ResetInfroViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ResetInfroViewController"];
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        vc.oldText = cell.textLabel.text;
        [self.navigationController pushViewController:vc animated:YES];
    }
}
@end
