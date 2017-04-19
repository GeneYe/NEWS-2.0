//
//  WebModel.h
//  NEWS
//
//  Created by Gene_Ye on 2016/11/2.
//  Copyright © 2016年 Gene. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WebModel : NSObject

@property (nonatomic, copy) NSString *body;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSArray  *css;
@property (nonatomic, strong)NSString *image;

- (instancetype)initWithDict:(NSDictionary *)dict;

@end
