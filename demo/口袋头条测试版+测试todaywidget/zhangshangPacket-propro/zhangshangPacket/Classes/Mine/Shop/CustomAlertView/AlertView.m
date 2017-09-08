//
//  AlertView.m
//  testAlertView
//
//  Created by liuyx on 15/1/21.
//  Copyright (c) 2015年 liuyx. All rights reserved.
//

#import "AlertView.h"
#import <QuartzCore/QuartzCore.h>
#import "NSString+Ext.h"
//当前固件版本
#define ZKB_CURRENT_SYSTEM_VERSION [[UIDevice currentDevice].systemVersion floatValue]
#define IOS6    ( ZKB_CURRENT_SYSTEM_VERSION >= 6.0)
#define IOS7    ( ZKB_CURRENT_SYSTEM_VERSION >= 7.0)
#define IOS71   ( ZKB_CURRENT_SYSTEM_VERSION >= 7.1)
#define IOS8    ( ZKB_CURRENT_SYSTEM_VERSION >= 8.0)
#define IOS9    ( ZKB_CURRENT_SYSTEM_VERSION >= 9.0)
@class CustomAlertBackgroundWindow;

const UIWindowLevel UIWindowLevelCustomAlert = 1999.0;
const UIWindowLevel UIWindowLevelCustomAlertBackground = 1998.0;

static NSMutableArray *_custom_alert_queue;
static CustomAlertBackgroundWindow *_custom_alert_background_window;
static AlertView *_custom_alert_current_view;





@interface AlertView ()

@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic, strong) UIWindow *alertWindow;
@property (nonatomic, assign, getter = isVisible) BOOL visible;
//@property (nonatomic,assign) CustomAlertViewTransitionStyle transitionStyle;

@property (nonatomic, strong) UILabel *titleLabel;
//@property (nonatomic, strong) UILabel *lineLabel;
@property (nonatomic, strong) UILabel *messageLabel;
@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) NSMutableArray *buttons;
@property (nonatomic, strong) UILabel *lineContentLabel;
@property (nonatomic, strong) UILabel *lineButtonLabel;

@property (nonatomic, assign, getter = isLayoutDirty) BOOL layoutDirty;

+ (NSMutableArray *)sharedQueue;
+ (AlertView *)currentAlertView;

//+ (BOOL)isAnimating;
//+ (void)setAnimating:(BOOL)animating;

+ (void)showBackground;
+ (void)hideBackgroundAnimated:(BOOL)animated;

- (void)setup;
- (void)invaliadateLayout;
- (void)resetTransition;

@end

@interface CustomAlertBackgroundWindow:UIWindow

@property (nonatomic) CustomAlertViewBackgroundStyle style;

@end

@interface CustomAlertBackgroundWindow ()

@end

@implementation CustomAlertBackgroundWindow

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        self.opaque = NO;
        self.windowLevel = UIWindowLevelCustomAlertBackground;
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    switch (self.style) {
        case CustomAlertViewBackgroundStyleGradient:
        {
            size_t locationsCount = 2;
            CGFloat locations[2] = {0.0f, 1.0f};
            CGFloat colors[8] = {0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0.75f};
            CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
            CGGradientRef gradient = CGGradientCreateWithColorComponents(colorSpace, colors, locations, locationsCount);
            CGColorSpaceRelease(colorSpace);
            
            CGPoint center = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);
            CGFloat radius = MIN(self.bounds.size.width, self.bounds.size.height) ;
            CGContextDrawRadialGradient (context, gradient, center, 0, center, radius, kCGGradientDrawsAfterEndLocation);
            CGGradientRelease(gradient);
            break;
        }
        case CustomAlertViewBackgroundStyleSolid:
        {
            [UIView animateWithDuration:0.5 animations:^{
                [[UIColor colorWithWhite:0 alpha:0.5] set];
                CGContextFillRect(context, self.bounds);
            }];
            break;
        }
    }
}


@end

#pragma mark - CustomAlertItem

@interface CustomAlertItem : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) CustomAlertViewButtonType type;
@property (nonatomic, copy) AlertViewHandler action;

@end

@implementation CustomAlertItem

@end


@interface CustomAlertViewController : UIViewController

@property (nonatomic,strong) AlertView *alertView;

@end

