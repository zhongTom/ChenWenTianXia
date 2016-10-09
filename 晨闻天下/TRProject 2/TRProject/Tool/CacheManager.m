//
//  CacheManager.m
//  TRProject
//
//  Created by 钟至大 on 16/8/6.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "CacheManager.h"

@implementation CacheManager
+ (NSString *)getPathForNewsType:(NewsType)type{
    return [kDocPath stringByAppendingPathComponent:@(type).stringValue];
}
+ (BOOL)saveNewsModel:(NewsViewModel *)newsVM{
    return [NSKeyedArchiver archiveRootObject:newsVM toFile:[self getPathForNewsType:newsVM.newsType]];
}
+ (id)getNewsModelWith:(NewsType)type{
    return [NSKeyedUnarchiver unarchiveObjectWithFile:[self getPathForNewsType:type]];
}
/** 获取路径 */
+ (NSString *)getPathForCar{
    return [kDocPath stringByAppendingPathComponent:@"car"];
}
/** 归档 */
+ (BOOL)saveCarModel:(InfoLisViewModel *)infoVM{
    return [NSKeyedArchiver archiveRootObject:infoVM toFile:[self getPathForCar]];
}
/** 解档 */
+ (id)getNewsModelWithCar{
    return [NSKeyedUnarchiver unarchiveObjectWithFile:[self getPathForCar]];
}
+ (NSString *)getPathForTVType:(NSInteger)type{
    return [kDocPath stringByAppendingString:@(type).stringValue];
}
+ (BOOL)saveTVModel:(TVViewModel *)tVVM{
    return [NSKeyedArchiver archiveRootObject:tVVM toFile:[self getPathForTVType:tVVM.typeId]];
}
+ (id)getModelWithTVWith:(NSInteger)type{
    return [NSKeyedUnarchiver unarchiveObjectWithFile:[self getPathForTVType:type]];
}
//电台
+ (NSString *)getPathForRadio{
    return [kDocPath stringByAppendingPathComponent:@"radio"];
}
+ (BOOL)saveRadioModel:(RadioViewModel *)RadioVM{
    return [NSKeyedArchiver archiveRootObject:RadioVM toFile:[self getPathForRadio]];
}
+ (id)getModelForRadio{
    return [NSKeyedUnarchiver unarchiveObjectWithFile:[self getPathForRadio]];
}
//直播
+ (NSString *)getPathForLive{
    return [kDocPath stringByAppendingPathComponent:@"live"];
}
+ (BOOL)saveLiveModel:(LiveViewModel *)LiveVM{
    return [NSKeyedArchiver archiveRootObject:LiveVM toFile:[self getPathForLive]];
}
+ (id)getModelForLive{
    return [NSKeyedUnarchiver unarchiveObjectWithFile:[self getPathForLive]];
}
@end
