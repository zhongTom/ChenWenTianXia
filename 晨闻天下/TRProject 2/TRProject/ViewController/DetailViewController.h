//
//  DetailViewController.h
//  TRProject
//
//  Created by 钟至大 on 16/8/8.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailModel.h"

@interface DetailViewController : UIViewController
@property (nonatomic,readonly) NSURL *webURL;
- (instancetype)initWithURL:(NSURL *)url;
@property (nonatomic) UIWebView *webView;
@property (nonatomic) UILabel *content;
@property (nonatomic) NSString *contentText;
@property (nonatomic) UIScrollView *scrollView;
@property (nonatomic) NSString *controllerTitle;

@end
