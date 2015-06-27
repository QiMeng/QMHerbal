//
//  DBHelp.m
//  QMHerbal
//
//  Created by QiMENG on 15/6/26.
//  Copyright (c) 2015年 QiMENG. All rights reserved.
//

#import "DBHelp.h"

@implementation DBHelp

+ (NSString *)FMDBPath {
//    return  [[NSBundle mainBundle] pathForResource:@"herbal" ofType:@"db"];
        return  [[NSBundle mainBundle] pathForResource:@"data" ofType:@"db"];
}
+ (FMDatabase *)db {
    FMDatabase *_db = [FMDatabase databaseWithPath:[self FMDBPath]];
    [_db open];
    return _db;
}

+ (NSArray *)readPage:(int)aPage {
    
    NSMutableArray * array = [NSMutableArray array];
    
    @autoreleasepool {
        FMDatabase * db = [self db];
        
//        FMResultSet *rs = [db executeQuery:@"SELECT * FROM medica"];
        NSLog(@"%@",[NSString stringWithFormat:@"SELECT * FROM medica LIMIT %d,%d",aPage*500,500]);
        FMResultSet *rs = [db executeQuery:[NSString stringWithFormat:@"SELECT * FROM medica LIMIT %d,%d",aPage*500,500]];
        
        while ([rs next]) {
            
            [array addObject:[[Model alloc]initWithTitle:[rs stringForColumn:@"title"]
                                                    href:[rs stringForColumn:@"href"]
                                                    info:[rs stringForColumn:@"info"]]];
            
            
        }
        
        [db close];
    }
    
    return array;
}


+ (NSArray *)search:(NSString *)aSearch {
    
    NSMutableArray * array = [NSMutableArray array];
    
    @autoreleasepool {
        FMDatabase * db = [self db];
        
        FMResultSet *rs = [db executeQuery:[NSString stringWithFormat:@"SELECT * FROM medica WHERE title LIKE  '%%%@%%'",aSearch]];
        
        while ([rs next]) {
            
            [array addObject:[[Model alloc]initWithTitle:[rs stringForColumn:@"title"]
                                                    href:[rs stringForColumn:@"href"]
                                                    info:[rs stringForColumn:@"info"]]];
        }
        [db close];
    }
    
    return array;
    
}


@end
