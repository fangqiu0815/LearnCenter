//
//  SBMap.m
//  SmartBus
//
//  Created by 飞瞳凡想 on 14-5-6.
//  Copyright (c) 2014年 飞瞳凡想. All rights reserved.
//

#import "SBAMapView.h"
#pragma -mark SBAPoint
/** 辅助封装CGPoint */
@interface SBAPoint : NSObject

@property (nonatomic,assign) CGFloat x;
@property (nonatomic,assign) CGFloat y;

-(SBAPoint *)initWithPoint:(CGPoint) point;

@end

@implementation SBAPoint

@synthesize x;
@synthesize y;

-(SBAPoint *)initWithPoint:(CGPoint) point{
    self = [super init];
    if (self) {
        self.x = point.x;
        self.y = point.y;
    }
    return self;
}

@end

#pragma -mark SBALineBaseView
/** 提供线路图绘图数据 */
@protocol SBALineViewDataSource;
/** 线路图绘图基类 */
@interface SBALineBaseView : UIView
/** delegate对象，执行数据反馈操作 */
@property (nonatomic,assign) id<SBALineViewDataSource> dataSource;
/** 线宽 */
@property (nonatomic,assign) CGFloat lineWidth;
/** 新路号及对应颜色 */
@property (nonatomic,strong) NSDictionary *lineColor;
/** 是否隐藏空白坐标，默认为NO */
@property (nonatomic,assign) BOOL shouldHiddenPosition;
/** 当前选中站台 */
@property (nonatomic,strong) SBAStop *currentStop;
/** 自定义线路 */
@property (nonatomic,strong) SBALine *diyLine;
/** 默认颜色*/
@property (nonatomic,strong) UIColor *dColor;

/** 用line数据绘线路图 */
-(void) createLine:(CGContextRef)ctx withLine:(SBALine *)line useColor:(UIColor *)color;
/** 绘圆 */
-(void) drawCricle:(CGContextRef)ctx atPoint:(SBAPoint *)point withColor:(UIColor *)color;
/** 绘两点间直线 */
-(void) drawLine:(CGContextRef)ctx begin:(SBAPoint *)last end:(SBAPoint *)current withColor:(UIColor *)color;
/** 绘两圆间直线 */
-(void) drawLineBetweenCircles:(CGContextRef)ctx begin:(SBAPoint *)last end:(SBAPoint *)current withColor:(UIColor *)color;
/** 绘点到圆直线 */
-(void) drawPointToCircle:(CGContextRef)ctx point:(SBAPoint *)point circle:(SBAPoint *)circle withColor:(UIColor *)color;
/** 绘圆到点直线 */
-(void) drawCircleToPoint:(CGContextRef)ctx circle:(SBAPoint *)circle point:(SBAPoint *)point withColor:(UIColor *)color;

@end
@protocol SBALineViewDataSource <NSObject>

@required
/**
 * 获取positionId对应的屏幕坐标
 * @param SBLineViewDataSource
 * @param positionId
 * @return SBAPoint
 */
-(SBAPoint *) getPoint:(SBALineBaseView *)lineView byPositionId:(NSString *)positionId;
@optional
/**
 * 提供线路数据
 * @param SBLineView
 * @return NSDictionary
 */
-(NSArray *) lineData:(SBALineBaseView *)lineView;

@end

@implementation SBALineBaseView

@synthesize dataSource;
@synthesize lineWidth;
@synthesize lineColor;
@synthesize shouldHiddenPosition;
@synthesize currentStop;
@synthesize diyLine;
@synthesize dColor;

