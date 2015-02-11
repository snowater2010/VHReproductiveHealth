//
//  RHMenstrualDataManger.m
//  VHReproductiveHealth
//
//  Created by lipeng on 15/2/8.
//  Copyright (c) 2015年 vichiger. All rights reserved.
//

#import "RHMenstrualDataManger.h"
#import "FMDatabase.h"
#import "RHDataModel.h"

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
        NSString *documentDirectory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
        NSString *dbPath = [documentDirectory stringByAppendingPathComponent:@"RHMenstrual.db"];
        
        NSFileManager *maneger = [NSFileManager defaultManager];
        if (![maneger fileExistsAtPath:dbPath]) {
            _db = [FMDatabase databaseWithPath:dbPath];
            if (![_db open]) {
                return nil;
            }
            [self createTables];
        }
        else {
            _db = [FMDatabase databaseWithPath:dbPath];
            if (![_db open]) {
                return nil;
            }
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

- (NSArray *)queryBiaoZhuStartDate:(NSDate *)strDate endDate:(NSDate *)endDate{
    NSString *qBiaozhu = @"SELECT * FROM biaozhu WHERE calendar >= ? and calendar <= ? ";
    long strTime = [strDate timeIntervalSince1970] * 1000;
    long endTime = [endDate timeIntervalSince1970] * 1000;
    
    NSMutableArray *result = [NSMutableArray array];
    
    FMResultSet *rs = [_db executeQuery:qBiaozhu, [NSNumber numberWithLong:strTime], [NSNumber numberWithLong:endTime]];
    while ([rs next]) {
        RHBiaoZhuModel *biaoZhu = [[RHBiaoZhuModel alloc] init];
        
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
        
        [result addObject:biaoZhu];
    }
    [rs close];
    
    return result;
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
    // 改进

    NSString *dBiaozhu = @"DELETE FROM biaozhu WHERE calendar = ?";
    [_db executeQuery:dBiaozhu, [NSNumber numberWithLong:biaozhu.calendar]];
    
    [self insertBiaoZhu:biaozhu];
    
//    NSString *uBiaozhu = @"UPDATE biaozhu SET tongfang = ?, jiandang = ?, jinzhouqi = ?, jianceBchao = ?, nanfangzhunbei = ?, dayezhen = ?, quruan = ?, yizhi = ?, dongpeixufei = ?, xiaohuipeitai = ?, bushufu = ? WHERE calendar = ?";
//    
//    [_db executeUpdate:uBiaozhu,
//        [NSNumber numberWithInteger:biaozhu.tongfang],
//        [NSNumber numberWithInteger:biaozhu.jiandang],
//        [NSNumber numberWithInteger:biaozhu.jinzhouqi],
//        [NSNumber numberWithInteger:biaozhu.jianceBchao],
//        [NSNumber numberWithInteger:biaozhu.nanfangzhunbei],
//        [NSNumber numberWithInteger:biaozhu.dayezhen],
//        [NSNumber numberWithInteger:biaozhu.quruan],
//        [NSNumber numberWithInteger:biaozhu.yizhi],
//        [NSNumber numberWithInteger:biaozhu.dongpeixufei],
//        [NSNumber numberWithInteger:biaozhu.xiaohuipeitai],
//        biaozhu.bushufu,
//        [NSNumber numberWithLong:biaozhu.calendar]];
}

- (RHDayimaModel *)queryDayimaStartDate:(NSDate *)start {
    NSString *sql = @"SELECT * FROM dayima WHERE start = ?";
    long timeInterval = [start timeIntervalSince1970]*1000;
    
    FMResultSet *rs = [_db executeQuery:sql, [NSNumber numberWithLong:timeInterval]];
    while ([rs next]) {
        RHDayimaModel *model = [[RHDayimaModel alloc] init];
        model.tid = [rs intForColumn:@"tid"];
        model.start = [rs longForColumn:@"start"];
        model.end = [rs longForColumn:@"end"];
        return model;
        break;
    }
    [rs close];
    
    return nil;
}

- (NSArray *)queryDayima {
    NSString *sql = @"SELECT * FROM dayima ORDER BY start ASC";
    
    NSMutableArray *result = [NSMutableArray array];
    
    FMResultSet *rs = [_db executeQuery:sql];
    while ([rs next]) {
        RHDayimaModel *model = [[RHDayimaModel alloc] init];
        model.tid = [rs intForColumn:@"tid"];
        model.start = [rs longForColumn:@"start"];
        model.end = [rs longForColumn:@"end"];
        [result addObject:model];
    }
    [rs close];
    
    return result;
}

- (NSArray *)queryDayimaStartDate:(NSDate *)start endDate:(NSDate *)end {
    NSString *sql = @"SELECT * FROM dayima WHERE end >= ? and start <= ? ";
    
    long timeStart = [start timeIntervalSince1970] * 1000;
    long timeEnd = [end timeIntervalSince1970] * 1000;
    
    NSMutableArray *result = [NSMutableArray array];
    
    FMResultSet *rs = [_db executeQuery:sql, [NSNumber numberWithLong:timeStart], [NSNumber numberWithLong:timeEnd]];
    while ([rs next]) {
        RHDayimaModel *model = [[RHDayimaModel alloc] init];
        model.tid = [rs intForColumn:@"tid"];
        model.start = [rs longForColumn:@"start"];
        model.end = [rs longForColumn:@"end"];
        [result addObject:model];
    }
    [rs close];
    
    return result;
}

- (void)insertDayima:(RHDayimaModel *)model {
    NSString *sql = @"INSERT INTO dayima (start, end) VALUES (?, ?)";
    [_db executeUpdate:sql, [NSNumber numberWithLong:model.start], [NSNumber numberWithLong:model.end]];
}

- (void)insertDayimaStartDate:(NSDate *)startDate endDate:(NSDate *)endDate {
    RHDayimaModel *model = [[RHDayimaModel alloc] init];
    model.start = [startDate timeIntervalSince1970] * 1000;
    model.end = [endDate timeIntervalSince1970] * 1000;
    [self insertDayima:model];
}

- (void)deleteDayimaWithDate:(NSDate *)date {
    NSString *sql = @"DELETE FROM dayima WHERE start <= ? and end >= ?";
    long time = [date timeIntervalSince1970] * 1000;
    [_db executeUpdate:sql, [NSNumber numberWithLong:time], [NSNumber numberWithLong:time]];
}

- (void)updateDayimaEndDate:(NSDate *)endDate withDate:(NSDate *)date {
    NSString *sql = @"UPDATE dayima SET end = ? WHERE start <= ? and end >= ?";
    long endTime = [endDate timeIntervalSince1970] * 1000;
    long time = [date timeIntervalSince1970] * 1000;
    [_db executeUpdate:sql, [NSNumber numberWithLong:endTime], [NSNumber numberWithLong:time], [NSNumber numberWithLong:time]];
}

- (void)updateDayima:(RHDayimaModel *)model {
    NSString *sql = @"UPDATE biaozhu SET start = ?, end = ? WHERE tid = ?";
    [_db executeUpdate:sql, [NSNumber numberWithLong:model.start], [NSNumber numberWithLong:model.end], [NSNumber numberWithLong:model.tid]];
}

- (NSArray *)getMonthData:(NSDate *)date {
    NSDate *startDate = [RHMenstrualDataManger dateFirstAtMonth:date];
    NSDate *endDate = [RHMenstrualDataManger dateLastAtMonth:date];
    
    NSArray *dayimaArray = [self queryDayimaStartDate:startDate endDate:endDate];
    NSArray *biaozhuArray = [self queryBiaoZhuStartDate:startDate endDate:endDate];
    
    NSMutableArray *result = [NSMutableArray array];
    NSDate *eachDate = startDate;
    for (int i = 0; i < endDate.day; i++) {
        RHDataModel *model = [[RHDataModel alloc] initWithDate:eachDate];
        
        // dayima
        long eachTime = [eachDate timeIntervalSince1970] * 1000;
        for (RHDayimaModel *dayima in dayimaArray) {
            if (eachTime >= dayima.start && eachTime <= dayima.end) {
                model.isDayima = YES;
                model.isDayimaBegin = eachTime == dayima.start;
                model.isDayimaEnd = eachTime == dayima.end;
                break;
            }
        }
        
        // biaozhu
        for (RHBiaoZhuModel *biaozhu in biaozhuArray) {
            if (biaozhu.calendar == eachTime) {
                model.biaozhu = biaozhu;
            }
        }
        
        [result addObject:model];
        eachDate = [eachDate dateByAddingDays:1];
    }
    
    return result;
}

+ (NSDate *)dateFirstAtMonth:(NSDate *)date {
    return [[date dateBySettingDays:1] dateAtBeginningOfDay];
}

+ (NSDate *)dateLastAtMonth:(NSDate *)date {
    return [[[[date dateByAddingMonths:1] dateBySettingDays:1] dateByAddingDays:-1] dateAtBeginningOfDay];
}

@end
