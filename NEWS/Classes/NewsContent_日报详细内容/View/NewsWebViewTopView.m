//
//  NewsWebViewTopView.m
//  NEWS
//
//  Created by Gene_Ye on 2016/11/11.
//  Copyright © 2016年 Gene. All rights reserved.
//

#import "NewsWebViewTopView.h"
#import <UIImageView+WebCache.h>

@implementation NewsWebViewTopView

+(instancetype)initCustomNewsWebViewTopViewWithFrame:(CGRect)frame ImageUrlString:(NSString *)urlStr Title:(NSString *)title{
    
    NewsWebViewTopView *topView = [[[NSBundle mainBundle] loadNibNamed:@"NewsWebViewTopView" owner:nil options:nil] objectAtIndex:0];
    
    topView.frame = frame;
    
    topView.newsWebViewTopViewTitleLabel.text = title;
    
    [topView.newsWebViewTopViewImageView sd_setImageWithURL:[NSURL URLWithString:urlStr]];

    topView.newsWebViewTopViewImageView.contentMode = UIViewContentModeScaleAspectFill;
    [topView.newsWebViewTopViewImageView setClipsToBounds:YES];
    
    return topView;
    
}

//+ (instancetype)initCustomNewsWebViewTopViewWithFrame:(CGRect)frame ImageUrlString:(NSString *)urlStr Title:(NSString *)title{
//    
//    NewsWebViewTopView *topView = [[NewsWebViewTopView alloc] initWithFrame:frame];
//    topView.newsWebViewTopViewTitleLabel = [[UILabel alloc] initWithFrame:frame];
////    topView.newsWebViewTopViewTitleLabel.RL_Height = 44;
////    topView.newsWebViewTopViewTitleLabel.RL_right = 10;
////    topView.newsWebViewTopViewTitleLabel.RL_Width = Screen_Width - 20;
////    topView.newsWebViewTopViewTitleLabel.RL_bottom = 15;
//    topView.newsWebViewTopViewTitleLabel.font = [UIFont systemFontOfSize:20.0];
//    topView.newsWebViewTopViewTitleLabel.textColor = [UIColor whiteColor];
//    topView.newsWebViewTopViewTitleLabel.text = title;
//    [topView addSubview:topView.newsWebViewTopViewTitleLabel];
//    
//    topView.newsWebViewTopViewImageView = [[UIImageView alloc] initWithFrame:frame];
//    topView.newsWebViewTopViewImageView.backgroundColor = [UIColor blueColor];
//    [topView.newsWebViewTopViewImageView sd_setImageWithURL:[NSURL URLWithString:urlStr]];
//    topView.newsWebViewTopViewImageView.contentMode = UIViewContentModeScaleAspectFill;
//    [topView addSubview:topView.newsWebViewTopViewImageView];
//    
//    return topView;
//}

@end
