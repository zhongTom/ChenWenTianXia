//
//  LiveListViewController.m
//  TRProject
//
//  Created by 钟至大 on 16/8/23.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "LiveListViewController.h"
#import "LiveListViewModel.h"
#import "LiveCell.h"
#import "LiveRoomViewController.h"
@interface LiveListViewController ()
@property (nonatomic) LiveListViewModel *liveListVM;
@end

@implementation LiveListViewController
#pragma mark - 生命周期 Life Circle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"背景"]];
    [self.tableView registerNib:[UINib nibWithNibName:@"LiveCell" bundle:nil] forCellReuseIdentifier:@"LiveCell"];
    [self.liveListVM getLiveListCompletionHandler:^(NSError *error) {
        if (!error) {
            [self.tableView reloadData];
        }
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.liveListVM.rowNumber;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LiveCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LiveCell" forIndexPath:indexPath];
    cell.title.text = [self.liveListVM getTitleForRow:indexPath.row];
    [cell.iconIV setImageWithURL:[self.liveListVM getURLForRow:indexPath.row]];
    cell.userCount.text = [self.liveListVM getTimeForRow:indexPath.row];
    cell.liveState.text = [self.liveListVM getLiveStateForRow:indexPath.row];
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 200;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    LiveCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    LiveRoomViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"LiveRoomViewController"];
    vc.topImage = cell.iconIV.image;
    vc.skipId = [self.liveListVM getSkipIDForRow:indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - 懒加载 Lazy Load

- (LiveListViewModel *)liveListVM {
	if(_liveListVM == nil) {
		_liveListVM = [[LiveListViewModel alloc] initWithSpecialID:self.specialID];
	}
	return _liveListVM;
}

@end
