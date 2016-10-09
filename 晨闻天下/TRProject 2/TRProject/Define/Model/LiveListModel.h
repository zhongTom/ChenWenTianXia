//
//  LiveListModel.h
//  TRProject
//
//  Created by 钟至大 on 16/8/23.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LiveList,LiveListTopicsModel,LiveListDocsModel,LiveListLive_InfoModel;
@interface LiveListModel : NSObject

@property (nonatomic, strong) LiveList *list;

@end
@interface LiveList : NSObject

@property (nonatomic, strong) NSArray *topicspatch;

@property (nonatomic, copy) NSString *webviews;

@property (nonatomic, copy) NSString *ptime;

@property (nonatomic, copy) NSString *ec;

@property (nonatomic, copy) NSString *sdocid;

@property (nonatomic, assign) NSInteger del;

@property (nonatomic, copy) NSString *lmodify;

@property (nonatomic, copy) NSString *imgsrc;

@property (nonatomic, strong) NSArray *topicslatest;

@property (nonatomic, copy) NSString *tag;

@property (nonatomic, strong) NSArray *topicsplus;

@property (nonatomic, copy) NSString *type;

@property (nonatomic, copy) NSString *sid;

@property (nonatomic, copy) NSString *photoset;

@property (nonatomic, strong) NSArray *headpics;

@property (nonatomic, copy) NSString *banner;

@property (nonatomic, copy) NSString *sname;

@property (nonatomic, copy) NSString *shownav;

@property (nonatomic, strong) NSArray<LiveListTopicsModel *> *topics;

@property (nonatomic, copy) NSString *digest;

@end

@interface LiveListTopicsModel : NSObject

@property (nonatomic, copy) NSString *tname;

@property (nonatomic, strong) NSArray<LiveListDocsModel *> *docs;

@property (nonatomic, copy) NSString *shortname;

@property (nonatomic, copy) NSString *type;

@property (nonatomic, assign) NSInteger index;

@end

@interface LiveListDocsModel : NSObject

@property (nonatomic, copy) NSString *ipadcomment;

@property (nonatomic, copy) NSString *digest;

@property (nonatomic, copy) NSString *imgsrc;

@property (nonatomic, copy) NSString *lmodify;

@property (nonatomic, assign) NSInteger priority;

@property (nonatomic, copy) NSString *source;

@property (nonatomic, copy) NSString *skipID;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *ptime;

@property (nonatomic, copy) NSString *TAG;

@property (nonatomic, copy) NSString *docid;

@property (nonatomic, strong) LiveListLive_InfoModel *live_info;

@property (nonatomic, strong) NSArray *editor;

@property (nonatomic, assign) NSInteger imgType;

@property (nonatomic, copy) NSString *TAGS;

@property (nonatomic, copy) NSString *skipType;

@end

@interface LiveListLive_InfoModel : NSObject

@property (nonatomic, copy) NSString *end_time;

@property (nonatomic, assign) NSInteger user_count;

@property (nonatomic, assign) NSInteger roomId;

@property (nonatomic, assign) BOOL mutilVideo;

@property (nonatomic, assign) BOOL pano;

@property (nonatomic, assign) NSInteger remindTag;

@property (nonatomic, copy) NSString *start_time;

@property (nonatomic, assign) NSInteger type;

@property (nonatomic, assign) BOOL video;

@end

