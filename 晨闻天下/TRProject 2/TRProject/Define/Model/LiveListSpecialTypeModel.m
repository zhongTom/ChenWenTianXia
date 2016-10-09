//
//  LiveListSpecialTypeModel.m
//  TRProject
//
//  Created by 钟至大 on 16/8/20.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "LiveListSpecialTypeModel.h"

@implementation LiveListSpecialTypeModel

MJCodingImplementation
+ (NSDictionary *)objClassInArray{
    return @{@"list" : [SpecialListModel class]};
}
+ (NSDictionary *)replaceKeyFromPropertyName{
    return @{@"list":@"T1462958418713"};
}
@end
@implementation SpecialListModel
MJCodingImplementation
+ (NSDictionary *)objClassInArray{
    return @{@"specialextra" : [SpecialextraModel class]};
}

@end


@implementation SpecialextraModel
MJCodingImplementation
@end


@implementation SpecialLive_InfoModel
MJCodingImplementation
@end

