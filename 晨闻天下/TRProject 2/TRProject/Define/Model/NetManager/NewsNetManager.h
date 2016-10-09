//
//  NewsNetManager.h
//  Project
//
//  Created by 钟至大 on 16/8/2.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "NSObject+AFNetworking.h"
#import "RequestPath.h"
@interface NewsNetManager : NSObject
//带有apiKey的请求,用于API接口数据
+ (id)getNewsForNewsType:(NewsType)newsType num:(NSInteger)num page:(NSInteger)page completionHandler:(void(^)(id model,NSError *error))completionHandler;

@end
