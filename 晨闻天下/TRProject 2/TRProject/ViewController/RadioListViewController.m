//
//  RadioListViewController.m
//  TRProject
//
//  Created by 钟至大 on 16/8/17.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "RadioListViewController.h"
#import "RadioListCell.h"
#import "RadioListViewModel.h"
#import "RadioPlayerListController.h"
@interface RadioListViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) RadioListViewModel *radiolistVM;
@end

@implementation RadioListViewController
#pragma mark - UITableView Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.radiolistVM.rowNumber;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RadioListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ListCell"];
    [cell.iconIV setImageWithURL:[self.radiolistVM getIconURLForRow:indexPath.row]];
    cell.title.text = [self.radiolistVM getTitleForRow:indexPath.row];
    cell.descrip.text = [self.radiolistVM getDescriptionForRow:indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    RadioPlayerListController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"RadioPlayerListController"];
    vc.resourceId = [self.radiolistVM getResourceId:indexPath.row];
    RadioListCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    vc.image = cell.iconIV.image;
    [self.navigationController pushViewController:vc animated:YES];

}


#pragma mark - 生命周期 Life Circle


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.vcTitle;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor =[UIColor colorWithPatternImage:[UIImage imageNamed:@"背景"]];
    self.tableView.backgroundColor = [UIColor clearColor];

    [_tableView registerNib:[UINib nibWithNibName:@"RadioListCell" bundle:nil] forCellReuseIdentifier:@"ListCell"];
    WK(weakSelf);
    [_tableView addHeaderRefresh:^{
        [weakSelf.radiolistVM getRadioListWithRequestMode:RequestModeRefresh CompletionHandler:^(NSError *error) {
            if (!error) {
                [_tableView reloadData];
            }
        }];
        [_tableView endHeaderRefresh];
    }];
    [_tableView addAutoFooterRefresh:^{
        [self.radiolistVM getRadioListWithRequestMode:RequestModeMore CompletionHandler:^(NSError *error) {
            if (!error) {
                [_tableView reloadData];
            }
        }];
        [_tableView endFooterRefresh];
    }];
    [_tableView beginHeaderRefresh];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - 懒加载 Lazy Load


- (RadioListViewModel *)radiolistVM {
	if(_radiolistVM == nil) {
		_radiolistVM = [[RadioListViewModel alloc] initWithNodeId:self.nodeId];
	}
	return _radiolistVM;
}

@end