@implementation CustomAlertViewController

- (void)loadView
{
    self.view = self.alertView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.alertView setup];
}
@end


@implementation AlertView

- (id)init
{
    return [self initWithTitle:nil andMessage:nil];
}

- (id)initWithTitle:(NSString *)title andMessage:(NSString *)message
{
    self = [super init];
    if (self) {
        _title = title;
        if(title.length == 0){
            _title = nil;
        }
        _message = message;
        if(message.length == 0){
            _message = nil;
        }
        self.transitionStyle = CustomAlertViewTransitionStyleBounce;
        self.items = [[NSMutableArray alloc] init];
    }
    return self;
}

- (id)initWithCustomView:(UIView *)view
{
    self = [super init];
    if (self) {
        _customView = view;
        self.transitionStyle = CustomAlertViewTransitionStyleBounce;
        self.items = [[NSMutableArray alloc] init];
    }
    return self;
}

- (id)initWithCustomView:(UIView *)view style:(CustomAlertViewTransitionStyle)style
{
    self = [self initWithCustomView:view];
    if (self) {
        self.transitionStyle = style;
    }
    return self;
}

+ (NSMutableArray *)sharedQueue
{
    if (!_custom_alert_queue) {
        _custom_alert_queue = [NSMutableArray array];
    }
    return _custom_alert_queue;
}

+ (AlertView *)currentAlertView
{
    return _custom_alert_current_view;
}

+ (void)setCurrentAlertView:(AlertView *)alertView
{
    _custom_alert_current_view = alertView;
}


