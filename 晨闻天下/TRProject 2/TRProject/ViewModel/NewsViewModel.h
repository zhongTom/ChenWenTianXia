//
//  NewsViewModel.h
//  Project
//
//  Created by 钟至大 on 16/8/4.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetModel.h"
#import "APIModel.h"
#import "XiaoHuaModel.h"
#import "HotModel.h"
#import "NewsNetManager.h"
#import "NSObject+ViewModel.h"

@interface NewsViewModel : NSObject
/** 根据UI效果图 */
//cell的行数
@property (nonatomic) NSInteger rowNumber;
//标题
- (NSString *)getTitleForRow:(NSInteger)row;
//新闻时间
- (NSString *)getTimeForRow:(NSInteger)row;
//评论数
- (NSString *)getNumberOfCommentForRow:(NSInteger)row;
//新闻出处
- (NSString *)getOriginForRow:(NSInteger)row;
//获取图片的URL
- (NSArray *)getMultibleURLForRow:(NSInteger)row;
//详情页URL
- (NSURL *)getDetailURLForRow:(NSInteger)row;
/** 根据解析和请求获取属性和方法 */
@property (nonatomic) NewsType newsType;
@property (nonatomic) NSInteger page;
- (instancetype)initWithNewsType:(NewsType)type;

//存放数据
@property (nonatomic) NSMutableArray *list;
- (void)getDataWithRequestMode:(RequestMode)mode completionHandler:(void(^)(NSError *error))completionHandler;
/** 笑话部分从特殊处理 */
//内容的处理
- (NSString *)getContentForRow:(NSInteger)row;



@end
