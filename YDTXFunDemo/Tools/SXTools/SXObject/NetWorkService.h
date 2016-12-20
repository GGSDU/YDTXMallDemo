//
//  NetWorkService.h
//  YDTXFunDemo
//
//  Created by Story5 on 13/12/2016.
//  Copyright © 2016 Story5. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    responseSuccessed       = 200,
    responseFailed          = 400,
    responseIllegalData     = 401,
    responseIllegalParam    = 403,
} ResponseStatus;

typedef enum : NSUInteger {
    RequestMethodNone,
    GET,
    POST,
} RequestMethod;

typedef enum : NSUInteger {
    URLModuleKeyTypeShopCategory,
    URLModuleKeyTypeCategoryList,
    URLModuleKeyTypeHomeListAggregatedData,
    URLModuleKeyTypeProductDetail,
    URLModuleKeyTypeProductDetailModel,
    URLModuleKeyTypeAddAddress,
    URLModuleKeyTypeAddressList,
    URLModuleKeyTypeModifyAddressShowInfo,
    URLModuleKeyTypeCommitModifyAddress,
    URLModuleKeyTypeDeleteAddress,
} URLModuleKeyType;


@interface NetWorkService : NSObject

@property (strong, nonatomic) NSMutableDictionary *urlDictionary;   //URL Dictionary

+ (nullable instancetype)shareInstance;

#pragma mark - Project ShopMarket GET/POST methods
/**
 * 请求通用方法
 */
- (void)requestForDataByURLModuleKey:(URLModuleKeyType)urlModuleKey
                        requestParam:(nullable NSDictionary *)requestParam
                       responseBlock:(nullable void (^)(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject))responseBlock;




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
