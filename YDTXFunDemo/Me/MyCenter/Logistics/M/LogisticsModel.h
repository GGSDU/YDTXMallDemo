//
//  LogisticsModel.h
//  YDTXFunDemo
//
//  Created by 舒通 on 2016/12/14.
//  Copyright © 2016年 Story5. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LogisticsDetailModel.h"

@interface LogisticsModel : NSObject

/*
 "mailNo": "883843356725385408",
 "state": 4,
 "courier": "圆通速递",
 "tel": "021-69777888/999",
 "dataInfo": [
 {
 "time": "2016-12-20 13:16:40",
 "context": "客户 签收人: 邮件收发章 已签收  感谢使用圆通速递，期待再次为您服务"
 },
 {
 "time": "2016-12-20 08:25:48",
 "context": "上海市闵行区万源公司(点击查询电话)王** 派件中 派件员电话15821933627"
 },
 {
 "time": "2016-12-20 08:02:30",
 "context": "上海市闵行区万源公司 已收入"
 },
 {
 "time": "2016-12-20 04:42:07",
 "context": "上海转运中心 已发出,下一站 上海市闵行九星"
 }
 ]
 */

/*
 //物流信息跟踪
 http://test.m.yundiaoke.cn/api/goodsOrder/orderLogistics/goods_order_id/17
 请求方式：GET
 参数：goods_order_id：订单id
 返回参数：
 MailNo：快递单号
 State：快递状态
 -1 待查询
 0 查询异常
 1 暂无记录
 2 在途中
 3 派送中
 4 已签收
 5 用户拒签
 6 疑难件
 7 无效单
 8 超时单
 9 签收失败
 10 退回
 
 Courier：快递名称
 Tel：快递公司电话
 DataInfo：物流信息
 Time：物流信息时间，
 Context：物流信息地址
 200：成功，400：失败，401：数据不合法，403：非法参数

 */

@property (nonatomic, copy) NSString *mailNo;//订单号
@property (nonatomic, assign) int state;
@property (nonatomic, copy) NSString *courier;
@property (nonatomic, copy) NSString *tel;
@property (nonatomic, strong) NSArray *dataInfo;

//@property (nonatomic, strong) LogisticsDetailModel *detailModel;


-(instancetype)initData:(NSDictionary*)dic;
@end
