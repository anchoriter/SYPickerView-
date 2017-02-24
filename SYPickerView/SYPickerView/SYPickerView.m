//
//  SYPickerView.m
//  mobileapp
//
//  Created by Anchoriter on 2017/2/24.
//  Copyright © 2017年 Anchoriter. All rights reserved.
//

#import "SYPickerView.h"

#define ScreenHeight  [UIScreen mainScreen].bounds.size.height
#define ScreenWidth  [UIScreen mainScreen].bounds.size.width

@interface SYPickerView ()<UIPickerViewDelegate, UIPickerViewDataSource>
/** 底层容器 */
@property (nonatomic, strong) UIView *bottomContainerView;
/** 遮罩层 */
@property (nonatomic, strong) UIButton *bottomButton;
/** 承载弹窗的容器 */
@property (nonatomic, strong) UIView *coverView;
/** 选择器 */
@property (nonatomic, strong) UIPickerView *pickerView;
/** 选择器顶部选择栏 */
@property (nonatomic, strong) UIToolbar *toolbar;

@end

@implementation SYPickerView
-(instancetype)initWithTitltArr:(NSArray *)titltArr completeButtonBlock:(ConfirmBtnClickBlock)block{

    if (self = [super init]) {
        // 默认的属性设置
        // 背景透明度
        self.backgroundAlpha = 0.5;
        // 默认背景颜色
        self.toolbarBackgroundColor = [UIColor colorWithRed:247 green:247 blue:247 alpha:1.0f];
        self.backgroundViewColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1.0f];
        // 默认toolbar宽高
        self.buttonWidth = 60;
        self.buttonHeight = 44;
        // 默认pickView背景颜色
        self.pickerViewBackgroundColor = [UIColor whiteColor];
        // 默认pickView高度
        self.pickerViewHeight = 216;
        
        self.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
        
        [self addPickerView];
        [self showPickerView];
        
        self.dataSource = titltArr;
        self.confirmBtnClickBlock = block;
        
    }
    return self;
}

/**
 添加控件
 */
-(void)addPickerView{
    // 底层view
    self.bottomContainerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    [self addSubview:self.bottomContainerView];
    
    // 和底层view等宽等高的按钮
    self.bottomButton = [[UIButton alloc] init];
    self.bottomButton.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    [self.bottomButton addTarget:self action:@selector(backgroundBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.bottomButton.backgroundColor = self.backgroundViewColor;
    self.bottomButton.alpha = self.backgroundAlpha;
    [self.bottomContainerView addSubview:self.bottomButton];
    
    // 承载弹窗的容器
    self.coverView = [[UIView alloc] init];
    [self.bottomContainerView addSubview:self.coverView];
    self.coverView.frame = CGRectMake(0, ScreenHeight, ScreenWidth, self.pickerViewHeight + self.buttonHeight);
    
    // 工具栏
    self.toolbar = [[UIToolbar alloc] init];
    self.toolbar.backgroundColor = self.toolbarBackgroundColor;
    [self.coverView addSubview:self.toolbar];
    self.toolbar.frame = CGRectMake(0, 0, ScreenWidth, self.buttonHeight);
    
    // 选择器
    self.pickerView = [[UIPickerView alloc] init];
    self.pickerView.backgroundColor = self.pickerViewBackgroundColor;
    self.pickerView.dataSource = self;
    self.pickerView.delegate = self;
    [self.coverView addSubview:self.pickerView];
    self.pickerView.frame = CGRectMake(0, self.buttonHeight, ScreenWidth, self.pickerViewHeight);
    
    // 设置工具栏
    [self setUpToobar];
}

- (void)setUpToobar{
    UIBarButtonItem *cancelBtn=[[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancelBtnClick)];
    UIBarButtonItem *flexible=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    UIBarButtonItem *finishBtn=[[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(confirmBtnClick)];
    NSArray *btnArr=[[NSArray alloc]initWithObjects:cancelBtn,flexible,finishBtn, nil];
    [self.toolbar setItems:btnArr];
    
    cancelBtn.width = self.buttonWidth;
    finishBtn.width = self.buttonWidth;

}
#pragma mark - 数据源赋值

/**
 数据源赋值

 @param dataSource 数据源数组
 */
- (void)setDataSource:(NSArray *)dataSource {
    _dataSource = dataSource;
    [self.pickerView reloadAllComponents];
    [self.pickerView selectRow:1 inComponent:0 animated:YES];
}

#pragma mark - 按钮点击响应方法
/**
 半透明的背景按钮点击响应方法
 */
- (void)backgroundBtnClick {
    [self hideCoverView];
}

/**
 取消按钮
 */
- (void)cancelBtnClick {
    [self hideCoverView];
}

/**
 确定按钮
 */
- (void)confirmBtnClick {
    
    __weak typeof(self) weakSelf = self;
    
    if (self.confirmBtnClickBlock != nil) {
        NSInteger index = [weakSelf.pickerView selectedRowInComponent:0];
        NSString *selectedString = weakSelf.dataSource[index];

        weakSelf.confirmBtnClickBlock(selectedString);
    }
    [self hideCoverView];
}

#pragma mark - 开始和结束

/**
 开始
 */
- (void)showPickerView {
    
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.5f delay:0.0f usingSpringWithDamping:0.8f initialSpringVelocity:5.0f options:UIViewAnimationOptionLayoutSubviews animations:^{
        
        weakSelf.coverView.frame = CGRectMake(0, ScreenHeight - weakSelf.pickerViewHeight - weakSelf.buttonHeight, ScreenWidth, weakSelf.pickerViewHeight + weakSelf.buttonHeight);
        
        
    } completion:^(BOOL finished) {
        
        
    }];
    
}

/**
 结束
 */
- (void)hideCoverView {
    
    [self.bottomContainerView removeFromSuperview];
    [self removeFromSuperview];
}

#pragma mark - UIPickerView DataSource

/**
 设置选择器轮子组数

 @param pickerView 当前选择器
 @return 返回选择器轮子组数
 */
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

/**
 设置选择器每组的可选数

 @param pickerView 当前选择器
 @param component 第几个轮子
 @return 选择器每组的可选数
 */
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    return self.dataSource.count;
}

/**
 *  区域中row的展示view
 *
 *  @param pickerView 选择器视图
 *  @param row        第几行
 *  @param component  第几个区域
 *  @param view       重用view
 *
 *  @return 展示view
 */
-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    
    UILabel *lable = [[UILabel alloc]init];
    lable.textAlignment = NSTextAlignmentCenter;
    lable.font = [UIFont systemFontOfSize:23];
    
    lable.text = [self.dataSource objectAtIndex:row];
    
    [self changeSpearatorLineColor];
    return lable;
}
-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    
    return 35;
}

#pragma mark - 改变分割线的颜色和高度
- (void)changeSpearatorLineColor
{
    for(UIView *speartorView in self.pickerView.subviews)
    {
        if (speartorView.frame.size.height < 1)//取出分割线view
        {
            // 修改分割线的高度
            CGRect frame = speartorView.frame;
            frame.size.height = 0.5;
            
            speartorView.frame = frame;
            // 修改分割线颜色
            speartorView.backgroundColor = [UIColor lightGrayColor];
        }
    }
}


@end