+ (void)showBackground
{
    if (!_custom_alert_background_window) {
        _custom_alert_background_window = [[CustomAlertBackgroundWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        [_custom_alert_background_window makeKeyAndVisible];
        _custom_alert_background_window.alpha = 0;
        [UIView animateWithDuration:0.3
                         animations:^{
                             _custom_alert_background_window.alpha = 1;
                         }];
    }
}

+ (void)hideBackgroundAnimated:(BOOL)animated
{
    if (!animated) {
        [_custom_alert_background_window removeFromSuperview];
        _custom_alert_background_window = nil;
        return;
    }
    [UIView animateWithDuration:0.3
                     animations:^{
                         _custom_alert_background_window.alpha = 0;
                     }
                     completion:^(BOOL finished) {
                         [_custom_alert_background_window removeFromSuperview];
                         _custom_alert_background_window = nil;
                     }];
}

#pragma mark - Setters

- (void)setTitle:(NSString *)title
{
    _title = title;
    [self invaliadateLayout];
}

- (void)setMessage:(NSString *)message
{
    _message = message;
    [self invaliadateLayout];
}

- (void)addButtonWithTitle:(NSString *)title type:(CustomAlertViewButtonType)type handler:(AlertViewHandler)handler
{
    CustomAlertItem *item = [[CustomAlertItem alloc] init];
    item.title = title;
    item.type = type;
    item.action = handler;
    [self.items addObject:item];
}

- (void)show
{
    if (![[AlertView sharedQueue] containsObject:self]) {
        [[AlertView sharedQueue] addObject:self];
    }
    
    if (self.isVisible) {
        return;
    }
    
    if ([AlertView currentAlertView].isVisible) {
        AlertView *alert = [AlertView currentAlertView];
        [alert dismissAnimated:YES cleanup:NO];
    }
    
    self.visible = YES;
    
    [AlertView setCurrentAlertView:self];
    
    // transition background
    [AlertView showBackground];
    
    CustomAlertViewController *viewController = [[CustomAlertViewController alloc] initWithNibName:nil bundle:nil];
    viewController.alertView = self;
    
    if (!self.alertWindow) {
        UIWindow *window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        window.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        window.opaque = NO;
        window.windowLevel = UIWindowLevelCustomAlert;
        window.rootViewController = viewController;
        self.alertWindow = window;
    }
    [self.alertWindow makeKeyAndVisible];
    
    [self validateLayout];
    
    [self transitionInCompletion:^{
        NSInteger index = [[AlertView sharedQueue] indexOfObject:self];
        if (index < [AlertView sharedQueue].count - 1) {
            [self dismissAnimated:YES cleanup:NO]; // dismiss to show next alert view
        }
    }];
}

- (void)dismissAnimated:(BOOL)animated
{
    [self dismissAnimated:animated cleanup:YES];
}

- (void)dismissAnimated:(BOOL)animated cleanup:(BOOL)cleanup
{
    BOOL isVisible = self.isVisible;
    
    void (^dismissComplete)(void) = ^{
        self.visible = NO;
        
        [self teardown];
        
        [AlertView setCurrentAlertView:nil];
        
        AlertView *nextAlertView;
        NSInteger index = [[AlertView sharedQueue] indexOfObject:self];
        if (index != NSNotFound && index < [AlertView sharedQueue].count - 1) {
            nextAlertView = [AlertView sharedQueue][index + 1];
        }
        
        if (cleanup) {
            [[AlertView sharedQueue] removeObject:self];
        }
        
        // check if we should show next alert
        if (!isVisible) {
            return;
        }
        
        if (nextAlertView) {
            [nextAlertView show];
        } else {
            // show last alert view
            if ([AlertView sharedQueue].count > 0) {
                AlertView *alert = [[AlertView sharedQueue] lastObject];
                [alert show];
            }
        }
    };
    
    if (animated && isVisible) {
        [self transitionOutCompletion:dismissComplete];
        
        if ([AlertView sharedQueue].count == 1) {
            [AlertView hideBackgroundAnimated:YES];
        }
        
    } else {
        dismissComplete();
//
        if ([AlertView sharedQueue].count == 0) {
            [AlertView hideBackgroundAnimated:NO];
        }
    }
}

#pragma mark - Transitions

- (void)transitionInCompletion:(void(^)(void))completion
{
    switch (self.transitionStyle) {
        case CustomAlertViewTransitionStyleSlideFromBottom:
        {
            CGRect rect = self.containerView.frame;
            CGRect originalRect = rect;
            rect.origin.y = self.bounds.size.height;
            self.containerView.frame = rect;
            [UIView animateWithDuration:0.3
                             animations:^{
                                 self.containerView.frame = originalRect;
                             }
                             completion:^(BOOL finished) {
                                 if (completion) {
                                     completion();
                                 }
                             }];
        }
            break;
        case CustomAlertViewTransitionStyleSlideFromTop:
        {
            CGRect rect = self.containerView.frame;
            CGRect originalRect = rect;
            rect.origin.y = -rect.size.height;
            self.containerView.frame = rect;
            [UIView animateWithDuration:0.3
                             animations:^{
                                 self.containerView.frame = originalRect;
                             }
                             completion:^(BOOL finished) {
                                 if (completion) {
                                     completion();
                                 }
                             }];
            break;
        }
            
        case CustomAlertViewTransitionStyleBounce:
        {
            CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
            animation.values = @[@(0.01), @(1.2), @(0.9), @(1)];
            animation.keyTimes = @[@(0), @(0.4), @(0.6), @(1)];
            animation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear], [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear], [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
            animation.duration = 0.5;
            animation.delegate = self;
            [animation setValue:completion forKey:@"handler"];
            [self.containerView.layer addAnimation:animation forKey:@"bouce"];
            break;
        }
        default:
            break;
    }
}

- (void)transitionOutCompletion:(void(^)(void))completion
{
    
    switch (self.transitionStyle) {
        case CustomAlertViewTransitionStyleSlideFromBottom:
        {
            CGRect rect = self.containerView.frame;
            rect.origin.y = self.bounds.size.height;
            [UIView animateWithDuration:0.3
                                  delay:0
                                options:UIViewAnimationOptionCurveEaseIn
                             animations:^{
                                 self.containerView.frame = rect;
                             }
                             completion:^(BOOL finished) {
                                 if (completion) {
                                     completion();
                                 }
                             }];
        }
            break;
        case CustomAlertViewTransitionStyleSlideFromTop:
        {
            CGRect rect = self.containerView.frame;
            rect.origin.y = -rect.size.height;
            [UIView animateWithDuration:0.3
                                  delay:0
                                options:UIViewAnimationOptionCurveEaseIn
                             animations:^{
                                 self.containerView.frame = rect;
                             }
                             completion:^(BOOL finished) {
                                 if (completion) {
                                     completion();
                                 }
                             }];
        }
            break;
        case CustomAlertViewTransitionStyleBounce:
        {
            CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
            animation.values = @[@(1), @(1.2), @(0.01)];
            animation.keyTimes = @[@(0), @(0.4), @(1)];
            animation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut], [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
            animation.duration = 0.35;
            animation.delegate = self;
            [animation setValue:completion forKey:@"handler"];
            [self.containerView.layer addAnimation:animation forKey:@"bounce"];
            
            self.containerView.transform = CGAffineTransformMakeScale(0.01, 0.01);
        }
            break;
        default:
            break;
    }
}

- (void)resetTransition
{
    [self.containerView.layer removeAllAnimations];
}

#pragma mark - Layout

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self validateLayout];
}

