//
//  CacheManager.h
//  TRProject
//
//  Created by 钟至大 on 16/8/6.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RequestPath.h"
#import "NewsViewModel.h"
#import "InfoLisViewModel.h"
#import "TVViewModel.h"
#import "RadioViewModel.h"
#import "LiveViewModel.h"
@interface CacheManager : NSObject
/** 获取路径 */
+ (NSString *)getPathForNewsType:(NewsType)type;
/** 归档 */
+ (BOOL)saveNewsModel:(NewsViewModel *)newsVM;
/** 解档 */
+ (id)getNewsModelWith:(NewsType)type;
/** 获取路径 */
+ (NSString *)getPathForCar;
/** 归档 */
+ (BOOL)saveCarModel:(InfoLisViewModel *)infoVM;
/** 解档 */
+ (id)getNewsModelWithCar;

//视频
/** 获取路径 */
+ (NSString *)getPathForTVType:(NSInteger)type;
/** 归档 */
+ (BOOL)saveTVModel:(TVViewModel *)tVVM;
/** 解档 */
+ (id)getModelWithTVWith:(NSInteger)type;

//电台
/** 获取路径 */
+ (NSString *)getPathForRadio;
/** 归档 */
+ (BOOL)saveRadioModel:(RadioViewModel *)RadioVM;
/** 解档 */
+ (id)getModelForRadio;

//直播
/** 获取路径 */
+ (NSString *)getPathForLive;
/** 归档 */
+ (BOOL)saveLiveModel:(LiveViewModel *)LiveVM;
/** 解档 */
+ (id)getModelForLive;
@end
