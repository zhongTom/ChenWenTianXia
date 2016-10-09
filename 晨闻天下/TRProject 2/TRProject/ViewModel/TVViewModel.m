//
//  TVViewModel.m
//  TRProject
//
//  Created by 钟至大 on 16/8/12.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "TVViewModel.h"
#import "TVNetManager.h"
#import "CacheManager.h"
@implementation TVViewModel
MJCodingImplementation
- (instancetype)initWithTypeId:(NSInteger)typeId{
    if (self = [super init]) {
        self.typeId = typeId;
        self.page = 1;
        id obj = [CacheManager getModelWithTVWith:typeId];
        if (obj) {
            self = obj;
        }
    }
    return self;
}
- (NSInteger)rowNumber{
    return self.dataList.count;
}
- (TVItemModel *)modelForRow:(NSInteger)row{
    return self.dataList[row];
}
- (NSURL *)getURLForRow:(NSInteger)row{
    return [NSURL URLWithString:[self modelForRow:row].image];
}
- (NSString *)getTitleForRow:(NSInteger)row{
    return [self modelForRow:row].title;
}
- (NSString *)getPlayTimeForRow:(NSInteger)row{
    return [self modelForRow:row].playTime;
}
- (NSString *)getCommentForRow:(NSInteger)row{
    return @([self modelForRow:row].commentsall).stringValue;
}
- (NSString *)getDurationForRow:(NSInteger)row{
    NSString *ss = nil;
    if ([self modelForRow:row].duration%60>9) {
        ss = [NSString stringWithFormat:@"%ld",[self modelForRow:row].duration%60];
    }else{
        ss = [NSString stringWithFormat:@"0%ld",[self modelForRow:row].duration%60];
    }
    return [NSString stringWithFormat:@"%ld'%@\"",[self modelForRow:row].duration/60,ss];
}
- (NSURL *)getVedioURLForRow:(NSInteger)row{
    return [NSURL URLWithString:[self modelForRow:row].video_url];
}
- (NSMutableArray<TVItemModel *> *)dataList{
    if (!_dataList) {
        _dataList = [NSMutableArray new];
    }
    return _dataList;
}
- (void)getTVDataWithRequestMode:(RequestMode)mode completionHandler:(void(^)(NSError *))completionHandler{
    NSInteger tmpPage = 1;
    switch (mode) {
        case RequestModeRefresh: {
            tmpPage = 1;
            break;
        }
        case RequestModeMore: {
            tmpPage = _page + 1;
            break;
        }
    }
    self.dataTask = [TVNetManager getTVDataWithTypeId:_typeId page:tmpPage completionHandler:^(NSArray *model, NSError *error) {
        if (!error) {
            if (mode == RequestModeRefresh) {
                [self.dataList removeAllObjects];
            }
            [self.dataList addObjectsFromArray:((TVModel *)(model.firstObject)).item];
            [CacheManager saveTVModel:self];
        }
        _page = tmpPage;
        
        completionHandler(error);
    }];
    

}
@end
