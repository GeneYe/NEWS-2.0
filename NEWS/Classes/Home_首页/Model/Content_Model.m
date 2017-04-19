//
//  Content_Model.m
//  NEWS
//
//  Created by Gene_Ye on 16/10/26.
//  Copyright © 2016年 Gene. All rights reserved.
//

#import "Content_Model.h"

@implementation Content_Model

- (instancetype)initWithDictionary:(NSDictionary *)dic{
    
    if ( self == [super init]) {
        
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key compare: @"id"] == NSOrderedSame) {
        _Id = value;
    }
}

@end
