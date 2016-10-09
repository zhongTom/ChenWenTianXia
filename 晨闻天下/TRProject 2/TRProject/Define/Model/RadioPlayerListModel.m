//
//  RadioPlayerListModel.m
//  TRProject
//
//  Created by 钟至大 on 16/8/18.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "RadioPlayerListModel.h"

@implementation RadioPlayerListModel

@end
@implementation RadioPlayerDataModel

+ (NSDictionary *)objClassInArray{
    return @{@"resourcelist" : [RadioPlayerDataResourcelistModel class], @"audiolist" : [RadioPlayerDataAudiolistModel class]};
}
+ (NSDictionary *)replaceKeyFromPropertyName{
    return @{@"ID":@"id"};
}
@end


@implementation RadioPlayerDataResourcelistModel

+ (NSDictionary *)objClassInArray{
    return @{@"audiolist" : [RadioPlayerDataResourceListAudiolistModel class]};
}
+ (NSDictionary *)replaceKeyFromPropertyName{
    return @{@"ID":@"id"};
}
@end


@implementation RadioPlayerDataResourceListAudiolistModel

@end


@implementation RadioPlayerDataAudiolistModel

@end


