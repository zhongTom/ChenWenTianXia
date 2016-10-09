//
//  NewsNetManager.m
//  Project
//
//  Created by 钟至大 on 16/8/2.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "NewsNetManager.h"
#import "APIModel.h"
#import "NetModel.h"
#import "XiaoHuaModel.h"
#import "HotModel.h"
#import "InfoListModel.h"
@implementation NewsNetManager
+ (id)getNewsForNewsType:(NewsType)newsType num:(NSInteger)num page:(NSInteger)page completionHandler:(void (^)(id, NSError *))completionHandler{
    if (newsType < 7) {
       return [self getNewsWithHeaderForNewsType:newsType num:num page:page completionHandler:^(id model, NSError *error) {
            completionHandler(model,error);
        }];
    }else{
       return [self getNewsWithNetType:newsType page:page completionHandler:^(id model, NSError *error) {
            completionHandler(model,error);
        }];
    }
}
+ (id)getNewsWithHeaderForNewsType:(NewsType)newsType num:(NSInteger)num page:(NSInteger)page completionHandler:(void (^)(id model, NSError *error))completionHandler{
    NSString *path = nil;
    NSInteger type = 0 ;
    switch (newsType) {
        case NewsTypeHot: {
            path = [NSString stringWithFormat:kNewsTypeHot,page];
            type = NewsTypeHot;
            break;
        }
        case NewsTypeNational: {
            path = [NSString stringWithFormat:kNewsTypeNational,num,page];
            type = NewsTypeNational;
            break;
        }
        case NewsTypeSociety: {
            path = [NSString stringWithFormat:kNewsTypeSociety,num,page];
            type = NewsTypeSociety;
            break;
        }
        case NewsTypeScience: {
            path = [NSString stringWithFormat:kNewsTypeScience,num,page];
            type = NewsTypeScience;
            break;
        }
        case NewsTypeSports: {
            path = [NSString stringWithFormat:kNewsTypeSports,num,page];
            type = NewsTypeSports;
            break;
        }
        case NewsTypeBeauty: {
            path = [NSString stringWithFormat:kNewsTypeBeauty,num];
            type = NewsTypeBeauty;
            break;
        }
        case NewsTypeXiaoHua: {
            path = [NSString stringWithFormat:kNewsTypeXiaoHua,page];
            type = NewsTypeXiaoHua;
            break;
        }
        default:
            break;
    }
    return [self GET:path apiKey:@"302b1ff9310cb795477c8609ae06f804" parameters:nil progress:nil completionHandler:^(id responseObj, NSError *error) {
        if (type>=1&&type<=5) {
            completionHandler([APIModel parse:responseObj],error);
        }else if (type==0){
            completionHandler([HotModel parse:responseObj],error);
        }else{
            completionHandler([XiaoHuaModel parse:responseObj],error);
        }
    }];
}

+ (id)getNewsWithNetType:(NewsType)netType page:(NSInteger)page completionHandler:(void (^)(id model, NSError *error))completionHandler{
    NSString *path = nil;
    switch (netType) {
        case NetTypeFire: {
            path = [NSString stringWithFormat:kNetTypeFire,(page -1)*20,(page+1)*20];
            break;
        }
        case NetTypeGame: {
            path = [NSString stringWithFormat:kNetTypeGame,(page -1)*20,(page+1)*20];
            break;
        }
        case NetTypeAmuse: {
            path = [NSString stringWithFormat:kNetTypeAmuse,(page -1)*20,(page+1)*20];
            break;
        }
        case NetTypeMoney: {
            path = [NSString stringWithFormat:kNetTypeMoney,(page -1)*20,(page+1)*20];
            break;
        }
        case NetTypeRelax: {
            path = [NSString stringWithFormat:kNetTypeRelax,(page -1)*20,page*20];
            break;
        }
        default:
            break;
    }
    return [self GET:path parameters:nil progress:nil completionHandler:^(NSMutableDictionary *responseObj, NSError *error) {
        id model = [NetDataModel mj_objectArrayWithKeyValuesArray:responseObj[responseObj.allKeys.firstObject]];
        completionHandler(model,error);
    }];
}
@end
