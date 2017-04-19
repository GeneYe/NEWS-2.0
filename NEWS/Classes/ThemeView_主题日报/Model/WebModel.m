//
//  WebModel.m
//  NEWS
//
//  Created by Gene_Ye on 2016/11/2.
//  Copyright © 2016年 Gene. All rights reserved.
//

#import "WebModel.h"

@implementation WebModel

- (instancetype)initWithDict:(NSDictionary *)dict {
    
    if (self=[super init]) {
        
        [self setValuesForKeysWithDictionary:dict];
    }
    
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
    
}


@end