- (void)invaliadateLayout
{
    self.layoutDirty = YES;
    [self setNeedsLayout];
}

- (void)validateLayout
{
    if (!self.isLayoutDirty) {
        return;
    }
    self.layoutDirty = NO;
#if DEBUG_LAYOUT
    NSLog(@"%@, %@", self, NSStringFromSelector(_cmd));
#endif
    
    CGFloat height = [self preferredHeight];
    CGFloat left = 25;
    CGFloat top = (self.bounds.size.height - height) * 0.5;
    self.containerView.transform = CGAffineTransformIdentity;
    self.containerView.frame = CGRectMake(left, top,IPHONE_W-50, height);
    [self.containerView.layer setCornerRadius:6.0];
    self.containerView.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:self.containerView.bounds cornerRadius:self.containerView.layer.cornerRadius].CGPath;
    
    CGFloat y = ALERT_VIEW_CONTENT_PADDING_TOP;
    if (self.titleLabel) {
        self.titleLabel.text = self.title;
        CGFloat height = [self heightForTitleLabel];
        self.titleLabel.frame = CGRectMake(ALERT_VIEW_CONTENT_PADDING_LEFT, y, self.containerView.bounds.size.width - ALERT_VIEW_CONTENT_PADDING_LEFT * 2, height);
        y += height;
    }
    
    if (self.messageLabel) {
        if (y > ALERT_VIEW_CONTENT_PADDING_TOP) {
            y += ALERT_VIEW_GAP;
        }
        self.messageLabel.text = self.message;
        if(_messageNeedLineSpace){
            NSAttributedString *att = [self getAttrLineSpaceForContent:self.message];
            [self.messageLabel setAttributedText:att];
        }
        CGFloat height = [self heightForMessageLabel];
        self.messageLabel.frame = CGRectMake(ALERT_VIEW_CONTENT_PADDING_LEFT, y, self.containerView.bounds.size.width - ALERT_VIEW_CONTENT_PADDING_LEFT * 2, height);
        y += height;
        
    }
    if(self.customView){
        CGRect rect = self.customView.frame;
        if(rect.size.width > self.containerView.frame.size.width){
            rect.size.width = self.containerView.frame.size.width;
        }
        if(rect.size.height > ALERT_VIEW_CONTAINER_HEIGHT){
            rect.size.height = ALERT_VIEW_CONTAINER_HEIGHT;
        }
        [self.customView setFrame:rect];
        y += rect.size.height;
    }
    if (self.items.count > 0) {
        self.lineContentLabel.backgroundColor = [UIColor lightGrayColor];
        CGFloat lineHeight = 1.0;
        
        self.lineContentLabel.frame = CGRectMake(0, y + ALERT_VIEW_GAP, self.containerView.bounds.size.width, lineHeight);
        y += 1;
        if (y > ALERT_VIEW_CONTENT_PADDING_TOP) {
            y += ALERT_VIEW_GAP;
        }
        if (self.items.count == 2) {
            CGFloat width = (self.containerView.bounds.size.width - ALERT_VIEW_BUTTON_PADDING_LEFT * 2) * 0.5;
            UIButton *button = self.buttons[0];
            button.frame = CGRectMake(ALERT_VIEW_BUTTON_PADDING_LEFT, y, width, ALERT_VIEW_BUTTON_HEIGHT);
            button = self.buttons[1];
            button.frame = CGRectMake(ALERT_VIEW_BUTTON_PADDING_LEFT + width, y, width, ALERT_VIEW_BUTTON_HEIGHT);
            
            self.lineButtonLabel.backgroundColor = [UIColor lightGrayColor];
            CGFloat lineHeight = 1.0;
            self.lineButtonLabel.frame = CGRectMake(ALERT_VIEW_BUTTON_PADDING_LEFT + width, y, lineHeight, ALERT_VIEW_BUTTON_HEIGHT);
        } else {
            for (NSUInteger i = 0; i < self.buttons.count; i++) {
                UIButton *button = self.buttons[i];
                button.frame = CGRectMake(ALERT_VIEW_BUTTON_PADDING_LEFT, y, self.containerView.bounds.size.width - ALERT_VIEW_BUTTON_PADDING_LEFT * 2, ALERT_VIEW_BUTTON_HEIGHT);
                if (self.buttons.count > 1) {
                    if (i == self.buttons.count - 1 && ((CustomAlertItem *)self.items[i]).type == CustomAlertViewButtonTypeCancel) {
                        CGRect rect = button.frame;
                        rect.origin.y += ALERT_VIEW_CANCEL_BUTTON_PADDING_TOP;
                        button.frame = rect;
                    }
                    y += ALERT_VIEW_BUTTON_HEIGHT + ALERT_VIEW_GAP;
                }
            }
        }
    }
}

