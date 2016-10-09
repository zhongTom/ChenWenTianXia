//
//  LiveViewController.m
//  TRProject
//
//  Created by 钟至大 on 16/8/20.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "LiveViewController.h"
#import "LiveViewModel.h"
#import "LiveCell.h"
#import "SpecialCell.h"
#import "LiveRoomViewController.h"
#import <MJRefreshFooter.h>
#import "LiveListViewController.h"
@interface LiveViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) LiveViewModel *LiveVM;
@end

@implementation LiveViewController
#pragma mark - 生命周期 Life Circle


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"背景"]];
    [_tableView registerNib:[UINib nibWithNibName:@"LiveCell" bundle:nil] forCellReuseIdentifier:@"LiveCell"];
    [_tableView registerNib:[UINib nibWithNibName:@"SpecialCell" bundle:nil] forCellReuseIdentifier:@"SpecialCell"];
    WK(weakSelf);
    [_tableView addHeaderRefresh:^{
        [weakSelf.LiveVM getLiveWithRequestMode:RequestModeRefresh completionHandler:^(NSError *error) {
            if (!error) {
                [weakSelf.tableView reloadData];
            }
            [_tableView endHeaderRefresh];
        }];
    }];
    [_tableView addAutoFooterRefresh:^{
        [weakSelf.LiveVM getLiveWithRequestMode:RequestModeMore completionHandler:^(NSError *error) {
            if (!error) {
                [weakSelf.tableView reloadData];
            }
            [_tableView.mj_footer endRefreshingWithNoMoreData];
        }];
    }];
    [_tableView beginHeaderRefresh];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.LiveVM.smallRowNumber+1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return self.LiveVM.bigRowNumber;
    }
    return 4;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        LiveCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LiveCell" forIndexPath:indexPath];
        cell.title.text = [self.LiveVM getTitleForIndexPath:indexPath];
        [cell.iconIV setImageWithURL:[self.LiveVM getURLsForIndexPath:indexPath]];
        cell.userCount.text = [self.LiveVM getUserCountForIndexPath:indexPath];
        cell.liveState.text = [self.LiveVM getLiveStateForIndexPath:indexPath];
        return cell;
    }else if (indexPath.row == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
        cell.textLabel.text = [self.LiveVM getSubTitleForIndexPath:indexPath];
        return cell;
    }else{
        SpecialCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SpecialCell"];
        cell.title.text = [self.LiveVM getTitleForIndexPath:indexPath];
        [cell.iconIV setImageWithURL:[self.LiveVM getURLsForIndexPath:indexPath]];
        cell.userCount.text = [self.LiveVM getUserCountForIndexPath:indexPath];
        cell.liveState.text = [self.LiveVM getLiveStateForIndexPath:indexPath];
        return cell;
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        
        return 200;
    }else if(indexPath.row == 0){
        return 44;
    }else{
        return 90;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 1;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    LiveRoomViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"LiveRoomViewController"];
    if (indexPath.section == 0) {
        vc.skipId = self.LiveVM.bigList[indexPath.row].skipID;
        LiveCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        vc.topImage = cell.iconIV.image;
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row !=0){
        vc.skipId = self.LiveVM.smallList[indexPath.section-1].specialextra[indexPath.row-1].skipID;
        SpecialCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        vc.topImage = cell.iconIV.image;
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        LiveListViewController *listVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"LiveListViewController"];
        listVC.specialID = [self.LiveVM getSpecialIDForSection:indexPath.section];
        [self.navigationController pushViewController:listVC animated:YES];
    }
    
    
    
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"LiveVM" object:self userInfo:@{@"title":[self.LiveVM getTitleForIndexPath:indexPath],@"url":[self.LiveVM ]}];
}
#pragma mark - 懒加载 Lazy Load


- (LiveViewModel *)LiveVM {
	if(_LiveVM == nil) {
		_LiveVM = [[LiveViewModel alloc] init];
	}
	return _LiveVM;
}

@end
