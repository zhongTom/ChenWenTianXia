//
//  SaveViewController.m
//  TRProject
//
//  Created by 钟至大 on 16/8/23.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "SaveViewController.h"
#import "DetailModel.h"
#import "DetailViewController.h"
#import "TRTabBarController.h"
@import AVFoundation;
@import AVKit;

@interface SaveViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) NSMutableArray<DetailModel *> *model;
@property (nonatomic) AVPlayerViewController *playerVC;
@end

@implementation SaveViewController
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
#pragma mark - 方法 Methods
- (void)backVC{
    id navi = [TRTabBarController defaultTabBar];
    [self.sideMenuViewController setContentViewController:navi animated:YES];
}
- (void)playerWithURL:(NSURL *)url{
    self.playerVC.player = [AVPlayer playerWithURL:url];
    [self presentViewController:self.playerVC animated:YES completion:nil];
    [self.playerVC.player play];
}
- (IBAction)clean:(id)sender {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [UIAlertView bk_showAlertViewWithTitle:@"确定要清除收藏夹吗？" message:nil cancelButtonTitle:@"取消" otherButtonTitles:@[@"确定"] handler:^(UIAlertView *alertView, NSInteger buttonIndex) {
        if (buttonIndex == 1) {
            [userDefaults removeObjectForKey:@"likeNews"];
            [userDefaults removeObjectForKey:@"likeCar"];
            [userDefaults removeObjectForKey:@"likeTV"];
            [userDefaults removeObjectForKey:@"likeRadio"];
            [_tableView reloadData];
            if ([userDefaults objectForKey:@"likeNews"] == nil) {
                [self setHUDWithTitle:@"清除成功！"];
            }

        }
        
    }];
    
}
//添加到收藏
- (void)addToUserDefault:(NSMutableArray *)modelArr key:(NSString *)key{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:modelArr];
    [userDefaults setObject:data forKey:key];
    [userDefaults synchronize];
}
- (NSMutableArray <DetailModel *> *)queryWithKey:(NSString *)key{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [userDefaults objectForKey:key];
    return [NSKeyedUnarchiver unarchiveObjectWithData:data];
}
#pragma mark - UITableView Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return [self queryWithKey:@"likeNews"].count;
            break;
        case 1:
            return [self queryWithKey:@"likeTV"].count;
            break;
        case 2:
            return [self queryWithKey:@"likeRadio"].count;
            break;
        default:
            return 0;
            break;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SaveCell"];
    switch (indexPath.section) {
        case 0:{
            cell.textLabel.text = [self queryWithKey:@"likeNews"][indexPath.row].title;
            break;
        }
        case 1:{
            cell.textLabel.text = [self queryWithKey:@"likeTV"][indexPath.row].title;
            break;
        }
        case 2:{
            cell.textLabel.text = [self queryWithKey:@"likeRadio"][indexPath.row].title;
            break;
        }
    }
    cell.contentView.backgroundColor = [UIColor clearColor];
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        DetailViewController *vc = [[DetailViewController alloc]initWithURL:[self queryWithKey:@"likeNews"][indexPath.row].url];
        if ([self queryWithKey:@"likeNews"][indexPath.row].url==nil) {
            NSString *s = [self queryWithKey:@"likeNews"][indexPath.row].contentText;
            vc.contentText = s;
        }
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.section == 1){
        [self playerWithURL:[self queryWithKey:@"likeTV"][indexPath.row].url];
    }else if (indexPath.section == 2){
        
        [self playerWithURL:[self queryWithKey:@"likeRadio"][indexPath.row].url];
    }
    
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSMutableArray *list = [NSMutableArray new];
        switch (indexPath.section) {
            case 0:{
                list = [self queryWithKey:@"likeNews"];
                [list removeObjectAtIndex:indexPath.row];
                [self addToUserDefault:list key:@"likeNews"];
                break;
            }
            case 1:{
                list = [self queryWithKey:@"likeTV"];
                [list removeObjectAtIndex:indexPath.row];
                [self addToUserDefault:list key:@"likeTV"];
                break;
            }
            case 2:{
                list = [self queryWithKey:@"likeRadio"];
                [list removeObjectAtIndex:indexPath.row];
                [self addToUserDefault:list key:@"likeRadio"];
                break;
            }
                
            default:
                break;
        }
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationBottom];

    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return @"新闻";
            break;
        case 1:
            return @"视频";
            break;
        case 2:
            return @"电台";
            break;
        default:
            return 0;
            break;
    }
    
}
#pragma mark - Like Delegate
- (NSMutableArray<DetailModel *> *)model {
    if(_model == nil) {
        _model = [[NSMutableArray<DetailModel *> alloc] init];
    }
    return _model;
}

- (AVPlayerViewController *)playerVC {
    if(_playerVC == nil) {
        _playerVC = [[AVPlayerViewController alloc] init];
    }
    return _playerVC;
}

@end
