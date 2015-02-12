//
//  RHHomeViewCtro.m
//  VHReproductiveHealth
//
//  Created by lipeng on 15/1/27.
//  Copyright (c) 2015年 vichiger. All rights reserved.
//

#import "RHHomeViewCtro.h"
#import "RHMyJingliViewCtro.h"
#import "RHMenstrualViewCtro.h"

@interface RHHomeViewCtro ()

@end

@implementation RHHomeViewCtro

- (void)loadView {
    [super loadView];
    
    self.view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT)];
}

- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUIView];
}

- (void)initUIView {
    
    // title
    UIView *menuBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, STATUSBAR_HEIGHT+NAVIGATIONBAR_HEIGHT)];
    [self.view addSubview:menuBar];
    menuBar.backgroundColor = UIColorFromRGB(0x0079c2);
    
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, STATUSBAR_HEIGHT, menuBar.width, NAVIGATIONBAR_HEIGHT)];
    [self.view addSubview:titleView];
    
    UIImage *xImage = [UIImage imageNamed:@"sd_index_09"];
    UIImageView *xImageView = [[UIImageView alloc] initWithImage:xImage];
    [titleView addSubview:xImageView];
    [[[xImageView setSizeFromSize:xImage.size] centerYWith:titleView] insideLeftEdgeBy:15];
    
    UIImage *lImage = [UIImage imageNamed:@"sd_index_06"];
    UIImageView *lImageView = [[UIImageView alloc] initWithImage:lImage];
    [titleView addSubview:lImageView];
    [[[lImageView setSizeFromSize:lImage.size] centerYWith:titleView] outsideRightEdgeOf:xImageView by:15];
    
    UIImage *aImage = [UIImage imageNamed:@"sd_index_03"];
    UIImageView *aImageView = [[UIImageView alloc] initWithImage:aImage];
    [titleView addSubview:aImageView];
    [[[aImageView setSizeFromSize:aImage.size] centerYWith:titleView] outsideRightEdgeOf:lImageView by:8];
    
    UIImage *rImage = [UIImage imageNamed:@"sd_index_12"];
    UIImageView *rImageView = [[UIImageView alloc] initWithImage:rImage];
    [titleView addSubview:rImageView];
    [[[rImageView setSizeFromSize:rImage.size] centerYWith:titleView] insideRightEdgeBy:20];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:titleView.frame];
    [titleView addSubview:titleLabel];
    [[titleLabel insideTopEdgeBy:0] outsideRightEdgeOf:aImageView by:8];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.text = @"山东大学附属生殖医院";
    titleLabel.textColor = COLOR_TEXT_WHITE;
    
    // main
    UIView *mainView = [[UIView alloc] initWithFrame:CGRectMake(0, menuBar.height, self.view.width, self.view.height-menuBar.height)];
    [self.view addSubview:mainView];
    
    UIImageView *bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sd_home_bg"]];
    [mainView addSubview:bgImageView];
    [[[bgImageView setSizeFromView:mainView] insideLeftEdgeBy:0] outsideBottomEdgeOf:menuBar by:0];
    bgImageView.backgroundColor = [UIColor blackColor];
    
    UIView *cellsView = [[UIView alloc] initWithFrame:mainView.bounds];
    [mainView addSubview:cellsView];
    
    UIImageView *centerImagev = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sd_index_30"]];
    [cellsView addSubview:centerImagev];
    
    [[[centerImagev setW:[self xBaseOnWidth:centerImagev.image.size.width] andH:[self yBaseOnHeight:centerImagev.image.size.height]] insideLeftEdgeBy:[self xBaseOnWidth:17]] insideTopEdgeBy:[self yBaseOnHeight:102]];
    
    UIImageView *imageView1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sd_index_19"]];
    [cellsView addSubview:imageView1];
    [[[imageView1 setSizeFromSize:imageView1.image.size] insideLeftEdgeBy:[self xBaseOnWidth:89]] insideTopEdgeBy:[self yBaseOnHeight:18]];
    
    UIImageView *imageView2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sd_index_22"]];
    [cellsView addSubview:imageView2];
    [[[imageView2 setSizeFromSize:imageView2.image.size] insideLeftEdgeBy:[self xBaseOnWidth:144]] insideTopEdgeBy:[self yBaseOnHeight:45]];
    
    UIImageView *imageView3 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sd_index_26"]];
    [cellsView addSubview:imageView3];
    [[[imageView3 setSizeFromSize:imageView3.image.size] insideLeftEdgeBy:[self xBaseOnWidth:185]] insideTopEdgeBy:[self yBaseOnHeight:88]];
    
    UIImage *image4 = [UIImage imageNamed:@"sd_index_34"];
    UIButton *imageView4 = [[UIButton alloc] init];
    [cellsView addSubview:imageView4];
    [[[imageView4 setSizeFromSize:image4.size] insideLeftEdgeBy:[self xBaseOnWidth:204]] insideTopEdgeBy:[self yBaseOnHeight:142]];
    imageView4.tag = 4;
    [imageView4 setBackgroundImage:image4 forState:UIControlStateNormal];
    [imageView4 addTarget:self action:@selector(goModule:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *imageView5 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sd_index_38"]];
    [cellsView addSubview:imageView5];
    [[[imageView5 setSizeFromSize:imageView5.image.size] insideLeftEdgeBy:[self xBaseOnWidth:209]] insideTopEdgeBy:[self yBaseOnHeight:200]];
    
    UIImageView *imageView6 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sd_index_42"]];
    [cellsView addSubview:imageView6];
    [[[imageView6 setSizeFromSize:imageView6.image.size] insideLeftEdgeBy:[self xBaseOnWidth:187]] insideTopEdgeBy:[self yBaseOnHeight:258]];
    
    UIImageView *imageView7 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sd_index_46"]];
    [cellsView addSubview:imageView7];
    [[[imageView7 setSizeFromSize:imageView7.image.size] insideLeftEdgeBy:[self xBaseOnWidth:143]] insideTopEdgeBy:[self yBaseOnHeight:301]];
    
    UIImageView *imageView8 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sd_index_50"]];
    [cellsView addSubview:imageView8];
    [[[imageView8 setSizeFromSize:imageView8.image.size] insideLeftEdgeBy:[self xBaseOnWidth:90]] insideTopEdgeBy:[self yBaseOnHeight:323]];
    
    
    CGFloat labWidth = 100;
    CGFloat labHeight = imageView1.height;
    
    UILabel *cellLabel1 = [[UILabel alloc] init];
    [cellsView addSubview:cellLabel1];
    [[[[cellLabel1 setW:labWidth andH:labHeight] outsideRightEdgeOf:imageView1 by:5] insideTopEdgeBy:imageView1.y] adjustY:-5];
    [self setCellLabelStyle:&cellLabel1];
    cellLabel1.text = @"我要预约";
    
    UILabel *cellLabel2 = [[UILabel alloc] init];
    [cellsView addSubview:cellLabel2];
    [[[cellLabel2 setW:labWidth andH:labHeight] outsideRightEdgeOf:imageView2 by:5] insideTopEdgeBy:imageView2.y];
    [self setCellLabelStyle:&cellLabel2];
    cellLabel2.text = @"排队服务";
    
    UILabel *cellLabel3 = [[UILabel alloc] init];
    [cellsView addSubview:cellLabel3];
    [[[cellLabel3 setW:labWidth andH:labHeight] outsideRightEdgeOf:imageView3 by:5] insideTopEdgeBy:imageView3.y];
    [self setCellLabelStyle:&cellLabel3];
    cellLabel3.text = @"我问医生";
    
    UILabel *cellLabel4 = [[UILabel alloc] init];
    [cellsView addSubview:cellLabel4];
    [[[cellLabel4 setW:labWidth andH:labHeight] outsideRightEdgeOf:imageView4 by:5] insideTopEdgeBy:imageView4.y];
    [self setCellLabelStyle:&cellLabel4];
    cellLabel4.text = @"我的经历";
    
    UILabel *cellLabel5 = [[UILabel alloc] init];
    [cellsView addSubview:cellLabel5];
    [[[cellLabel5 setW:labWidth andH:labHeight] outsideRightEdgeOf:imageView5 by:5] insideTopEdgeBy:imageView5.y];
    [self setCellLabelStyle:&cellLabel5];
    cellLabel5.text = @"医院咨询";
    
    UILabel *cellLabel6 = [[UILabel alloc] init];
    [cellsView addSubview:cellLabel6];
    [[[cellLabel6 setW:labWidth andH:labHeight] outsideRightEdgeOf:imageView6 by:5] insideTopEdgeBy:imageView6.y];
    [self setCellLabelStyle:&cellLabel6];
    cellLabel6.text = @"我和宝宝";
    
    UILabel *cellLabel7 = [[UILabel alloc] init];
    [cellsView addSubview:cellLabel7];
    [[[cellLabel7 setW:labWidth andH:labHeight] outsideRightEdgeOf:imageView7 by:5] insideTopEdgeBy:imageView7.y];
    [self setCellLabelStyle:&cellLabel7];
    cellLabel7.text = @"我的查询";
    
    UILabel *cellLabel8 = [[UILabel alloc] init];
    [cellsView addSubview:cellLabel8];
    [[[[cellLabel8 setW:labWidth andH:labHeight] outsideRightEdgeOf:imageView8 by:0] insideTopEdgeBy:imageView8.y] adjustY:20];
    [self setCellLabelStyle:&cellLabel8];
    cellLabel8.text = @"实时提醒";
    
    
    UILabel *nameLabel = [[UILabel alloc] init];
    [self.view addSubview:nameLabel];
    [[[nameLabel setW:self.view.width andH:140] insideLeftEdgeBy:0] insideBottomEdgeBy:0];
    nameLabel.text = @"山大生殖掌上医疗服务平台";
    nameLabel.font = FONT_20B;
    nameLabel.textColor = COLOR_TEXT_WHITE;
    nameLabel.textAlignment = NSTextAlignmentCenter;
}

- (CGFloat)xBaseOnWidth:(CGFloat)x {
    return self.view.width / 320 * x;
}

- (CGFloat)yBaseOnHeight:(CGFloat)y {
    return self.view.height / 568 * y;
}


- (void)setCellLabelStyle:(UILabel * __autoreleasing *)label {
    [*label setFont:FONT_14];
    [*label setTextColor:COLOR_TEXT_WHITE];
}

- (void)goModule:(UIButton *)button {
    if (button.tag == 4) {
        [self.navigationController pushViewController:[[RHMenstrualViewCtro alloc] init] animated:YES];
    }
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
