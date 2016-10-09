//
//  PageViewController.m
//  Project
//
//  Created by 钟至大 on 16/8/5.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "PageViewController.h"
#import "ViewController.h"
@interface PageViewController ()
@property (nonatomic) UIImageView *titleView;
@end

@implementation PageViewController

#pragma mark - WMPageViewController Delegate

- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController{
    return self.titles.count;
}
- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index{
    ViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ViewController"];
    vc.newsType = index;
    return vc;
}
- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index{
    return self.titles[index];
}
#pragma mark - 生命周期 Life Circle

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        self.menuHeight = 40;
        self.menuItemWidth = 60;
        self.menuViewStyle = WMMenuViewStyleLine;
        self.menuBGColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"背景"]];
        
    }
    return self;
}
- (NSArray<NSString *> *)titles{
    return @[@"头条",@"国际",@"社会",@"科技",@"体育",@"美女",@"笑话",@"军事",@"财经",@"汽车",@"游戏",@"娱乐",@"段子"];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    UIBarButtonItem *item = [[UIBarButtonItem alloc]
    bk_initWithBarButtonSystemItem:UIBarButtonSystemItemBookmarks handler:^(id sender) {
        [self.sideMenuViewController presentLeftMenuViewController];

    }];
    self.navigationItem.leftBarButtonItem = item;
    
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
