//
//  NetWorkService.m
//  YDTXFunDemo
//
//  Created by Story5 on 13/12/2016.
//  Copyright © 2016 Story5. All rights reserved.
//

#import "NetWorkService.h"

@interface NetWorkService ()

@property (nonatomic,retain) AFHTTPSessionManager *httpSessionManager;

@end

static NetWorkService *instance = nil;

@implementation NetWorkService

+ (instancetype)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    
    return instance;
}

#pragma mark - Project ShopMarket GET/POST methods
- (void)requestForDataByURLModuleKey:(URLModuleKeyType)urlModuleKey
                        requestParam:(nullable NSDictionary *)requestParam
                       responseBlock:(nullable void (^)(NSURLSessionDataTask * _Nonnull, id _Nullable))responseBlock
{
    NSString *requestURLString = [self getRequestURLStringByURLModuleKey:urlModuleKey];
    RequestMethod requestMethod = [self getRequestMethodByURLModuleKey:urlModuleKey];
    switch (requestMethod) {
        case GET:
        {
            [self.httpSessionManager GET:requestURLString parameters:requestParam progress:^(NSProgress * _Nonnull downloadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
                responseBlock(task,responseObject);
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
                NSString *message =  [self errorMessageWithResponseStatus:error.code];
                
                if (_delegate && [_delegate respondsToSelector:@selector(networkService:requestFailedWithTask:error:message:)]) {
                    [_delegate networkService:self requestFailedWithTask:task error:error message:message];
                }
                
            }];
        }
            break;
        case POST:
        {
            [self.httpSessionManager POST:requestURLString parameters:requestParam constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
                
            } progress:^(NSProgress * _Nonnull uploadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
                responseBlock(task,responseObject);
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
                NSString *message =  [self errorMessageWithResponseStatus:error.code];
                
                if (_delegate && [_delegate respondsToSelector:@selector(networkService:requestFailedWithTask:error:message:)]) {
                    [_delegate networkService:self requestFailedWithTask:task error:error message:message];
                }
            }];
        }
        default:
            break;
    }
    
}

/**
 *  商城分类
 */
- (void)requestForShopCategoryWithPid:(NSInteger)pid responseBlock:(nullable void(^)(NSArray *responseModelArray))responseBlock
{
    NSMutableDictionary *param = [[NSMutableDictionary alloc] initWithCapacity:0];
    [param setObject:[NSString stringWithFormat:@"%ld",pid] forKey:@"pid"];
    
    [self requestForDataByURLModuleKey:URLModuleKeyTypeShopCategory requestParam:param responseBlock:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *responseDic = (NSDictionary *)responseObject;
        
        NSArray *categoryModelArray = [responseDic objectForKey:@"data"];
        
        NSMutableArray *responseModelArray = [[NSMutableArray alloc] init];
        for (NSDictionary *modelDic in categoryModelArray) {
            CategoryModel *categoryModel = [[CategoryModel alloc] init];
            [categoryModel setValuesForKeysWithDictionary:modelDic];
            [responseModelArray addObject:categoryModel];
        }
        responseBlock(responseModelArray);
    }];
}

/**
 *  商品聚合数据
 */
- (void)requestForHomeListAggregatedDataWithResponseBlock:(void (^)(NSArray *))responseBlock
{
    [self requestForDataByURLModuleKey:URLModuleKeyTypeHomeListAggregatedData requestParam:nil responseBlock:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *responseDic = (NSDictionary *)responseObject;
        NSDictionary *categoryModelDic = [responseDic objectForKey:@"data"];
        
        
        NSMutableArray *productBriefModelArray = [[NSMutableArray alloc] initWithCapacity:0];
        // 默认展示商品
        NSArray *defaultArray = [categoryModelDic objectForKey:defaultProductKey];
        NSMutableArray *defaultModelArray = [[NSMutableArray alloc] initWithCapacity:0];
        for (NSDictionary *modelDic in defaultArray) {
            ProductBriefModel *productBriefModel = [[ProductBriefModel alloc] init];
            [productBriefModel setValuesForKeysWithDictionary:modelDic];
            [defaultModelArray addObject:productBriefModel];
        }
        [productBriefModelArray addObject:defaultModelArray];
        
        // 推荐商品
        NSArray *recommendedArray = [categoryModelDic objectForKey:recommendedProductKey];
        for (NSArray *recommendedProductArray in recommendedArray) {
            
            NSMutableArray *recommendedModelArray = [[NSMutableArray alloc] initWithCapacity:0];
            for (NSDictionary *recommendedDic in recommendedProductArray) {
                ProductBriefModel *productBriefModel = [[ProductBriefModel alloc] init];
                [productBriefModel setValuesForKeysWithDictionary:recommendedDic];
                [recommendedModelArray addObject:productBriefModel];
            }
            [productBriefModelArray addObject:recommendedModelArray];
        }
        
        responseBlock(productBriefModelArray);
    }];
}




