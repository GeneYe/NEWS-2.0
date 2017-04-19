//
//  ThemeTitle_Model.h
//  NEWS
//
//  Created by Gene_Ye on 2016/11/1.
//  Copyright © 2016年 Gene. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ThemeTitle_Model : NSObject

@property (nonatomic , copy) NSString              * name;
@property (nonatomic , strong) NSNumber              * Id;
@property (nonatomic , copy) NSString              * Description;
@property (nonatomic , copy) NSString              * thumbnail;
@property (nonatomic , strong) NSNumber              * color;


-(instancetype)initWithDictionary:(NSDictionary *)dic;

@end