-(void) createLine:(CGContextRef)ctx withLine:(SBALine *)line useColor:(UIColor *)color{
    NSArray *stops = line.stops;
    NSArray *positions = line.positions;
    for (int i=0;i<[positions count];i++){
        UIColor *_lineColor = [[UIColor alloc]init];
        if (color == nil) {
            _lineColor = [self _lineColor:line.lineId];
        }else{
            _lineColor = color;
        }
        if (!shouldHiddenPosition) {
            if (i == 0) {
                if ([self _isStop:[positions objectAtIndex:i] inLine:stops]) {
                    [self drawCricle:ctx atPoint:[self _getPointByPositionId:[positions objectAtIndex:i]] withColor:_lineColor];
                }/* !currentIsStop */else{
                    //do nothing
                }
            }/* i!=0 */else{
                if ([self _isStop:[positions objectAtIndex:i] inLine:stops]) {
                    [self drawCricle:ctx atPoint:[self _getPointByPositionId:[positions objectAtIndex:i]] withColor:_lineColor];
                }/* !currentIsStop */else{
                    //do nothing
                }
                [self drawLineBetweenCircles:ctx begin:[self _getPointByPositionId:[positions objectAtIndex:i-1]] end:[self _getPointByPositionId:[positions objectAtIndex:i]] withColor:_lineColor];
            }
        }/* shouldHiddenPosition */else{
            if (i == 0) {
                if ([self _isStop:[positions objectAtIndex:i] inLine:stops]) {
                    [self drawCricle:ctx atPoint:[self _getPointByPositionId:[positions objectAtIndex:i]] withColor:_lineColor];
                }/* !isStop */else{
                    // do nothing
                }
            }/* i!=0 */else{
                if ([self _isStop:[positions objectAtIndex:i] inLine:stops]) {
                    [self drawCricle:ctx atPoint:[self _getPointByPositionId:[positions objectAtIndex:i]] withColor:_lineColor];
                    if ([self _isStop:[positions objectAtIndex:i-1] inLine:stops]) {
                        [self drawLineBetweenCircles:ctx begin:[self _getPointByPositionId:[positions objectAtIndex:i-1]] end:[self _getPointByPositionId:[positions objectAtIndex:i]] withColor:_lineColor];
                    }/* !lastIsStop */else{
                        [self drawPointToCircle:ctx point:[self _getPointByPositionId:[positions objectAtIndex:i-1]] circle:[self _getPointByPositionId:[positions objectAtIndex:i]] withColor:_lineColor];
                    }
                }/* !currentIsStop */else{
                    if ([self _isStop:[positions objectAtIndex:i-1] inLine:stops]) {
                        [self drawCircleToPoint:ctx circle:[self _getPointByPositionId:[positions objectAtIndex:i-1]] point:[self _getPointByPositionId:[positions objectAtIndex:i]] withColor:_lineColor];
                    }/* !lastIsStop */else{
                        [self drawLine:ctx begin:[self _getPointByPositionId:[positions objectAtIndex:i-1]] end:[self _getPointByPositionId:[positions objectAtIndex:i]] withColor:_lineColor];
                    }
                }
            }
        }
    }
}
-(void) drawCricle:(CGContextRef)ctx atPoint:(SBAPoint *)point withColor:(UIColor *)color{
    CGContextSetStrokeColorWithColor(ctx, color.CGColor);
    CGContextSetLineWidth(ctx,lineWidth);
    CGContextStrokeEllipseInRect(ctx, CGRectMake(point.x-lineWidth, point.y-lineWidth,2*lineWidth, 2*lineWidth));
}

-(void) drawLine:(CGContextRef)ctx begin:(SBAPoint *)last end:(SBAPoint *)current withColor:(UIColor *)color{
    CGContextSetStrokeColorWithColor(ctx, color.CGColor);
    CGContextSetLineWidth(ctx,lineWidth);
    /*绘制连接线*/
    if (last.x == current.x) {
        if (last.y < current.y) {
            CGContextMoveToPoint(ctx,last.x,last.y-lineWidth/2);
            CGContextAddLineToPoint(ctx,current.x, current.y+lineWidth/2);
        }else{
            CGContextMoveToPoint(ctx,last.x,last.y+lineWidth/2);
            CGContextAddLineToPoint(ctx,current.x, current.y-lineWidth/2);
        }
    }else if (last.y == current.y){
        if (last.x < current.x) {
            CGContextMoveToPoint(ctx,last.x-lineWidth/2,last.y);
            CGContextAddLineToPoint(ctx,current.x+lineWidth/2, current.y);
        }else{
            CGContextMoveToPoint(ctx,last.x+lineWidth/2,last.y);
            CGContextAddLineToPoint(ctx,current.x-lineWidth/2, current.y);
        }
        
    }else{
        CGContextMoveToPoint(ctx,last.x,last.y);
        CGContextAddLineToPoint(ctx,current.x, current.y);
    }
    CGContextStrokePath(ctx);
}

