//
//  LiveListLiveTypeModel.m
//  TRProject
//
//  Created by 钟至大 on 16/8/20.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "LiveListLiveTypeModel.h"

@implementation LiveListLiveTypeModel

MJCodingImplementation
+ (NSDictionary *)objClassInArray{
    return @{@"list" : [ListModel class]};
}
+(NSDictionary *)replaceKeyFromPropertyName{
    return @{@"list":@"T1462958418713"};
}
@end
@implementation ListModel
MJCodingImplementation
@end


@implementation Live_InfoModel
MJCodingImplementation
@end


