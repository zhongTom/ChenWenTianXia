//
//  APIModel.m
//  Project
//
//  Created by 钟至大 on 16/8/3.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "APIModel.h"

@implementation APIModel
MJCodingImplementation

+ (NSDictionary *)objClassInArray{
    return @{@"list" : [APINewslistModel class]};
}
+ (NSDictionary *)replaceKeyFromPropertyName{
    return @{@"list":@"newslist"};
}
@end
@implementation APINewslistModel
MJCodingImplementation
+ (NSDictionary *)replaceKeyFromPropertyName{
    return @{@"Description":@"description"};
}
@end