/**
 *  商城分类列表数据
 */
-(void)requestForMarketCategoryListDataWithPid:(NSString *)pid Page:(NSInteger)page responseBlock:(nullable void(^)(NSArray *marketListModelArray))responseBlock
{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"id"] = pid;
    params[@"page"] = @(page);
    [self requestForDataByURLModuleKey:URLModuleKeyTypeCategoryList requestParam:params responseBlock:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if ([responseObject[@"status"] integerValue] == 200) {
            
            //字典转模型
            NSArray* marketListModelArray = [marketListModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            responseBlock(marketListModelArray);
        }else if ([responseObject[@"status"] integerValue] == 400){  //失败
            
            [RHNotiTool NotiShowWithTitle:@"没有更多数据了" Time:1.0];
            if (_delegate &&[_delegate respondsToSelector:@selector(mj_footerNoMoreData)]) {
                [_delegate mj_footerNoMoreData];
            }
            
        }else if ([responseObject[@"status"] integerValue] == 401){ //数据不合法
            
            [RHNotiTool NotiShowWithTitle:@"刷新失败" Time:1.0];
            
        }else if ([responseObject[@"status"] integerValue] == 403){ //非法参数
            
            [RHNotiTool NotiShowWithTitle:@"刷新失败" Time:1.0];
        }
    }];
}

/**
 *  商品详情数据
 */
- (void)requestForMarketGoodsDetailDataWithGoodsId:(NSString *)goods_id UserId:(NSString *)user_id responseBlock:(void (^)(NSArray *))responseBlock
{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"goods_id"] = goods_id;
    params[@"userid"]  = user_id;
    [self requestForDataByURLModuleKey:URLModuleKeyTypeProductDetail requestParam:params responseBlock:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"status"] integerValue] == 200) {
            
            //字典转模型
            NSArray* marketGoodsDetailModelArray = [marketDetailModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            responseBlock(marketGoodsDetailModelArray);
        }else if ([responseObject[@"status"] integerValue] == 400){  //失败
            
            [RHNotiTool NotiShowWithTitle:@"加载商品详情失败~" Time:1.0];
            
        }else if ([responseObject[@"status"] integerValue] == 401){ //数据不合法
            
            [RHNotiTool NotiShowWithTitle:@"加载商品详情失败~" Time:1.0];
            
        }else if ([responseObject[@"status"] integerValue] == 403){ //非法参数
            
            [RHNotiTool NotiShowWithTitle:@"加载商品详情失败~" Time:1.0];
        }
        
    }];
}

/**
 *  购物车列表
 */
- (void)requestForCartListWithUserId:(int)user_id responseBlock:(void (^)(NSArray *))responseBlock
{
    NSMutableDictionary *param = [[NSMutableDictionary alloc] initWithCapacity:0];
    [param setObject:[NSString stringWithFormat:@"%d",user_id] forKey:@"user_id"];
    
    [self requestForDataByURLModuleKey:URLModuleKeyTypeCartList requestParam:param responseBlock:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSMutableArray *responseArray = [[NSMutableArray alloc] initWithCapacity:0];
        NSDictionary *responseDic = (NSDictionary *)responseObject;
        NSArray *cartListModelArray = [responseDic objectForKey:@"data"];
        
        for (NSDictionary *cartListDic in cartListModelArray) {
            
            CartProductModel *cartProductModel = [[CartProductModel alloc] init];
            [cartProductModel setValuesForKeysWithDictionary:cartListDic];
            [responseArray addObject:cartProductModel];
        }
        
        responseBlock(responseArray);
    }];
}