-(void) drawLineBetweenCircles:(CGContextRef)ctx begin:(SBAPoint *)last end:(SBAPoint *)current withColor:(UIColor *)color{
    CGFloat x0,y0,x1,y1,distance;
    distance = sqrt(pow(current.x - last.x,2)+pow(current.y - last.y,2));
    x0 = last.x + (current.x - last.x)*lineWidth/distance;
    y0 = last.y + (current.y - last.y)*lineWidth/distance;
    x1 = current.x - (current.x - last.x)*lineWidth/distance;
    y1 = current.y - (current.y - last.y)*lineWidth/distance;
    last = [[SBAPoint alloc]initWithPoint:CGPointMake(x0, y0)];
    current = [[SBAPoint alloc]initWithPoint:CGPointMake(x1, y1)];
    [self drawLine:ctx begin:last end:current withColor:color];
}

-(void) drawPointToCircle:(CGContextRef)ctx point:(SBAPoint *)point circle:(SBAPoint *)circle withColor:(UIColor *)color{
    CGFloat x0,y0,distance;
    distance = sqrt(pow(circle.x - point.x, 2)+pow(circle.y - point.y,2));
    x0 = circle.x - (circle.x - point.x)*lineWidth/distance;
    y0 = circle.y - (circle.y - point.y)*lineWidth/distance;
    circle = [[SBAPoint alloc]initWithPoint:CGPointMake(x0, y0)];
    [self drawLine:ctx begin:point end:circle withColor:color];
}

-(void) drawCircleToPoint:(CGContextRef)ctx circle:(SBAPoint *)circle point:(SBAPoint *)point withColor:(UIColor *)color{
    CGFloat x0,y0,distance;
    distance = sqrt(pow(circle.x - point.x, 2)+pow(circle.y - point.y,2));
    x0 = circle.x + (point.x - circle.x)*lineWidth/distance;
    y0 = circle.y + (point.y - circle.y)*lineWidth/distance;
    circle = [[SBAPoint alloc]initWithPoint:CGPointMake(x0, y0)];
    [self drawLine:ctx begin:circle end:point withColor:color];
}

/**
 * 判断该位置是否是站台
 * @param positionId
 * @return BOOL
 */
-(BOOL) _isStop:(NSString *)positionId inLine:(NSArray *)stopArray{
    if (stopArray != nil && [stopArray count] != 0){
        for (NSString *position in stopArray){
            if ([position isEqualToString:positionId]) {
                return YES;
            }
        }
    }
    return NO;
}
/**
 * 根据positionId获取相应的屏幕坐标
 * @return SBAPoint
 */
-(SBAPoint *) _getPointByPositionId:(NSString *)positionId{
    if (dataSource != nil && [dataSource respondsToSelector:@selector(getPoint:byPositionId:)]) {
        return [dataSource getPoint:self byPositionId:positionId];
    }
    return nil;
}
-(UIColor *) _lineColor:(NSString *)lineId{
    if (lineColor != nil && [lineColor count] != 0 && lineId != nil) {
        NSEnumerator *keys = [lineColor keyEnumerator];
        for (NSString *key in keys){
            if ([key isEqualToString:lineId]) {
                return [lineColor objectForKey:key];
            }
        }
    }
    return ColorDefault;
}
@end

