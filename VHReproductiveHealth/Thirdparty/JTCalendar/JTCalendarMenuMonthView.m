//
//  JTCalendarMenuMonthView.m
//  JTCalendar
//
//  Created by Jonathan Tribouharet
//

#import "JTCalendarMenuMonthView.h"

@interface JTCalendarMenuMonthView(){
    UILabel *textLabel;
    
    UIButton *goLeftButton;
    UIButton *goRightButton;
    
    UIImage *leftButtonImage;
    UIImage *rightButtonImage;
}

@end

@implementation JTCalendarMenuMonthView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(!self){
        return nil;
    }
    
    [self commonInit];
    
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(!self){
        return nil;
    }
    
    [self commonInit];
    
    return self;
}

- (void)commonInit
{
    {
        textLabel = [UILabel new];
        [self addSubview:textLabel];
        
        textLabel.textAlignment = NSTextAlignmentCenter;
        textLabel.numberOfLines = 0;
    }
    
#pragma mark lipeng_s
    {
        goLeftButton = [UIButton new];
        goRightButton = [UIButton new];
        [self addSubview:goLeftButton];
        [self addSubview:goRightButton];
        
        leftButtonImage = [UIImage imageNamed:@"calendar_goleft"];
        rightButtonImage = [UIImage imageNamed:@"calendar_goright"];
        
        [goLeftButton setBackgroundImage:leftButtonImage forState:UIControlStateNormal];
        [goRightButton setBackgroundImage:rightButtonImage forState:UIControlStateNormal];
        
        [goLeftButton addTarget:self action:@selector(goPreviousMonth) forControlEvents:UIControlEventTouchUpInside];
        [goRightButton addTarget:self action:@selector(goNextMonth) forControlEvents:UIControlEventTouchUpInside];
    }
#pragma mark lipeng_e
}

#pragma mark lipeng_s
- (void)goPreviousMonth
{
    [self.calendarManager loadPreviousMonth];
    [self.calendarManager reloadData];
}

- (void)goNextMonth
{
    [self.calendarManager loadNextMonth];
    [self.calendarManager reloadData];
}
#pragma mark lipeng_e

- (void)setCurrentDate:(NSDate *)currentDate
{
    textLabel.text = self.calendarManager.calendarAppearance.monthBlock(currentDate, self.calendarManager);
}

- (void)layoutSubviews
{
    textLabel.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    
#pragma mark lipeng_s
    CGSize textSize = [textLabel.text sizeWithAttributes:@{NSFontAttributeName : textLabel.font}];
    
    goLeftButton.frame = CGRectMake((self.frame.size.width-textSize.width)*0.5-leftButtonImage.size.width*2, (self.frame.size.height-leftButtonImage.size.height)*0.5, leftButtonImage.size.width, leftButtonImage.size.height);
    
    goRightButton.frame = CGRectMake((self.frame.size.width+textSize.width)*0.5+rightButtonImage.size.width, (self.frame.size.height-rightButtonImage.size.height)*0.5, rightButtonImage.size.width, rightButtonImage.size.height);
#pragma mark lipeng_e
    
    // No need to call [super layoutSubviews]
}

- (void)reloadAppearance
{
    textLabel.textColor = self.calendarManager.calendarAppearance.menuMonthTextColor;
    textLabel.font = self.calendarManager.calendarAppearance.menuMonthTextFont;
}

@end