#pragma mark - get info form 'URLInterface.plist' file
- (NSDictionary *)getRequestInfoDictionaryByURLModuleKey:(URLModuleKeyType)urlModuleKey
{
    NSDictionary *requestInfoDictionary = nil;
    switch (urlModuleKey) {
        case URLModuleKeyTypeShopCategory:
        {
            requestInfoDictionary = [self.urlDictionary objectForKey:@"ShopCategory"];
        }
            break;
        case URLModuleKeyTypeHomeListAggregatedData:
        {
            requestInfoDictionary = [self.urlDictionary objectForKey:@"HomeListAggregatedData"];
        }
            break;
        case URLModuleKeyTypeCategoryList:
        {
            requestInfoDictionary = [self.urlDictionary objectForKey:@"CategoryList"];
        }
            break;
        case URLModuleKeyTypeProductDetail:
        {
            requestInfoDictionary = [self.urlDictionary objectForKey:@"ProductDetail"];
        }
            break;
        case URLModuleKeyTypeProductDetailModel:
        {
            requestInfoDictionary = [self.urlDictionary objectForKey:@"ProductDetailModel"];
        }
            break;
        case URLModuleKeyTypeCartList:
        {
            requestInfoDictionary = [self.urlDictionary objectForKey:@"CartList"];
        }
            break;
        case URLModuleKeyTypeDeleteCartList:
        {
            requestInfoDictionary = [self.urlDictionary objectForKey:@"DeleteCartList"];
        }
            break;
        case URLModuleKeyTypeCheckGoodsQuantity:
        {
            requestInfoDictionary = [self.urlDictionary objectForKey:@"CheckGoodsQuantity"];
        }
            break;
        case URLModuleKeyTypeOrderList:
        {
            requestInfoDictionary = [self.urlDictionary objectForKey:@"OrderList"];
        }
            break;
        case URLModuleKeyTypeOrderDetail:
        {
            requestInfoDictionary = [self.urlDictionary objectForKey:@"OrderDetail"];
            
        }
            break;
        case URLModuleKeyTypeCommitOrder:
        {
            requestInfoDictionary = [self.urlDictionary objectForKey:@"CommitOrder"];
        }
            break;
        case URLModuleKeyTypeCancelOrder:
        {
            requestInfoDictionary = [self.urlDictionary objectForKey:@"CanecelOrder"];
        }
            break;
        case URLModuleKeyTypeDeleteOrder:
        {
            requestInfoDictionary = [self.urlDictionary objectForKey:@"DeleteOrder"];
        }
            break;
        case URLModuleKeyTypeAddressList:
        {
            requestInfoDictionary = [self.urlDictionary objectForKey:@"AddressList"];
        }
            break;
        case URLModuleKeyTypeAddAddress:
        {
            requestInfoDictionary = [self.urlDictionary objectForKey:@"AddAddress"];
        }
            break;
        case URLModuleKeyTypeModifyAddressShowInfo:
        {
            requestInfoDictionary = [self.urlDictionary objectForKey:@"ModifyAddressShowInfo"];
        }
            break;
        case URLModuleKeyTypeCommitModifyAddress:
        {
            requestInfoDictionary = [self.urlDictionary objectForKey:@"CommitModifyAddress"];
        }
            break;
        case URLModuleKeyTypeDeleteAddress:
        {
            requestInfoDictionary = [self.urlDictionary objectForKey:@"DeleteAddress"];
        }
            break;
        default:
            break;
    }
    return [requestInfoDictionary copy];
}

- (NSString *)getRequestURLStringByURLModuleKey:(URLModuleKeyType)urlModuleKey
{
    NSDictionary *requestInfoDictionary = [self getRequestInfoDictionaryByURLModuleKey:urlModuleKey];
    NSString *URLString = [requestInfoDictionary objectForKey:@"RequestURL"];
    return URLString;
}

