//
//  TVModel.h
//  TRProject
//
//  Created by 钟至大 on 16/8/12.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TVItemModel;
@interface TVModel : NSObject

@property (nonatomic, copy) NSString *currentPage;

@property (nonatomic, copy) NSString *type;

@property (nonatomic, assign) NSInteger totalPage;

@property (nonatomic, strong) NSArray<TVItemModel *> *item;

@end
@interface TVItemModel : NSObject

@property (nonatomic, assign) NSInteger commentsall;

@property (nonatomic, copy) NSString *video_url;

@property (nonatomic, assign) NSInteger video_size;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *image;

@property (nonatomic, assign) NSInteger duration;

@property (nonatomic, copy) NSString *shareUrl;

@property (nonatomic, copy) NSString *commentsUrl;

@property (nonatomic, copy) NSString *documentId;

@property (nonatomic, copy) NSString *playTime;

@end

