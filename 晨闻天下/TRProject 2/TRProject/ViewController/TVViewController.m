//
//  TVViewController.m
//  TRProject
//
//  Created by 钟至大 on 16/8/13.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "TVViewController.h"
#import "TVViewModel.h"
#import "TVCell.h"
#import "Factory.h"
#import "DetailModel.h"
#import "UMSocial.h"
#import "UMSocialData.h"
@import AVKit;
@import AVFoundation;
@interface TVViewController ()<UITableViewDelegate,UITableViewDataSource,TVCellDelegate,UMSocialUIDelegate>
@property (weak, nonatomic) IBOutlet UITableView *TVTableView;
@property (nonatomic) TVViewModel *tvVM;
@property (nonatomic) AVPlayerViewController *playerVC;
@end

@implementation TVViewController
#pragma mark - TVCell Delegate
- (void)playVedioForCell:(TVCell *)cell{
    NSIndexPath *indexPath = [_TVTableView indexPathForCell:cell];
    [self playerWithURL:[self.tvVM getVedioURLForRow:indexPath.row]];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"TVVM" object:self userInfo:@{@"title":[self.tvVM getTitleForRow:indexPath.row],@"url":[self.tvVM getVedioURLForRow:indexPath.row]}];
}
- (void)saveItemForCell:(TVCell *)cell{
    DetailModel *model = [DetailModel new];
    NSIndexPath *indexPath = [_TVTableView indexPathForCell:cell];
    model.url = [self.tvVM getVedioURLForRow:indexPath.row];
    model.title = cell.titleLb.text;
    NSMutableArray<DetailModel *> *arr = [NSMutableArray new];
    NSArray<DetailModel *> *queryArr = [self query];
    BOOL isSame = NO;
    if (![self query]) {
        [arr addObject:model];
    }else{
        arr = [self query];
        for (DetailModel *m in queryArr) {
            if ([m.title isEqualToString:model.title]) {
                isSame = YES;
            }
        }
        if (!isSame) {
            [arr addObject:model];
        }
    }
    
    [self addToUserDefault:arr];
}
- (void)shareItemForCell:(TVCell *)cell{
    NSIndexPath *indexPath = [_TVTableView indexPathForCell:cell];
    [self UMShareWithImage:[self.tvVM getURLForRow:indexPath.row] title:[self.tvVM getTitleForRow:indexPath.row] vedioURL:[self.tvVM getVedioURLForRow:indexPath.row]];
}
#pragma mark - UITableView Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.tvVM.rowNumber;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row = indexPath.row;
    TVCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TVCell"];
    [cell.backgroundIV setImageWithURL:[self.tvVM getURLForRow:row]];
    cell.durationLb.text = [self.tvVM getDurationForRow:row];
    cell.titleLb.text = [self.tvVM getTitleForRow:row];
    cell.playTimesLb.text = [self.tvVM getPlayTimeForRow:row];
    cell.commentLb.text = [self.tvVM getCommentForRow:row];
    cell.delegate = self;


    if (self.type == 6) {
        cell.backgroundIV.contentMode = UIViewContentModeScaleToFill;
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    //560*268
    return 250;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self playerWithURL:[self.tvVM getVedioURLForRow:indexPath.row]];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"TVVM" object:self userInfo:@{@"title":[self.tvVM getTitleForRow:indexPath.row],@"url":[self.tvVM getVedioURLForRow:indexPath.row]}];
    
}
#pragma mark - 方法 Methods
- (void)playerWithURL:(NSURL *)url{
    self.playerVC.player = [AVPlayer playerWithURL:url];
    [self presentViewController:self.playerVC animated:YES completion:nil];
    [self.playerVC.player play];
}
//友盟分享
- (void)UMShareWithImage:(NSURL *)url title:(NSString *)title vedioURL:(NSURL *)vedioURL{
    [[UMSocialData defaultData].urlResource setResourceType:UMSocialUrlResourceTypeVideo url:[vedioURL absoluteString]];
    [UMSocialData defaultData].extConfig.title = title;
    [UMSocialData defaultData].extConfig.qqData.url = [vedioURL absoluteString] ;
    [UMSocialData defaultData].extConfig.sinaData.urlResource.url = [vedioURL absoluteString] ;
    [UMSocialData defaultData].extConfig.wechatSessionData.url =[vedioURL absoluteString] ;
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:kUMengKey
                                      shareText:[NSString stringWithFormat:@"晨闻天下#分享视频# \n%@ \n %@",title,[vedioURL absoluteString]]
                                     shareImage:nil
                                shareToSnsNames:@[UMShareToWechatSession,UMShareToWechatTimeline,UMShareToSina,UMShareToQQ]
                                       delegate:self];
    
    
}
-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    //根据`responseCode`得到发送结果,如果分享成功
    if(response.responseCode == UMSResponseCodeSuccess)
    {
        //得到分享到的平台名
        [self setHUDWithTitle:@"分享成功!"];
    }
}

//添加到收藏
- (void)addToUserDefault:(NSMutableArray *)modelArr{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:modelArr];
    [userDefaults setObject:data forKey:@"likeTV"];
    [userDefaults synchronize];
}
- (NSMutableArray <DetailModel *> *)query{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [userDefaults objectForKey:@"likeTV"];
    NSMutableArray *arr = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    return arr;
}

#pragma mark - 生命周期 Life Circle
//当左右滑动切换控制器时，停止当前界面的网络活动
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self.tvVM suspendTask];
    
}
//界面重新显示时，恢复网络活动
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.tvVM resumeTask];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor colorWithPatternImage:[UIImage imageNamed:@"背景"]];
    self.TVTableView.backgroundColor = [UIColor clearColor];

    [_TVTableView registerNib:[UINib nibWithNibName:@"TVCell" bundle:nil] forCellReuseIdentifier:@"TVCell"];
    WK(weakSelf);
    [_TVTableView addHeaderRefresh:^{
        [weakSelf.tvVM getTVDataWithRequestMode:RequestModeRefresh completionHandler:^(NSError *error) {
            if (error) {
                DDLogError(@"TVerror:%@",error);
            }else{
                [_TVTableView reloadData];
            }
        }];
        [_TVTableView endHeaderRefresh];
    }];
    [_TVTableView addAutoFooterRefresh:^{
        [_tvVM getTVDataWithRequestMode:RequestModeMore completionHandler:^(NSError *error) {
            if (error) {
                DDLogError(@"TVerror:%@",error);
            }else{
                [_TVTableView reloadData];
            }
        }];
        [_TVTableView endFooterRefresh];
    }];
    [_TVTableView beginHeaderRefresh];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 懒加载 Lazy Load

- (TVViewModel *)tvVM {
	if(_tvVM == nil) {
		_tvVM = [[TVViewModel alloc] initWithTypeId:self.type];
	}
	return _tvVM;
}

- (AVPlayerViewController *)playerVC {
	if(_playerVC == nil) {
		_playerVC = [[AVPlayerViewController alloc] init];
        UIBarButtonItem *item = [[UIBarButtonItem alloc]init];
        item.title = @"完成";
        _playerVC.navigationController.navigationItem.leftBarButtonItem = item;
//        [Factory addBackItemToVC:_playerVC];
	}
	return _playerVC;
}

@end
