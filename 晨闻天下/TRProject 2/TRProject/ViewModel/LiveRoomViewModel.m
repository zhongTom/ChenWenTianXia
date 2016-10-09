//
//  LiveRoomViewModel.m
//  TRProject
//
//  Created by 钟至大 on 16/8/21.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "LiveRoomViewModel.h"
#import "LiveNetManager.h"
@implementation LiveRoomViewModel
- (instancetype)initWithSkipId:(NSString *)skipId{
    if (self = [super init]) {
        self.skipId = skipId;
        self.nextPage = self.liveRoomModel.nextPage;
    }
    return self;
}
- (BOOL)isHasVedioForHeader{
    if (self.liveRoomModel.video.videoUrl==nil&&self.liveRoomModel.mutilVideo == nil) {
        return NO;
    }else{
        return YES;
    }
}
- (BOOL)isHasContentURLForRow:(NSInteger)row{
    if (self.messages[row].images) {
        return YES;
    }
    return NO;
}
- (NSInteger)rowNumber{
    return self.messages.count;
}
- (NSURL *)getIconURLForRow:(NSInteger)row{
    return [NSURL URLWithString:self.messages[row].commentator.imgUrl];
}
- (NSString *)getTitleForRow:(NSInteger)row{
    return self.messages[row].commentator.name;
}
- (NSString *)getTimeForRow:(NSInteger)row{
    return self.messages[row].time;
}
- (NSString *)getContentTextForRow:(NSInteger)row{
    if (![self isHasContentURLForRow:row]) {
        return self.messages[row].msg.content;
    }
    return nil;
}
- (NSURL *)getContentURLForRow:(NSInteger)row{
    if ([self isHasContentURLForRow:row]) {
        return [NSURL URLWithString:self.messages[row].images.firstObject.fullSizeSrc];
    }
    return nil;
    
}
- (CGSize)getContentSizeForRow:(NSInteger)row{
    if ([self isHasContentURLForRow:row]){
        NSRange range = [self.messages[row].images.firstObject.fullSrcSize rangeOfString:@"*"];
        CGFloat width = [self.messages[row].images.firstObject.fullSrcSize substringToIndex:range.location].integerValue;
        CGFloat height = [self.messages[row].images.firstObject.fullSrcSize substringFromIndex:range.location+1].integerValue;
      
        
        return CGSizeMake(width, height);
    }
    return CGSizeZero;
}
- (NSMutableArray<MessagesModel *> *)messages{
    if (!_messages) {
        _messages = [NSMutableArray new];
    }
    return _messages;
}
- (void)getLiveRoomModelWithRequestMode:(RequestMode)mode completionHandler:(void (^)(NSError *))completionHandler{
    NSInteger tmpPage = 0;
    switch (mode) {
        case RequestModeRefresh: {
            tmpPage = 0;
            break;
        }
        case RequestModeMore: {
            tmpPage = self.nextPage;
            break;
        }
    }
    [LiveNetManager getLiveRoomWithSkipId:self.skipId nextPage:tmpPage completionHandler:^(LiveRoomModel *model, NSError *error) {
        if (!error) {
            if (mode == RequestModeRefresh) {
                [self.messages removeAllObjects];
            }
            [self.messages addObjectsFromArray:model.messages];
            self.liveRoomModel = model;
            self.nextPage = self.liveRoomModel.nextPage;
        }
        completionHandler(error);
    }];
}



@end
