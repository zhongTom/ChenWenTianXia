

//
//  LiveListSpecialTypeModel.h
//  TRProject
//
//  Created by 钟至大 on 16/8/20.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SpecialListModel,SpecialextraModel,SpecialLive_InfoModel;
@interface LiveListSpecialTypeModel : NSObject
@property (nonatomic, strong) NSArray<SpecialListModel *> *list;
@end
@interface SpecialListModel : NSObject

@property (nonatomic, copy) NSString *specialID;

@property (nonatomic, copy) NSString *specialtip;

@property (nonatomic, copy) NSString *digest;

@property (nonatomic, copy) NSString *subtitle;

@property (nonatomic, copy) NSString *imgsrc;

@property (nonatomic, copy) NSString *lmodify;

@property (nonatomic, assign) NSInteger priority;

@property (nonatomic, copy) NSString *source;

@property (nonatomic, copy) NSString *skipID;

@property (nonatomic, copy) NSString *specialadlogo;

@property (nonatomic, copy) NSString *ptime;

@property (nonatomic, strong) NSArray<SpecialextraModel *> *specialextra;

@property (nonatomic, copy) NSString *docid;

@property (nonatomic, copy) NSString *speciallogo;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *skipType;

@end

@interface SpecialextraModel : NSObject

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

@property (nonatomic, strong) SpecialLive_InfoModel *live_info;

@property (nonatomic, copy) NSString *TAGS;

@property (nonatomic, copy) NSString *skipType;

@end

@interface SpecialLive_InfoModel : NSObject

@property (nonatomic, copy) NSString *end_time;

@property (nonatomic, assign) NSInteger roomId;

@property (nonatomic, assign) NSInteger user_count;

@property (nonatomic, assign) BOOL mutilVideo;

@property (nonatomic, assign) BOOL pano;

@property (nonatomic, assign) NSInteger remindTag;

@property (nonatomic, copy) NSString *start_time;

@property (nonatomic, assign) NSInteger type;

@property (nonatomic, assign) BOOL video;

@end

