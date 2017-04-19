//
//  MenuBottomView.m
//  NEWS
//
//  Created by Gene_Ye on 2016/11/12.
//  Copyright © 2016年 Gene. All rights reserved.
//

#import "MenuBottomView.h"

@implementation MenuBottomView

- (void)awakeFromNib{
    
    [super awakeFromNib];
    
    self.translatesAutoresizingMaskIntoConstraints = YES;
}

+ (instancetype)createCustomBottomViewWithFrame:(CGRect)frame{
    
    MenuBottomView *view = [[[NSBundle mainBundle] loadNibNamed:@"MenuBottomView" owner:nil options:nil] objectAtIndex:0];
    
    view.frame = frame;
    
    view.backgroundColor = [UIColor clearColor];
    
    [view.MenuBottomDarkButton setTitleColor:GYFontColor forState:UIControlStateNormal];
    [view.MenuBottomDownLoadButton setTitleColor:GYFontColor forState:UIControlStateNormal];
    
    view.MenuBottomDownLoadButton.titleLabel.font = [UIFont systemFontOfSize:18];
    view.MenuBottomDarkButton.titleLabel.font = [UIFont systemFontOfSize:18];
    
    
    return view;
    
}

- (void)layoutSubviews{
    CGRect frame = self.frame;
    frame.size.width = Menu_Width;
    [self setFrame:frame];
}

- (IBAction)changeBackgroundColor:(UIButton *)sender {
    
    _isDrak = !_isDrak;
    if (_isDrak) {
        [_MenuBottomDarkButton setTitle:@"白天" forState:UIControlStateNormal];
        [_MenuBottomDarkButton setImage:[UIImage imageNamed:@"Menu_Day"] forState:UIControlStateNormal];

        _cellBackgroundColor = GYTableViewCellBackgroundColor;
        _cellTextLabelFontColor = GYTableViewCellTextColor;
    }
    else{
        [_MenuBottomDarkButton setTitle:@"夜间" forState:UIControlStateNormal];
        [_MenuBottomDarkButton setImage:[UIImage imageNamed:@"Menu_Dark"] forState:UIControlStateNormal];

        _cellBackgroundColor = [UIColor whiteColor];
        _cellTextLabelFontColor = [UIColor blackColor];
    }
    
    NSDictionary *dic = @{@"backgroundColor":_cellBackgroundColor,@"fontColor":_cellTextLabelFontColor};
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"changeColor" object:nil userInfo:dic];
}









@end