- (NSAttributedString *)getAttrLineSpaceForContent:(NSString *)content{
    if(!IOS6){
        return nil;
    }
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithString:content];
    NSMutableParagraphStyle *lineStyle = [[NSMutableParagraphStyle alloc] init];
    [lineStyle setLineSpacing:5.0];
    [attributeStr addAttribute:NSParagraphStyleAttributeName value:lineStyle range:NSMakeRange(0, content.length)];
    
    return attributeStr;
}


- (CGFloat)preferredHeight
{
    CGFloat height = ALERT_VIEW_CONTENT_PADDING_TOP;
    if (self.title) {
        height += [self heightForTitleLabel];
    }
    if (self.message) {
        if (height > ALERT_VIEW_CONTENT_PADDING_TOP) {
            height += ALERT_VIEW_GAP;
        }
        height += [self heightForMessageLabel];
    }
    
    if(_customView){
        CGRect rect = self.customView.frame;
        if(rect.size.height > ALERT_VIEW_CONTAINER_HEIGHT){
            rect.size.height = ALERT_VIEW_CONTAINER_HEIGHT;
        }
        height += rect.size.height;
    }
    
    if (self.items.count > 0) {
        height += 1;
        if (height > ALERT_VIEW_CONTENT_PADDING_TOP) {
            height += ALERT_VIEW_GAP;
        }
        if (self.items.count <= 2) {
            height += ALERT_VIEW_BUTTON_HEIGHT;
        } else {
            height += (ALERT_VIEW_BUTTON_HEIGHT + ALERT_VIEW_GAP) * self.items.count - ALERT_VIEW_GAP;
            if (self.buttons.count > 2 && ((CustomAlertItem *)[self.items lastObject]).type == CustomAlertViewButtonTypeCancel) {
                height += ALERT_VIEW_CANCEL_BUTTON_PADDING_TOP;
            }
        }
    }
    
    height += ALERT_VIEW_CONTENT_PADDING_BOTTOM;
    return height;
}

- (CGFloat)heightForTitleLabel
{
    if (self.titleLabel) {
        CGSize size = [self.title sizeWithFont:self.titleLabel.font maxW:ALERT_VIEW_CONTAINER_WIDTH - ALERT_VIEW_CONTENT_PADDING_LEFT * 2];
        
//        CGSize size = [self.title sizeWithFont:self.titleLabel.font
//                                   minFontSize:self.titleLabel.font.pointSize * self.titleLabel.minimumScaleFactor
//                                actualFontSize:nil
//                                      forWidth:ALERT_VIEW_CONTAINER_WIDTH - ALERT_VIEW_CONTENT_PADDING_LEFT * 2
//                                 lineBreakMode:self.titleLabel.lineBreakMode];
        return size.height;
    }
    return 0;
}