#pragma -mark SBAHighLightLineView
#pragma -mark SBAHighLightLineViewInterface
/** 选中线路图 */
@interface SBAHighLightLineView :SBALineBaseView
/** 需要高亮的线路数据 */
@property (nonatomic,strong) NSArray *lines;

@end
#pragma -mark SBAHighLightLineViewImplementation

@implementation SBAHighLightLineView

@synthesize lines;

-(SBAHighLightLineView *) initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

-(void) drawRect:(CGRect)rect{
    /** 当前画布信息 */
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    if (lines != nil && [lines count] != 0) {
        for (SBALine *line in lines){
            [self createLine:ctx withLine:line useColor:self.dColor];
        }
    }
    if (self.currentStop) {
        [self drawCricle:ctx atPoint:[self _getPointByPositionId:self.currentStop.positionId] withColor:ColorOrange];
    }
}

@end

#pragma -mark SBALineView
#pragma -mark SBALineViewDataInterface

/** 线路图 */
@interface SBALineView : SBALineBaseView
/** 刷新线路数据 */
-(void) reloadData;
@end

@interface SBALineView ()
/** 高亮线路图  */
@property (nonatomic,strong) SBAHighLightLineView *highLightView;

@end
#pragma -mark SBALineViewImplementation
@implementation SBALineView

-(SBALineView *) initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

-(void) drawRect:(CGRect)rect{
    /** 当前画布信息 */
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    NSArray *lines = [self _lineData];
    /* 绘基础线路图 */
    if (lines != nil && [lines count] != 0) {
        for (SBALine *line in lines)
            [self createLine:ctx withLine:line useColor:self.dColor];
    }
}

-(void) reloadData{
    /** 刷新高亮线路图 */
    void(^reloadHighLightLineView)(NSArray*,NSDictionary*,SBAStop*) = ^(NSArray *lines,NSDictionary *lineColor,SBAStop *currentStop){
        if (_highLightView) {
            [_highLightView removeFromSuperview];
        }else{
            _highLightView = [[SBAHighLightLineView alloc]initWithFrame:self.bounds];
            _highLightView.dataSource = self.dataSource;
            _highLightView.shouldHiddenPosition = self.shouldHiddenPosition;
            _highLightView.lineWidth = self.lineWidth;
        }
        _highLightView.lines = lines;
        _highLightView.lineColor = lineColor;
        _highLightView.currentStop = currentStop;
        [_highLightView setNeedsDisplay];
        [self addSubview:_highLightView];
    };
        if (_highLightView) {
            [_highLightView removeFromSuperview];
        }
    /* 自定义线路 */
    if(self.diyLine) {
        NSMutableArray *lines = [[NSMutableArray alloc]init];
        [lines addObject:self.diyLine];
        reloadHighLightLineView(lines,self.lineColor,self.currentStop);
    }else{
        /* 选中线路 */
        if (self.lineColor != nil && [self.lineColor count] != 0) {
            NSEnumerator *keys = [self.lineColor keyEnumerator];
            NSArray *lines = [self _lineData];
            NSMutableArray *linesHighLight = [[NSMutableArray alloc]init];
           if (lines != nil && [lines count] != 0) {
                for (NSString *key in keys){
                    for (SBALine *line in lines){
                        if ([key isEqualToString:line.lineId]) {
                            [linesHighLight addObject:line];
                        }
                    }
                }
            }
            reloadHighLightLineView(linesHighLight,self.lineColor,self.currentStop);
        }
    }
}
/**
 * 获取线路绘图数据
 * @return NSArray
 */
-(NSArray *) _lineData{
    if (self.dataSource != nil && [self.dataSource respondsToSelector:@selector(lineData:)]) {
        return [self.dataSource lineData:self];
    }
    return nil;
}

@end

#pragma -mark SBABusView
/** 公交图 */
@interface SBABusView : UIView

@property (nonatomic,assign) CGFloat line_width;

@end

@implementation SBABusView

@synthesize line_width;

-(SBABusView *) initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

