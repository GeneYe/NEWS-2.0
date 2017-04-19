//
//  SectionTitleView.h
//  NEWS
//
//  Created by Gene_Ye on 2016/11/10.
//  Copyright © 2016年 Gene. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SectionTitleView : UIView
@property (weak, nonatomic) IBOutlet UILabel *BeforeNewsTitleLabel;

+ (instancetype)initWithSectionViewWithFrame:(CGRect)frame;

@end