- (CGFloat)heightForMessageLabel
{
    CGFloat minHeight = ALERT_VIEW_MESSAGE_MIN_LINE_COUNT * self.messageLabel.font.lineHeight;
    if (self.messageLabel) {
        CGFloat maxHeight = ALERT_VIEW_MESSAGE_MAX_LINE_COUNT * self.messageLabel.font.lineHeight;
        CGSize size = [self.message sizeWithFont:self.messageLabel.font maxSize:CGSizeMake(ALERT_VIEW_CONTAINER_WIDTH - ALERT_VIEW_CONTENT_PADDING_LEFT * 2, maxHeight)];
        
//        CGSize size = [self.message sizeWithFont:self.messageLabel.font
//                               constrainedToSize:CGSizeMake(ALERT_VIEW_CONTAINER_WIDTH - ALERT_VIEW_CONTENT_PADDING_LEFT * 2, maxHeight)
//                                   lineBreakMode:self.messageLabel.lineBreakMode];
        if(_messageNeedLineSpace){
            size = [self getContentSizeForHasLineSpaceByContent:self.message font:self.messageLabel.font maxWidth:ALERT_VIEW_CONTAINER_WIDTH - ALERT_VIEW_CONTENT_PADDING_LEFT * 2];
        }
        return MAX(minHeight, size.height);
    }
    return minHeight;
}

- (CGSize)getContentSizeForHasLineSpaceByContent:(NSString *)content font:(UIFont *)font maxWidth:(CGFloat)maxWidth{
    CGSize sizeContent = [content sizeWithFont:font maxW:maxWidth];
    NSString *strSize = @"擦";
    CGSize size = [strSize sizeWithFont:font maxW:maxWidth];
    if(size.height > 0){
        sizeContent.height += sizeContent.height/size.height * 5;
    }
    return sizeContent;
}



#pragma mark - Setup

- (void)setup
{
    [self setupContainerView];
    [self updateTitleLabel];
    [self updateMessageLabel];
    [self setupButtons];
    [self invaliadateLayout];
}

- (void)teardown
{
    [self.containerView removeFromSuperview];
    self.containerView = nil;
    self.titleLabel = nil;
//    self.lineLabel = nil;
    self.messageLabel = nil;
    self.lineContentLabel = nil;
    self.lineButtonLabel = nil;
    [self.buttons removeAllObjects];
    [self.alertWindow removeFromSuperview];
    self.alertWindow = nil;
}

- (void)setupContainerView
{
    self.containerView = [[UIView alloc] initWithFrame:self.bounds];
    self.containerView.backgroundColor = MainBGColor;
    self.containerView.layer.cornerRadius = self.cornerRadius;
    self.containerView.layer.shadowOffset = CGSizeZero;
    self.containerView.layer.shadowRadius = self.shadowRadius;
    self.containerView.layer.shadowOpacity = 0.5;
    [self addSubview:self.containerView];
    
    if(_customView){
        [self.containerView addSubview:_customView];
    }
}

- (void)updateTitleLabel
{
    if (self.title) {
        if (!self.titleLabel) {
            self.titleLabel = [[UILabel alloc] initWithFrame:self.bounds];
            self.titleLabel.textAlignment = NSTextAlignmentCenter;
            self.titleLabel.backgroundColor = [UIColor clearColor];
            self.titleLabel.font = self.titleFont;
            self.titleLabel.textColor = self.titleColor;
            self.titleLabel.adjustsFontSizeToFitWidth = YES;
            self.titleLabel.minimumScaleFactor = 0.75;
            [self.containerView addSubview:self.titleLabel];
#if DEBUG_LAYOUT
            self.titleLabel.backgroundColor = [UIColor redColor];
#endif
        }
        self.titleLabel.text = self.title;
    } else {
        [self.titleLabel removeFromSuperview];
        self.titleLabel = nil;
    }
    if(!self.lineContentLabel){
        self.lineContentLabel = [[UILabel alloc] initWithFrame:self.bounds];
        self.lineContentLabel.backgroundColor = [UIColor clearColor];
        [self.containerView addSubview:self.lineContentLabel];
    }
    [self invaliadateLayout];
}

