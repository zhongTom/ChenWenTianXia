//
//  TVViewModel.h
//  TRProject
//
//  Created by 钟至大 on 16/8/12.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TVModel.h"
@interface TVViewModel : NSObject
/* 根据效果图 */
@property (nonatomic) NSInteger rowNumber;
- (NSURL *)getURLForRow:(NSInteger)row;
- (NSString *)getTitleForRow:(NSInteger)row;
- (NSString *)getPlayTimeForRow:(NSInteger)row;
- (NSString *)getCommentForRow:(NSInteger)row;
- (NSString *)getDurationForRow:(NSInteger)row;
- (NSURL *)getVedioURLForRow:(NSInteger)row;
/* 根据Model */
@property (nonatomic) NSMutableArray<TVItemModel *> *dataList;
- (instancetype)initWithTypeId:(NSInteger)typeId;
@property (nonatomic) NSInteger typeId;
@property (nonatomic) NSInteger page;
- (void)getTVDataWithRequestMode:(RequestMode)mode completionHandler:(void(^)(NSError *error))completionHandler;
@end
