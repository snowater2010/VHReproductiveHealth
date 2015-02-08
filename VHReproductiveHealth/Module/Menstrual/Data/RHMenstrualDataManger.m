//
//  RHMenstrualDataManger.m
//  VHReproductiveHealth
//
//  Created by lipeng on 15/2/8.
//  Copyright (c) 2015年 vichiger. All rights reserved.
//

#import "RHMenstrualDataManger.h"
#import "FMDatabase.h"

@interface RHMenstrualDataManger () {
    FMDatabase *_db;
}

@end

@implementation RHMenstrualDataManger

+ (instancetype)sharedInstance {
    static RHMenstrualDataManger *_sharedInstance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[RHMenstrualDataManger alloc] init];
    });
    return _sharedInstance;
}

- (instancetype)init {
    if (self = [super init]) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentDirectory = [paths objectAtIndex:0];
        NSString *dbPath = [documentDirectory stringByAppendingPathComponent:@"RHMenstrual.db"];
        
        _db = [FMDatabase databaseWithPath:dbPath];
        if (![_db open]) {
            return nil;
        }
        
        NSFileManager *maneger = [NSFileManager defaultManager];
        if (![maneger fileExistsAtPath:dbPath]) {
            [self createTables];
        }
    }
    return self;
}

- (void)dealloc {
    [self closeDB];
}

- (void)closeDB {
    if ([_db open]) {
        [_db close];
    }
}

- (void)createTables {
    NSString *biaozhuD = @"DROP TABLE IF EXISTS 'biaozhu';";
    NSString *biaozhuC = @"CREATE TABLE 'biaozhu' ('tid' INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,'calendar' long NOT NULL,'tongfang' integer DEFAULT -1,'jiandang' integer DEFAULT -1,'jinzhouqi' integer DEFAULT -1,'jianceBchao' integer DEFAULT -1,'nanfangzhunbei' integer DEFAULT -1,'dayezhen' integer DEFAULT -1,'quruan' integer DEFAULT -1,'yizhi' integer DEFAULT -1,'dongpeixufei' integer DEFAULT -1,'xiaohuipeitai' integer DEFAULT -1,'bushufu' text);";
    
    NSString *dayimaD = @"DROP TABLE IF EXISTS 'dayima';";
    NSString *dayimaC = @"CREATE TABLE 'dayima' ('tid' integer NOT NULL DEFAULT 1 PRIMARY KEY AUTOINCREMENT,'start' integer NOT NULL DEFAULT 0,'end' integer NOT NULL DEFAULT 0);";
    
    
    NSString *koufubiyuanyaoD = @"DROP TABLE IF EXISTS 'koufubiyuanyao';";
    NSString *koufubiyuanyaoC = @"CREATE TABLE 'koufubiyuanyao' ('tid' integer NOT NULL PRIMARY KEY AUTOINCREMENT,'start' integer,'end' integer);";
    
    NSString *redianliliaoD = @"DROP TABLE IF EXISTS 'redianliliao';";
    NSString *redianliliaoC = @"CREATE TABLE 'redianliliao' ('tid' integer NOT NULL PRIMARY KEY AUTOINCREMENT,'start' integer,'end' integer);";
    
    [_db executeUpdate:biaozhuD];
    [_db executeUpdate:biaozhuC];
    [_db executeUpdate:dayimaD];
    [_db executeUpdate:dayimaC];
    [_db executeUpdate:koufubiyuanyaoD];
    [_db executeUpdate:koufubiyuanyaoC];
    [_db executeUpdate:redianliliaoD];
    [_db executeUpdate:redianliliaoC];
}

