//
//  NewsWebViewTopView.h
//  NEWS
//
//  Created by Gene_Ye on 2016/11/11.
//  Copyright © 2016年 Gene. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsWebViewTopView : UIView

//@property (weak, nonatomic) IBOutlet UIImageView *newsWebViewTopViewImageView;
//
//@property (weak, nonatomic) IBOutlet UILabel *newsWebViewTopViewTitleLabel;

@property (nonatomic,strong)UILabel *newsWebViewTopViewTitleLabel;
@property (nonatomic,strong)UIImageView *newsWebViewTopViewImageView;

+ (instancetype)initCustomNewsWebViewTopViewWithFrame:(CGRect)frame ImageUrlString:(NSString *)urlStr Title:(NSString *)title;

@end
