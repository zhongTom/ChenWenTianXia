//
//  RadioListViewModel.m
//  TRProject
//
//  Created by 钟至大 on 16/8/17.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "RadioListViewModel.h"
#import "RadioNetManager.h"
@implementation RadioListViewModel
- (instancetype)initWithNodeId:(NSString *)nodeId{
    if (self = [super init]) {
        _nodeId = nodeId;
        _page = 1;
    }
    return self;
}
- (NSInteger)rowNumber{
    return self.list.count;
}
- (NSMutableArray<RadioListDataProgramlistModel *> *)list{
    if (!_list) {
        _list = [NSMutableArray new];
    }
    return _list;
}
- (RadioListDataProgramlistModel *)modelForRow:(NSInteger)row{
    return self.list[row];
}
- (NSURL *)getIconURLForRow:(NSInteger)row{
    return [NSURL URLWithString:[self modelForRow:row].programImg];
}
- (NSString *)getTitleForRow:(NSInteger)row{
    return [self modelForRow:row].programName;
}
- (NSString *)getDescriptionForRow:(NSInteger)row{
    return [self modelForRow:row].programDetails;
}
- (NSString *)getResourceId:(NSInteger)row{
    return @([self modelForRow:row].resourceId).stringValue;
}
- (void)getRadioListWithRequestMode:(RequestMode)mode CompletionHandler:(void (^)(NSError *))completionHandler{
    NSInteger tmpPage = 1;
    switch (mode) {
        case RequestModeRefresh: {
            tmpPage = 1;
            break;
        }
        case RequestModeMore: {
            tmpPage = self.page + 1;
            break;
        }
    }
    [RadioNetManager getRadioListWithNodeId:_nodeId page:tmpPage completionHandler:^(RadioListModel *model, NSError *error) {
        if (!error) {
            if (mode == RequestModeRefresh) {
                [self.list removeAllObjects];
            }
            [self.list addObjectsFromArray:model.data.programList];
        }
        _page = tmpPage;
        completionHandler(error);
    }];
}
@end
