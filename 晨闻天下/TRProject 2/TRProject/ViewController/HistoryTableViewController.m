//
//  HistoryTableViewController.m
//  TRProject
//
//  Created by 钟至大 on 16/8/20.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "HistoryTableViewController.h"
#import "DetailModel.h"
#import "PageViewController.h"
#import "AppDelegate.h"
#import "TRTabBarController.h"
#import "DetailViewController.h"
#import "NewsViewModel.h"
#import "InfoLisViewModel.h"
@import AVFoundation;
@import AVKit;
@interface HistoryTableViewController ()
@property (nonatomic) NewsViewModel *newsVM;
@property (nonatomic) InfoLisViewModel *infoVM;
@property (nonatomic) AVPlayerViewController *playerVC;
@end

@implementation HistoryTableViewController
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

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return [self queryWithType:0].count;
    }else if (section == 1){
        return [self queryWithType:1].count;
    }else if (section == 2){
        return [self queryWithType:2].count;
    }else{
        return [self queryWithType:3].count;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.textLabel.text = [self queryWithType:indexPath.section][indexPath.row].title;
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        DetailViewController *vc = [[DetailViewController alloc]initWithURL:[self queryWithType:0][indexPath.row].url];
        if ([self queryWithType:0][indexPath.row].url==nil) {
            NSString *s = [self queryWithType:0][indexPath.row].contentText;
            vc.contentText = s;
        }
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.section == 1){
        DetailViewController *vc = [[DetailViewController alloc]initWithURL:[self queryWithType:1][indexPath.row].url];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.section == 2){
        [self playerWithURL:[self queryWithType:2][indexPath.row].url];
    }else if(indexPath.section == 3){
        [self playerWithURL:[self queryWithType:2][indexPath.row].url];
    }
    
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return @"新闻";
    }else if (section == 1){
        return @"汽车";
    }else if (section == 2){
        return @"视频";
    }else{
        return @"电台";
    }
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (UITableViewCellEditingStyleDelete == editingStyle) {
        NSMutableArray *list = [NSMutableArray new];
        switch (indexPath.section) {
            case 0:{
                list = [self queryWithType:0];
                [list removeObjectAtIndex:indexPath.row];
                [self addDataWithObj:list withType:0];
                break;
            }
            case 1:{
                list = [self queryWithType:1];
                [list removeObjectAtIndex:indexPath.row];
                [self addDataWithObj:list withType:1];
                break;
            }
            case 2:{
                list = [self queryWithType:2];
                [list removeObjectAtIndex:indexPath.row];
                [self addDataWithObj:list withType:2];
                break;
            }
            case 3:{
                list = [self queryWithType:3];
                [list removeObjectAtIndex:indexPath.row];
                [self addDataWithObj:list withType:3];
                break;
            }
                
            default:
                break;
        }
    }
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationBottom];
}
#pragma mark - 方法 Methods
- (NSMutableArray<DetailModel *> *)queryWithType:(NSInteger)type{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    switch (type) {
        case 0:{
            NSData *data = [userDefaults objectForKey:@"news"];
            NSMutableArray *arr = [NSKeyedUnarchiver unarchiveObjectWithData:data];
            return arr;
        }
        case 1:{
            NSData *data = [userDefaults objectForKey:@"car"];
            return [NSKeyedUnarchiver unarchiveObjectWithData:data];
        }
        case 2:{
            NSData *data = [userDefaults objectForKey:@"tv"];
            return [NSKeyedUnarchiver unarchiveObjectWithData:data];
        }
        case 3:{
            NSData *data = [userDefaults objectForKey:@"radio"];
            return [NSKeyedUnarchiver unarchiveObjectWithData:data];
            
        }
        default:
            return nil;
    }
}
- (void)addDataWithObj:(NSMutableArray *)model withType:(NSInteger)type{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:model];
    switch (type) {
        case 0:{
            [userDefaults setObject:data forKey:@"news"];
            [userDefaults synchronize];
            break;
        }
        case 1:{
            [userDefaults setObject:data forKey:@"car"];
            [userDefaults synchronize];
            break;
        }
        case 2:{
            [userDefaults setObject:data forKey:@"tv"];
            [userDefaults synchronize];
            break;
        }
        case 3:{
            [userDefaults setObject:data forKey:@"radio"];
            [userDefaults synchronize];
            break;
        }
        default:
            break;
    }
}

- (IBAction)clean:(id)sender {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [UIAlertView bk_showAlertViewWithTitle:@"确定要清除历史记录吗？" message:nil cancelButtonTitle:@"取消" otherButtonTitles:@[@"确定"] handler:^(UIAlertView *alertView, NSInteger buttonIndex) {
        if (buttonIndex == 1) {
            [userDefaults removeObjectForKey:@"news"];
            [userDefaults removeObjectForKey:@"car"];
            [userDefaults removeObjectForKey:@"tv"];
            [userDefaults removeObjectForKey:@"radio"];
            [self.tableView reloadData];
            if ([userDefaults objectForKey:@"likeNews"] == nil) {
                [self setHUDWithTitle:@"清除成功！"];
            }
        }
        
        
    }];
}

- (void)playerWithURL:(NSURL *)url{
    self.playerVC.player = [AVPlayer playerWithURL:url];
    [self presentViewController:self.playerVC animated:YES completion:nil];
    [self.playerVC.player play];
}
- (AVPlayerViewController *)playerVC {
    if(_playerVC == nil) {
        _playerVC = [[AVPlayerViewController alloc] init];
    }
    return _playerVC;
}

@end