- (void)updateMessageLabel
{
    if (self.message) {
        if (!self.messageLabel) {
            self.messageLabel = [[UILabel alloc] initWithFrame:self.bounds];
            if(_messageIsAlignLeft){
                self.messageLabel.textAlignment = NSTextAlignmentLeft;
            }
            else{
                self.messageLabel.textAlignment = NSTextAlignmentCenter;
            }
            
            self.messageLabel.backgroundColor = [UIColor clearColor];
            self.messageLabel.font = self.messageFont;
            self.messageLabel.textColor = self.messageColor;
            self.messageLabel.numberOfLines = ALERT_VIEW_MESSAGE_MAX_LINE_COUNT;
            [self.containerView addSubview:self.messageLabel];
#if DEBUG_LAYOUT
            self.messageLabel.backgroundColor = [UIColor redColor];
#endif
        }
        self.messageLabel.text = self.message;
        
    } else {
        [self.messageLabel removeFromSuperview];
        self.messageLabel = nil;
    }
    [self invaliadateLayout];
}

- (void)setupButtons
{
    if(!self.lineContentLabel){
        self.lineContentLabel = [[UILabel alloc] initWithFrame:self.bounds];
        self.lineContentLabel.backgroundColor = [UIColor clearColor];
        [self.containerView addSubview:self.lineContentLabel];
    }
    self.buttons = [[NSMutableArray alloc] initWithCapacity:self.items.count];
    for (NSUInteger i = 0; i < self.items.count; i++) {
        UIButton *button = [self buttonForItemIndex:i];
        [self.buttons addObject:button];
        [self.containerView addSubview:button];
    }
    if(self.items.count == 2){
        if(!self.lineButtonLabel){
            self.lineButtonLabel = [[UILabel alloc] initWithFrame:self.bounds];
            self.lineButtonLabel.backgroundColor = [UIColor clearColor];
            [self.containerView addSubview:self.lineButtonLabel];
        }
    }
}

- (UIButton *)buttonForItemIndex:(NSUInteger)index
{
    CustomAlertItem *item = self.items[index];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.tag = index;
    button.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    button.titleLabel.font = self.buttonFont;
    [button setTitle:item.title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}

#pragma mark - Actions

- (void)buttonAction:(UIButton *)button
{
//    [AlertView setAnimating:YES]; // set this flag to YES in order to prevent showing another alert in action block
    CustomAlertItem *item = self.items[button.tag];
    if (item.action) {
        item.action(self);
    }
    [self dismissAnimated:YES];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    void(^completion)(void) = [anim valueForKey:@"handler"];
    if (completion) {
        completion();
    }
}

#pragma mark - UIAppearance setters

- (void)setViewBackgroundColor:(UIColor *)viewBackgroundColor
{
    if (_viewBackgroundColor == viewBackgroundColor) {
        return;
    }
    _viewBackgroundColor = viewBackgroundColor;
    self.containerView.backgroundColor = viewBackgroundColor;
}

- (void)setTitleFont:(UIFont *)titleFont
{
    if (_titleFont == titleFont) {
        return;
    }
    _titleFont = titleFont;
    self.titleLabel.font = titleFont;
    [self invaliadateLayout];
}

- (void)setMessageFont:(UIFont *)messageFont
{
    if (_messageFont == messageFont) {
        return;
    }
    _messageFont = messageFont;
    self.messageLabel.font = messageFont;
    [self invaliadateLayout];
}

- (void)setTitleColor:(UIColor *)titleColor
{
    if (_titleColor == titleColor) {
        return;
    }
    _titleColor = titleColor;
    self.titleLabel.textColor = titleColor;
}

- (void)setMessageColor:(UIColor *)messageColor
{
    if (_messageColor == messageColor) {
        return;
    }
    _messageColor = messageColor;
    self.messageLabel.textColor = messageColor;
}

- (void)setButtonFont:(UIFont *)buttonFont
{
    if (_buttonFont == buttonFont) {
        return;
    }
    _buttonFont = buttonFont;
    for (UIButton *button in self.buttons) {
        button.titleLabel.font = buttonFont;
    }
}

- (void)setCornerRadius:(CGFloat)cornerRadius
{
    if (_cornerRadius == cornerRadius) {
        return;
    }
    _cornerRadius = cornerRadius;
    self.containerView.layer.cornerRadius = cornerRadius;
}

- (void)setShadowRadius:(CGFloat)shadowRadius
{
    if (_shadowRadius == shadowRadius) {
        return;
    }
    _shadowRadius = shadowRadius;
    self.containerView.layer.shadowRadius = shadowRadius;
}


@end
