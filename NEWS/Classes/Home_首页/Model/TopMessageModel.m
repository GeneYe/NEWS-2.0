//
//  TopMessageModel.m
//  NEWS
//
//  Created by Gene_Ye on 16/10/26.
//  Copyright © 2016年 Gene. All rights reserved.
//

#import "TopMessageModel.h"

@implementation TopMessageModel

- (instancetype)initWithDictionary:(NSDictionary *)dictionary{
   
    if (self == [super init]) {
        
        [self setValuesForKeysWithDictionary:dictionary];
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    if ([key compare:@"id"] == NSOrderedSame) {
        _Id = value;
    }
}

@end
