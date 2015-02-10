//
//  RHRootViewCtro.m
//  VHReproductiveHealth
//
//  Created by lipeng on 15/1/26.
//  Copyright (c) 2015年 vichiger. All rights reserved.
//

#import "RHRootViewCtro.h"

@interface RHRootViewCtro ()

@end

@implementation RHRootViewCtro

- (void)loadView {
    [super loadView];
    
    self.view = [[UIView alloc] initWithFrame:CGRectMake(0, STATUSBAR_HEIGHT+NAVIGATIONBAR_HEIGHT, DEVICE_WIDTH, DEVICE_HEIGHT-STATUSBAR_HEIGHT-NAVIGATIONBAR_HEIGHT)];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.hidden = NO;
    
    self.view.backgroundColor = COLOR_BG_DEF;
}

- (void)initData {
    
}

- (void)initUIView {
    
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
