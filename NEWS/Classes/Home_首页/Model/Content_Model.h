//
//  Content_Model.h
//  NEWS
//
//  Created by Gene_Ye on 16/10/26.
//  Copyright © 2016年 Gene. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Content_Model : NSObject

@property (nonatomic , strong) NSNumber              * Id;
@property (nonatomic , copy) NSString              * title;
@property (nonatomic , strong) NSNumber              * type;
@property (nonatomic , strong) NSArray              * images;
@property (nonatomic , copy) NSString              * ga_prefix;

- (instancetype)initWithDictionary:(NSDictionary *)dic;

@end
