//
//  TVModel.m
//  TRProject
//
//  Created by 钟至大 on 16/8/12.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "TVModel.h"

@implementation TVModel
MJCodingImplementation

+ (NSDictionary *)objectClassInArray{
    
    return @{@"item" : [TVItemModel class]};
}
@end
@implementation TVItemModel
MJCodingImplementation
@end


