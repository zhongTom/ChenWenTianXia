//
//  RadioListViewModel.h
//  TRProject
//
//  Created by 钟至大 on 16/8/17.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RadioListModel.h"
@interface RadioListViewModel : NSObject
/** 列表界面 */
/** 效果图部分 */
@property (nonatomic) NSInteger rowNumber;
- (NSURL *)getIconURLForRow:(NSInteger)row;
- (NSString *)getTitleForRow:(NSInteger)row;
- (NSString *)getDescriptionForRow:(NSInteger)row;
- (NSString *)getResourceId:(NSInteger)row;
/** 数据部分 */
@property (nonatomic) NSMutableArray<RadioListDataProgramlistModel *> *list;
@property (nonatomic) NSString * nodeId;
@property (nonatomic) NSInteger page;
- (void)getRadioListWithRequestMode:(RequestMode)mode CompletionHandler:(void(^)(NSError *error))completionHandler;
- (instancetype)initWithNodeId:(NSString *)nodeId;

@end