- (RHBiaoZhuModel *)queryBiaoZhu:(NSDate *)date {
    NSString *qBiaozhu = @"SELECT * FROM biaozhu WHERE calendar = ?";
    long timeInterval = [date timeIntervalSince1970]*1000;
    
    BOOL hasResult = NO;
    
    RHBiaoZhuModel *biaoZhu = [[RHBiaoZhuModel alloc] init];
    FMResultSet *rs = [_db executeQuery:qBiaozhu, [NSNumber numberWithLong:timeInterval]];
    while ([rs next]) {
        hasResult = YES;
        
        biaoZhu.calendar = [rs longForColumn:@"calendar"];
        biaoZhu.tongfang = [rs intForColumn:@"tongfang"];
        biaoZhu.jiandang = [rs intForColumn:@"jiandang"];
        
        biaoZhu.jinzhouqi = [rs longForColumn:@"jinzhouqi"];
        biaoZhu.jianceBchao = [rs intForColumn:@"jianceBchao"];
        biaoZhu.nanfangzhunbei = [rs intForColumn:@"nanfangzhunbei"];
        
        biaoZhu.dayezhen = [rs longForColumn:@"dayezhen"];
        biaoZhu.quruan = [rs intForColumn:@"quruan"];
        biaoZhu.yizhi = [rs intForColumn:@"yizhi"];
        
        biaoZhu.dongpeixufei = [rs longForColumn:@"dongpeixufei"];
        biaoZhu.xiaohuipeitai = [rs intForColumn:@"xiaohuipeitai"];
        biaoZhu.bushufu = [rs stringForColumn:@"bushufu"];
        
        break;
    }
    [rs close];
    
    // 如果没有查到则新建一条空的
    if (!hasResult) {
        biaoZhu.calendar = timeInterval;
        [self insertBiaoZhu:biaoZhu];
    }
    
    return biaoZhu;
}

- (void)insertBiaoZhu:(RHBiaoZhuModel *)biaozhu {
    NSString *iBiaozhu = @"INSERT INTO biaozhu (tongfang, jiandang, jinzhouqi, jianceBchao, nanfangzhunbei, dayezhen, quruan, yizhi, dongpeixufei, xiaohuipeitai, bushufu, calendar) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?) ";
    
    [_db executeUpdate:iBiaozhu,
        [NSNumber numberWithInteger:biaozhu.tongfang],
        [NSNumber numberWithInteger:biaozhu.jiandang],
        [NSNumber numberWithInteger:biaozhu.jinzhouqi],
        [NSNumber numberWithInteger:biaozhu.jianceBchao],
        [NSNumber numberWithInteger:biaozhu.nanfangzhunbei],
        [NSNumber numberWithInteger:biaozhu.dayezhen],
        [NSNumber numberWithInteger:biaozhu.quruan],
        [NSNumber numberWithInteger:biaozhu.yizhi],
        [NSNumber numberWithInteger:biaozhu.dongpeixufei],
        [NSNumber numberWithInteger:biaozhu.xiaohuipeitai],
        biaozhu.bushufu,
        [NSNumber numberWithLong:biaozhu.calendar]];
    
}

- (void)updateBiaoZhu:(RHBiaoZhuModel *)biaozhu {
    NSString *uBiaozhu = @"UPDATE biaozhu SET tongfang = ?, jiandang = ?, jinzhouqi = ?, jianceBchao = ?, nanfangzhunbei = ?, dayezhen = ?, quruan = ?, yizhi = ?, dongpeixufei = ?, xiaohuipeitai = ?, bushufu = ? WHERE calendar = ?";
    
    [_db executeUpdate:uBiaozhu,
        [NSNumber numberWithInteger:biaozhu.tongfang],
        [NSNumber numberWithInteger:biaozhu.jiandang],
        [NSNumber numberWithInteger:biaozhu.jinzhouqi],
        [NSNumber numberWithInteger:biaozhu.jianceBchao],
        [NSNumber numberWithInteger:biaozhu.nanfangzhunbei],
        [NSNumber numberWithInteger:biaozhu.dayezhen],
        [NSNumber numberWithInteger:biaozhu.quruan],
        [NSNumber numberWithInteger:biaozhu.yizhi],
        [NSNumber numberWithInteger:biaozhu.dongpeixufei],
        [NSNumber numberWithInteger:biaozhu.xiaohuipeitai],
        biaozhu.bushufu,
        [NSNumber numberWithLong:biaozhu.calendar]];
}

@end