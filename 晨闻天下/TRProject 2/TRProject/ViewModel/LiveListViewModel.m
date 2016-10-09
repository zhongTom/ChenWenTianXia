//
//  LiveListViewModel.m
//  TRProject
//
//  Created by 钟至大 on 16/8/23.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "LiveListViewModel.h"
#import "LiveNetManager.h"
@implementation LiveListViewModel
- (instancetype)initWithSpecialID:(NSString *)specialID{
    if (self = [super init]) {
        self.specialID = specialID;
    }
    return self;
}
- (NSInteger)rowNumber{
    return self.liveList.count;
}
- (LiveListDocsModel *)modelForRow:(NSInteger)row{
    return self.liveList[row];
}
- (NSString *)getTitleForRow:(NSInteger)row{
    return [self modelForRow:row].title;
}
- (NSURL *)getURLForRow:(NSInteger)row{
    return [NSURL URLWithString:[self modelForRow:row].imgsrc];
}
- (NSString *)getLiveStateForRow:(NSInteger)row{
    return [self modelForRow:row].TAG;
}
- (NSString *)getTimeForRow:(NSInteger)row{
    if ([[self getLiveStateForRow:row]isEqualToString:@"直播预告"]) {
        NSRange range = [[self modelForRow:row].live_info.start_time rangeOfString:@" "];
        return [[self modelForRow:row].live_info.start_time substringFromIndex:range.location];
    }else{
        return [NSString stringWithFormat:@"%.2f万人参与",[self modelForRow:row].live_info.user_count*1.0/10000];
    }
}
- (NSString *)getSkipIDForRow:(NSInteger)row{
    return [self modelForRow:row].skipID;
}
- (void)getLiveListCompletionHandler:(void (^)())completionHandler{
    [LiveNetManager getLiveListWithSpecialId:self.specialID completionHandler:^(LiveList *model, NSError *error) {
        self.liveList = [model.topics.firstObject.docs mutableCopy];
        completionHandler(error);
    }];
}

@end
