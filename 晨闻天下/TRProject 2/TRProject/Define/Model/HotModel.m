//
//  HotModel.m
//  Project
//
//  Created by 钟至大 on 16/8/3.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "HotModel.h"

@implementation HotModel
MJCodingImplementation
@end
@implementation HotDataModel
MJCodingImplementation
+ (NSDictionary *)objClassInArray{
    return @{@"list" : [HotDataArticleModel class]};
}
+ (NSDictionary *)replaceKeyFromPropertyName{
    return @{@"list":@"article"};
}
@end


@implementation HotDataArticleModel
MJCodingImplementation
@end


