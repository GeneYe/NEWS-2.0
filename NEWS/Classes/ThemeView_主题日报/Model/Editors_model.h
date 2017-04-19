//
//  Editors_model.h
//  NEWS
//
//  Created by Gene_Ye on 2016/11/13.
//  Copyright © 2016年 Gene. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Editors_model : NSObject

@property (nonatomic , copy) NSString              * avatar;
@property (nonatomic , strong) NSNumber              * Id;
@property (nonatomic , copy) NSString              * url;
@property (nonatomic , copy) NSString              * name;
@property (nonatomic , copy) NSString              * bio;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
