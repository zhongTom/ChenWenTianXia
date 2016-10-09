//
//  XiaoHuaModel.m
//  Project
//
//  Created by 钟至大 on 16/8/3.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "XiaoHuaModel.h"

@implementation XiaoHuaModel
MJCodingImplementation
@end
@implementation XiaoHuaRes_BodyModel
MJCodingImplementation
+ (NSDictionary *)objClassInArray{
    return @{@"list" : [XiaoHuaJokelistModel class]};
}
+ (NSDictionary *)replaceKeyFromPropertyName{
    return @{@"list":@"JokeList"};
}
@end


@implementation XiaoHuaJokelistModel
MJCodingImplementation
@end


