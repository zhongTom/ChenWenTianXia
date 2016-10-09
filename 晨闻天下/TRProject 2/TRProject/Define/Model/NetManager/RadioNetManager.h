//
//  RadioNetManager.h
//  TRProject
//
//  Created by 钟至大 on 16/8/16.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RadioNetManager : NSObject
+ (id)getRadioCompletionHandler:(void(^)(id model,NSError *error))completionHandler;
+ (id)getRadioListWithNodeId:(NSString *)nodeId page:(NSInteger)page completionHandler:(void(^)(id model,NSError *error))completionHandler;
+ (id)getRadioPlayerWithResourceId:(NSString *)resourceId page:(NSInteger)page completionHandler:(void(^)(id model,NSError *error))completionHandler;
@end
