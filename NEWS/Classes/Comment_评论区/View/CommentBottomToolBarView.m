//
//  CommentBottomToolBarView.m
//  NEWS
//
//  Created by Gene_Ye on 2016/11/3.
//  Copyright © 2016年 Gene. All rights reserved.
//

#import "CommentBottomToolBarView.h"

@implementation CommentBottomToolBarView

+(instancetype)initCustomWithFrame:(CGRect)frame{
    
    CommentBottomToolBarView *commentBottomToolBarView = [[[NSBundle mainBundle] loadNibNamed:@"CommentBottomToolBarView" owner:nil options:nil] objectAtIndex:0];
    
    commentBottomToolBarView.frame = frame;
    
    return commentBottomToolBarView;
}



- (IBAction)backAction:(UIButton *)sender {
    
    [self.webViewNavigationController popViewControllerAnimated:YES];
}
- (IBAction)goToCommentZone:(UIButton *)sender {
}

@end
