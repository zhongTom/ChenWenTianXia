//
//  TVPageViewController.m
//  TRProject
//
//  Created by 钟至大 on 16/8/14.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "TVPageViewController.h"
#import "TVViewController.h"
@interface TVPageViewController ()

@end

@implementation TVPageViewController
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        self.menuHeight = 40;
        self.menuItemWidth = 60;
        self.menuViewStyle = WMMenuViewStyleLine;
        self.menuBGColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"背景"]];
    }
    return self;
}
- (NSArray *)titles{
    return @[@"美女",@"段子",@"历史",@"社会",@"军事",@"生活"];
}
#pragma mark - WMPageViewController Delegate
- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController{
    return self.titles.count;
}
- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index{
    TVViewController *TVVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"TVViewController"];
    TVVC.type = index+1;
    return TVVC;
    
}
- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index{
    return self.titles[index];
}
#pragma mark - 生命周期 Life Circle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
