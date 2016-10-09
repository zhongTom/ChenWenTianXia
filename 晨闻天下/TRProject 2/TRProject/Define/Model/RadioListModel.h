//
//  RadioListModel.h
//  TRProject
//
//  Created by 钟至大 on 16/8/17.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RadioListDataModel,RadioListDataProgramlistModel;
@interface RadioListModel : NSObject

@property (nonatomic, strong) RadioListDataModel *data;

@property (nonatomic, assign) NSInteger code;

@end
@interface RadioListDataModel : NSObject

@property (nonatomic, strong) NSArray<RadioListDataProgramlistModel *> *programList;

@property (nonatomic, copy) NSString *nodeName;

@property (nonatomic, assign) NSInteger totalPage;

@property (nonatomic, assign) NSInteger programListCount;

@end

@interface RadioListDataProgramlistModel : NSObject
//id->ID
@property (nonatomic, copy) NSString *ID;

@property (nonatomic, copy) NSString *programDetails;

@property (nonatomic, copy) NSString *programImg;

@property (nonatomic, assign) NSInteger resourceId;

@property (nonatomic, copy) NSString *resourceTitle;

@property (nonatomic, copy) NSString *programName;

@end

