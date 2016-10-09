//
//  NetModel.m
//  Project
//
//  Created by 钟至大 on 16/8/4.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "NetModel.h"

@implementation NetModel
MJCodingImplementation

+ (NSDictionary *)objClassInArray{
    return @{@"list" : [NetDataModel class]};
}
+ (NSDictionary *)replaceKeyFromPropertyName{
    return @{@"list":@"T1348648141035"};
}
@end



@implementation NetDataModel
MJCodingImplementation
+ (NSDictionary *)objClassInArray{
    return @{@"imgextra" : [NetDataImgextraModel class]};
}

@end


@implementation NetDataImgextraModel
MJCodingImplementation
@end


