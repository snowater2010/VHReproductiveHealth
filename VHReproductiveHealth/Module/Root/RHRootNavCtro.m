//
//  RHRootNavCtro.m
//  VHReproductiveHealth
//
//  Created by lipeng on 15/1/26.
//  Copyright (c) 2015年 vichiger. All rights reserved.
//

#import "RHRootNavCtro.h"

@interface RHRootNavCtro ()

@end

@implementation RHRootNavCtro

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 设置导航栏不穿透
//    [[UINavigationBar appearance] setTranslucent:NO];
    
    self.navigationBar.barTintColor = COLOR_BG_DGREEN;
    [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : COLOR_TEXT_WHITE, NSFontAttributeName : FONT_18B}];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
