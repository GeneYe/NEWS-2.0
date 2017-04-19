//
//  BottomToolBarView.h
//  NEWS
//
//  Created by Gene_Ye on 2016/11/3.
//  Copyright © 2016年 Gene. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Theme_RootViewController.h"
#import "CommentViewController.h"

typedef void(^IsPushBlock)(BOOL isPush);
@interface BottomToolBarView : UIView
@property (weak, nonatomic) IBOutlet UIButton *backBtn;

@property (weak, nonatomic) IBOutlet UIButton *nextBtn;
@property (weak, nonatomic) IBOutlet UIButton *likeBtn;
@property (weak, nonatomic) IBOutlet UIButton *shareBtn;
@property (weak, nonatomic) IBOutlet UIButton *commentBtn;
@property (weak, nonatomic) IBOutlet UILabel *commentCountLabel;

@property (nonatomic,assign)BOOL isLike;
@property (nonatomic,copy) IsPushBlock ispushBlock;

@property (nonatomic,strong)UINavigationController *themeNavigationController;
@property (nonatomic,strong)CommentViewController *commentViewConroller;

+ (instancetype)initCustomWithframe:(CGRect)frame;

@end
