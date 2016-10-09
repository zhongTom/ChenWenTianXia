//
//  LiveRoomModel.m
//  TRProject
//
//  Created by 钟至大 on 16/8/21.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "LiveRoomModel.h"

@implementation LiveRoomModel


+ (NSDictionary *)objClassInArray{
    return @{@"commentator" : [CommentatorModel class], @"messages" : [MessagesModel class]};
}
+ (NSDictionary *)replaceKeyFromPropertyName{
    return @{@"temp":@"template"};
}
@end
@implementation ChatconfigModel

@end

@implementation MutilVideoModel


@end

@implementation VideoModel

@end


@implementation FloatlayerModel

@end


@implementation BannerModel

@end


@implementation CommentatorModel

@end


@implementation MessagesModel

+ (NSDictionary *)objClassInArray{
    return @{@"images" : [MessagesImagesModel class]};
}
+(NSDictionary *)replaceKeyFromPropertyName{
    return @{@"ID":@"id"};
}
@end


@implementation MessagesMsgModel




@end


@implementation MessagesCommentatorModel

@end


@implementation MessagesImagesModel

@end


