//
//  ViewController.m
//  TRProject
//
//  Created by jiyingxin on 16/2/4.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "ViewController.h"
#import "NewsNetManager.h"
#import "NewsViewModel.h"
#import "NewsCell.h"
#import "XiaoHuaCell.h"
#import "NewsMutiableCell.h"
#import "iCarousel.h"
#import "InfoLisViewModel.h"
#import "InfoListCell.h"
#import "DetailViewController.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,iCarouselDelegate,iCarouselDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) NewsViewModel *newsVM;
@property (nonatomic) InfoLisViewModel *infoVM;
@property (nonatomic) iCarousel *ic;
@property (nonatomic) UIPageControl *page;
@end

@implementation ViewController
#pragma mark - UIICarousel Delegate
- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel{
    return self.infoVM.topNumber;
}
- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view{
    if (view == nil) {
        view = [[UIView alloc]initWithFrame:carousel.frame];
        UIImageView *iconIV = [UIImageView new];
        iconIV.contentMode = UIViewContentModeScaleAspectFit;
        [view addSubview:iconIV];
        [iconIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(0);
        }];
        iconIV.tag = 100;
    }
    UIImageView *iconIV = [view viewWithTag:100];
    NSURL *url = [self.infoVM topIconURLForIndex:index];
    if (url) {
        [iconIV setImageWithURL:[self.infoVM topIconURLForIndex:index]];
    }
    return view;
}
- (CGFloat)carousel:(iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value{
    if (option == iCarouselOptionWrap) {
        return YES;
    }
    return value;
}
- (void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index{
    DetailViewController *topVC = [[DetailViewController alloc]initWithURL:[self.infoVM topDetailURLForRow:index]];
    [self.navigationController pushViewController:topVC animated:YES];
}
#pragma mark - UITableView Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.newsType == NetTypeCar) {
        return self.infoVM.rowNumber;
    }else{
        return self.newsVM.rowNumber;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row = indexPath.row;
    
    if (self.newsType == NewsTypeXiaoHua) {
        XiaoHuaCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XioHuaCell"];
        cell.title.text = [self.newsVM getTitleForRow:row];
        cell.content.text = [self.newsVM getContentForRow:row];
        cell.date.text = [self.newsVM getTimeForRow:row];
        return cell;
    }
    else if (self.newsType == NetTypeCar){
        InfoListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CarCell"];
        [cell.iconIV setImageWithURL:[self.infoVM iconURLForRow:row]];
        cell.titleLb.text = [self.infoVM titleForRow:row];
        cell.dateLb.text = [self.infoVM dateForRow:row];
        cell.commentLb.text = [self.infoVM commentNumForRow:row];
        return cell;
    }else if ([self.newsVM getMultibleURLForRow:row].count>1){
        NewsMutiableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MCell"];
        cell.title.text = [self.newsVM getTitleForRow:row];
        if ([self.newsVM getNumberOfCommentForRow:row]) {
            cell.comment.text = [self.newsVM getNumberOfCommentForRow:row];
        }else{
            cell.comment.text = [self.newsVM getOriginForRow:row];
        }
        
        [cell.iconL setImageWithURL:[self.newsVM getMultibleURLForRow:row].firstObject placeholderImage:[UIImage imageNamed:[NSString stringWithFormat:@"iu%d",arc4random()%27+1]]];
        [cell.iconM setImageWithURL:[self.newsVM getMultibleURLForRow:row][1]placeholderImage:[UIImage imageNamed:[NSString stringWithFormat:@"iu%d",arc4random()%27+1]]];
        [cell.iconR setImageWithURL:[self.newsVM getMultibleURLForRow:row][2] placeholderImage:[UIImage imageNamed:[NSString stringWithFormat:@"iu%d",arc4random()%27+1]]];
        return cell;
    }else{
        NewsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
        [cell.iconIV setImageWithURL:[self.newsVM getMultibleURLForRow:row].firstObject placeholderImage:[UIImage imageNamed:[NSString stringWithFormat:@"iu%d",arc4random()%27+1]]];
        cell.title.text = [self.newsVM getTitleForRow:row];
        if ([self.newsVM getTimeForRow:row]) {
            cell.date.text = [self.newsVM getTimeForRow:row];
        }else{
            cell.date.text = [self.newsVM getOriginForRow:row];
        }
        if ([self.newsVM getNumberOfCommentForRow:row]) {
            cell.comment.text = [self.newsVM getNumberOfCommentForRow:row];
        }else{
            cell.comment.text = [self.newsVM getOriginForRow:row];
        }
        
        return cell;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.newsType != NetTypeCar &&[self.newsVM getMultibleURLForRow:indexPath.row].count>1) {
        return 145;
    }
    return 90;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    DetailViewController *dVC;
    if (self.newsType == NetTypeCar) {
        dVC = [[DetailViewController alloc]initWithURL:[self.infoVM detailURLForRow:indexPath.row]];
        dVC.controllerTitle = [self.infoVM titleForRow:indexPath.row];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"carVM" object:self userInfo:@{@"title":self.infoVM.dataList[indexPath.row].title,@"url":[self.infoVM detailURLForRow:indexPath.row]}];
        
    }else{
        dVC = [[DetailViewController alloc]initWithURL:[self.newsVM getDetailURLForRow:indexPath.row]];
        if ([self.newsVM getDetailURLForRow:indexPath.row]==nil) {
            dVC.contentText = [self.newsVM getContentForRow:indexPath.row];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"newsVM" object:self userInfo:@{@"title":[self.newsVM getTitleForRow:indexPath.row],@"contentText":[self.newsVM getContentForRow:indexPath.row]}];
        }else{
            [[NSNotificationCenter defaultCenter] postNotificationName:@"newsVM" object:self userInfo:@{@"title":[self.newsVM getTitleForRow:indexPath.row],@"url":[self.newsVM getDetailURLForRow:indexPath.row]}];
        }
        dVC.controllerTitle = [self.newsVM getTitleForRow:indexPath.row];
    }
    [self.navigationController pushViewController:dVC animated:YES];
}
//当ic中的页面发生变化时触发
- (void)carouselCurrentItemIndexDidChange:(iCarousel *)carousel{
    _page.currentPage = carousel.currentItemIndex;
}
#pragma mark - 生命周期 Life Circle

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor =[UIColor colorWithPatternImage:[UIImage imageNamed:@"背景"]];
    self.tableView.backgroundColor = [UIColor clearColor];

   
    if (self.newsType == NewsTypeXiaoHua) {
        [_tableView registerNib:[UINib nibWithNibName:@"XiaoHuaCell" bundle:nil] forCellReuseIdentifier:@"XioHuaCell"];
    }else if (self.newsType == NetTypeCar){
        [_tableView registerNib:[UINib nibWithNibName:@"InfoListCell" bundle:nil] forCellReuseIdentifier:@"CarCell"];
    }else{
        [_tableView registerNib:[UINib nibWithNibName:@"NewsCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
        [_tableView registerNib:[UINib nibWithNibName:@"NewsMutiableCell" bundle:nil] forCellReuseIdentifier:@"MCell"];
    }
    __block __weak __typeof(&*self)weakSelf = self;
    [_tableView addHeaderRefresh:^{
        if (self.newsType == NetTypeCar) {
            [weakSelf.infoVM getDataWithRequestMode:RequestModeRefresh completionHanle:^(NSError *error) {
                if (error) {
                    NSLog(@"%@",error);
                }else{
                    if (self.infoVM.isHasTopView) {
                        _tableView.tableHeaderView = self.ic;
                        self.page.numberOfPages = self.infoVM.topNumber;
                    }else{
                        _tableView.tableHeaderView = nil;
                    }
                    [_tableView reloadData];
                }
            }];
        }else{
            [weakSelf.newsVM getDataWithRequestMode:RequestModeRefresh completionHandler:^(NSError *error) {
                if (error) {
                    NSLog(@"%@",error);
                }else{
                    [_tableView reloadData];
                }
            }];
            
        }
        [_tableView endHeaderRefresh];
    }];
    [_tableView addAutoFooterRefresh:^{
        if (self.newsType == NetTypeCar) {
            [weakSelf.infoVM getDataWithRequestMode:RequestModeMore completionHanle:^(NSError *error) {
                if (error) {
                    NSLog(@"%@",error);
                }else{
                    [_tableView reloadData];
                }
                [_tableView endFooterRefresh];
            }];
        }else{
            [weakSelf.newsVM getDataWithRequestMode:RequestModeMore completionHandler:^(NSError *error) {
                if (error) {
                    NSLog(@"%@",error);
                }else{
                    [_tableView reloadData];
                }
                [_tableView endFooterRefresh];
            }];
            
        }
    }];
    [_tableView beginHeaderRefresh];
    
}



//当左右滑动切换控制器时，停止当前界面的网络活动
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self.newsVM suspendTask];
}
//界面重新显示时，恢复网络活动
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.newsVM resumeTask];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - 懒加载 Lazy Load


- (NewsViewModel *)newsVM {
    if(_newsVM == nil) {
        _newsVM = [[NewsViewModel alloc] initWithNewsType:self.newsType];
    }
    return _newsVM;
}

- (iCarousel *)ic {
    if(_ic == nil) {
        _ic = [[iCarousel alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenW*370/750)];
        _page = [UIPageControl new];
        [_ic addSubview:_page];
        [_page mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(10);
            make.centerX.equalTo(0);
        }];
        _page.userInteractionEnabled = NO;
        _ic.delegate = self;
        _ic.dataSource = self;
        _ic.type = iCarouselTypeLinear;
        _ic.scrollSpeed = 0.1;
        [NSTimer bk_scheduledTimerWithTimeInterval:2 block:^(NSTimer *timer) {
            [_ic scrollToItemAtIndex:_ic.currentItemIndex + 1 animated:YES];
        } repeats:YES];
    }
    return _ic;
}

- (InfoLisViewModel *)infoVM {
    if(_infoVM == nil) {
        _infoVM = [[InfoLisViewModel alloc] initWithInfoListType:InfoListTypeZuiXin];
    }
    return _infoVM;
}

@end
