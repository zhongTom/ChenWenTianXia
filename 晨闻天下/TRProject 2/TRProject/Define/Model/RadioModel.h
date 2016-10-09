//
//  RadioModel.h
//  TRProject
//
//  Created by 钟至大 on 16/8/16.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RadioDataModel,RadioDataFocusModel,RadioDataCardlistModel,RadioDataCardListCarddetailsModel;
@interface RadioModel : NSObject

@property (nonatomic, strong) RadioDataModel *data;

@property (nonatomic, assign) NSInteger code;

@end
@interface RadioDataModel : NSObject

@property (nonatomic, strong) NSArray<RadioDataFocusModel *> *focus;

@property (nonatomic, strong) NSArray<RadioDataCardlistModel *> *cardList;

@end

@interface RadioDataFocusModel : NSObject

@property (nonatomic, copy) NSString *bannerTitle;
//id->ID
@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, copy) NSString *redirectType;

@property (nonatomic, assign) NSInteger redirectId;

@property (nonatomic, copy) NSString *image;

@property (nonatomic, copy) NSString *activityUrl;

@end

@interface RadioDataCardlistModel : NSObject

@property (nonatomic, copy) NSString *nodeId;

@property (nonatomic, copy) NSString *nodeName;
//id->ID
@property (nonatomic, copy) NSString *ID;

@property (nonatomic, strong) NSArray<RadioDataCardListCarddetailsModel *> *cardDetails;

@property (nonatomic, copy) NSString *cardTitle;

@property (nonatomic, copy) NSString *sourceType;

@property (nonatomic, copy) NSString *jumpType;

@end

@interface RadioDataCardListCarddetailsModel : NSObject

@property (nonatomic, assign) NSInteger listenNumShow;
//id->ID
@property (nonatomic, copy) NSString *ID;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *image;

@property (nonatomic, copy) NSString *programName;

@end

