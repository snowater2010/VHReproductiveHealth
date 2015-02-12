//
//  RHSettingBushufuViewCtro.m
//  VHReproductiveHealth
//
//  Created by lipeng on 15/2/8.
//  Copyright (c) 2015年 vichiger. All rights reserved.
//

#import "RHSettingBushufuViewCtro.h"
#import "DWTagList.h"

@interface RHSettingBushufuViewCtro () <DWTagListDelegate> {
    
}
@property (strong, nonatomic) DWTagList *tagList;
@property (strong, nonatomic) NSArray *array;

@property (strong, nonatomic) NSMutableArray *selectedArray;

@end

@implementation RHSettingBushufuViewCtro

- (instancetype)init {
    if (self = [super init]) {
        [self initSet];
    }
    return self;
}

- (void)initSet {
    self.settingHeight = 300;
    
    self.array = [RHSettingBushufuViewCtro bushufuArray];
    self.selectedArray = [NSMutableArray array];
}

+ (NSArray *)bushufuArray {
    return @[@"头痛" ,@"呕吐", @"腹泻", @"小腹追涨", @"乳房胀痛", @"白带异常", @"感冒", @"其他"];
}

+ (NSString *)getSignNameWithText:(NSString *)value {
    NSArray *array = [RHSettingBushufuViewCtro bushufuArray];
    
    if ([value containsString:@"true"]) {
        NSMutableString *bushufu = [NSMutableString string];
        NSArray *bushufuArray = [value componentsSeparatedByString:@","];
        for (int i = 0; i < bushufuArray.count; i++) {
            NSString *str = bushufuArray[i];
            if ([str isEqualToString:@"true"]) {
                [bushufu appendFormat:@"%@、", array[i]];
            }
        }
        if (bushufu.length > 0) {
            [bushufu deleteCharactersInRange:(NSRange){bushufu.length-1, 1}];
        }
        return bushufu;
    }
    else {
        return @"未标注";
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.settingTitle = @"不舒服症状";
    
    _tagList = [[DWTagList alloc] init];
    [self.contentView addSubview:_tagList];
    
    [[_tagList setW:self.contentView.width-44 andH:self.contentView.height-44] centerWith:self.contentView];
    
    [_tagList setAutomaticResize:NO];
    [_tagList setTags:_array];
    [_tagList setTagDelegate:self];
    
    // Customisation
    [_tagList setFont:FONT_20];
    [_tagList setLabelMargin:20];
    [_tagList setBottomMargin:20];
    [_tagList setTagBackgroundColor:[UIColor clearColor]];
    [_tagList setTextColor:COLOR_TEXT_BLACK];
    
    [_tagList setCornerRadius:4.0f];
    [_tagList setBorderColor:[UIColor lightGrayColor]];
    [_tagList setBorderWidth:1.0f];
}

- (void)viewWillAppear:(BOOL)animated {
    NSArray *bushufuArray = [_bushufu componentsSeparatedByString:@","];
    int tagIndex = 0;
    for (NSString *flag in bushufuArray) {
        UIView *view = (UIView *)[_tagList viewWithTag:tagIndex+1];
        if ([view isKindOfClass:[DWTagView class]]) {
            DWTagView *tagView = (DWTagView *)view;
            if ([flag isEqualToString:@"true"]) {
                [tagView setTextColor:[UIColor whiteColor]];
                [tagView setBackgroundColor:COLOR_BG_DGREEN];
                [_selectedArray addObject:_array[tagIndex]];
            }
            else {
                [tagView setTextColor:[UIColor blackColor]];
                [tagView setBackgroundColor:[UIColor clearColor]];
                [tagView setNeedsDisplay];
                [_selectedArray removeObject:_array[tagIndex]];
            }
        }
        tagIndex++;
    }
}

- (void)selectedTag:(NSString *)tagName tagIndex:(NSInteger)tagIndex {
    UIView *view = [_tagList viewWithTag:tagIndex];
    if ([view isKindOfClass:[DWTagView class]]) {
        DWTagView *tagView = (DWTagView *)view;
        if ([_selectedArray containsObject:tagName]) {
            [tagView setTextColor:[UIColor blackColor]];
            [tagView setBackgroundColor:[UIColor clearColor]];
            [_selectedArray removeObject:tagName];
        }
        else {
            [tagView setTextColor:[UIColor whiteColor]];
            [tagView setBackgroundColor:COLOR_BG_DGREEN];
            [_selectedArray addObject:tagName];
        }
    }
}

- (void)doConfirm {
    if (_settingBlock) {
        NSMutableString *bushufu = [NSMutableString string];
        
        for (NSString *str in _array) {
            if ([_selectedArray containsObject:str]) {
                [bushufu appendString:@"true,"];
            }
            else {
                [bushufu appendString:@"false,"];
            }
        }
        if (bushufu.length > 0) {
            [bushufu deleteCharactersInRange:(NSRange){bushufu.length-1, 1}];
        }
        _settingBlock(bushufu);
    }
    [super doConfirm];
}

@end
