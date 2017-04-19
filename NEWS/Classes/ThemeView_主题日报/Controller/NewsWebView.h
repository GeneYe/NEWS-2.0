//
//  NewsWebView.h
//  NEWS
//
//  Created by Gene_Ye on 2016/11/2.
//  Copyright © 2016年 Gene. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsWebView : UIViewController

@property (nonatomic,strong)NSString *url;

@property (nonatomic,strong)NSNumber *newsId;

@property (nonatomic,strong)NSString *topViewTitle;

@property (nonatomic,strong)NSString *topViewImageUrlStr;


@end
