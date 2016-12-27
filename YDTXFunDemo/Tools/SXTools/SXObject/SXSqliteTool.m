//
//  SXSqliteTool.m
//  YueChoose
//
//  Created by Story5 on 6/13/16.
//  Copyright © 2016 Webcity. All rights reserved.
//

#import "SXSqliteTool.h"

@interface SXSqliteTool ()


@end

static SXSqliteTool *instance = nil;

@implementation SXSqliteTool


#pragma mark - fmdb原始方法透出
+ (instancetype)shareInstance
{
   static dispatch_once_t once;
   dispatch_once(&once, ^{
      instance = [[SXSqliteTool alloc] init];
   });
   return instance;
}

#pragma mark - open DB
- (BOOL)openDataBaseWithName:(NSString *)name
{
    // 默认将数据库缓存文件放在Document下
    NSArray *documentDirectory = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    //因为documentDirectory数组只有一个元素,所以取第一个或者最后一个都是一样的
    NSString *myDocPath = [documentDirectory firstObject];
    NSString *path = [NSString stringWithFormat:@"%@/%@.sqlite",myDocPath,name];
    NSLog(@"sqlite path : %@",path);
    return [self openDataBaseWithPath:path];
}

- (BOOL)openDataBaseWithPath:(NSString *)path
{
   _openResult = YES;
   
   if (self.queue) {
      [self.queue close];
      self.queue = nil;
   }
   
   
   _path = path;
   self.queue = [FMDatabaseQueue databaseQueueWithPath:_path];
   
   if (self.queue == nil) {
      _openResult = NO;
   }
   
   return _openResult;
}

#pragma makr - close DB
- (void)closeDataBase
{
   if (self.queue) {
      [self.queue close];
   }
}

#pragma mark - operate DB
- (void)inDatabase:(void (^)(FMDatabase *))block
{
   if (self.queue) {
      [self.queue inDatabase:block];
   }
}

- (void)inTransaction:(void (^)(FMDatabase *, BOOL *))block
{
   if (self.queue) {
      [self.queue inTransaction:block];
   }
}

@end
