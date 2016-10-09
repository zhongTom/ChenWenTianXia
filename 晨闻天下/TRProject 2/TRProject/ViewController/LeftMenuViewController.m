//
//  LeftMenuViewController.m
//  TRProject
//
//  Created by 钟至大 on 16/8/10.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "LeftMenuViewController.h"
#import "MyView.h"
#import "DetailModel.h"
#import "HistoryTableViewController.h"
#import "RegisterViewController.h"

@interface LeftMenuViewController ()
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UIImageView *iconIV;
@property (weak, nonatomic) IBOutlet UIButton *loginItem;
@property (weak, nonatomic) IBOutlet UIButton *registerItem;
@property (weak, nonatomic) IBOutlet UIButton *exitLogin;
@property (nonatomic) UILabel *userName ;
@property (nonatomic) NSMutableArray<DetailModel *> *newsList;
@property (nonatomic) NSMutableArray<DetailModel *> *carList;
@property (nonatomic) NSMutableArray<DetailModel *> *videoList;
@property (nonatomic) NSMutableArray<DetailModel *> *radioList;
@property (nonatomic) NSMutableArray<DetailModel *> *liveList;
@end


@implementation LeftMenuViewController
#pragma mark - UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 1) {
        UINavigationController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"leftNavi"];
        [self.sideMenuViewController setContentViewController:vc];
        
        [self.sideMenuViewController hideMenuViewController];
    }else if(indexPath.row == 2){
        UINavigationController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"SaveViewController"];
        [self.sideMenuViewController setContentViewController:vc];
        
        [self.sideMenuViewController hideMenuViewController];
    }else if(indexPath.row == 5){
        UINavigationController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"CleanCrashViewController"];
        [self.sideMenuViewController setContentViewController:vc];
        
        [self.sideMenuViewController hideMenuViewController];
    }else if (indexPath.row == 3){
        UINavigationController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"Info"];
        [self.sideMenuViewController setContentViewController:vc];
        
        [self.sideMenuViewController hideMenuViewController];
    }
}
#pragma mark - 方法 Methods

- (IBAction)nightModel:(UISwitch *)sender {
    MyView *view = [MyView shareView];
    if (sender.isOn == YES) {
        view.alpha = 0.4;
        view.backgroundColor = [UIColor blackColor];
        [[UIApplication sharedApplication].keyWindow addSubview:view];
    }else{
        view.alpha = 0;
    }
}
#pragma mark - 生命周期 Life Circle


- (void)viewDidLoad {
    [super viewDidLoad];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSNumber  *isLogin = [userDefaults objectForKey:@"login"];
    NSLog(@"%d",isLogin.boolValue);
    if(isLogin.boolValue){
    [self userIcon];
    }else{
        [self.exitLogin setHidden:YES];
    }
    self.topView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"背景"]];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(catchNewsVM:) name:@"newsVM" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(catchNewsVM:) name:@"carVM" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(catchNewsVM:) name:@"TVVM" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(catchNewsVM:) name:@"RadioVM" object:nil];
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"newsVM" object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"carVM" object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"TVVM" object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"RadioVM" object:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - 方法 Methods
//头像显示界面
- (IBAction)unLogin:(UIButton *)sender {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    BOOL isLogin = NO;
    [userDefaults setObject:@(isLogin) forKey:@"login"];
    [sender setHidden:YES];
    [self.loginItem setHidden:NO];
    [self.registerItem setHidden:NO];
    self.iconIV.image = [UIImage imageNamed:@"theadsmall@2x"];
    [self.userName setHidden:YES];
}

- (void)userIcon{
    [self.topView addSubview:self.userName];
    BmobUser *user = [BmobUser currentUser];
    self.userName.text = [user objectForKey:@"name"];
    [self.userName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(-45);
        make.top.equalTo(100);
        make.width.equalTo(30);
        make.height.equalTo(20);
    }];
    self.userName.numberOfLines = 1;
    self.userName.font = [UIFont systemFontOfSize:17];
    self.userName.textAlignment = NSTextAlignmentCenter;
    [self.loginItem setHidden:YES];
    [self.registerItem setHidden:YES];
    [self.iconIV setImageWithURL:[NSURL URLWithString:[user objectForKey:@"headPath"]]];
}
//注册
- (IBAction)register:(id)sender {
    RegisterViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"Register"];
    [self.sideMenuViewController setContentViewController:vc animated:YES];
    [self.sideMenuViewController hideMenuViewController];
}
//登录
- (IBAction)loadIn:(id)sender {
    RegisterViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"LogIn"];
    [self.sideMenuViewController setContentViewController:vc animated:YES];
    [self.sideMenuViewController hideMenuViewController];
}

//历史浏览记录
- (void)catchNewsVM:(NSNotification *)sender{
    DetailModel *model = [DetailModel new];
    if ([sender.name isEqualToString:@"newsVM"]) {
        model.type = 0;
        model.title = sender.userInfo[@"title"];
        model.url = sender.userInfo[@"url"];
        model.contentText = sender.userInfo[@"contentText"];
        self.newsList = [self queryWithType:0];
        if (model.url||model.contentText) {
            [self.newsList addObject:model];
        }
        [self addDataWithObj:self.newsList withType:0];
    }else if([sender.name isEqualToString:@"carVM"]){
        model.type = 1;
        model.title = sender.userInfo[@"title"];
        model.url = sender.userInfo[@"url"];
        self.carList = [self queryWithType:1];
        [self.carList addObject:model];
        [self addDataWithObj:self.carList withType:1];
    }else if ([sender.name isEqualToString:@"TVVM"]){
        model.type = 2;
        model.title = sender.userInfo[@"title"];
        model.url = sender.userInfo[@"url"];
        self.videoList = [self queryWithType:2];
        [self.videoList addObject:model];
        [self addDataWithObj:self.videoList withType:2];
    }else if ([sender.name isEqualToString:@"RadioVM"]){
        model.type = 3;
        model.title = sender.userInfo[@"title"];
        model.url = sender.userInfo[@"url"];
        self.radioList = [self queryWithType:3];
        [self.radioList addObject:model];
        [self addDataWithObj:self.radioList withType:3];
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
- (NSMutableArray<DetailModel *> *)queryWithType:(NSInteger)type{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    switch (type) {
        case 0:{
            NSData *data = [userDefaults objectForKey:@"news"];
            return [NSKeyedUnarchiver unarchiveObjectWithData:data];
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
#pragma mark - 懒加载 Lazy Load


- (NSMutableArray *)newsList {
    if(_newsList == nil) {
        _newsList = [[NSMutableArray alloc] init];
    }
    return _newsList;
}



- (NSMutableArray<DetailModel *> *)carList {
    if(_carList == nil) {
        _carList = [[NSMutableArray<DetailModel *> alloc] init];
    }
    return _carList;
}

- (NSMutableArray<DetailModel *> *)videoList {
    if(_videoList == nil) {
        _videoList = [[NSMutableArray<DetailModel *> alloc] init];
    }
    return _videoList;
}

- (NSMutableArray<DetailModel *> *)radioList {
    if(_radioList == nil) {
        _radioList = [[NSMutableArray<DetailModel *> alloc] init];
    }
    return _radioList;
}

- (NSMutableArray<DetailModel *> *)liveList {
    if(_liveList == nil) {
        _liveList = [[NSMutableArray<DetailModel *> alloc] init];
    }
    return _liveList;
}

- (UILabel *)userName {
	if(_userName == nil) {
		_userName = [[UILabel alloc] init];
	}
	return _userName;
}

@end