-(void) drawRect:(CGRect)rect{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(ctx, ColorYellow.CGColor);
    CGContextSetLineWidth(ctx,line_width);
    CGContextStrokeEllipseInRect(ctx, CGRectMake(self.bounds.origin.x+line_width, self.bounds.origin.y+line_width,2*line_width, 2*line_width));
}

@end

#pragma -mark SBInfoView
/** 信息显示 */
@interface SBAInfoView : UIView

@end

#pragma mark -SBMapView
@interface SBAMapView ()<SBALineViewDataSource>

/** 线路veiw */
@property (nonatomic,strong) SBALineView *lineView;
/** 公交view */
@property (nonatomic,strong) NSMutableDictionary *busViews;
/** 信息显示view */
@property (nonatomic,strong) SBAInfoView *infoView;
/** 屏幕坐标表 */
@property (nonatomic,strong) NSMutableDictionary *screenMapData;
/** 站台信息 */
@property (nonatomic,strong) NSArray *stopData;
/** 线路信息 */
@property (nonatomic,strong) NSArray *lineData;
/** 线宽 */
@property (nonatomic,assign) CGFloat lineWidth;
/** 背景view */
@property (nonatomic,strong) UIImageView *bgView;
@end

@implementation SBAMapView

@synthesize delegate;
@synthesize dataSource;
@synthesize shouldHiddenPosition;
@synthesize onlyTrackArriving;
@synthesize shouldTouchEvent;
@synthesize bground;
@synthesize dColor;

-(SBAMapView *) initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    self.backgroundColor = [UIColor clearColor];
    return self;
}

-(void) reloadAllData{
    /** 当前画布信息 */
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    /** 绘制所有坐标点 */
    void(^drawPositions)(void) = ^{
        NSEnumerator *keys = [_screenMapData keyEnumerator];
        for (NSString *key in keys){
            SBAPoint *point = [_screenMapData objectForKey:key];
            CGFloat x = point.x - _lineWidth,
            y = point.y - _lineWidth;
            CGContextSetStrokeColorWithColor(ctx,dColor.CGColor);
            CGContextSetLineWidth(ctx,_lineWidth);
            CGContextStrokeEllipseInRect(ctx, CGRectMake(x, y, 2*_lineWidth, 2*_lineWidth));
        }
    };
    /** 将数据坐标转换为屏幕坐标，计算绘图数据 */
    dispatch_block_t convertMapData =  ^{
        _lineData = [self _lineData];
        _stopData = [self _stopData];
        if (dColor == nil) {
            dColor =ColorDefault;
        }
        _screenMapData = [[NSMutableDictionary alloc]init];
        NSArray *mapData = [self _mapData];
        if (mapData != nil && [mapData count] != 0) {
            if ([mapData count] == 1) {
                SBAPoint *point = [[SBAPoint alloc]initWithPoint:CGPointMake(self.bounds.origin.x+self.bounds.size.width/2,self.bounds.origin.y+self.bounds.size.height/2)];
                _lineWidth = MIN(self.bounds.size.width, self.bounds.size.height)/5;
                [_screenMapData setObject:point forKey:((SBAPosition *)[mapData objectAtIndex:0]).positionId];
            }else{
                CGRect dataSize = [self _dataSize:mapData];
                CGFloat divHeight = (self.bounds.size.height)/dataSize.size.height,
                        divWidth = (self.bounds.size.width)/dataSize.size.width,
                        originX = dataSize.origin.x,
                        originY = dataSize.origin.y,
                        x0 = self.bounds.origin.x,
                        y0 = self.bounds.origin.y;
                _lineWidth = MIN(self.bounds.size.width, self.bounds.size.height)/([mapData count]/2);
                for (SBAPosition *position in mapData){
                    SBAPoint *screenPoint = [[SBAPoint alloc]initWithPoint:CGPointMake(x0+([((SBAPosition *)position).x floatValue] - originX)*divWidth,y0+([((SBAPosition *)position).y floatValue] - originY)*divHeight)];
                    [_screenMapData setObject:screenPoint forKey:((SBAPosition *)position).positionId];
                    
                }
            }
        }else{
            _lineWidth = 0;
        }
    };
    void(^createLineView)(void) = ^{
        if (_lineView) {
            [_lineView removeFromSuperview];
        }
        if (bground) {
            _bgView = [[UIImageView alloc]initWithFrame:self.bounds];
            _bgView.image = bground;
            [self addSubview:_bgView];
        }
        _lineView = [[SBALineView alloc]initWithFrame:self.bounds];
        _lineView.dataSource = self;
        _lineView.shouldHiddenPosition = shouldHiddenPosition;
        _lineView.lineWidth = _lineWidth;
        _lineView.dColor = dColor;
        _lineView.lineColor = nil;
        _lineView.currentStop = nil;
        [self addSubview:_lineView];
    };
    convertMapData ();
    if (!shouldHiddenPosition) {
        drawPositions();
    }
    createLineView ();
}

