//
//  ThemeTitle_Model.m
//  NEWS
//
//  Created by Gene_Ye on 2016/11/1.
//  Copyright © 2016年 Gene. All rights reserved.
//

#import "ThemeTitle_Model.h"

@implementation ThemeTitle_Model

- (instancetype)initWithDictionary:(NSDictionary *)dic{
    if (self = [super init]) {
        
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        _Id = value;
    }
    if ([key isEqualToString:@"description"]) {
        _Description = value;
    }
}

@end
