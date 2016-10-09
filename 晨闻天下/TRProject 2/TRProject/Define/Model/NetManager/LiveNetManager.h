//
//  LiveNetManager.h
//  TRProject
//
//  Created by 钟至大 on 16/8/19.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LiveNetManager : NSObject
+ (id)getLiveWithPage:(NSInteger)page completionHandler:(void(^)(id liveModel,id specialModel ,NSError *error))completionHandler;
+ (id)getLiveRoomWithSkipId:(NSString *)skipId nextPage:(NSInteger)nextPage completionHandler:(void(^)(id model,NSError *error))completionHandler;
+ (id)getLiveListWithSpecialId:(NSString *)specialId completionHandler:(void(^)(id model,NSError *error))completionHandler;
@end
