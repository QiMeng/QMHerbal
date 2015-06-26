//
//  DBHelp.h
//  QMHerbal
//
//  Created by QiMENG on 15/6/26.
//  Copyright (c) 2015年 QiMENG. All rights reserved.
//

#import "QMHerbal-Bridging-Header.h"
#import "Model.h"
@interface DBHelp : NSObject

+ (FMDatabase *)db;

+ (NSArray *)readPage:(int)aPage;

+ (NSArray *)search:(NSString *)aSearch;

@end
