//
//  HotModel.h
//  Project
//
//  Created by 钟至大 on 16/8/3.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HotDataModel,HotDataArticleModel;
@interface HotModel : NSObject

@property (nonatomic, strong) HotDataModel *data;

@property (nonatomic, assign) NSInteger code;

@end
@interface HotDataModel : NSObject

@property (nonatomic, copy) NSString *channel;
//list - >article
@property (nonatomic, strong) NSArray<HotDataArticleModel *> *list;

@end

@interface HotDataArticleModel : NSObject

@property (nonatomic, copy) NSString *author;//出处

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *img;

@property (nonatomic, copy) NSString *url;

@property (nonatomic, assign) NSInteger time;//评论

@end

