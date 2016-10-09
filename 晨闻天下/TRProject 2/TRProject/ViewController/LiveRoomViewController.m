//
//  LiveRoomViewController.m
//  TRProject
//
//  Created by 钟至大 on 16/8/22.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "LiveRoomViewController.h"
#import "LiveRoomViewModel.h"
#import "TextCell.h"
#import "PicCell.h"
@import AVKit;
@import AVFoundation;
@interface LiveRoomViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *button;
@property (nonatomic) AVPlayerViewController *avVC;
@property (nonatomic) LiveRoomViewModel *roomModel;
@end

@implementation LiveRoomViewController
#pragma mark - 方法 Methods
- (IBAction)playLiving:(id)sender {
    if (self.roomModel.liveRoomModel.video) {
        self.avVC.player = [AVPlayer playerWithURL:[NSURL URLWithString:self.roomModel.liveRoomModel.video.videoUrl]];
    }else{
        self.avVC.player = [AVPlayer playerWithURL:[NSURL URLWithString:self.roomModel.liveRoomModel.mutilVideo[0].url]];
    }
    [self presentViewController:self.avVC animated:YES completion:nil];
    [self.avVC.player play];
}

- (void)topUI{
    if ([self.roomModel isHasVedioForHeader]) {
//        [self.imageView setImageWithURL:[NSURL URLWithString:self.roomModel.liveRoomModel.mutilVideo.firstObject.imgUrl]];
    }else{
        self.button.hidden = YES;
        self.imageView.image = self.topImage;
    }
}
//评论头像
- (UIImage *)clipIconIV:(NSURL *)url{
    //创建画布
    UIGraphicsBeginImageContext(CGSizeMake(40, 40));
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, 40, 40)];
    [path addClip];
    UIImageView *view = [UIImageView new];
    [view setImageWithURL:url placeholderImage:[UIImage imageNamed:@"qq."]];
    [view.image drawInRect:CGRectMake(0, 0, 40, 40)];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
#pragma mark - 生命周期 Life Circle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"背景"]];
    [self.tableView registerNib:[UINib nibWithNibName:@"TextCell" bundle:nil] forCellReuseIdentifier:@"TextCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"PicCell" bundle:nil] forCellReuseIdentifier:@"PicCell"];
    
    WK(weakSelf);
    [self.tableView addHeaderRefresh:^{
        [weakSelf.roomModel getLiveRoomModelWithRequestMode:RequestModeRefresh completionHandler:^(NSError *error) {
            if (!error) {
                [_tableView reloadData];
                [self topUI];
            }
        }];
        [_tableView endHeaderRefresh];
    }];
    [self.tableView addAutoFooterRefresh:^{
        [weakSelf.roomModel getLiveRoomModelWithRequestMode:RequestModeMore completionHandler:^(NSError *error) {
            if (!error) {
                [_tableView reloadData];
            }
        }];
        [_tableView.mj_footer endRefreshingWithNoMoreData];
    }];
    [_tableView beginHeaderRefresh];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
#pragma mark - UITableView Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.roomModel.rowNumber;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.roomModel isHasContentURLForRow:indexPath.row]) {
        PicCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PicCell"];
        cell.iconIV.image = [self clipIconIV:[self.roomModel getIconURLForRow:indexPath.row]];
        cell.title.text = [self.roomModel getTitleForRow:indexPath.row];
        cell.time.text = [self.roomModel getTimeForRow:indexPath.row];
        [cell.contenIV setImageWithURL:[self.roomModel getContentURLForRow:indexPath.row]];
        return cell;
    }else{
        TextCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TextCell"];
        cell.iconIV.image = [self clipIconIV:[self.roomModel getIconURLForRow:indexPath.row]];
        cell.title.text = [self.roomModel getTitleForRow:indexPath.row];
        cell.time.text = [self.roomModel getTimeForRow:indexPath.row];
        cell.content.text = [self.roomModel getContentTextForRow:indexPath.row];
        return cell;
        
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.roomModel isHasContentURLForRow:indexPath.row]) {
        CGFloat height = kScreenW*[self.roomModel getContentSizeForRow:indexPath.row].height/[self.roomModel getContentSizeForRow:indexPath.row].width;
        return height +40;
    }else{

        
        NSString *str = [self.roomModel getContentTextForRow:indexPath.row];
        
        CGRect rect = [str boundingRectWithSize:CGSizeMake(300, MAXFLOAT)  options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil];

        
        return rect.size.height + 50;
    }
}
#pragma mark - 懒加载 Lazy Load
- (LiveRoomViewModel *)roomModel {
    if(_roomModel == nil) {
        _roomModel = [[LiveRoomViewModel alloc] initWithSkipId:self.skipId];
    }
    return _roomModel;
}



- (AVPlayerViewController *)avVC {
	if(_avVC == nil) {
		_avVC = [[AVPlayerViewController alloc] init];
	}
	return _avVC;
}

@end