-(void) reloadBusData:(SBABus *)bus{
    if (bus != nil) {
        if (_busViews == nil) {
            _busViews = [[NSMutableDictionary alloc]init];
            SBAPoint *point = [_screenMapData objectForKey:bus.positionId];
            SBABusView *busView = [[SBABusView alloc]initWithFrame:CGRectMake(point.x-2*_lineWidth, point.y-2*_lineWidth, 4*_lineWidth, 4*_lineWidth)];
            busView.line_width = _lineWidth;
            [_busViews setObject:busView forKey:bus.busId];
            [self addSubview:busView];
        }else{
            NSEnumerator *keys = [_busViews keyEnumerator];
            int i=0;
            for (NSString *key in keys){
                if ([bus.busId isEqualToString:key]) {
                    NSMutableDictionary *data = [[NSMutableDictionary alloc]init];
                    [data setObject:[_busViews objectForKey:key] forKey:@"busView"];
                    [data setObject:key forKey:@"key"];
                    [data setObject:[_screenMapData objectForKey:bus.positionId] forKey:@"point"];
                    [NSThread detachNewThreadSelector:@selector(_reloadBusViewThread:) toTarget:self withObject:data];
                    i++;
                }
            }
            if (i == 0) {
                SBAPoint *point = [_screenMapData objectForKey:bus.positionId];
                SBABusView *busView = [[SBABusView alloc]initWithFrame:CGRectMake(point.x-2*_lineWidth, point.y-2*_lineWidth, 4*_lineWidth, 4*_lineWidth)];
                busView.line_width = _lineWidth;
                [_busViews setObject:busView forKey:bus.busId];
                [self addSubview:busView];
            }
        }
    }else{
        NSEnumerator *keys = [_busViews keyEnumerator];
        for (NSString *key in keys){
            SBABusView *busView = [_busViews objectForKey:key];
            [busView removeFromSuperview];
        }
    }
}
/** 刷新公交视图线程 */
-(void) _reloadBusViewThread:(NSDictionary *)data{
    SBABusView *busView = [data objectForKey:@"busView"];
    SBAPoint *point = [data objectForKey:@"point"];
    NSString *key = [data objectForKey:@"key"];
    [busView removeFromSuperview];
    busView = [[SBABusView alloc]initWithFrame:CGRectMake(point.x-2*_lineWidth, point.y-2*_lineWidth, 4*_lineWidth, 4*_lineWidth)];
    [_busViews setObject:busView forKey:key];
    busView.line_width = _lineWidth;
    [self addSubview:busView];
}

-(void) reloadStopData:(SBAStop *)stop{
    if (stop != nil) {
        [self _reloadLineDataWithColor:[self _linesColorAtStop:stop inLine:nil] atStop:stop useLine:nil];
    }else{
        [self _reloadLineDataWithColor:nil atStop:nil useLine:nil];
    }
}

