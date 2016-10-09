//
//  DetailViewController.m
//  TRProject
//
//  Created by 钟至大 on 16/8/8.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "DetailViewController.h"
#import "SaveViewController.h"
#import "UMSocialData.h"
#import "UMSocialSnsService.h"
#import "UMSocial.h"
@interface DetailViewController ()<UIWebViewDelegate,UMSocialUIDelegate>

@end

@implementation DetailViewController
#pragma mark - 方法 Methods
//友盟分享
- (void)UMShare{
    [UMSocialData defaultData].extConfig.title = @"..........";
    [UMSocialData defaultData].extConfig.qqData.url = [self.webURL absoluteString];
    [UMSocialData defaultData].extConfig.sinaData.urlResource.url = [self.webURL absoluteString];
    [UMSocialData defaultData].extConfig.wechatSessionData.url = @"www.baidu.com";
    [[UMSocialData defaultData].urlResource setResourceType:UMSocialUrlResourceTypeImage url:[self.webURL absoluteString]];
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:kUMengKey
                                      shareText:[NSString stringWithFormat:@"晨闻天下#分享新闻# \n%@ \n %@",self.controllerTitle,[self.webURL absoluteString]]
                                     shareImage:[UIImage imageNamed:@"alert_error_icon"]
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
    [userDefaults setObject:data forKey:@"likeNews"];
    [userDefaults synchronize];
}
- (NSMutableArray <DetailModel *> *)query{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [userDefaults objectForKey:@"likeNews"];
    NSMutableArray *arr = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    return arr;
}
- (void)saveItem{
    DetailModel *model = [DetailModel new];
    model.url = self.webURL;
    model.contentText = self.contentText;
    model.title = self.controllerTitle;
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
//收藏按钮
- (void)addLike{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 45, 45);
    UIImage *image = [UIImage imageNamed:@"like"];
    [button setImage:image forState:UIControlStateNormal];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:self action:nil];
    item.width = -15;

    UIBarButtonItem *likeItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    UIButton *share = [UIButton buttonWithType:UIButtonTypeCustom];
    share.frame = CGRectMake(0, 0, 45, 45);
    UIImage *shareImage = [UIImage imageNamed:@"video_list_item_share"];
    [share setImage:shareImage forState:UIControlStateNormal];
     UIBarButtonItem *shareItem = [[UIBarButtonItem alloc]initWithCustomView:share];
    self.navigationItem.rightBarButtonItems = @[item,shareItem,likeItem];
    [button addTarget:self action:@selector(saveItem) forControlEvents:UIControlEventTouchUpInside];
    [share addTarget:self action:@selector(UMShare) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - 生命周期 Life Circle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.view.backgroundColor =[UIColor colorWithPatternImage:[UIImage imageNamed:@"背景"]];
    [self addLike];
    
    
    UIView *view =  self.webView.scrollView.subviews[0] ;
    view.backgroundColor = [UIColor clearColor];
    
    self.navigationController.navigationBar.tintColor =[UIColor whiteColor];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    if (self.webURL == nil) {
        self.content.text = self.contentText;
    }else{
        [self.webView loadRequest:[NSURLRequest requestWithURL:self.webURL]];
    }
    
    self.webView.backgroundColor = [UIColor clearColor];
    
    
    self.webView.delegate = self;
    
    [self.webView setOpaque:NO];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 懒加载 Lazy Load

- (instancetype)initWithURL:(NSURL *)url{
    if (self = [super init]) {
        _webURL = url;
    }
    return self;
}
- (UIWebView *)webView {
    if(_webView == nil) {
        _webView = [[UIWebView alloc] init];
        [self.view addSubview:_webView];
        [_webView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(0);
            make.top.equalTo(-64);
        }];
    }
    return _webView;
}
- (UILabel *)content {
    if(_content == nil) {
        _content = [[UILabel alloc] init];
        
        UIView *view = [UIView new];
        [self.scrollView addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
            
        }];
        
        [view addSubview:_content];
        [_content mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo([UIScreen mainScreen].bounds.size.width - 20);
            make.left.equalTo(10);
            make.right.equalTo(-10);
            make.top.equalTo(10);
            make.bottom.equalTo(-10);
            
        }];
        _content.numberOfLines = 0;
        _content.font = [UIFont systemFontOfSize:17];
        
    }
    return _content;
}
- (UIScrollView *)scrollView {
    if(_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] init];
        [self.view addSubview:_scrollView];
        //        _scrollView.backgroundColor = [UIColor redColor];
        [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.right.bottom.mas_equalTo(0);
            make.top.mas_equalTo(64);
        }];
        //         _scrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height*1.5);
    }
    return _scrollView;
}
@end
