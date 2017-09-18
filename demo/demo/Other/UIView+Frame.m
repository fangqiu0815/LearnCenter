
#import "UIView+Frame.h"

@implementation UIView (Frame)

-(void)setYj_point:(CGPoint)yj_point{
    CGRect newframe = self.frame;
    newframe.origin = yj_point;
    self.frame = newframe;
}

-(CGPoint)yj_point{
    return self.frame.origin;
}

-(void)setYj_size:(CGSize)yj_size{
    CGRect newframe = self.frame;
    newframe.size = yj_size;
    self.frame = newframe;
}

-(CGSize)yj_size{
    return self.frame.size;
}

- (void)setYj_x:(CGFloat)yj_x{
    CGRect frame = self.frame;
    frame.origin.x = yj_x;
    // 设置UIView的x值
    self.frame = frame;
}

- (CGFloat)yj_x{
    // 返回UIView的x值
    return self.frame.origin.x;
}

- (void)setYj_y:(CGFloat)yj_y{
    CGRect frame = self.frame;
    frame.origin.y = yj_y;
    self.frame = frame;
}

- (CGFloat)yj_y{
    return self.frame.origin.y;
}

- (void)setYj_width:(CGFloat)yj_width{
    CGRect frame = self.frame;
    frame.size.width = yj_width;
    self.frame = frame;
}

- (CGFloat)yj_width{
    return self.frame.size.width;
}

- (void)setYj_height:(CGFloat)yj_height{
    CGRect frame = self.frame;
    frame.size.height = yj_height;
    self.frame = frame;
}

- (CGFloat)yj_height{
    return self.frame.size.height;
}

- (void)setYj_centerX:(CGFloat)yj_centerX{
    CGPoint center = self.center;
    center.x = yj_centerX;
    self.center = center;
}

- (CGFloat)yj_centerX{
    return self.center.x;
}

- (void)setYj_centerY:(CGFloat)yj_centerY
{
    CGPoint center = self.center;
    center.y = yj_centerY;
    self.center = center;
}

- (CGFloat)yj_centerY
{
    return self.center.y;
}



@end

