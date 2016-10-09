//
//  RequestPath.h
//  Project
//
//  Created by 钟至大 on 16/8/2.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#ifndef RequestPath_h
#define RequestPath_h

typedef NS_ENUM(NSUInteger, NewsType) {
    NewsTypeHot,//头条--Hot
    NewsTypeNational,//国际--API
    NewsTypeSociety,//社会
    NewsTypeScience,//科技
    NewsTypeSports,//体育
    NewsTypeBeauty,//美女
    NewsTypeXiaoHua,//笑话-XiaoHua 6
    
    NetTypeFire,//军事--Net 7
    NetTypeMoney,//财经
    NetTypeCar,//汽车--Car 9
    NetTypeGame,//游戏
    NetTypeAmuse,//娱乐
    NetTypeRelax,//放松一下 12
};

#define kNewsTypeNational @"http://apis.baidu.com/txapi/world/world?num=%ld&page=%ld"
#define kNewsTypeSociety @"http://apis.baidu.com/txapi/social/social?num=%ld&page=%ld"
#define kNewsTypeScience @"http://apis.baidu.com/txapi/keji/keji?num=%ld&page=%ld"
#define kNewsTypeSports @"http://apis.baidu.com/txapi/tiyu/tiyu?num=%ld&page=%ld"
#define kNewsTypeBeauty @"http://apis.baidu.com/txapi/mvtp/meinv?num=%ld"


#define kNewsTypeXiaoHua @"http://apis.baidu.com/hihelpsme/chinajoke/getjokelist?page=%ld"//model需要重写
#define kNewsTypeHot @"http://apis.baidu.com/3023/news/channel?id=popular&page=%ld"//model需要重写
//网易
#define kNetTypeRelax @"http://c.m.163.com/nc/article/list/T1350383429665/%ld-%ld.html"
#define kNetTypeFire @"http://c.m.163.com/nc/article/list/T1348648141035/%ld-%ld.html"
#define kNetTypeGame @"http://c.m.163.com/nc/article/list/T1348654151579/%ld-%ld.html"
#define kNetTypeAmuse @"http://c.m.163.com/nc/article/list/T1348648517839/%ld-%ld.html"
#define kNetTypeMoney @"http://c.m.163.com/nc/article/list/T1348648756099/%ld-%ld.html"
#define kNetTypeCar @"http://app.api.autohome.com.cn/autov5.0.0/news/newslist-pm1-c0-nt0-p%ld-s30-l%@.json"

#endif /* RequestPath_h */
