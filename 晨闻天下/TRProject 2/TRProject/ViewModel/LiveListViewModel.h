//
//  LiveListViewModel.h
//  TRProject
//
//  Created by 钟至大 on 16/8/23.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LiveListModel.h"
@interface LiveListViewModel : NSObject
/** 直播列表 */
//根据效果图

@property (nonatomic) NSInteger rowNumber;
- (NSString *)getTitleForRow:(NSInteger)row;
- (NSURL *)getURLForRow:(NSInteger)row;
- (NSString *)getTimeForRow:(NSInteger)row;
- (NSString *)getLiveStateForRow:(NSInteger)row;
//根据数据
@property (nonatomic) NSString *specialID;
@property (nonatomic) NSMutableArray<LiveListDocsModel *> *liveList;
- (instancetype)initWithSpecialID:(NSString *)specialID;
- (void)getLiveListCompletionHandler:(void(^)(NSError *error))completionHandler;
- (NSString *)getSkipIDForRow:(NSInteger)row;
@end
