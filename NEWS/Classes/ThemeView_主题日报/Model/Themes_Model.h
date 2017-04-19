//
//  Themes_Model.h
//  NEWS
//
//  Created by Gene_Ye on 2016/11/1.
//  Copyright © 2016年 Gene. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Themes_Model : NSObject

@property (nonatomic , strong) NSNumber              * Id;
@property (nonatomic , copy) NSString              * title;
@property (nonatomic , strong) NSNumber              * type;
@property (nonatomic , strong) NSArray              * images;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
