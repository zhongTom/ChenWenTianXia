//
//  LiveRoomViewModel.h
//  TRProject
//
//  Created by 钟至大 on 16/8/21.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LiveRoomModel.h"
@interface LiveRoomViewModel : NSObject
/** 根据效果图 */
@property (nonatomic) LiveRoomModel *liveRoomModel;
- (NSURL *)getIconURLForRow:(NSInteger)row;
- (NSString *)getTitleForRow:(NSInteger)row;
- (NSString *)getTimeForRow:(NSInteger)row;
- (NSString *)getContentTextForRow:(NSInteger)row;
- (NSURL *)getContentURLForRow:(NSInteger)row;
/** 根据数据 */
@property (nonatomic) NSInteger rowNumber;
- (BOOL)isHasVedioForHeader;
- (BOOL)isHasContentURLForRow:(NSInteger)row;
- (instancetype)initWithSkipId:(NSString *)skipId;
@property (nonatomic) NSInteger nextPage;
@property (nonatomic) NSString *skipId;
- (void)getLiveRoomModelWithRequestMode:(RequestMode)mode completionHandler:(void(^)(NSError *error))completionHandler;
- (CGSize)getContentSizeForRow:(NSInteger)row;
@property (nonatomic) NSMutableArray<MessagesModel *> *messages;
@end
