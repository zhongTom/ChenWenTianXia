//
//  RadioViewController.m
//  TRProject
//
//  Created by 钟至大 on 16/8/16.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "RadioViewController.h"
#import "RadioViewModel.h"
#import "RadioCell.h"
#import "iCarousel.h"
#import "RadioListViewController.h"
#import "RadioPlayerListController.h"
@interface RadioViewController ()<UITableViewDelegate,UITableViewDataSource,iCarouselDelegate,iCarouselDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) RadioViewModel *radioVM;
@property (nonatomic) iCarousel *ic;
@property (nonatomic) UILabel *topTitle;
@property (nonatomic) UIPageControl *page;
@end

@implementation RadioViewController
#pragma mark - iCarousel Delegate
- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel{
    return self.radioVM.icNumber;
}
- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view{
    if (view == nil) {
        view = [[UIImageView alloc]initWithFrame:carousel.frame];
        UIImageView *iconIV = [UIImageView new] ;
        [view addSubview:iconIV];
        [iconIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(0);
        }];
        iconIV.tag = 1000;
    }
    UIImageView *iconIV = [view viewWithTag:1000];
    [iconIV setImageWithURL:[self.radioVM getTopIconURLForRow:index]];
    self.topTitle.text = [self.radioVM getTopTitleForRow:index];
    return view;
}
- (CGFloat)carousel:(iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value{
    if (option == iCarouselOptionWrap) {
        return YES;
    }
    return value;
}
- (void)carouselCurrentItemIndexDidChange:(iCarousel *)carousel{
    _page.currentPage = _ic.currentItemIndex;
}
#pragma mark - UITableView Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.radioVM.sectionNumber;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"titleCell"];
        cell.textLabel.text = [self.radioVM getBigTitleForSection:indexPath.section];
   
        return cell;
    }else{
        RadioCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RadioCell"];
        int i = 0;
        for (NSURL *url in [self.radioVM getURLForSection:indexPath.section]) {
            [cell.iconIVs[i] setImageWithURL:url];
            i++;
        }
        int j = 0;
        for (NSString *title in [self.radioVM getSmallTitleForSection:indexPath.section]) {
            ((UILabel *)cell.smallTitles[j]).text = title;
            j++;
        }
        int k = 0;
        for (NSString *origin in [self.radioVM getOriginForSection:indexPath.section]) {
            ((UILabel *)cell.origins[k]).text = origin;
            k++;
        }
        return cell;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 30;
    }else{
        return 165;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        RadioListViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"RadioListViewController"];
        vc.nodeId = [self.radioVM getNodeIdForSection:indexPath.section];
        vc.vcTitle = [self.radioVM getBigTitleForSection:indexPath.section];
        [self.navigationController pushViewController:vc animated:YES];
        
    }else{
        RadioPlayerListController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"RadioPlayerListController"];
        
        RadioCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        vc.resourceId = [self.radioVM getIdForSection:indexPath.section][cell.pointNumber];
        vc.image = ((UIImageView *)(cell.iconIVs[cell.pointNumber])).image;
        [self.navigationController pushViewController:vc animated:YES];

    }
}
#pragma mark - 生命周期 Life Circle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.view.backgroundColor =[UIColor colorWithPatternImage:[UIImage imageNamed:@"背景"]];
    [_tableView registerNib:[UINib nibWithNibName:@"RadioCell" bundle:nil] forCellReuseIdentifier:@"RadioCell"];
    [self.radioVM getRadioCompletionHandler:^(NSError *error) {
        if (!error) {
            _tableView.tableHeaderView = self.ic;
            [_tableView reloadData];
        }
    }];
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

- (RadioViewModel *)radioVM {
	if(_radioVM == nil) {
		_radioVM = [[RadioViewModel alloc] init];
	}
	return _radioVM;
}

- (iCarousel *)ic {
	if(_ic == nil) {
		_ic = [[iCarousel alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenW*370/750)];
        _ic.scrollSpeed = 0.1;
        _ic.type = iCarouselTypeLinear;
        _ic.delegate = self;
        _ic.dataSource = self;
        _topTitle = [UILabel new];
        [_ic addSubview:_topTitle];
        [_topTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(15);
            make.bottom.equalTo(-8);
            make.height.equalTo(25);
            make.width.equalTo(280);
        }];
        _topTitle.font = [UIFont systemFontOfSize:16];
        _topTitle.textColor = [UIColor whiteColor];
        _page = [UIPageControl new];
        [_ic addSubview:_page];
        [_page mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(-20);
            make.bottom.equalTo(4);
        }];
        _page.numberOfPages = 5;
        _page.pageIndicatorTintColor = [UIColor lightGrayColor];
//        _page.currentPageIndicatorTintColor = [UIColor grayColor];
	}
	return _ic;
}

@end
