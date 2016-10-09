//
//  TVNetManager.m
//  TRProject
//
//  Created by 钟至大 on 16/8/12.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "TVNetManager.h"

@implementation TVNetManager
+ (id)getTVDataWithTypeId:(NSInteger)typeId page:(NSInteger)page completionHandler:(void (^)(id, NSError *))completionHandler{
    return [self GET:[NSString stringWithFormat:@"http://api.iclient.ifeng.com/ifengvideoList?page=%ld&listtype=list&typeid=%ld&gv=5.2.2&av=0&proid=ifengnews&os=ios_9.2&vt=5&screen=750x1334&publishid=4002&uid=4afd132aa49c49718a317c26764c8427&nw=wifi",page,typeId] parameters:nil progress:nil completionHandler:^(id responseObj, NSError *error) {
        completionHandler([TVModel parse:responseObj],error);
    }];
}
@end
