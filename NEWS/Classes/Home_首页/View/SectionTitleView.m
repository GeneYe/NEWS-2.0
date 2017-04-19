//
//  SectionTitleView.m
//  NEWS
//
//  Created by Gene_Ye on 2016/11/10.
//  Copyright © 2016年 Gene. All rights reserved.
//

#import "SectionTitleView.h"

@implementation SectionTitleView

+ (instancetype)initWithSectionViewWithFrame:(CGRect)frame{
    
    SectionTitleView *sectionView = [[[NSBundle mainBundle] loadNibNamed:@"SectionTitleView" owner:nil options:nil] objectAtIndex:0];
    
    sectionView.frame = frame;
    
    sectionView.backgroundColor = GYNavigationBarColor;
    
    return sectionView;
}


@end