-(void) reloadLineData:(SBALine *)line withColor:(UIColor *)color{
    NSMutableDictionary *lineColor = [[NSMutableDictionary alloc]init];
    [lineColor setObject:color forKey:line.lineId];
    [self _reloadLineDataWithColor:lineColor atStop:nil useLine:line];
}

/** 刷新线路数据 */
-(void) _reloadLineDataWithColor:(NSDictionary *)lineColor atStop:(SBAStop *)currentStop useLine:(SBALine *)diyLine{
    _lineView.lineColor = lineColor;
    _lineView.currentStop = currentStop;
    if (diyLine != nil) {
        NSArray *convertArray = [NSArray arrayWithObject:diyLine];
        _lineView.diyLine = [[self _convertLineStops:convertArray] objectAtIndex:0];
    }else{
        _lineView.diyLine = diyLine;
    }
    [_lineView reloadData];
}

/**
 * 获取地图绘图数据
 * @return NSArray
 */
-(NSArray *) _mapData{
    if (dataSource != nil && [dataSource respondsToSelector:@selector(drawMapData:)] ) {
        return  [dataSource drawMapData:self];
    }
    return nil;
}
/**
 * 获取线路绘图数据
 * @return NSArray
 */
-(NSArray *) _lineData{
    if (dataSource != nil && [dataSource respondsToSelector:@selector(drawLineData:)]) {
        return [dataSource drawLineData:self];
    }
    return nil;
}
/**
 * 获取站台绘图数据
 * @return NSArray
 */
-(NSArray *) _stopData{
    if (dataSource != nil && [dataSource respondsToSelector:@selector(drawStopData:)]) {
        return [dataSource drawStopData:self];
    }
    return nil;
}
/**
 * 获取公交绘图数据
 * @return NSArray
 */
-(NSArray *) _busData{
    if (dataSource != nil && [dataSource respondsToSelector:@selector(drawBusData:)]) {
        return [dataSource drawBusData:self];
    }
    return nil;
}

/**
 * 计算数据x,y最大值，返回地图数据尺寸
 * @param mapData
 * @return CGSize
 */
-(CGRect) _dataSize:(NSArray *)mapData{
    NSInteger max_x=0,max_y=0,min_x=0,min_y=0;
    for (SBAPosition *position in mapData){
        if ([position.x intValue] > max_x)
            max_x = [position.x intValue];
        if ([position.x intValue] < min_x)
            min_x = [position.x intValue];
        if ([position.y intValue] > max_y)
            max_y = [position.y  intValue];
        if ([position.y  intValue] < min_y)
            min_y = [position.y  intValue];
    }
    return CGRectMake(min_x, min_y, max_x-min_x, max_y-min_y);
}
/**
 * 生成线路颜色描述字典
 * @param stop 为空则返回值为空
 * @param line 为空则显示该站点所有线路
 * @return NSDictionay
 */
-(NSDictionary *) _linesColorAtStop:(SBAStop *)stop inLine:(SBALine *)line{
    /** 生成颜色数组 */
    UIColor*(^colorForIndex)(NSInteger) = ^(NSInteger index){
        index %= 3;
        switch (index) {
            case 0:
                return ColorBlue;
            case 1:
                return ColorGreen;
            case 2:
                return ColorRed;
            default:
                return ColorDefault;
        }
    };
     NSMutableDictionary *lineColor = [[NSMutableDictionary alloc]init];
    if (line == nil) {
        if (stop != nil && _lineData != nil) {
            for (int i=0; i<[_lineData count]; i++) {
                SBALine *line1 = [_lineData objectAtIndex:i];
                NSArray *stops = line1.stops;
                for (NSString *sotpId in stops){
                    if ([stop.stopId isEqualToString:sotpId]) {
                        [lineColor setObject:colorForIndex(i) forKey:line1.lineId];
                    }
                }
            }
        }
    }else{
        [lineColor setObject:colorForIndex(0) forKey:line.lineId];
    }
    return lineColor;
}
/**
 * 查询坐标点是为有Position有效范围内 ? positionId ：nil
 * @param SPAPoint
 * @return NSString
 */
