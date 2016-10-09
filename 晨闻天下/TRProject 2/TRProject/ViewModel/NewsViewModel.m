//
//  NewsViewModel.m
//  Project
//
//  Created by 钟至大 on 16/8/4.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "NewsViewModel.h"
#import "CacheManager.h"
@interface NewsViewModel (){
    NSInteger _choose;
}

@end

@implementation NewsViewModel

MJCodingImplementation
- (instancetype)initWithNewsType:(NewsType)type{
    if (self = [super init]) {
        self.newsType = type;
        id obj = [CacheManager getNewsModelWith:type];
        if (obj) {
            self = obj;
        }
        self.page = 1;
        if (type==0) {
            _choose = 0;
        }else if (type == 6){
            _choose = 1;
        }else if (type >0&&type<6){
            _choose = 2;
        }else{
            _choose = 3;
        }
        
    }
    return self;
}
- (NSInteger)rowNumber{
    return self.list.count;
}
- (NSMutableArray *)list{
    if (!_list) {
        _list = [NSMutableArray new];
    }
    return _list;
}
- (NSURL *)getURLForRow:(NSInteger)row{
    switch (_choose) {
        case 0:
            return [NSURL URLWithString:((HotDataArticleModel *)self.list[row]).img];
            break;
        case 1:
            return nil;
            break;
        case 2:
            return [NSURL URLWithString:((APINewslistModel *)self.list[row]).picUrl];
            break;
        case 3:{
            NSString *s = ((NetDataModel *)self.list[row]).imgsrc;
            return [NSURL URLWithString:s];
            break;
        }
        default:
            break;
    }
    return nil;
    
}
- (NSArray *)getMultibleURLForRow:(NSInteger)row{
    NSMutableArray *picURL = [NSMutableArray new];
    if ([self getURLForRow:row]) {
        [picURL addObject:[self getURLForRow:row]];
    }
    
    if (_choose == 3) {
        for (NetDataImgextraModel *image in ((NetDataModel *)self.list[row]).imgextra) {
            if (image) {
                [picURL addObject:[NSURL URLWithString:image.imgsrc]];
                
            }
        }
    }
    return [picURL copy];
}
- (NSString *)getTitleForRow:(NSInteger)row{
    switch (_choose) {
        case 0:
            return ((HotDataArticleModel *)self.list[row]).title;
            break;
        case 1:
            return ((XiaoHuaJokelistModel *)self.list[row]).JokeTitle;
            break;
        case 2:
            return ((APINewslistModel *)self.list[row]).title;
            break;
        case 3:
            return ((NetDataModel *)self.list[row]).title;
            break;
        default:
            return nil;
    }
}
- (NSString *)getTimeForRow:(NSInteger)row{
    switch (_choose) {
        case 0:
            return nil;
            break;
        case 1:
            return [((XiaoHuaJokelistModel *)self.list[row]).BillNo substringToIndex:8];
            break;
        case 2:
            return ((APINewslistModel *)self.list[row]).ctime;
            break;
        case 3:
            return ((NetDataModel *)self.list[row]).ptime;
            break;
        default:
            return nil;
    }
    
}
- (NSString *)getOriginForRow:(NSInteger)row{
    switch (_choose) {
        case 0:
            return ((HotDataArticleModel *)self.list[row]).author;
            break;
        case 1:
            return nil;
            break;
        case 2:
            return ((APINewslistModel *)self.list[row]).Description;
            break;
        case 3:
            return ((NetDataModel *)self.list[row]).source;
            break;
        default:
            return nil;
    }
    
}
- (NSString *)getNumberOfCommentForRow:(NSInteger)row{
    switch (_choose) {
        case 0:
            return [NSString stringWithFormat:@"%@万人阅读",@(((HotDataArticleModel *)self.list[row]).time/10000).stringValue];
            break;
        case 1:
            return nil;
            break;
        case 2:
            return nil;
            break;
        case 3:
            return [NSString stringWithFormat:@"%@评论",@(((NetDataModel *)self.list[row]).replyCount).stringValue];
            break;
        default:
            return nil;
    }
    
}
- (NSString *)getContentForRow:(NSInteger)row{
    if (self.newsType == NewsTypeXiaoHua) {
        return [((XiaoHuaJokelistModel *)self.list[row]).JokeContent stringByReplacingOccurrencesOfString:@"\r\n" withString:@"\n"];
    }
    return nil;
}
- (void)getDataWithRequestMode:(RequestMode)mode completionHandler:(void (^)(NSError *))completionHandler{
    NSInteger tmpPage = 0;
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
    self.dataTask = [NewsNetManager getNewsForNewsType:self.newsType num:10 page:tmpPage completionHandler:^(id model, NSError *error) {
        if (!error) {
            if (mode == RequestModeRefresh) {
                [self.list removeAllObjects];
            }
            switch (_choose) {
                case 0:
                    [self.list addObjectsFromArray:((HotModel *)model).data.list];
                    break;
                case 1:
                    [self.list addObjectsFromArray:((XiaoHuaModel *)model).res_body.list];
                    break;
                case 2:
                    [self.list addObjectsFromArray:((APIModel *)model).list];
                    break;
                case 3:
                    for (NetDataModel *netData in model) {
                        if (netData.url) {
                            [self.list addObject:netData];
                        }
                    }
                    break;
            }
            self.page = tmpPage;
            [CacheManager saveNewsModel:self];
        }
        completionHandler(error);
    }];
}
//详情页
- (NSURL *)getDetailURLForRow:(NSInteger)row{
    switch (_choose) {
        case 0:
            return [NSURL URLWithString:((HotDataArticleModel *)self.list[row]).url];
            break;
        case 1:
            return nil;
            break;
        case 2:
            return [NSURL URLWithString:((APINewslistModel *)self.list[row]).url];
            break;
        case 3:
            return [NSURL URLWithString:((NetDataModel *)self.list[row]).url];
            break;
        default:
            return nil;
    }
}
@end
