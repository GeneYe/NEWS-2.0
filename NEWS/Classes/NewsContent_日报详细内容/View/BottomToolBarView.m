//
//  BottomToolBarView.m
//  NEWS
//
//  Created by Gene_Ye on 2016/11/3.
//  Copyright © 2016年 Gene. All rights reserved.
//

#import "BottomToolBarView.h"

@implementation BottomToolBarView


+ (instancetype)initCustomWithframe:(CGRect)frame{
    
    BottomToolBarView *bottomToolBarView = [[[NSBundle mainBundle] loadNibNamed:@"BottomToolBarView" owner:nil options:nil] objectAtIndex:0];
    
    bottomToolBarView.frame = frame;
    
    return bottomToolBarView;
}


- (IBAction)backAction:(UIButton *)sender {
    
    [self.themeNavigationController popViewControllerAnimated:YES];
}

- (IBAction)nextAction:(UIButton *)sender {
    
}

- (IBAction)likeAction:(id)sender {
    
    _isLike = !_isLike;
    if (_isLike) {
        [_likeBtn setImage:[UIImage imageNamed:@"News_Navigation_Voted"] forState:UIControlStateNormal];
    }
    else{
        [_likeBtn setImage:[UIImage imageNamed:@"News_Navigation_Vote"] forState:UIControlStateNormal];
    }
}


- (IBAction)shareAction:(UIButton *)sender {
}


- (IBAction)commentAction:(UIButton *)sender {
    
    [self.themeNavigationController pushViewController:self.commentViewConroller animated:YES];
}
@end
