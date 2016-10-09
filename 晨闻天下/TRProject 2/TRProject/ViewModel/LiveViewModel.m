//
//  LiveViewModel.m
//  TRProject
//
//  Created by 钟至大 on 16/8/20.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "LiveViewModel.h"
#import "LiveNetManager.h"
#import "CacheManager.h"
@implementation LiveViewModel
MJCodingImplementation
- (instancetype)init
{
    self = [super init];
    if (self) {
        id obj = [CacheManager getModelForLive];
        if (obj) {
            self = obj;
        }
    }
    return self;
}
- (NSInteger)bigRowNumber{
    return self.bigList.count;
}
- (NSInteger)smallRowNumber{
    return self.smallList.count;
}
- (NSMutableArray<ListModel *> *)bigList{
    if (_bigList == nil) {
        _bigList = [NSMutableArray new];
    }
    return _bigList;
}
- (NSMutableArray<SpecialListModel *> *)smallList{
    if (_smallList == nil) {
        _smallList = [NSMutableArray new];
    }
    return _smallList;
}
- (BOOL)isLiveStyleForSection:(NSInteger)section{
    if (section == 0) {
        return YES;
    }else{
        return NO;
    }
}
- (NSString *)getUserCountForIndexPath:(NSIndexPath *)indexPath{
    if ([self isLiveStyleForSection:indexPath.section]) {
        if ([self.bigList[indexPath.row].TAG isEqualToString:@"直播预告"]) {
            NSRange range = [self.bigList[indexPath.row].live_info.start_time rangeOfString:@" "];
            return [NSString stringWithFormat:@"%@",[self.bigList[indexPath.row].live_info.start_time substringFromIndex:range.location]];
        }else {
            return [NSString stringWithFormat:@"%.2f万参与",self.bigList[indexPath.row].live_info.user_count*1.0/10000];
        }
    }else{
        if ([self.smallList[indexPath.section-1].specialextra[indexPath.row-1].TAG isEqualToString:@"直播预告"]) {
            NSRange range = [self.smallList[indexPath.section-1].specialextra[indexPath.row-1].live_info.start_time rangeOfString:@" "];
            return [NSString stringWithFormat:@"%@",[self.smallList[indexPath.section-1].specialextra[indexPath.row-1].live_info.start_time substringFromIndex:range.location]];
        }else {
            return [NSString stringWithFormat:@"%.2f万参与",self.smallList[indexPath.section-1].specialextra[indexPath.row-1].live_info.user_count*1.0/10000];
        }
    }
}
- (NSString *)getLiveStateForIndexPath:(NSIndexPath *)indexPath{
    if ([self isLiveStyleForSection:indexPath.section]) {
        return self.bigList[indexPath.row].TAG;
    }else{
        return self.smallList[indexPath.section-1].specialextra[indexPath.row-1].TAG;
    }
}
- (NSString *)getSubTitleForIndexPath:(NSIndexPath *)indexPath{
    if ([self.smallList[indexPath.section-1].subtitle containsString:@"网易"]) {
        return [self.smallList[indexPath.section-1].subtitle stringByReplacingOccurrencesOfString:@"网易" withString:@"晨闻"];
    }
    return self.smallList[indexPath.section-1].subtitle;
}
- (NSString *)getTitleForIndexPath:(NSIndexPath *)indexPath{
    if ([self isLiveStyleForSection:indexPath.section]) {
        return self.bigList[indexPath.row].title;
    }else{
        return self.smallList[indexPath.section-1].specialextra[indexPath.row-1].title;
    }
}

- (NSURL *)getURLsForIndexPath:(NSIndexPath *)indexPath{
    if ([self isLiveStyleForSection:indexPath.section]) {
        return [NSURL URLWithString:self.bigList[indexPath.row].imgsrc];
    }else{
        return [NSURL URLWithString:self.smallList[indexPath.section-1].specialextra[indexPath.row-1].imgsrc];
    }
}
- (void)getLiveWithRequestMode:(RequestMode)mode completionHandler:(void (^)(NSError *))completionHandler{
    NSInteger tmpPage = 0;
    switch (mode) {
        case RequestModeRefresh: {
            tmpPage = 0;
            break;
        }
        case RequestModeMore: {
            tmpPage = self.page + 1;
            break;
        }
    }
    [LiveNetManager getLiveWithPage:tmpPage completionHandler:^(NSArray<ListModel *> *liveModel, NSArray<SpecialListModel *> *specialModel, NSError *error) {
        if (!error) {
            if (mode == RequestModeRefresh) {
                [self.bigList removeAllObjects];
                [self.smallList removeAllObjects];
            }
            [self.bigList addObjectsFromArray:liveModel];
            [self.smallList addObjectsFromArray:specialModel];
            _page = tmpPage;
            
        }
        [CacheManager saveLiveModel:self];
        completionHandler(error);
    }];
}
- (NSString *)getSpecialIDForSection:(NSInteger)section{
    return self.smallList[section-1].specialID;
}
@end
