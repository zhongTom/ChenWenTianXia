//
//  RadioPlayerListViewModel.h
//  TRProject
//
//  Created by 钟至大 on 16/8/18.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RadioPlayerListModel.h"
#import "RadioNetManager.h"
@interface RadioPlayerListViewModel : NSObject
/** 播放界面 */
/** 效果图部分 */
@property (nonatomic) NSInteger rowNumber;
- (NSURL *)getIconURLForRow:(NSInteger)row;
- (NSString *)getTitleForRow:(NSInteger)row;
- (NSString *)getDateForRow:(NSInteger)row;
/** 数据部分 */
@property (nonatomic) NSMutableArray<RadioPlayerDataResourcelistModel *> *list;
@property (nonatomic) NSInteger page;
@property (nonatomic) NSString *resourceId;
- (instancetype)initWithResourceId:(NSString *)resourceId;
- (void)getRadioPlayerWithRequestMode:(RequestMode)mode CompletionHandler:(void(^)(NSError *error))completionHandler;
- (NSURL *)getHtmlURLWithForRow:(NSInteger)row;

@end
