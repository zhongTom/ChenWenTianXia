//
//  RadioPlayerListController.m
//  TRProject
//
//  Created by 钟至大 on 16/8/18.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "RadioPlayerListController.h"
#import "RadioPlayerListViewModel.h"
#import "RadioPlayerListCell.h"
#import "DetailModel.h"
@import AVFoundation;
@interface RadioPlayerListController ()<UITableViewDelegate,UITableViewDataSource,RadioPlayerDelegate>
@property (nonatomic) RadioPlayerListViewModel *playerVM;
@property (weak, nonatomic) IBOutlet UIView *headView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (weak, nonatomic) IBOutlet UILabel *didProgress;
@property (weak, nonatomic) IBOutlet UILabel *totalProgress;
@property (nonatomic) AVPlayer *player;
@property (nonatomic) BOOL isPlaying;
@property (nonatomic) BOOL anotherAV;
@property (nonatomic) NSInteger row;
@property (weak, nonatomic) IBOutlet UIButton *previous;
@property (weak, nonatomic) IBOutlet UIButton *play;
@property (weak, nonatomic) IBOutlet UIButton *next;
@property (nonatomic) NSTimer *timer;


@end

@implementation RadioPlayerListController
#pragma mark - 方法 Methods
//添加到收藏
- (void)addToUserDefault:(NSMutableArray *)modelArr{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:modelArr];
    [userDefaults setObject:data forKey:@"likeRadio"];
    [userDefaults synchronize];
}
- (NSMutableArray <DetailModel *> *)query{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [userDefaults objectForKey:@"likeRadio"];
    NSMutableArray *arr = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    return arr;
}
- (void)saveItemForCell:(RadioPlayerListCell *)cell{
    DetailModel *model = [DetailModel new];
    NSIndexPath *indexPath = [_tableView indexPathForCell:cell];
    model.url = [self.playerVM getHtmlURLWithForRow:indexPath.row];
    model.title = cell.title.text;
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


- (IBAction)previousRadio:(id)sender {
    self.row--;
    if (self.row >=0) {
        self.isPlaying = YES;
        [self.play setImage:[UIImage imageNamed:@"pause"] forState:UIControlStateNormal];
        [self playVedioWithURL:[self.playerVM getHtmlURLWithForRow:self.row]];
    }else{
        self.row++;
    }
}
- (void)cellForSelectedToPlay:(UIButton *)sender{
    [sender setImage:[UIImage imageNamed:@"pause"] forState:UIControlStateNormal];
    self.isPlaying = YES;
    [self.player pause];
    [self playVedioWithURL:[self.playerVM getHtmlURLWithForRow:self.row]];
}
- (IBAction)playRadio:(UIButton *)sender {
    if(self.isPlaying){
        [sender setImage:[UIImage imageNamed:@"play_head"] forState:UIControlStateNormal];
        self.timer.fireDate = [NSDate distantFuture];
        [self.player pause];
        self.isPlaying = NO;
    }else{
        self.isPlaying = YES;
        
        [sender setImage:[UIImage imageNamed:@"pause"] forState:UIControlStateNormal];
        if (CMTimeGetSeconds(self.player.currentTime)>0) {
            [self continuePlay];
        }else{
            [self playVedioWithURL:[self.playerVM getHtmlURLWithForRow:self.row]];
        }
    }
}
- (IBAction)nextRadio:(id)sender {
    self.row++;
    if (self.row <= self.playerVM.rowNumber) {
        [self.play setImage:[UIImage imageNamed:@"pause"] forState:UIControlStateNormal];
        self.isPlaying = YES;
        [self playVedioWithURL:[self.playerVM getHtmlURLWithForRow:self.row]];
    }else{
        self.row--;
    }
}
- (void)continuePlay{
    [_player play];
}
- (void)playVedioWithURL:(NSURL *)url{
    self.player = [AVPlayer playerWithURL:url];
    [self.player play];
}
- (void)drawHeadViewForImage:(UIImage *)image{
    //创建画布
    UIGraphicsBeginImageContext(CGSizeMake(85, 85));
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, 85, 85)];
    [path addClip];
    [image drawInRect:CGRectMake(0, 0, 85, 85)];
    UIImageView *imageView = [[UIImageView alloc]initWithImage:UIGraphicsGetImageFromCurrentImageContext()];
    UIGraphicsEndImageContext();
    [self.headView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(0);
    }];
    [self.headView insertSubview:imageView atIndex:0];
    imageView.alpha =0.8;
}
#pragma mark - 生命周期 Life Circle


- (void)viewDidLoad {
    [super viewDidLoad];
    [self drawHeadViewForImage:self.image];
    self.navigationController.navigationBarHidden = YES;
    self.view.backgroundColor =[UIColor colorWithPatternImage:[UIImage imageNamed:@"背景"]];
    self.tableView.backgroundColor = [UIColor clearColor];
    [self.tableView registerNib:[UINib nibWithNibName:@"RadioPlayerListCell" bundle:nil] forCellReuseIdentifier:@"PlayerCell"];
    WK(weakSelf);
    [self.tableView addHeaderRefresh:^{
        [weakSelf.playerVM getRadioPlayerWithRequestMode:RequestModeRefresh CompletionHandler:^(NSError *error) {
            if (!error) {
                [weakSelf.tableView reloadData];
            }
            [weakSelf.tableView endHeaderRefresh];
        }];
    }];
    [self.tableView addAutoFooterRefresh:^{
        [weakSelf.playerVM getRadioPlayerWithRequestMode:RequestModeMore CompletionHandler:^(NSError *error) {
            if (!error) {
                [weakSelf.tableView reloadData];
            }
            [weakSelf.tableView endFooterRefresh];
        }];
    }];
    [self.tableView beginHeaderRefresh];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.playerVM.rowNumber;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RadioPlayerListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PlayerCell" forIndexPath:indexPath];
    cell.title.text = [self.playerVM getTitleForRow:indexPath.row];
    cell.date.text = [self.playerVM getDateForRow:indexPath.row];
    cell.delegate = self;
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.row == indexPath.row) {
        self.anotherAV = NO;
    }else{
        self.anotherAV = YES;
    }
    self.row = indexPath.row;
    [self cellForSelectedToPlay:self.play];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"RadioVM" object:self userInfo:@{@"title":[self.playerVM getTitleForRow:indexPath.row],@"url":[self.playerVM getHtmlURLWithForRow:indexPath.row]}];
}
#pragma mark - 懒加载 Lazy Load


- (RadioPlayerListViewModel *)playerVM {
    if(_playerVM == nil) {
        _playerVM = [[RadioPlayerListViewModel alloc] initWithResourceId:self.resourceId];
    }
    return _playerVM;
}

- (AVPlayer *)player {
    if(_player == nil) {
        _player = [[AVPlayer alloc] init];
    }
    return _player;
}



- (NSTimer *)timer {
    if(_timer == nil) {
        _timer = [NSTimer bk_timerWithTimeInterval:0.01 block:^(NSTimer *timer) {
            float currentTime =  CMTimeGetSeconds(self.player.currentItem.currentTime);
            float totalTime =  CMTimeGetSeconds(self.player.currentItem.duration);
            _progressView.progress = currentTime/totalTime;
        } repeats:YES];
    }
    return _timer;
} 

@end
