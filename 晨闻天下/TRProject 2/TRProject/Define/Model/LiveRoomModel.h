//
//  LiveRoomModel.h
//  TRProject
//
//  Created by 钟至大 on 16/8/21.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ChatconfigModel,MutilVideoModel,VideoModel,FloatlayerModel,BannerModel,CommentatorModel,MessagesModel,MessagesMsgModel,MessagesCommentatorModel,MessagesImagesModel;
@interface LiveRoomModel : NSObject

@property (nonatomic, copy) NSString *roomName;

@property (nonatomic, assign) NSInteger duration;

@property (nonatomic, strong) NSArray<MessagesModel *> *messages;
//temp -> template
@property (nonatomic, copy) NSString *temp;

@property (nonatomic, strong) NSArray<CommentatorModel *> *commentator;

@property (nonatomic, strong) VideoModel *video;

@property (nonatomic, strong) NSArray<MutilVideoModel *> *mutilVideo;

@property (nonatomic, assign) NSInteger roomId;

@property (nonatomic, copy) NSString *endDate;

@property (nonatomic, assign) BOOL statExist;

@property (nonatomic, copy) NSString *liveRoomTrigger;

@property (nonatomic, strong) BannerModel *banner;

@property (nonatomic, copy) NSString *chatRoomTrigger;

@property (nonatomic, strong) FloatlayerModel *floatLayer;

@property (nonatomic, copy) NSString *liveVideoFull;

@property (nonatomic, strong) ChatconfigModel *chatConfig;

@property (nonatomic, copy) NSString *liveVideoUrl;

@property (nonatomic, assign) NSInteger nextPage;

@property (nonatomic, copy) NSString *order;

@property (nonatomic, strong) NSArray<NSString *> *section;

@property (nonatomic, copy) NSString *startDate;

@end
@interface ChatconfigModel : NSObject

@property (nonatomic, assign) NSInteger chatRoomCount;

@property (nonatomic, copy) NSString *chatImgTrigger;

@end

@interface MutilVideoModel : NSObject

@property (nonatomic,copy) NSString *imgUrl;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *url;

@end

@interface VideoModel : NSObject

@property (nonatomic, copy) NSString *videoFull;

@property (nonatomic, copy) NSString *videoUrl;

@property (nonatomic, copy) NSString *panoUrl;

@property (nonatomic, copy) NSString *isPano;

@end

@interface FloatlayerModel : NSObject

@property (nonatomic, copy) NSString *floatType;

@property (nonatomic, copy) NSString *iconUrl;

@property (nonatomic, copy) NSString *floatUrl;

@end

@interface BannerModel : NSObject

@property (nonatomic, copy) NSString *des;

@property (nonatomic, copy) NSString *type;

@property (nonatomic, copy) NSString *url;

@end

@interface CommentatorModel : NSObject

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *imgUrl;

@end

@interface MessagesModel : NSObject
//ID->id
@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, strong) MessagesCommentatorModel *commentator;

@property (nonatomic, strong) MessagesMsgModel *msg;

@property (nonatomic, copy) NSString *section;

@property (nonatomic, strong) NSArray<MessagesImagesModel *> *images;

@property (nonatomic, copy) NSString *time;

@end

@interface MessagesMsgModel : NSObject

@property (nonatomic, copy) NSString *align;

@property (nonatomic, copy) NSString *content;

@property (nonatomic, copy) NSString *fontColor;

@property (nonatomic, copy) NSString *fontType;


@end

@interface MessagesCommentatorModel : NSObject

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *imgUrl;

@end

@interface MessagesImagesModel : NSObject

@property (nonatomic, copy) NSString *fullSizeSrc;

@property (nonatomic, copy) NSString *fullSrcSize;

@property (nonatomic, copy) NSString *src;

@end

