//
//  SXSqliteTool.h
//  YueChoose
//
//  Created by Story5 on 6/13/16.
//  Copyright © 2016 Webcity. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FMDB.h"

@interface SXSqliteTool : NSObject

+ (instancetype)shareInstance;

#pragma mark - fmdb原始方法透出
@property (nonatomic,assign,readonly) BOOL openResult;

@property (nonatomic,copy) NSString *path;

//@property (nonatomic,strong) FMDatabase *fb;
@property (nonatomic,strong) FMDatabaseQueue *queue;

/**
 *  打开数据库文件,成功返回YES,失败返回NO
 *  如果文件不存在,则创建
 */
- (BOOL)openDataBaseWithName:(NSString *)name;
- (BOOL)openDataBaseWithPath:(NSString *)path;

/**
 *  关闭数据库
 */
- (void)closeDataBase;

/**
 *  多线程操作
 */
- (void)inDatabase:(void (^)(FMDatabase *db))block;

/**
 *  多事务操作
 *  支持回滚
 */
- (void)inTransaction:(void (^)(FMDatabase *db, BOOL *rollback))block;

@end
