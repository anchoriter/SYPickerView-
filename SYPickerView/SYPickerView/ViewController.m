//
//  ViewController.m
//  SYPickerView
//
//  Created by Anchoriter on 2017/2/24.
//  Copyright © 2017年 Anchoriter. All rights reserved.
//

#import "ViewController.h"
#import "SYPickerView.h"

@interface ViewController ()
@property (nonatomic, strong) NSArray *pickViewTitltArr;

@property (weak, nonatomic) IBOutlet UIButton *typeButton;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}
- (IBAction)clickButton:(UIButton *)sender {
    
    // 选择器
    __weak typeof(self)weakSelf = self;
    SYPickerView * pickView = [[SYPickerView alloc] initWithTitltArr:self.pickViewTitltArr completeButtonBlock:^(NSString *selectedString) {
        
        [weakSelf.typeButton setTitle:selectedString forState:UIControlStateNormal];
    }];
    
    [[UIApplication sharedApplication].keyWindow addSubview:pickView];
    
    // 以下属性可根据需要设置
    //    pickView.backgroundAlpha = 0.5;
    //    // 默认背景颜色
    //    pickView.toolbarBackgroundColor = [UIColor colorWithRed:247 green:247 blue:247 alpha:1.0f];
    //    pickView.backgroundViewColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1.0f];
    //    // 默认toolbar宽高
    //    pickView.buttonWidth = 60;
    //    pickView.buttonHeight = 44;
    //    // 默认pickView背景颜色
    //    pickView.pickerViewBackgroundColor = [UIColor whiteColor];
    //    // 默认pickView高度
    //    pickView.pickerViewHeight = 216;
    
    
}


#pragma mark - 懒加载
-(NSArray *)pickViewTitltArr{
    if (!_pickViewTitltArr) {
        _pickViewTitltArr = [NSArray arrayWithObjects:@"身份证", @"驾驶证", @"结婚证", nil];
    }
    return _pickViewTitltArr;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