-(NSString *) _idForPoint:(SBAPoint *)point{
    if (_screenMapData != nil && [_screenMapData count] != 0) {
        NSEnumerator *keys = [_screenMapData keyEnumerator];
        for (NSString *key in keys){
            SBAPoint *position = [_screenMapData objectForKey:key];
            CGFloat distance = sqrt(pow(position.x - point.x, 2) + pow(position.y - point.y, 2));
            if (distance <= 2*_lineWidth) {
                return key;
            }
        }
    }
    return nil;
}
/**
 * 查询坐标点是否属于站台范围 ? 站台信息 ：nil
 * @param SPAPoint
 * @return SBAStop
 */
-(SBAStop *) _getStopAtPoint:(SBAPoint *)point{
    if (_stopData == nil || [_stopData count] == 0) {
        return nil;
    }
    NSString *positionId = [self _idForPoint:point];
    if (positionId != nil) {
        for (SBAStop *stop in _stopData){
            if ([stop.positionId isEqualToString:positionId]) {
                return stop;
            }
        }
        return nil;
    }else{
        return nil;
    }
}
/** 将Line.stops 中的 stopId 转换为对应的 positionId */
-(NSArray *) _convertLineStops:(NSArray *)lines{
    NSMutableArray *lineData = [[NSMutableArray alloc]init];
    /* 将stopID 转换为对应的 positionId */
    if (lines != nil && _stopData != nil && [lines count] != 0 && [_stopData count] != 0) {
        for (SBALine *line in _lineData){
            NSMutableArray *stopArray = [[NSMutableArray alloc]init];
            for (NSString *stopId in line.stops){
                for (SBAStop *stop in _stopData){
                    if ([stop.stopId isEqualToString:stopId]) {
                        [stopArray addObject:stop.positionId];
                    }
                }
            }
            SBALine *_line = [[SBALine alloc]init];
            _line.stops = stopArray;
            _line.lineId = line.lineId;
            _line.positions = line.positions;
            [lineData addObject:_line];
        }
    }
    return lineData;
}
#pragma -mark TouchHelper
/* 触碰操作 */
- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    if (shouldTouchEvent) {
        UITouch *touch = [touches anyObject];
        SBAPoint *touchPoint = [[SBAPoint alloc]initWithPoint:[touch locationInView:self]];
        NSString *positionId;
        if (!shouldHiddenPosition) {
            positionId = [self _idForPoint:touchPoint];
            if (positionId != nil) {
                NSLog(@"SBAMapView.touchesEnded : touch on : %@",positionId);
                if (delegate != nil && [delegate respondsToSelector:@selector(mapView:didSelectPosition:)]) {
                    [delegate mapView:self didSelectPosition:positionId];
                }
            }
        }
        SBAStop *stop = [self _getStopAtPoint:touchPoint];
        if (stop != nil) {
             NSLog(@"SBAMapView.touchesEnded : touch on : %@",stop.stopId);
            [self _reloadLineDataWithColor:[self _linesColorAtStop:stop inLine:nil] atStop:stop useLine:nil];
            if (delegate != nil && [delegate respondsToSelector:@selector(mapView:didSelectStop:)]) {
                [delegate mapView:self didSelectStop:stop.stopId];
            }
        }else{
            [self _reloadLineDataWithColor:nil atStop:nil useLine:nil];
        }
        if (stop == nil && positionId == nil) {
            NSLog(@"SBAMapView.touchesEnded : touch on : outside");
            if (delegate != nil && [delegate respondsToSelector:@selector(didSelectOutSide:)]) {
                [delegate didSelectOutSide:self];
            }
        }
    }
}
#pragma -mark SBLineDataSource

-(NSArray *) lineData:(SBALineView *)lineView{
    return [self _convertLineStops:_lineData];
}

-(SBAPoint *) getPoint:(SBALineView *)lineView byPositionId:(NSString *)positionId{
    return [_screenMapData objectForKey:positionId];
}
@end
