//
//  LiveListModel.m
//  TRProject
//
//  Created by 钟至大 on 16/8/23.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "LiveListModel.h"

@implementation LiveListModel
MJCodingImplementation
+(NSDictionary *)replaceKeyFromPropertyName{
    return @{@"list":@"S1462934631724"};
}
@end
@implementation LiveList
MJCodingImplementation
+ (NSDictionary *)objClassInArray{
    return @{@"topics" : [LiveListTopicsModel class]};
}

@end


@implementation LiveListTopicsModel
MJCodingImplementation
+ (NSDictionary *)objClassInArray{
    return @{@"docs" : [LiveListDocsModel class]};
}

@end


@implementation LiveListDocsModel
MJCodingImplementation
@end


@implementation LiveListLive_InfoModel
MJCodingImplementation
@end


