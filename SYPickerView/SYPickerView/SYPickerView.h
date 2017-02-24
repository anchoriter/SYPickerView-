//
//  SYPickerView.h
//  mobileapp
//
//  Created by Anchoriter on 2017/2/24.
//  Copyright © 2017年 Anchoriter. All rights reserved.

#import <UIKit/UIKit.h>

typedef void(^ConfirmBtnClickBlock)(NSString *selectedString);

/**
 *  绑定实盘账号证件选择器视图
 */
@interface SYPickerView : UIView

/** 完成按钮的回调 */
@property (nonatomic, copy) ConfirmBtnClickBlock confirmBtnClickBlock;
/** PickerView数据源 */
@property (strong,nonatomic)NSArray *dataSource;
/** 背景的透明度 */
@property (assign,nonatomic)CGFloat backgroundAlpha;
/** 背景的颜色 */
@property (strong,nonatomic)UIColor *backgroundViewColor;
/** 按钮的宽 */
@property (assign,nonatomic)NSInteger buttonWidth;
/** 按钮的高 */
@property (assign,nonatomic)NSInteger buttonHeight;
/** Toolbar的背景颜色 */
@property (strong,nonatomic)UIColor *toolbarBackgroundColor;
/** pickerView的背景颜色 */
@property (strong,nonatomic)UIColor *pickerViewBackgroundColor;
/** pickerView的高度 */
@property (assign,nonatomic)CGFloat pickerViewHeight;

-(instancetype)initWithTitltArr:(NSArray *)titltArr completeButtonBlock:(ConfirmBtnClickBlock)block;

/**
 *  展示遮盖
 */
//- (void)showPickerView;
/**
 *  确定按钮回调
 */
//- (void)clickCompleteButtonBlock:(ConfirmBtnClickBlock)block;

@end