- (RequestMethod)getRequestMethodByURLModuleKey:(URLModuleKeyType)urlModuleKey
{
    NSDictionary *requestInfoDictionary = [self getRequestInfoDictionaryByURLModuleKey:urlModuleKey];
    NSString *methodString = [requestInfoDictionary objectForKey:@"RequestMethod"];
    if ([methodString isEqualToString:@"GET"]) {
        return GET;
    } else if ([methodString isEqualToString:@"POST"]) {
        return POST;
    }
    return RequestMethodNone;
}

- (NSDictionary *)getRequestParamByURLModuleKey:(URLModuleKeyType)urlModuleKey
{
    NSDictionary *requestInfoDictionary = [self getRequestInfoDictionaryByURLModuleKey:urlModuleKey];
    NSDictionary *requestParam = [requestInfoDictionary objectForKey:@"RequestParam"];
    return requestParam;
}

- (NSDictionary *)getResponseParamByURLModuleKey:(URLModuleKeyType)urlModuleKey
{
    NSDictionary *requestInfoDictionary = [self getRequestInfoDictionaryByURLModuleKey:urlModuleKey];
    NSDictionary *responseParam = [requestInfoDictionary objectForKey:@"ResponseParam"];
    return responseParam;
}

#pragma mark - Response Status
- (NSString *)errorMessageWithResponseStatus:(ResponseStatus)aStatus
{
    NSString *message = nil;
    switch (aStatus) {
        case responseSuccessed:
            message = @"成功";
            break;
        case responseFailed:
            message = @"失败";
            break;
        case responseIllegalData:
            message = @"数据不合法";
            break;
        case responseIllegalParam:
            message = @"非法参数";
            break;
            
        default:
            break;
    }
    NSLog(@"response status : %@",message);
    return message;
}



#pragma mark - get
- (NSMutableDictionary *)urlDictionary
{
    if (_urlDictionary == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"URLInterface" ofType:@"plist"];
        _urlDictionary = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
    }
    return _urlDictionary;
}


#pragma mark - AFHTTPSessionManager
- (AFHTTPSessionManager *)httpSessionManager
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    // 超时时间
    //    manager.requestSerializer.timeoutInterval = 200;
    
    // 声明上传的是json格式的参数，需要你和后台约定好，不然会出现后台无法获取到你上传的参数问题
    manager.requestSerializer = [AFHTTPRequestSerializer serializer]; // 上传普通格式
    //        manager.requestSerializer = [AFJSONRequestSerializer serializer]; // 上传JSON格式
    
    // 声明获取到的数据格式
    //    manager.responseSerializer = [AFHTTPResponseSerializer serializer]; // AFN不会解析,数据是data，需要自己解析
    manager.responseSerializer = [AFJSONResponseSerializer serializer]; // AFN会JSON解析返回的数据
    // 个人建议还是自己解析的比较好，有时接口返回的数据不合格会报3840错误，大致是AFN无法解析返回来的数据
    return manager;
}

#pragma mark - AF GET/POST methods
- (NSURLSessionDataTask *)GET:(NSString *)URLString parameters:(id)parameters progress:(void (^)(NSProgress * _Nonnull))downloadProgress success:(void (^)(NSURLSessionDataTask * _Nonnull, id _Nullable))success failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure
{
    return [self.httpSessionManager GET:URLString parameters:parameters progress:downloadProgress success:success failure:failure];
}

- (NSURLSessionDataTask *)POST:(NSString *)URLString parameters:(id)parameters progress:(void (^)(NSProgress * _Nonnull))uploadProgress success:(void (^)(NSURLSessionDataTask * _Nonnull, id _Nullable))success failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure
{
    return [self.httpSessionManager POST:URLString parameters:parameters progress:uploadProgress success:success failure:failure];
}

- (NSURLSessionDataTask *)POST:(NSString *)URLString parameters:(id)parameters constructingBodyWithBlock:(void (^)(id<AFMultipartFormData> _Nonnull))block progress:(void (^)(NSProgress * _Nonnull))uploadProgress success:(void (^)(NSURLSessionDataTask * _Nonnull, id _Nonnull))success failure:(void (^)(NSURLSessionDataTask * _Nonnull, NSError * _Nonnull))failure
{    return [self.httpSessionManager POST:URLString parameters:parameters constructingBodyWithBlock:block progress:uploadProgress success:success failure:failure];
}

@end
