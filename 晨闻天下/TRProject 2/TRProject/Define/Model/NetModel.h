//
//  NetModel.h
//  Project
//
//  Created by 钟至大 on 16/8/4.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import <Foundation/Foundation.h>


@class NetDataModel,NetDataImgextraModel;
@interface NetModel : NSObject
//list -> T1348648141035
@property (nonatomic, strong) NSArray<NetDataModel *> *list;

@end

@interface NetDataModel : NSObject

@property (nonatomic, copy) NSString *digest;

@property (nonatomic, copy) NSString *imgsrc;

@property (nonatomic, copy) NSString *lmodify;

@property (nonatomic, copy) NSString *postid;

@property (nonatomic, copy) NSString *boardid;

@property (nonatomic, assign) NSInteger priority;

@property (nonatomic, copy) NSString *skipID;

@property (nonatomic, copy) NSString *ptime;//时间

@property (nonatomic, copy) NSString *source;//新闻出处

@property (nonatomic, copy) NSString *docid;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, assign) NSInteger votecount;

@property (nonatomic, copy) NSString *photosetID;

@property (nonatomic, strong) NSArray<NetDataImgextraModel *> *imgextra;

@property (nonatomic, assign) NSInteger replyCount;//评论数

@property (nonatomic, copy) NSString *skipType;

@property (nonatomic, copy) NSString *url;

@end

@interface NetDataImgextraModel : NSObject

@property (nonatomic, copy) NSString *imgsrc;

@end

