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
@property (nonatomic,assign) BOOL openResult;

@property (nonatomic,copy) NSString *path;

@property (nonatomic,strong) FMDatabaseQueue *queue;

- (BOOL)openDataBaseWithPath:(NSString *)path;

- (void)closeDataBase;

- (void)inDatabase:(void (^)(FMDatabase *db))block;

- (void)inTransaction:(void (^)(FMDatabase *db, BOOL *rollback))block;

@end
