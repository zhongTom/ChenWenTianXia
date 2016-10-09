//
//  RadioModel.m
//  TRProject
//
//  Created by 钟至大 on 16/8/16.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "RadioModel.h"

@implementation RadioModel
MJCodingImplementation
+ (NSDictionary *)replaceKeyFromPropertyName{
    return @{@"ID":@"id"};
}
@end
@implementation RadioDataModel
MJCodingImplementation
+ (NSDictionary *)objClassInArray{
    return @{@"focus" : [RadioDataFocusModel class], @"cardList" : [RadioDataCardlistModel class]};
}
+ (NSDictionary *)replaceKeyFromPropertyName{
    return @{@"ID":@"id"};
}
@end


@implementation RadioDataFocusModel
MJCodingImplementation
+ (NSDictionary *)replaceKeyFromPropertyName{
    return @{@"ID":@"id"};
}
@end


@implementation RadioDataCardlistModel
MJCodingImplementation
+ (NSDictionary *)objClassInArray{
    return @{@"cardDetails" : [RadioDataCardListCarddetailsModel class]};
}
+ (NSDictionary *)replaceKeyFromPropertyName{
    return @{@"ID":@"id"};
}
@end


@implementation RadioDataCardListCarddetailsModel
MJCodingImplementation
+ (NSDictionary *)replaceKeyFromPropertyName{
    return @{@"ID":@"id"};
}
@end


