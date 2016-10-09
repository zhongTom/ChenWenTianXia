//
//  RadioPlayerListViewModel.m
//  TRProject
//
//  Created by 钟至大 on 16/8/18.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "RadioPlayerListViewModel.h"

@implementation RadioPlayerListViewModel
- (instancetype)initWithResourceId:(NSString *)resourceId{
    if (self = [super init]) {
        self.resourceId = resourceId;
    }
    return self;
}
- (instancetype)init{
    if (self = [super init]) {
        NSAssert(NO, @"%s必须使用initWithResourceId初始化",__FUNCTION__);
    }
    return self;
}
- (NSInteger)rowNumber{
    return self.list.count;
}

- (NSMutableArray<RadioPlayerDataResourcelistModel *> *)list{
    if (!_list) {
        _list = [NSMutableArray new];
    }
    return _list;
}
- (RadioPlayerDataResourcelistModel *)modelForRow:(NSInteger)row{
    return self.list[row];
}
- (NSURL *)getIconURLForRow:(NSInteger)row{
    return [NSURL URLWithString:[self modelForRow:row].image];
}
- (NSString *)getTitleForRow:(NSInteger)row{
    return [self modelForRow:row].title;
}
- (NSString *)getDateForRow:(NSInteger)row{
    return [self modelForRow:row].createTime;
}
- (NSURL *)getHtmlURLWithForRow:(NSInteger)row{
    NSString *path = ((RadioPlayerDataResourceListAudiolistModel *)[self modelForRow:row].audiolist.firstObject).filePath;
    NSString *filePath = [path stringByReplacingOccurrencesOfString:@"\\" withString:@""];
    return [NSURL URLWithString:filePath];
}
- (void)getRadioPlayerWithRequestMode:(RequestMode)mode CompletionHandler:(void (^)(NSError *))completionHandler{
    NSInteger tmpPage = 1;
    switch (mode) {
        case RequestModeRefresh: {
            tmpPage = 1;
            break;
        }
        case RequestModeMore: {
            tmpPage = self.page+1;
            break;
        }
    }
    [RadioNetManager getRadioPlayerWithResourceId:self.resourceId page:tmpPage completionHandler:^(RadioPlayerListModel *model, NSError *error) {
        if (!error) {
            if (mode == RequestModeRefresh) {
                [self.list removeAllObjects];
            }
            [self.list addObjectsFromArray:model.data.resourcelist];
        }
        self.page = tmpPage;
        completionHandler(error);
    }];
}
@end
