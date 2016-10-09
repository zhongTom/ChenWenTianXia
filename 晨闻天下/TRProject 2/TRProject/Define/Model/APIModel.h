//
//  APIModel.h
//  Project
//
//  Created by 钟至大 on 16/8/3.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import <Foundation/Foundation.h>

@class APINewslistModel;
@interface APIModel : NSObject

@property (nonatomic, copy) NSString *msg;
//list -> newslist
@property (nonatomic, strong) NSArray<APINewslistModel *> *list;

@property (nonatomic, assign) NSInteger code;

@end
@interface APINewslistModel : NSObject

@property (nonatomic, copy) NSString *ctime;//时间

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *Description;//新闻出处

@property (nonatomic, copy) NSString *url;

@property (nonatomic, copy) NSString *picUrl;

@end

