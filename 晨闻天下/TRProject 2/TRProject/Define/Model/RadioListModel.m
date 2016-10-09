//
//  RadioListModel.m
//  TRProject
//
//  Created by 钟至大 on 16/8/17.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "RadioListModel.h"

@implementation RadioListModel

@end
@implementation RadioListDataModel

+ (NSDictionary *)objClassInArray{
    return @{@"programList" : [RadioListDataProgramlistModel class]};
}

@end


@implementation RadioListDataProgramlistModel
+ (NSDictionary *)replaceKeyFromPropertyName{
    return @{@"ID":@"id"};
}
@end


