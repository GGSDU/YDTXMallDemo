//
//  NetWorkService.h
//  YDTXFunDemo
//
//  Created by Story5 on 13/12/2016.
//  Copyright © 2016 Story5. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    responseSuccessed       = 200,          // 成功
    responseFailed          = 400,          // 失败
    responseIllegalData     = 401,          // 非法数据
    responseIllegalParam    = 403,          // 非法参数
} ResponseStatus;

typedef enum : NSUInteger {
    RequestMethodNone,                      // default
    GET,                                    // GET
    POST,                                   // POST
} RequestMethod;

typedef enum : NSUInteger {
    URLModuleKeyTypeShopCategory,           // 商城分类
    URLModuleKeyTypeHomeListAggregatedData, // 商城首页列表聚合数据
    
    URLModuleKeyTypeCategoryList,           // 分类列表数据
    URLModuleKeyTypeProductDetail,          // 商品详情
    URLModuleKeyTypeProductDetailModel,     // 商品详情的型号
    
    URLModuleKeyTypeCartList,               // 购物车列表
    URLModuleKeyTypeDeleteCartList,         // 删除购物车列表
    URLModuleKeyTypeCheckGoodsQuantity,     // 检查库存

    URLModuleKeyTypeOrderList,              // 订单列表
    URLModuleKeyTypeOrderDetail,            // 订单详情
    URLModuleKeyTypeCommitOrder,            // 确认订单
    URLModuleKeyTypeCancelOrder,            // 取消订单
    URLModuleKeyTypeDeleteOrder,            // 删除订单
    
    
    URLModuleKeyTypeAddressList,            // 收货地址列表
    URLModuleKeyTypeAddAddress,             // 添加收货地址
    URLModuleKeyTypeModifyAddressShowInfo,  // 修改收货地址显示信息
    URLModuleKeyTypeCommitModifyAddress,    // 提交修改收货地址
    URLModuleKeyTypeDeleteAddress,          // 删除收货地址
    
    
} URLModuleKeyType;


@class NetWorkService;

@protocol NetWorkServiceDelegate <NSObject>

- (void)networkService:(NetWorkService *)networkService requestFailedWithTask:(NSURLSessionDataTask *)task error:(NSError *)error message:(NSString *)message;

- (void)mj_footerNoMoreData;

@end

static NSString *defaultProductKey     = @"shopping";
static NSString *recommendedProductKey = @"fishtree";


@interface NetWorkService : NSObject

@property (nonatomic,assign) id<NetWorkServiceDelegate>delegate;

@property (strong, nonatomic) NSMutableDictionary *urlDictionary;   //URL Dictionary

+ (nullable instancetype)shareInstance;

#pragma mark - Project ShopMarket GET/POST methods
/**
 * 请求通用方法
 */
- (void)requestForDataByURLModuleKey:(URLModuleKeyType)urlModuleKey
                        requestParam:(nullable NSDictionary *)requestParam
                       responseBlock:(nullable void (^)(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject))responseBlock;

/**
 *  商城分类
 */
- (void)requestForShopCategoryWithPid:(NSInteger)pid
                        responseBlock:(nullable void(^)(NSArray *responseModelArray))responseBlock;

/**
 *  商城首页列表聚合数据
 */
- (void)requestForHomeListAggregatedDataWithResponseBlock:(nullable void (^)(NSArray *productBriefModelArray))responseBlock;



/**
 *  商城分类列表数据
 */
- (void)requestForMarketCategoryListDataWithPid:(NSString *)pid
                                           Page:(NSInteger)page 
                                  responseBlock:(nullable void(^)(NSArray *marketListModelArray))responseBlock;



/**
 *  商品详情数据
 */
-(void)requestForMarketGoodsDetailDataWithGoodsId:(NSString *)goods_id UserId:(NSString *)user_id responseBlock:(nullable void(^)(NSArray *marketGoodsDetailModelArray))responseBlock;

/**
 *  获取库存
 */
- (void)getCurrentQuantityWithGoodsModelId:(int)goods_model_id quantity:(int *)quantity;

/**
 *  购物车列表
 */
- (void)requestForCartListWithUserId:(int)user_id responseBlock:(nullable void (^)(NSArray *responseCartProductModelArray))responseBlock;

/**
 *  删除购物车列表
 */
- (void)requestForDeleteCartListWithGoodsOrderIdArray:(NSArray *)goods_order_id_Array;

#pragma mark - get info form 'URLInterface.plist' file
- (NSDictionary *)getRequestInfoDictionaryByURLModuleKey:(URLModuleKeyType)urlModuleKey;

- (NSString *)getRequestURLStringByURLModuleKey:(URLModuleKeyType)urlModuleKey;

- (RequestMethod)getRequestMethodByURLModuleKey:(URLModuleKeyType)urlModuleKey;

- (NSDictionary *)getRequestParamByURLModuleKey:(URLModuleKeyType)urlModuleKey;

- (NSDictionary *)getResponseParamByURLModuleKey:(URLModuleKeyType)urlModuleKey;

#pragma mark - Response Status
- (NSString *)errorMessageWithResponseStatus:(ResponseStatus)aStatus;

#pragma mark - AF GET/POST methods
- (NSURLSessionDataTask *)GET:(nonnull NSString *)URLString
                            parameters:(nullable id)parameters
                              progress:(nullable void (^)(NSProgress *_Nonnull downloadProgress))downloadProgress
                               success:(nullable void (^)(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject))success
                               failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError *_Nonnull error))failure;

- (NSURLSessionDataTask *)POST:(nonnull NSString *)URLString
                    parameters:(nullable id)parameters
                      progress:(nullable void (^)(NSProgress * _Nonnull))uploadProgress
                       success:(nullable void (^)(NSURLSessionDataTask * _Nonnull, id _Nullable))success
                       failure:(nullable void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure;

- (NSURLSessionDataTask *)POST:(nonnull NSString *)URLString
                    parameters:(nullable id)parameters
     constructingBodyWithBlock:(nullable void (^)(id <AFMultipartFormData> _Nonnull formData))block
                      progress:(nullable void (^)(NSProgress * _Nonnull))uploadProgress
                       success:(nullable void (^)(NSURLSessionDataTask * _Nonnull task, id _Nonnull responseObject))success
                       failure:(nullable void (^)(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error))failure;

@end
