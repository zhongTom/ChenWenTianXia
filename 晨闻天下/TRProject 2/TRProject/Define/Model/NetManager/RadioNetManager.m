//
//  RadioNetManager.m
//  TRProject
//
//  Created by 钟至大 on 16/8/16.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "RadioNetManager.h"
#import "RadioModel.h"
#import "RadioListModel.h"
#import "RadioPlayerListModel.h"
@implementation RadioNetManager
+ (id)getRadioCompletionHandler:(void (^)(id, NSError *))completionHandler{
    return [self GET:@"http://api.3g.ifeng.com/api_fm_homepage?gv=5.2.2&av=0&proid=ifengnews&os=ios_9.2&vt=5&screen=750x1334&publishid=4002&uid=4afd132aa49c49718a317c26764c8427&nw=wifi" parameters:nil progress:nil completionHandler:^(id responseObj, NSError *error) {
        completionHandler([RadioModel parse:responseObj],error);
    }];
}
+ (id)getRadioListWithNodeId:(NSString *)nodeId page:(NSInteger)page completionHandler:(void (^)(id, NSError *))completionHandler{
    NSString *path = [NSString stringWithFormat:@"http://api.3g.ifeng.com/api_fm_programlist?nodeId=%@&page=%ld&pageSize=20&gv=5.2.2&av=0&proid=ifengnews&os=ios_9.2&vt=5&screen=750x1334&publishid=4002&uid=4afd132aa49c49718a317c26764c8427&nw=wifi",nodeId,page];
    return [self GET:path parameters:nil progress:nil completionHandler:^(id responseObj, NSError *error) {
        completionHandler([RadioListModel parse:responseObj],error);
    }];
}
+ (id)getRadioPlayerWithResourceId:(NSString *)resourceId page:(NSInteger)page completionHandler:(void (^)(id, NSError *))completionHandler{
    NSString *path = [NSString stringWithFormat:@"http://api.3g.ifeng.com/api_fm_resource?rid=%@&page=%ld&pageSize=20&gv=5.2.2&av=0&proid=ifengnews&os=ios_9.2&vt=5&screen=750x1334&publishid=4002&uid=4afd132aa49c49718a317c26764c8427&nw=wifi",resourceId,page];
    return [self GET:path parameters:nil progress:nil completionHandler:^(id responseObj, NSError *error) {
        completionHandler([RadioPlayerListModel parse:responseObj],error);
    }];
}
@end
