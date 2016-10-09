//
//  XiaoHuaModel.h
//  Project
//
//  Created by 钟至大 on 16/8/3.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import <Foundation/Foundation.h>

@class XiaoHuaRes_BodyModel,XiaoHuaJokelistModel;
@interface XiaoHuaModel : NSObject

@property (nonatomic, assign) NSInteger res_code;

@property (nonatomic, copy) NSString *res_error;

@property (nonatomic, strong) XiaoHuaRes_BodyModel *res_body;

@end
@interface XiaoHuaRes_BodyModel : NSObject

@property (nonatomic, assign) NSInteger Counts;

@property (nonatomic, assign) NSInteger PageCount;
//list -> JokeList
@property (nonatomic, strong) NSArray<XiaoHuaJokelistModel *> *list;

@end

@interface XiaoHuaJokelistModel : NSObject

@property (nonatomic, copy) NSString *BillNo;//时间，需要截取

@property (nonatomic, assign) NSInteger Collect;

@property (nonatomic, assign) BOOL IsHtml;

@property (nonatomic, copy) NSString *AddTime;

@property (nonatomic, assign) NSInteger Count;

@property (nonatomic, assign) NSInteger JokeType;

@property (nonatomic, copy) NSString *JokeContent;

@property (nonatomic, copy) NSString *JokeTitle;

@end

