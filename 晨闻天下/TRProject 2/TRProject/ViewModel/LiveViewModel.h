//
//  LiveViewModel.h
//  TRProject
//
//  Created by 钟至大 on 16/8/20.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LiveListLiveTypeModel.h"
#import "LiveListSpecialTypeModel.h"
@interface LiveViewModel : NSObject
/** 直播主界面 */
- (NSString *)getUserCountForIndexPath:(NSIndexPath *)indexPath;
- (NSString *)getLiveStateForIndexPath:(NSIndexPath *)indexPath;
- (NSString *)getSubTitleForIndexPath:(NSIndexPath *)indexPath;
- (NSString *)getTitleForIndexPath:(NSIndexPath *)indexPath;
- (NSURL *)getURLsForIndexPath:(NSIndexPath *)indexPath;
- (BOOL)isLiveStyleForSection:(NSInteger)section;
- (void)getLiveWithRequestMode:(RequestMode)mode completionHandler:(void(^)(NSError *error))completionHandler;
/** 大图标直播 */
//根据效果图
@property (nonatomic) NSInteger bigRowNumber;
//根据数据
@property (nonatomic) NSMutableArray<ListModel *> *bigList;
@property (nonatomic) NSInteger page;
/** 小图标直播 */
//根据效果图
@property (nonatomic) NSInteger smallRowNumber;
- (NSString *)getSpecialIDForSection:(NSInteger)section;
//根据数据
@property (nonatomic) NSMutableArray<SpecialListModel *> *smallList;
@end
