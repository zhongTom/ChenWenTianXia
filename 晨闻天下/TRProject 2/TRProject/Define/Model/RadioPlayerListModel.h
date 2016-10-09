//
//  RadioPlayerListModel.h
//  TRProject
//
//  Created by 钟至大 on 16/8/18.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RadioPlayerDataModel,RadioPlayerDataResourcelistModel,RadioPlayerDataResourceListAudiolistModel,RadioPlayerDataAudiolistModel;
@interface RadioPlayerListModel : NSObject

@property (nonatomic, strong) RadioPlayerDataModel *data;

@property (nonatomic, assign) NSInteger code;

@end
@interface RadioPlayerDataModel : NSObject
//id->ID
@property (nonatomic, copy) NSString *ID;

@property (nonatomic, copy) NSString *htmlUrl;

@property (nonatomic, assign) NSInteger totalPage;

@property (nonatomic, copy) NSString *programImg;

@property (nonatomic, copy) NSString *image_big;

@property (nonatomic, assign) NSInteger programId;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *createTime;

@property (nonatomic, copy) NSString *programName;

@property (nonatomic, copy) NSString *image;

@property (nonatomic, copy) NSString *programDetails;

@property (nonatomic, strong) NSArray<RadioPlayerDataAudiolistModel *> *audiolist;

@property (nonatomic, copy) NSString *duration;

@property (nonatomic, strong) NSArray<RadioPlayerDataResourcelistModel *> *resourcelist;

@property (nonatomic, assign) NSInteger resourcelistCount;

@end

@interface RadioPlayerDataResourcelistModel : NSObject

@property (nonatomic, strong) NSArray<RadioPlayerDataResourceListAudiolistModel *> *audiolist;
//id->ID
@property (nonatomic, copy) NSString *ID;

@property (nonatomic, copy) NSString *htmlUrl;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *duration;

@property (nonatomic, copy) NSString *image_big;

@property (nonatomic, copy) NSString *image;

@property (nonatomic, copy) NSString *createTime;

@end

@interface RadioPlayerDataResourceListAudiolistModel : NSObject

@property (nonatomic, copy) NSString *size;

@property (nonatomic, copy) NSString *isDefault;

@property (nonatomic, copy) NSString *audioStream;

@property (nonatomic, copy) NSString *filePath;

@end

@interface RadioPlayerDataAudiolistModel : NSObject

@property (nonatomic, copy) NSString *size;

@property (nonatomic, copy) NSString *isDefault;

@property (nonatomic, copy) NSString *audioStream;

@property (nonatomic, copy) NSString *filePath;

@end

