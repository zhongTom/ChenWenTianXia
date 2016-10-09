//
//  LiveNetManager.m
//  TRProject
//
//  Created by 钟至大 on 16/8/19.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "LiveNetManager.h"
#import "LiveListLiveTypeModel.h"
#import "LiveListSpecialTypeModel.h"
#import "LiveRoomModel.h"
#import "LiveListModel.h"
@implementation LiveNetManager
+ (id)getLiveWithPage:(NSInteger)page completionHandler:(void (^)(id,id, NSError *))completionHandler{
    NSString *path = [NSString stringWithFormat:@"http://c.m.163.com/nc/live/list/all/%ld-%ld.html",page*20,20*(page+1)];
    return [self GET:path parameters:nil progress:nil completionHandler:^(NSMutableDictionary *responseObj, NSError *error) {
        NSArray *arr = responseObj[responseObj.allKeys.firstObject];
        NSMutableArray *liveArr = [NSMutableArray new];
        NSMutableArray *specialArr = [NSMutableArray new];
        for (int i = 0; i < arr.count; i++) {
            if ([[arr[i] valueForKey:@"skipType"] isEqualToString:@"live"]) {
                [liveArr addObject:arr[i]];
            }else{
                [specialArr addObject:arr[i]];
            }
        }
        id liveModel = [ListModel mj_objectArrayWithKeyValuesArray:liveArr];
        id specialModel = [SpecialListModel mj_objectArrayWithKeyValuesArray:specialArr];
        completionHandler(liveModel,specialModel,error);
    }];
}
+ (id)getLiveRoomWithSkipId:(NSString *)skipId nextPage:(NSInteger)nextPage completionHandler:(void (^)(id, NSError *))completionHandler{
    NSString *path = nil;
    if (nextPage > 0) {
         path = [NSString stringWithFormat:@"http://data.live.126.net/liveAll/%@/%ld.json",skipId,nextPage];
    }else{
         path = [NSString stringWithFormat:@"http://data.live.126.net/liveAll/%@.json",skipId];
    }
    return [self GET:path parameters:nil progress:nil completionHandler:^(id responseObj, NSError *error) {
        completionHandler([LiveRoomModel parse:responseObj],error);
    }];
   
}
+ (id)getLiveListWithSpecialId:(NSString *)specialId completionHandler:(void (^)(id, NSError *))completionHandler{
    NSString *path = [NSString stringWithFormat:@"http://c.m.163.com/nc/special/%@.html",specialId];
    return [self GET:path parameters:nil progress:nil completionHandler:^(NSMutableDictionary *responseObj, NSError *error) {
        NSDictionary *model = responseObj[responseObj.allKeys.firstObject];
        completionHandler([LiveList parse:model],error);
    }];
}
@end
