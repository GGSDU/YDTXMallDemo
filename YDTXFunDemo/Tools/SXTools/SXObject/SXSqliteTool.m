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

- (BOOL)openDataBaseWithPath:(NSString *)path
{
   self.openResult = YES;
   
   if (self.queue) {
      [self.queue close];
      self.queue = nil;
   }
   
   
   self.path = path;
   self.queue = [FMDatabaseQueue databaseQueueWithPath:self.path];
   
   if (self.queue == nil) {
      self.openResult = NO;
   }
   
   return self.openResult;
}

- (void)closeDataBase
{
   if (self.queue) {
      [self.queue close];
   }
}

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
