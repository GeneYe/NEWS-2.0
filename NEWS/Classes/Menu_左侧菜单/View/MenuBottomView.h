//
//  MenuBottomView.h
//  NEWS
//
//  Created by Gene_Ye on 2016/11/12.
//  Copyright © 2016年 Gene. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MenuBottomViewDelegate <NSObject>

- (void)getCellBackgroundColor:(UIColor *)cellBackgroundColor;

@end

@interface MenuBottomView : UIView

@property (weak, nonatomic) IBOutlet UIButton *MenuBottomDownLoadButton;
@property (weak, nonatomic) IBOutlet UIButton *MenuBottomDarkButton;

@property (nonatomic,weak)id<MenuBottomViewDelegate>delegate;
@property (nonatomic,strong)UIColor *cellBackgroundColor;
@property (nonatomic,strong)UIColor *cellTextLabelFontColor;

@property (nonatomic,assign)BOOL isDrak;

+ (instancetype)createCustomBottomViewWithFrame:(CGRect)frame;

@end
