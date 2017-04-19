//
//  Editors_model.m
//  NEWS
//
//  Created by Gene_Ye on 2016/11/13.
//  Copyright © 2016年 Gene. All rights reserved.
//

#import "Editors_model.h"

@implementation Editors_model

- (instancetype)initWithDictionary:(NSDictionary *)dictionary{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dictionary];
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        _Id = value;
    }
}

@end
