//
//  RadioViewModel.h
//  TRProject
//
//  Created by 钟至大 on 16/8/16.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RadioModel.h"

@interface RadioViewModel : NSObject
/** 主界面 */
 /** 效果图部分 */
@property (nonatomic) NSInteger sectionNumber;
- (NSString *)getBigTitleForSection:(NSInteger)section;
- (NSArray<NSURL *> *)getURLForSection:(NSInteger)section;
- (NSArray<NSString *> *)getSmallTitleForSection:(NSInteger)section;
- (NSArray<NSString *> *)getOriginForSection:(NSInteger)section;

 /** 数据部分 */
@property (nonatomic) NSMutableArray<RadioDataCardlistModel *> *cardList;
- (void)getRadioCompletionHandler:(void(^)(NSError *error))completionHandler;
- (NSString *)getNodeIdForSection:(NSInteger)section;
- (NSArray *)getIdForSection:(NSInteger)section;
 /** 头部滚动视图 */
@property (nonatomic) NSInteger icNumber;
@property (nonatomic) NSMutableArray<RadioDataFocusModel *> *focusList;
- (NSURL *)getTopIconURLForRow:(NSInteger)row;
- (NSString *)getTopTitleForRow:(NSInteger)row;
@end
