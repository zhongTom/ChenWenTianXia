//
//  LiveListLiveTypeModel.h
//  TRProject
//
//  Created by 钟至大 on 16/8/20.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ListModel,Live_InfoModel;
@interface LiveListLiveTypeModel : NSObject

@property (nonatomic, strong) NSArray<ListModel *> *list;

@end
@interface ListModel : NSObject

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

@property (nonatomic, strong) Live_InfoModel *live_info;

@property (nonatomic, strong) NSArray *editor;

@property (nonatomic, assign) NSInteger imgType;

@property (nonatomic, copy) NSString *TAGS;

@property (nonatomic, copy) NSString *skipType;

@end

@interface Live_InfoModel : NSObject

@property (nonatomic, copy) NSString *end_time;

@property (nonatomic, assign) NSInteger roomId;

@property (nonatomic, assign) NSInteger user_count;

@property (nonatomic, assign) BOOL mutilVideo;

@property (nonatomic, assign) BOOL pano;

@property (nonatomic, copy) NSString *start_time;

@property (nonatomic, assign) NSInteger type;

@property (nonatomic, assign) BOOL video;

@end

