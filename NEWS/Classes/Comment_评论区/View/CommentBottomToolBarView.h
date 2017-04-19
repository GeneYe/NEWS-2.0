//
//  CommentBottomToolBarView.h
//  NEWS
//
//  Created by Gene_Ye on 2016/11/3.
//  Copyright © 2016年 Gene. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsWebView.h"

@interface CommentBottomToolBarView : UIView

@property (nonatomic,strong)UINavigationController *webViewNavigationController;

+(instancetype)initCustomWithFrame:(CGRect)frame;

@property (weak, nonatomic) IBOutlet UIButton *backBtn;

@end
