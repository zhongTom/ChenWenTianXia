//
//  InfoListNetManager.m
//  TRProject
//
//  Created by tarena on 16/2/17.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "InfoListNetManager.h"


@implementation InfoListNetManager

+ (id)getInfoListWithType:(InfoListType)listType updateTime:(NSString *)updateTime page:(NSInteger)page completionHandle:(void (^)(id, NSError *))completionHandle{
    NSString *path = [NSString stringWithFormat:@"http://app.api.autohome.com.cn/autov5.0.0/news/newslist-pm1-c0-nt0-p%ld-s30-l%@.json",page,updateTime];
    return [self GET:path parameters:nil progress:nil completionHandler:^(id responseObj, NSError *error) {
         completionHandle([InfoListModel parse:responseObj], error);
    }];
}

@end













