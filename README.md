# LearnCenter

1、设置UILabel行间距

    NSMutableAttributedString* attrString = [[NSMutableAttributedString  alloc] initWithString:label.text];
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setLineSpacing:20];
    [attrString addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, label.text.length)];
    label.attributedText = attrString;


2、当使用-performSelector:withObject:withObject:afterDelay:方法时，需要传入多参数问题

// 方法一、
// 把参数放进一个数组／字典，直接把数组／字典当成一个参数传过去，具体方法实现的地方再解析这个数组／字典

        NSArray * array = [NSArray arrayWithObjects: @"first", @"second", nil];
        [self performSelector:@selector(fooFirstInput:) withObject: array afterDelay:15.0];

// 方法二、
        // 使用NSInvocation
        
        SEL aSelector = NSSelectorFromString(@"doSoming:argument2:");
        NSInteger argument1 = 10;
        NSString *argument2 = @"argument2";
        if([self respondsToSelector:aSelector]) {
            NSInvocation *inv = [NSInvocation invocationWithMethodSignature:[self methodSignatureForSelector:aSelector]];
            [inv setSelector:aSelector];
            [inv setTarget:self];
            [inv setArgument:&(argument1) atIndex:2];
            [inv setArgument:&(argument2) atIndex:3];
            [inv performSelector:@selector(invoke) withObject:nil afterDelay:15.0];
        }
    
3、UILabel显示不同颜色字体

    NSMutableAttributedString * string = [[NSMutableAttributedString alloc] initWithString:label.text];
    [string addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0,5)];
    [string addAttribute:NSForegroundColorAttributeName value:[UIColor greenColor] range:NSMakeRange(5,6)];
    [string addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(11,5)];
    label.attributedText = string;

4、比较两个CGRect/CGSize/CGPoint是否相等

    if (CGRectEqualToRect(rect1, rect2)) { // 两个区域相等

        // do some
        
    }
    
    if (CGPointEqualToPoint(point1, point2)) { // 两个点相等
    
        // do some
        
    }
    
    if (CGSizeEqualToSize(size1, size2)) { // 两个size相等
    
        // do some
        
    }
    
5、比较两个NSDate相差多少小时

    NSDate* date1 = someDate;
 
    NSDate* date2 = someOtherDate;
 
    NSTimeInterval distanceBetweenDates = [date1 timeIntervalSinceDate:date2];
 
    double secondsInAnHour = 3600;
 
    // 除以3600是把秒化成小时，除以60得到结果为相差的分钟数

     NSInteger hoursBetweenDates = distanceBetweenDates / secondsInAnHour;
 
6、每个cell之间增加间距

    // 方法一，每个分区只显示一行cell，分区头当作你想要的间距(注意，从数据源数组中取值的时候需要用indexPath.section而不是indexPath.row)
    - (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
    {
        return yourArry.count;
    }

    - (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
    {
        return 1;
    }

    -(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
    {
        return cellSpacingHeight;
    }

// 方法二，在cell的contentView上加个稍微低一点的view，cell上原本的内容放在你的view上，而不是contentView上，这样能伪造出一个间距来。

// 方法三，自定义cell，重写setFrame：方法

    - (void)setFrame:(CGRect)frame
    {
        frame.size.height -= 20;
        [super setFrame:frame];
    }

7、播放一张张连续的图片

    // 加入现在有三张图片分别为animate_1、animate_2、animate_3

    // 方法一

    imageView.animationImages = @[[UIImage imageNamed:@"animate_1"], [UIImage imageNamed:@"animate_2"], [UIImage imageNamed:@"animate_3"]];
    
    imageView.animationDuration = 1.0;

    // 方法二

    imageView.image = [UIImage animatedImageNamed:@"animate_" duration:1.0];
    
    // 方法二解释下，这个方法会加载animate_为前缀的，后边0-1024，也就是animate_0、animate_1一直到animate_1024

8、加载gif图片

    推荐使用这个框架 FLAnimatedImage

9、防止离屏渲染为image添加圆角

    // image分类
    - (UIImage *)circleImage
    {
        // NO代表透明

        UIGraphicsBeginImageContextWithOptions(self.size, NO, 1);

        // 获得上下文

        CGContextRef ctx = UIGraphicsGetCurrentContext();

        // 添加一个圆

        CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);

        // 方形变圆形

        CGContextAddEllipseInRect(ctx, rect);

        // 裁剪

        CGContextClip(ctx);

        // 将图片画上去

        [self drawInRect:rect];

        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();

        UIGraphicsEndImageContext();

        return image;

    }

10、查看系统所有字体

    // 打印字体

    for (id familyName in [UIFont familyNames]) {

        NSLog(@"%@", familyName);
    
        for (id fontName in [UIFont fontNamesForFamilyName:familyName]) NSLog(@"  %@", fontName);
    
    }

    // 也可以进入这个网址查看 http://iosfonts.com/

11、获取随机数

    NSInteger i = arc4random();

12、获取随机数小数(0-1之间)

    #define ARC4RANDOM_MAX      0x100000000

    double val = ((double)arc4random() / ARC4RANDOM_MAX);

13、AVPlayer视频播放完成的通知监听

    [[NSNotificationCenter defaultCenter] 
      addObserver:self
      selector:@selector(videoPlayEnd)
      name:AVPlayerItemDidPlayToEndTimeNotification 
      object:nil];
      
14、判断两个rect是否有交叉

    if (CGRectIntersectsRect(rect1, rect2)) {
    }

15、判断一个字符串是否为数字

    NSCharacterSet *notDigits = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    if ([str rangeOfCharacterFromSet:notDigits].location == NSNotFound)
    {
      // 是数字
    } else
    {
      // 不是数字
    }
16、将一个view保存为pdf格式

    - (void)createPDFfromUIView:(UIView*)aView saveToDocumentsWithFileName:(NSString*)aFilename
    {
        NSMutableData *pdfData = [NSMutableData data];
        UIGraphicsBeginPDFContextToData(pdfData, aView.bounds, nil);
        UIGraphicsBeginPDFPage();
        CGContextRef pdfContext = UIGraphicsGetCurrentContext();
        [aView.layer renderInContext:pdfContext];
        UIGraphicsEndPDFContext();

        NSArray* documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES);
        NSString* documentDirectory = [documentDirectories objectAtIndex:0];
        NSString* documentDirectoryFilename = [documentDirectory stringByAppendingPathComponent:aFilename];
        [pdfData writeToFile:documentDirectoryFilename atomically:YES];
        NSLog(@"documentDirectoryFileName: %@",documentDirectoryFilename);
    }
17、让一个view在父视图中心

    child.center = [parent convertPoint:parent.center fromView:parent.superview];
    
18、获取当前导航控制器下前一个控制器

    - (UIViewController *)backViewController
    {
        NSInteger myIndex = [self.navigationController.viewControllers indexOfObject:self];
        if ( myIndex != 0 && myIndex != NSNotFound ) {
            return [self.navigationController.viewControllers objectAtIndex:myIndex-1];
        } else {
            return nil;
        }
    }
19、保存UIImage到本地

    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"Image.png"];

    [UIImagePNGRepresentation(image) writeToFile:filePath atomically:YES];
20、键盘上方增加工具栏

    UIToolbar *keyboardDoneButtonView = [[UIToolbar alloc] init];
    [keyboardDoneButtonView sizeToFit];
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                               style:UIBarButtonItemStyleBordered target:self
                                                              action:@selector(doneClicked:)];
    [keyboardDoneButtonView setItems:[NSArray arrayWithObjects:doneButton, nil]];
    txtField.inputAccessoryView = keyboardDoneButtonView;
    
21、copy一个view
因为UIView没有实现copy协议，因此找不到copyWithZone方法，使用copy的时候导致崩溃
但是我们可以通过归档再解档实现copy，这相当于对视图进行了一次深拷贝，代码如下

    id copyOfView = [NSKeyedUnarchiver unarchiveObjectWithData:[NSKeyedArchiver archivedDataWithRootObject:originalView]];
    
22、在image上绘制文字并生成新的image

    UIFont *font = [UIFont boldSystemFontOfSize:12];
    UIGraphicsBeginImageContext(image.size);
    [image drawInRect:CGRectMake(0,0,image.size.width,image.size.height)];
    CGRect rect = CGRectMake(point.x, point.y, image.size.width, image.size.height);
    [[UIColor whiteColor] set];
    [text drawInRect:CGRectIntegral(rect) withFont:font]; 
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
23、判断一个view是否为另一个view的子视图
// 如果myView是self.view本身，也会返回yes

    BOOL isSubView = [myView isDescendantOfView:self.view];
    
24、判断一个字符串是否包含另一个字符串
// 方法一、这种方法只适用于iOS8之后，如果是配iOS8之前用方法二

    if ([str containsString:otherStr]) NSLog(@"包含");

// 方法二

    NSRange range = [str rangeOfString:otherStr];
    if (range.location != NSNotFound) NSLog(@"包含");
    
25、UICollectionView自动滚动到某行
// 重写viewDidLayoutSubviews方法

    -(void)viewDidLayoutSubviews {
        [super viewDidLayoutSubviews];
        [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredVertically animated:NO];
    }
26、修改系统UIAlertController
// 但是据说这种方法会被App Store拒绝(慎用！)

    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    NSMutableAttributedString *hogan = [[NSMutableAttributedString alloc] initWithString:@"我是一个大文本"];
    [hogan addAttribute:NSFontAttributeName
                  value:[UIFont systemFontOfSize:30]
                  range:NSMakeRange(4, 1)];
    [hogan addAttribute:NSForegroundColorAttributeName
                  value:[UIColor redColor]
                  range:NSMakeRange(4, 1)];
    [alertVC setValue:hogan forKey:@"attributedTitle"];

    UIAlertAction *button = [UIAlertAction actionWithTitle:@"Label text" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){ }];
    UIImage *accessoryImage = [UIImage imageNamed:@"1"];
    [button setValue:accessoryImage forKey:@"image"];
    [alertVC addAction:button];
    [self presentViewController:alertVC animated:YES completion:nil];
    
27、判断某一行的cell是否已经显示

    CGRect cellRect = [tableView rectForRowAtIndexPath:indexPath];
    BOOL completelyVisible = CGRectContainsRect(tableView.bounds, cellRect);

28、让导航控制器pop回指定的控制器

    NSMutableArray *allViewControllers = [NSMutableArray arrayWithArray:[self.navigationController viewControllers]];
    for (UIViewController *aViewController in allViewControllers) {
        if ([aViewController isKindOfClass:[RequiredViewController class]]) {
            [self.navigationController popToViewController:aViewController animated:NO];
        }
    }
    
29、动画修改label上的文字
// 方法一

    CATransition *animation = [CATransition animation];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.type = kCATransitionFade;
    animation.duration = 0.75;
    [self.label.layer addAnimation:animation forKey:@"kCATransitionFade"];
    self.label.text = @"New";

// 方法二

    [UIView transitionWithView:self.label
                      duration:0.25f
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{
                        self.label.text = @"Well done!";
                    } completion:nil];

// 方法三

    [UIView animateWithDuration:1.0 animations:^{
                         self.label.alpha = 0.0f;
                         self.label.text = @"newText";
                         self.label.alpha = 1.0f;
    }];
                     
30、判断字典中是否包含某个key值

    if ([dic objectForKey:@"yourKey"]) {
        NSLog(@"有这个值");
    } else {
        NSLog(@"没有这个值");
    }

31、获取屏幕方向

    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;

    if(orientation == 0) //Default orientation
        //默认
    else if(orientation == UIInterfaceOrientationPortrait)
        //竖屏
    else if(orientation == UIInterfaceOrientationLandscapeLeft)
        // 左横屏
    else if(orientation == UIInterfaceOrientationLandscapeRight)
        //右横屏
        
32、设置UIImage的透明度
// 方法一、添加UIImage分类

    - (UIImage *)imageByApplyingAlpha:(CGFloat) alpha {
        UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0f);

        CGContextRef ctx = UIGraphicsGetCurrentContext();
        CGRect area = CGRectMake(0, 0, self.size.width, self.size.height);

        CGContextScaleCTM(ctx, 1, -1);
        CGContextTranslateCTM(ctx, 0, -area.size.height);

        CGContextSetBlendMode(ctx, kCGBlendModeMultiply);

        CGContextSetAlpha(ctx, alpha);

        CGContextDrawImage(ctx, area, self.CGImage);

        UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();

        UIGraphicsEndImageContext();

        return newImage;
    }

// 方法二、如果没有奇葩需求，干脆用UIImageView设置透明度

    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageWithName:@"yourImage"]];
    imageView.alpha = 0.5;
    
33、Attempt to mutate immutable object with insertString:atIndex:
这个错是因为你拿字符串调用insertString:atIndex:方法的时候，调用对象不是NSMutableString，应该先转成这个类型再调用


34、UIWebView添加单击手势不响应

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(webViewClick)];
    tap.delegate = self;
    [_webView addGestureRecognizer:tap];

// 因为webView本身有一个单击手势，所以再添加会造成手势冲突，从而不响应。需要绑定手势代理，并实现下边的代理方法

    - (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
        return YES;
    }

35、获取手机RAM容量
// 需要导入#import

    mach_port_t host_port;
    mach_msg_type_number_t host_size;
    vm_size_t pagesize;

    host_port = mach_host_self();
    host_size = sizeof(vm_statistics_data_t) / sizeof(integer_t);
    host_page_size(host_port, &pagesize);

    vm_statistics_data_t vm_stat;

    if (host_statistics(host_port, HOST_VM_INFO, (host_info_t)&vm_stat, &host_size) != KERN_SUCCESS) {
        NSLog(@"Failed to fetch vm statistics");
    }

    /* Stats in bytes */
    natural_t mem_used = (vm_stat.active_count +
                          vm_stat.inactive_count +
                          vm_stat.wire_count) * pagesize;
    natural_t mem_free = vm_stat.free_count * pagesize;
    natural_t mem_total = mem_used + mem_free;
    NSLog(@"已用: %u 可用: %u 总共: %u", mem_used, mem_free, mem_total);
    
    
    
36、地图上两个点之间的实际距离
// 需要导入#import

    CLLocation *locA = [[CLLocation alloc] initWithLatitude:34 longitude:113];
    CLLocation *locB = [[CLLocation alloc] initWithLatitude:31.05 longitude:121.76];
    // CLLocationDistance求出的单位为米
    CLLocationDistance distance = [locA distanceFromLocation:locB];
    
37、在应用中打开设置的某个界面
// 打开设置->通用

    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"prefs:root=General"]];

// 以下是设置其他界面

    prefs:root=General&path=About
    prefs:root=General&path=ACCESSIBILITY
    prefs:root=AIRPLANE_MODE
    prefs:root=General&path=AUTOLOCK
    prefs:root=General&path=USAGE/CELLULAR_USAGE
    prefs:root=Brightness
    prefs:root=Bluetooth
    prefs:root=General&path=DATE_AND_TIME
    prefs:root=FACETIME
    prefs:root=General
    prefs:root=General&path=Keyboard
    prefs:root=CASTLE
    prefs:root=CASTLE&path=STORAGE_AND_BACKUP
    prefs:root=General&path=INTERNATIONAL
    prefs:root=LOCATION_SERVICES
    prefs:root=ACCOUNT_SETTINGS
    prefs:root=MUSIC
    prefs:root=MUSIC&path=EQ
    prefs:root=MUSIC&path=VolumeLimit
    prefs:root=General&path=Network
    prefs:root=NIKE_PLUS_IPOD
    prefs:root=NOTES
    prefs:root=NOTIFICATIONS_ID
    prefs:root=Phone
    prefs:root=Photos
    prefs:root=General&path=ManagedConfigurationList
    prefs:root=General&path=Reset
    prefs:root=Sounds&path=Ringtone
    prefs:root=Safari
    prefs:root=General&path=Assistant
    prefs:root=Sounds
    prefs:root=General&path=SOFTWARE_UPDATE_LINK
    prefs:root=STORE
    prefs:root=TWITTER
    prefs:root=FACEBOOK
    prefs:root=General&path=USAGE prefs:root=VIDEO
    prefs:root=General&path=Network/VPN
    prefs:root=Wallpaper
    prefs:root=WIFI
    prefs:root=INTERNET_TETHERING
    prefs:root=Phone&path=Blocked
    prefs:root=DO_NOT_DISTURB
    
38、在UITextView中显示html文本

    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(20, 30, 100, 199)];
    textView.backgroundColor = [UIColor redColor];
    [self.view addSubview:textView];
    NSString *htmlString = @"
    ![](http://blogs.babble.com/famecrawler/files/2010/11/mickey_mouse-1097.jpg)";
    
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithData: [htmlString dataUsingEncoding:NSUnicodeStringEncoding] options: @{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes: nil error: nil];
    textView.attributedText = attributedString;
    
39、监听scrollView是否滚动到了顶部／底部

    -(void)scrollViewDidScroll: (UIScrollView*)scrollView
    {
        float scrollViewHeight = scrollView.frame.size.height;
        float scrollContentSizeHeight = scrollView.contentSize.height;
        float scrollOffset = scrollView.contentOffset.y;

        if (scrollOffset == 0)
        {
            // 滚动到了顶部
        }
        else if (scrollOffset + scrollViewHeight == scrollContentSizeHeight)
        {
            // 滚动到了底部
        }
    }
40、UISlider增量／减量为固定值(假如为5)

    - (void)setupSlider
    {
        UISlider *slider = [[UISlider alloc] init];
        [self.view addSubview:slider];
        [slider addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventValueChanged];
        slider.maximumValue = 100;
        slider.minimumValue = 0;
        slider.frame = CGRectMake(200, 20, 100, 30);
    }

    - (void)sliderAction:(UISlider *)slider
    {
        [slider setValue:((int)((slider.value + 2.5) / 5) * 5) animated:NO];
    }
    
41、选中textField或者textView所有文本(我这里以textView为例)

    [self.textView setSelectedTextRange:[self.textView textRangeFromPosition:self.textView.beginningOfDocument toPosition:self.textView.endOfDocument]]

42、从导航控制器中删除某个控制器
// 方法一、知道这个控制器所处的导航控制器下标

    NSMutableArray *navigationArray = [[NSMutableArray alloc] initWithArray: self.navigationController.viewControllers];
    [navigationArray removeObjectAtIndex: 2];
    self.navigationController.viewControllers = navigationArray;

// 方法二、知道具体是哪个控制器

    NSArray* tempVCA = [self.navigationController viewControllers];

    for(UIViewController *tempVC in tempVCA)
    {
        if([tempVC isKindOfClass:[urViewControllerClass class]])
        {
            [tempVC removeFromParentViewController];
        }
    }
    
43、隐藏UITextView/UITextField光标

    textField.tintColor = [UIColor clearColor];
    
44、当UITextView/UITextField中没有文字时，禁用回车键

    textField.enablesReturnKeyAutomatically = YES;

45、字符串encode编码(编码url字符串不成功的问题)
// 我们一般用这个方法处理stringByAddingPercentEscapesUsingEncoding但是这个方法好想不会处理／和&这种特殊符号，这种情况就需要用下边这个方法处理

    @implementation NSString (NSString_Extended)
    - (NSString *)urlencode {
    NSMutableString *output = [NSMutableString string];
    const unsigned char *source = (const unsigned char *)[self UTF8String];
    int sourceLen = strlen((const char *)source);
    for (int i = 0; i < sourceLen; ++i) {
            const unsigned char thisChar = source[i];
            if (thisChar == ' '){
                [output appendString:@"+"];
            } else if (thisChar == '.' || thisChar == '-' || thisChar == '_' || thisChar == '~' ||
                    (thisChar >= 'a' && thisChar = 'A' && thisChar = '0' && thisChar <= '9')) {
                   [output appendFormat:@"%c", thisChar];
            } else {
                [output appendFormat:@"%%X", thisChar];
            }
        }
        return output;
    }
46、计算UILabel上某段文字的frame

    @implementation UILabel (TextRect)

    - (CGRect)boundingRectForCharacterRange:(NSRange)range
    {
        NSTextStorage *textStorage = [[NSTextStorage alloc] initWithAttributedString:[self attributedText]];
        NSLayoutManager *layoutManager = [[NSLayoutManager alloc] init];
        [textStorage addLayoutManager:layoutManager];
        NSTextContainer *textContainer = [[NSTextContainer alloc] initWithSize:[self bounds].size];
        textContainer.lineFragmentPadding = 0;
        [layoutManager addTextContainer:textContainer];
        NSRange glyphRange;
        [layoutManager characterRangeForGlyphRange:range actualGlyphRange:&glyphRange];
        return [layoutManager boundingRectForGlyphRange:glyphRange inTextContainer:textContainer];
    }
    
47、获取随机UUID

    NSString *result;
    if([[[UIDevice currentDevice] systemVersion] floatValue] > 6.0)
    {
       result = [[NSUUID UUID] UUIDString];
    }
    else
    {
        CFUUIDRef uuidRef = CFUUIDCreate(NULL);
        CFStringRef uuid = CFUUIDCreateString(NULL, uuidRef);
        CFRelease(uuidRef);
        result = (__bridge_transfer NSString *)uuid;
    }
48、仿苹果抖动动画

    #define RADIANS(degrees) (((degrees) * M_PI) / 180.0)

    - (void)startAnimate {
    view.transform = CGAffineTransformRotate(CGAffineTransformIdentity, RADIANS(-5));
    [UIView animateWithDuration:0.25 delay:0.0 options:(UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionRepeat | UIViewAnimationOptionAutoreverse) animations:^ {
                         view.transform = CGAffineTransformRotate(CGAffineTransformIdentity, RADIANS(5));
                     } completion:nil];
    }

    - (void)stopAnimate {
    [UIView animateWithDuration:0.25 delay:0.0 options:(UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveLinear) animations:^ {
                         view.transform = CGAffineTransformIdentity;
                     } completion:nil];
    }
    
49、修改UISearBar内部背景颜色

    UITextField *textField = [_searchBar valueForKey:@"_searchField"];
    textField.backgroundColor = [UIColor redColor];
    
50、UITextView滚动到顶部

    // 方法一
    [self.textView scrollRangeToVisible:NSMakeRange(0, 0)];
    // 方法二
    [self.textView setContentOffset:CGPointZero animated:YES];
    
51、通知监听APP生命周期

    UIApplicationDidEnterBackgroundNotification 应用程序进入后台
    UIApplicationWillEnterForegroundNotification 应用程序将要进入前台
    UIApplicationDidFinishLaunchingNotification 应用程序完成启动
    UIApplicationDidFinishLaunchingNotification 应用程序由挂起变的活跃
    UIApplicationWillResignActiveNotification 应用程序挂起(有电话进来或者锁屏)
    UIApplicationDidReceiveMemoryWarningNotification 应用程序收到内存警告
    UIApplicationDidReceiveMemoryWarningNotification 应用程序终止(后台杀死、手机关机等)
    UIApplicationSignificantTimeChangeNotification 当有重大时间改变(凌晨0点，设备时间被修改，时区改变等)
    UIApplicationWillChangeStatusBarOrientationNotification 设备方向将要改变
    UIApplicationDidChangeStatusBarOrientationNotification 设备方向改变
    UIApplicationWillChangeStatusBarFrameNotification 设备状态栏frame将要改变
    UIApplicationDidChangeStatusBarFrameNotification 设备状态栏frame改变
    UIApplicationBackgroundRefreshStatusDidChangeNotification 应用程序在后台下载内容的状态发生变化
    UIApplicationProtectedDataWillBecomeUnavailable 本地受保护的文件被锁定,无法访问
    UIApplicationProtectedDataWillBecomeUnavailable 本地受保护的文件可用了
    
52、触摸事件类型

    UIControlEventTouchCancel 取消控件当前触发的事件
    UIControlEventTouchDown 点按下去的事件
    UIControlEventTouchDownRepeat 重复的触动事件
    UIControlEventTouchDragEnter 手指被拖动到控件的边界的事件
    UIControlEventTouchDragExit 一个手指从控件内拖到外界的事件
    UIControlEventTouchDragInside 手指在控件的边界内拖动的事件
    UIControlEventTouchDragOutside 手指在控件边界之外被拖动的事件
    UIControlEventTouchUpInside 手指处于控制范围内的触摸事件
    UIControlEventTouchUpOutside 手指超出控制范围的控制中的触摸事件

53、UITextField文字周围增加边距

    // 子类化UITextField，增加insert属性
    @interface WZBTextField : UITextField
    @property (nonatomic, assign) UIEdgeInsets insets;
    @end

    // 在.m文件重写下列方法
    - (CGRect)textRectForBounds:(CGRect)bounds {
    CGRect paddedRect = UIEdgeInsetsInsetRect(bounds, self.insets);
    if (self.rightViewMode == UITextFieldViewModeAlways || self.rightViewMode == UITextFieldViewModeUnlessEditing) {
        return [self adjustRectWithWidthRightView:paddedRect];
    }
        return paddedRect;
    }

    - (CGRect)placeholderRectForBounds:(CGRect)bounds {
    CGRect paddedRect = UIEdgeInsetsInsetRect(bounds, self.insets);

    if (self.rightViewMode == UITextFieldViewModeAlways || self.rightViewMode == UITextFieldViewModeUnlessEditing) {
        return [self adjustRectWithWidthRightView:paddedRect];
    }
        return paddedRect;
    }

    - (CGRect)editingRectForBounds:(CGRect)bounds {
    CGRect paddedRect = UIEdgeInsetsInsetRect(bounds, self.insets);
    if (self.rightViewMode == UITextFieldViewModeAlways || self.rightViewMode == UITextFieldViewModeWhileEditing) {
        return [self adjustRectWithWidthRightView:paddedRect];
    }
        return paddedRect;
    }

    - (CGRect)adjustRectWithWidthRightView:(CGRect)bounds {
        CGRect paddedRect = bounds;
        paddedRect.size.width -= CGRectGetWidth(self.rightView.frame);

        return paddedRect;
    }
    
54、监听UISlider拖动状态
// 添加事件

    [slider addTarget:self action:@selector(sliderValurChanged:forEvent:) forControlEvents:UIControlEventValueChanged];

// 实现方法

    - (void)sliderValurChanged:(UISlider*)slider forEvent:(UIEvent*)event {
    UITouch *touchEvent = [[event allTouches] anyObject];
    switch (touchEvent.phase) {
        case UITouchPhaseBegan:
            NSLog(@"开始拖动");
            break;
        case UITouchPhaseMoved:
            NSLog(@"正在拖动");
            break;
        case UITouchPhaseEnded:
            NSLog(@"结束拖动");
            break;
        default:
            break;
    }
    }
    
55、设置UITextField光标位置
// textField需要设置的textField，index要设置的光标位置

    - (void)cursorLocation:(UITextField *)textField index:(NSInteger)index
    {
        NSRange range = NSMakeRange(index, 0);
        UITextPosition *start = [textField positionFromPosition:[textField beginningOfDocument] offset:range.location];
        UITextPosition *end = [textField positionFromPosition:start offset:range.length];
        [textField setSelectedTextRange:[textField textRangeFromPosition:start toPosition:end]];
    }

56、去除webView底部黑色

    [webView setBackgroundColor:[UIColor clearColor]];
    [webView setOpaque:NO];
    for (UIView *v1 in [webView subviews])
    {
        if ([v1 isKindOfClass:[UIScrollView class]])
        {
            for (UIView *v2 in v1.subviews)
            {
                if ([v2 isKindOfClass:[UIImageView class]])
                {
                    v2.hidden = YES;
                }
            }
        }
    }
    
57、获取collectionViewCell在屏幕中的frame

    UICollectionViewLayoutAttributes *attributes = [collectionView layoutAttributesForItemAtIndexPath:indexPath];
    CGRect cellRect = attributes.frame;
    CGRect cellFrameInSuperview = [collectionView convertRect:cellRect toView:[cv superview]];

58、比较两个UIImage是否相等

    - (BOOL)image:(UIImage *)image1 isEqualTo:(UIImage *)image2
    {
        NSData *data1 = UIImagePNGRepresentation(image1);
        NSData *data2 = UIImagePNGRepresentation(image2);

        return [data1 isEqual:data2];
    }

59、解决当UIScrollView上有UIButton的时候，触摸到button滑动不了的问题
// 子类化UIScrollView，并重写以下方法

    - (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.delaysContentTouches = NO;
    }

    return self;
    }

    - (BOOL)touchesShouldCancelInContentView:(UIView *)view {
    if ([view isKindOfClass:UIButton.class]) {
        return YES;
    }

    return [super touchesShouldCancelInContentView:view];
    }

60、UITextView中的文字添加阴影效果

    - (void)setTextLayer:(UITextView *)textView color:(UIColor *)color
    {
        CALayer *textLayer = ((CALayer *)[textView.layer.sublayers objectAtIndex:0]);
        textLayer.shadowColor = color.CGColor;
        textLayer.shadowOffset = CGSizeMake(0.0f, 1.0f);
        textLayer.shadowOpacity = 1.0f;
        textLayer.shadowRadius = 1.0f;
    }
    
61、MD5加密

    + (NSString *)md5:(NSString *)str
    {
        const char *concat_str = [str UTF8String];
        unsigned char result[CC_MD5_DIGEST_LENGTH];
        CC_MD5(concat_str, (unsigned int)strlen(concat_str), result);
        NSMutableString *hash = [NSMutableString string];
        for (int i =0; i<16; i++){
            [hash appendFormat:@"X", result[i]];
            }
            return [hash uppercaseString];
    }

62、base64加密

    @interface NSData (Base64)
    /**
    *  @brief  字符串base64后转data
    */
    + (NSData *)dataWithBase64EncodedString:(NSString *)string
    {
    if (![string length]) return nil;
    NSData *decoded = nil;
    #if __MAC_OS_X_VERSION_MIN_REQUIRED < __MAC_10_9 || __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0
    if (![NSData instancesRespondToSelector:@selector(initWithBase64EncodedString:options:)])
    {
    #pragma clang diagnostic push
    #pragma clang diagnostic ignored "-Wdeprecated-declarations"
        decoded = [[self alloc] initWithBase64Encoding:[string stringByReplacingOccurrencesOfString:@"[^A-Za-z0-9+/=]" withString:@"" options:NSRegularExpressionSearch range:NSMakeRange(0, [string length])]];
        #pragma clang diagnostic pop
    }
    else
    #endif
    {
        decoded = [[self alloc] initWithBase64EncodedString:string options:NSDataBase64DecodingIgnoreUnknownCharacters];
    }
    return [decoded length]? decoded: nil;
    }
    
    /**
    *  @brief  NSData转string
    *  @param wrapWidth 换行长度  76  64
    */
    - (NSString *)base64EncodedStringWithWrapWidth:(NSUInteger)wrapWidth
    {
    if (![self length]) return nil;
    NSString *encoded = nil;
    #if __MAC_OS_X_VERSION_MIN_REQUIRED < __MAC_10_9 || __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0
    if (![NSData instancesRespondToSelector:@selector(base64EncodedStringWithOptions:)])
    {
    #pragma clang diagnostic push
    #pragma clang diagnostic ignored "-Wdeprecated-declarations"
        encoded = [self base64Encoding];
        #pragma clang diagnostic pop

    }
    else
    #endif
    {
        switch (wrapWidth)
        {
            case 64:
            {
                return [self base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
            }
            case 76:
            {
                return [self base64EncodedStringWithOptions:NSDataBase64Encoding76CharacterLineLength];
            }
            default:
            {
                encoded = [self base64EncodedStringWithOptions:(NSDataBase64EncodingOptions)0];
            }
        }
    }
    if (!wrapWidth || wrapWidth >= [encoded length])
    {
        return encoded;
    }
    wrapWidth = (wrapWidth / 4) * 4;
    NSMutableString *result = [NSMutableString string];
    for (NSUInteger i = 0; i < [encoded length]; i+= wrapWidth)
    {
        if (i + wrapWidth >= [encoded length])
        {
            [result appendString:[encoded substringFromIndex:i]];
            break;
        }
        [result appendString:[encoded substringWithRange:NSMakeRange(i, wrapWidth)]];
        [result appendString:@"\r\n"];
    }
    return result;
    }
    /**
    *  @brief  NSData转string 换行长度默认64
    */
    - (NSString *)base64EncodedString
    {
        return [self base64EncodedStringWithWrapWidth:0];
    }
    
63、AES加密

    #import
    @interface NSData (AES)
    /**
    *  利用AES加密数据
    */
    - (NSData*)encryptedWithAESUsingKey:(NSString*)key andIV:(NSData*)iv {

    NSData *keyData = [key dataUsingEncoding:NSUTF8StringEncoding];

    size_t dataMoved;
    NSMutableData *encryptedData = [NSMutableData dataWithLength:self.length + kCCBlockSizeAES128];

    CCCryptorStatus status = CCCrypt(kCCEncrypt,kCCAlgorithmAES128,kCCOptionPKCS7Padding,keyData.bytes,keyData.length,iv.bytes,self.bytes,self.length,encryptedData.mutableBytes, encryptedData.length,&dataMoved);

    if (status == kCCSuccess) {
        encryptedData.length = dataMoved;
        return encryptedData;
    }

    return nil;
    }

    /**
    *  @brief  利用AES解密据
    */
    - (NSData*)decryptedWithAESUsingKey:(NSString*)key andIV:(NSData*)iv {

    NSData *keyData = [key dataUsingEncoding:NSUTF8StringEncoding];

    size_t dataMoved;
    NSMutableData *decryptedData = [NSMutableData dataWithLength:self.length + kCCBlockSizeAES128];

    CCCryptorStatus result = CCCrypt(kCCDecrypt,kCCAlgorithmAES128,kCCOptionPKCS7Padding,keyData.bytes,keyData.length,iv.bytes,self.bytes,self.length,decryptedData.mutableBytes, decryptedData.length,&dataMoved);

    if (result == kCCSuccess) {
        decryptedData.length = dataMoved;
        return decryptedData;
    }

    return nil;

    }
    
64、3DES加密

    #import
    @interface NSData (3DES)
    /**
    *  利用3DES加密数据
    */
    - (NSData*)encryptedWith3DESUsingKey:(NSString*)key andIV:(NSData*)iv {

    NSData *keyData = [key dataUsingEncoding:NSUTF8StringEncoding];

    size_t dataMoved;
    NSMutableData *encryptedData = [NSMutableData dataWithLength:self.length + kCCBlockSize3DES];

    CCCryptorStatus result = CCCrypt(kCCEncrypt,kCCAlgorithm3DES,kCCOptionPKCS7Padding,keyData.bytes,keyData.length,iv.bytes,self.bytes,self.length,encryptedData.mutableBytes,encryptedData.length,&dataMoved);

    if (result == kCCSuccess) {
        encryptedData.length = dataMoved;
        return encryptedData;
    }

    return nil;

    }
    
    /**
    *  @brief   利用3DES解密数据
    */
    - (NSData*)decryptedWith3DESUsingKey:(NSString*)key andIV:(NSData*)iv {

    NSData *keyData = [key dataUsingEncoding:NSUTF8StringEncoding];

    size_t dataMoved;
    NSMutableData *decryptedData = [NSMutableData dataWithLength:self.length + kCCBlockSize3DES];

    CCCryptorStatus result = CCCrypt(kCCDecrypt,kCCAlgorithm3DES,kCCOptionPKCS7Padding,keyData.bytes,keyData.length,iv.bytes,self.bytes,self.length,decryptedData.mutableBytes,decryptedData.length,&dataMoved);

    if (result == kCCSuccess) {
        decryptedData.length = dataMoved;
        return decryptedData;
    }

    return nil;

    }
    
65、单个页面多个网络请求的情况，需要监听所有网络请求结束后刷新UI

    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t serialQueue = dispatch_queue_create("com.wzb.test.www", DISPATCH_QUEUE_SERIAL);
    dispatch_group_enter(group);
    dispatch_group_async(group, serialQueue, ^{
        // 网络请求一
        [WebClick getDataSuccess:^(ResponseModel *model) {
            dispatch_group_leave(group);
        } failure:^(NSString *err) {
            dispatch_group_leave(group);
        }];
    });
    dispatch_group_enter(group);
    dispatch_group_async(group, serialQueue, ^{
        // 网络请求二
        [WebClick getDataSuccess:getBigTypeRM onSuccess:^(ResponseModel *model) {
            dispatch_group_leave(group);
        }                                  failure:^(NSString *errorString) {
            dispatch_group_leave(group);
        }];
    });
    dispatch_group_enter(group);
    dispatch_group_async(group, serialQueue, ^{
        // 网络请求三
        [WebClick getDataSuccess:^{
            dispatch_group_leave(group);
        } failure:^(NSString *errorString) {
            dispatch_group_leave(group);
        }];
    });

    // 所有网络请求结束后会来到这个方法
    dispatch_group_notify(group, serialQueue, ^{
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                // 刷新UI
            });
        });
    });
    
66、解决openUrl延时问题
// 方法一

    dispatch_async(dispatch_get_main_queue(), ^{

        UIApplication *application = [UIApplication sharedApplication];
        if ([application respondsToSelector:@selector(openURL:options:completionHandler:)]) {
            [application openURL:URL options:@{}
           completionHandler:nil];
        } else {
           [application openURL:URL];
        }
    });
    
// 方法二

    [self performSelector:@selector(redirectToURL:) withObject:url afterDelay:0.1];

    - (void) redirectToURL
    {
    UIApplication *application = [UIApplication sharedApplication];
    if ([application respondsToSelector:@selector(openURL:options:completionHandler:)]) {
        [application openURL:URL options:@{}
           completionHandler:nil];
    } else {
        [application openURL:URL];
    }
    }
    
67、页面跳转实现翻转动画

    // modal方式
    TestViewController *vc = [[TestViewController alloc] init];
    vc.view.backgroundColor = [UIColor redColor];
    vc.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self presentViewController:vc animated:YES completion:nil];

    // push方式
    TestViewController *vc = [[TestViewController alloc] init];
    vc.view.backgroundColor = [UIColor redColor];
    [UIView beginAnimations:@"View Flip" context:nil];
    [UIView setAnimationDuration:0.80];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.navigationController.view cache:NO];
    [self.navigationController pushViewController:vc animated:YES];
    [UIView commitAnimations];
    
68、tableView实现无限滚动

    - (void)scrollViewDidScroll:(UIScrollView *)scrollView
    {
        CGFloat actualPosition = scrollView.contentOffset.y;
        CGFloat contentHeight = scrollView.contentSize.height - scrollView.frame.size.height;
        if (actualPosition >= contentHeight) {
            [self.dataArr addObjectsFromArray:self.dataArr];
            [self.tableView reloadData];
        }
    }
    
69、代码方式调整屏幕亮度

    // brightness属性值在0-1之间，0代表最小亮度，1代表最大亮度
    [[UIScreen mainScreen] setBrightness:0.5];
    
70、获取当前应用CUP用量

    float cpu_usage()
    {
    kern_return_t kr;
    task_info_data_t tinfo;
    mach_msg_type_number_t task_info_count;

    task_info_count = TASK_INFO_MAX;
    kr = task_info(mach_task_self(), TASK_BASIC_INFO, (task_info_t)tinfo, &task_info_count);
    if (kr != KERN_SUCCESS) {
        return -1;
    }

    task_basic_info_t      basic_info;
    thread_array_t         thread_list;
    mach_msg_type_number_t thread_count;

    thread_info_data_t     thinfo;
    mach_msg_type_number_t thread_info_count;

    thread_basic_info_t basic_info_th;
    uint32_t stat_thread = 0; // Mach threads

    basic_info = (task_basic_info_t)tinfo;

    // get threads in the task
    kr = task_threads(mach_task_self(), &thread_list, &thread_count);
    if (kr != KERN_SUCCESS) {
        return -1;
    }
    if (thread_count > 0)
        stat_thread += thread_count;

    long tot_sec = 0;
    long tot_usec = 0;
    float tot_cpu = 0;
    int j;

    for (j = 0; j < (int)thread_count; j++)
    {
        thread_info_count = THREAD_INFO_MAX;
        kr = thread_info(thread_list[j], THREAD_BASIC_INFO,
                         (thread_info_t)thinfo, &thread_info_count);
        if (kr != KERN_SUCCESS) {
            return -1;
        }

        basic_info_th = (thread_basic_info_t)thinfo;

        if (!(basic_info_th->flags & TH_FLAGS_IDLE)) {
            tot_sec = tot_sec + basic_info_th->user_time.seconds + basic_info_th->system_time.seconds;
            tot_usec = tot_usec + basic_info_th->user_time.microseconds + basic_info_th->system_time.microseconds;
            tot_cpu = tot_cpu + basic_info_th->cpu_usage / (float)TH_USAGE_SCALE * 100.0;
        }

    } // for each thread

    kr = vm_deallocate(mach_task_self(), (vm_offset_t)thread_list, thread_count * sizeof(thread_t));
    assert(kr == KERN_SUCCESS);

    return tot_cpu;
    }

71、float数据取整四舍五入

    CGFloat f = 4.65;
    NSLog(@"%d", (int)f);    // 打印结果4

    CGFloat f = 4.65;
    NSLog(@"%d", (int)round(f));    // 打印结果5
    
72、删除UISearchBar系统默认边框

    // 方法一
    searchBar.searchBarStyle = UISearchBarStyleMinimal;

    // 方法二
    [searchBar setBackgroundImage:[[UIImage alloc]init]];

    // 方法三
    searchBar.barTintColor = [UIColor whiteColor];
    
73、为UICollectionViewCell设置圆角和阴影

    cell.contentView.layer.cornerRadius = 2.0f;
    cell.contentView.layer.borderWidth = 1.0f;
    cell.contentView.layer.borderColor = [UIColor clearColor].CGColor;
    cell.contentView.layer.masksToBounds = YES;

    cell.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    cell.layer.shadowOffset = CGSizeMake(0, 2.0f);
    cell.layer.shadowRadius = 2.0f;
    cell.layer.shadowOpacity = 1.0f;
    cell.layer.masksToBounds = NO;
    cell.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:cell.bounds cornerRadius:cell.contentView.layer.cornerRadius].CGPath;

74、让正在滑动的scrollView停止滚动(不是禁止，而是暂时停止滚动)

    [scrollView setContentOffset:scrollView.contentOffset animated:NO];
    
75、使用xib设置UIView的边框、圆角

    圆角和边框看下图即可设置

    1432270-92361b4d420ac296.png

    xib设置圆角边框.png

    但是增加layer.borderColor的keyPath设置边框颜色并不能起作用，后来查了资料，这里应该用layer.borderUIColor，但是这里设置的颜色不起作用，无论设置什么颜色显示出来的都是黑色的。后来又去查了下，有种解决方案是给CALayer添加一个分类，提供一个 - (void)setBorderUIColor:(UIColor *)color;方法就可以解决了，实现如下：

    1432270-1fc7e7ca02eca962.png

    xib设置边框颜色.png

    #import "CALayer+BorderColor.h"

    @implementation CALayer (BorderColor)

    - (void)setBorderUIColor:(UIColor *)color
    {
        self.borderColor = color.CGColor;
    }
        
76、根据经纬度获取城市等信息

    // 创建经纬度
    CLLocation *location = [[CLLocation alloc] initWithLatitude:latitude longitude:longitude];
    //创建一个译码器
    CLGeocoder *cLGeocoder = [[CLGeocoder alloc] init];
    [cLGeocoder reverseGeocodeLocation:userLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        CLPlacemark *place = [placemarks objectAtIndex:0];
        // 位置名
    　　NSLog(@"name,%@",place.name);
    　　// 街道
    　　NSLog(@"thoroughfare,%@",place.thoroughfare);
    　　// 子街道
    　　NSLog(@"subThoroughfare,%@",place.subThoroughfare);
    　　// 市
    　　NSLog(@"locality,%@",place.locality);
    　　// 区
    　　NSLog(@"subLocality,%@",place.subLocality); 
    　　// 国家
    　　NSLog(@"country,%@",place.country);
        }
    }];

    /*  CLPlacemark中属性含义
    name                    地名

    thoroughfare            街道

    subThoroughfare        街道相关信息，例如门牌等
    locality                城市

    subLocality            城市相关信息，例如标志性建筑

    administrativeArea      直辖市

    subAdministrativeArea  其他行政区域信息（自治区等）

    postalCode              邮编

    ISOcountryCode          国家编码

    country                国家

    inlandWater            水源，湖泊

    ocean                  海洋

    areasOfInterest        关联的或利益相关的地标
    */
    
    
77、如何防止添加多个NSNotification观察者？
// 解决方案就是添加观察者之前先移除下这个观察者

    [[NSNotificationCenter defaultCenter] removeObserver:observer name:name object:object];
        [[NSNotificationCenter defaultCenter] addObserver:observer selector:selector name:name object:object];
        
78、将一个xib添加到另外一个xib上

    // 假设你的自定义view名字为CustomView，你需要在CustomView.m中重写 `- (instancetype)initWithCoder:(NSCoder *)aDecoder` 方法，代码如下：

    - (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if ((self = [super initWithCoder:aDecoder])) {
        [self addSubview:[[[NSBundle mainBundle] loadNibNamed:@"CustomView" owner:self options:nil] objectAtIndex:0]];
    }
    return self;
    }
    1432270-1baa2a4dd2e2d08f.png
    将一个xib添加到另外一个xib上.png

79、处理字符串，使其首字母大写

    NSString *str = @"abcdefghijklmn";
    NSString *resultStr;
    if (str && str.length > 0) {
        resultStr = [str stringByReplacingCharactersInRange:NSMakeRange(0,1) withString:[[str substringToIndex:1] capitalizedString]];
    }
    NSLog(@"%@", resultStr);
    
80、判断一个UIAlertView/UIAlertController是否显示

    // UIAlertView自带属性
    if (alert.visible)
    {
      NSLog(@"显示了");
    } else {
      NSLog(@"未显示");
    }

    // UIAlertController没有visible属性，需要自己判断，添加一个全局变量 BOOL visible
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Title" message:@"message" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"ActionTitle" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.visible = NO;
    }];
    UIAlertAction *calcelAction = [UIAlertAction actionWithTitle:@"calcelTitle" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        self.visible = NO;
    }];
    [alertController addAction:alertAction];
    [alertController addAction:calcelAction];
    [self presentViewController:alertController animated:YES completion:^{
        self.visible = YES;
    }];
    
81、获取字符串中的数字

    - (NSString *)getNumberFromStr:(NSString *)str
    {
        NSCharacterSet *nonDigitCharacterSet = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
        return [[str componentsSeparatedByCharactersInSet:nonDigitCharacterSet] componentsJoinedByString:@""];
    }
    NSLog(@"%@", [self getNumberFromStr:@"a0b0c1d2e3f4fda8fa8fad9fsad23"]); // 00123488923
    
82、为UIView的某个方向添加边框

    // 添加UIView分类

    // UIView+WZB.h
    #import


    /**
    边框方向

    - WZBBorderDirectionTop: 顶部
    - WZBBorderDirectionLeft: 左边
    - WZBBorderDirectionBottom: 底部
    - WZBBorderDirectionRight: 右边
    */
    typedef NS_ENUM(NSInteger, WZBBorderDirectionType) {
    WZBBorderDirectionTop = 0,
    WZBBorderDirectionLeft,
    WZBBorderDirectionBottom,
    WZBBorderDirectionRight
    };

    @interface UIView (WZB)


    /**
    为UIView的某个方向添加边框

    @param direction 边框方向
    @param color 边框颜色
    @param width 边框宽度
    */
    - (void)wzb_addBorder:(WZBBorderDirectionType)direction color:(UIColor *)color width:(CGFloat)width;

    @end

    // UIView+WZB.m
    #import "UIView+WZB.h"

    @implementation UIView (WZB)

    - (void)wzb_addBorder:(WZBBorderDirectionType)direction color:(UIColor *)color width:(CGFloat)width
    {
    CALayer *border = [CALayer layer];
    border.backgroundColor = color.CGColor;
    switch (direction) {
        case WZBBorderDirectionTop:
        {
            border.frame = CGRectMake(0.0f, 0.0f, self.bounds.size.width, width);
        }
            break;
        case WZBBorderDirectionLeft:
        {
            border.frame = CGRectMake(0.0f, 0.0f, width, self.bounds.size.height);
        }
            break;
        case WZBBorderDirectionBottom:
        {
            border.frame = CGRectMake(0.0f, self.bounds.size.height - width, self.bounds.size.width, width);
        }
            break;
        case WZBBorderDirectionRight:
        {
            border.frame = CGRectMake(self.bounds.size.width - width, 0, width, self.bounds.size.height);
        }
            break;
        default:
            break;
    }
    [self.layer addSublayer:border];
    }
    
83、通过属性设置UISwitch、UIProgressView等控件的宽高

    mySwitch.transform = CGAffineTransformMakeScale(5.0f, 5.0f);
    progressView.transform = CGAffineTransformMakeScale(5.0f, 5.0f);

84、自动搜索功能，用户连续输入的时候不搜索，用户停止输入的时候自动搜索(我这里设置的是0.5s，可根据需求更改)

    // 输入框文字改变的时候调用

    -(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    // 先取消调用搜索方法
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(searchNewResult) object:nil];
    // 0.5秒后调用搜索方法
    [self performSelector:@selector(searchNewResult) withObject:nil afterDelay:0.5];
    }

85、修改UISearchBar的占位文字颜色

    // 方法一（推荐使用）
    UITextField *searchField = [searchBar valueForKey:@"_searchField"];
    [searchField setValue:[UIColor blueColor] forKeyPath:@"_placeholderLabel.textColor"];

    // 方法二（已过期）
    [[UILabel appearanceWhenContainedIn:[UISearchBar class], nil] setTextColor:[UIColor redColor]];

    // 方法三（已过期）
    NSDictionary *placeholderAttributes = @{NSForegroundColorAttributeName : [UIColor redColor], NSFontAttributeName : [UIFont fontWithName:@"HelveticaNeue" size:15],};
    NSAttributedString *attributedPlaceholder = [[NSAttributedString alloc] initWithString:searchBar.placeholder attributes:placeholderAttributes];
    [[UITextField appearanceWhenContainedIn:[UISearchBar class], nil] setAttributedPlaceholder:attributedPlaceholder];
86、某个界面多个事件同时响应引起的问题(比如，两个button同时按push到新界面，两个都会响应，可能导致push重叠)

    // UIView有个属性叫做exclusiveTouch，设置为YES后，其响应事件会和其他view互斥(有其他view事件响应的时候点击它不起作用)
    view.exclusiveTouch = YES;
    // 一个一个设置太麻烦了，可以全局设置
    [[UIView appearance] setExclusiveTouch:YES];

    // 或者只设置button
    [[UIButton appearance] setExclusiveTouch:YES];
    
87、修改tabBar的frame

// 子类化UITabBarViewController，我这里以修改tabBar高度为例，重写viewWillLayoutSubviews方法

    #import "WZBTabBarViewController.h"

    @interface WZBTabBarViewController ()

    @end

    @implementation WZBTabBarViewController
    - (void)viewWillLayoutSubviews {

    CGRect tabFrame = self.tabBar.frame;
    tabFrame.size.height = 100;
    tabFrame.origin.y = self.view.frame.size.height - 100;
    self.tabBar.frame = tabFrame;
    }
    @end
    
88、修改键盘背景颜色

    // 设置某个键盘颜色
    textField.keyboardAppearance = UIKeyboardAppearanceAlert;

    // 设置工程中所有键盘颜色
    [[UITextField appearance] setKeyboardAppearance:UIKeyboardAppearanceAlert];
    
89、修改image颜色

    UIImage *image = [UIImage imageNamed:@"test"];
    imageView.image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    CGRect rect = CGRectMake(0, 0, image.size.width, image.size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextClipToMask(context, rect, image.CGImage);
    CGContextSetFillColorWithColor(context, [[UIColor redColor] CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    UIImage *flippedImage = [UIImage imageWithCGImage:img.CGImage scale:1.0 orientation: UIImageOrientationDownMirrored];
    imageView.image = flippedImage;
    
90、动画执行removeFromSuperview

    [UIView animateWithDuration:0.2
                     animations:^{
                         view.alpha = 0.0f;
                     } completion:^(BOOL finished){
                         [view removeFromSuperview];
                     }];
                     
                     
91、设置UIButton高亮时的背景颜色

    // 方法一、子类化UIButton，重写setHighlighted:方法，代码如下
    #import "WZBButton.h"

    @implementation WZBButton

    - (void)setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];

    UIColor *normalColor = [UIColor greenColor];
    UIColor *highlightedColor = [UIColor redColor];
    self.backgroundColor = highlighted ? highlightedColor : normalColor;

    }

    // 方法二、利用setBackgroundImage:forState:方法
    [button setBackgroundImage:[self imageWithColor:[UIColor blueColor]] forState:UIControlStateHighlighted];

    - (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();

    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);

    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return image;
    }
    
    
92、关于图片拉伸

    推荐看这个博客，讲的很详细：http://blog.csdn.net/q199109106q/article/details/8615661

93、利用runtime获取一个类所有属性

    - (NSArray *)allPropertyNames:(Class)aClass
    {
    unsigned count;
    objc_property_t *properties = class_copyPropertyList(aClass, &count);

    NSMutableArray *rv = [NSMutableArray array];

    unsigned i;
    for (i = 0; i < count; i++)
    {
        objc_property_t property = properties[i];
        NSString *name = [NSString stringWithUTF8String:property_getName(property)];
        [rv addObject:name];
    }

    free(properties);

    return rv;
    }
    
94、设置textView的某段文字变成其他颜色

    - (void)setupTextView:(UITextView *)textView text:(NSString *)text color:(UIColor *)color {
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc]initWithString:textView.text];
    [string addAttribute:NSForegroundColorAttributeName value:color range:[textView.text rangeOfString:text]];
    [textView setAttributedText:string];
    }
    
95、让push跳转动画像modal跳转动画那样效果(从下往上推上来)

    - (void)push
    {
    TestViewController *vc = [[TestViewController alloc] init];
    vc.view.backgroundColor = [UIColor redColor];
    CATransition* transition = [CATransition animation];
    transition.duration = 0.4f;
    transition.type = kCATransitionMoveIn;
    transition.subtype = kCATransitionFromTop;
    [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
    [self.navigationController pushViewController:vc animated:NO];
    }

    - (void)pop
    {
    CATransition* transition = [CATransition animation];
    transition.duration = 0.4f;
    transition.type = kCATransitionReveal;
    transition.subtype = kCATransitionFromBottom;
    [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
    [self.navigationController popViewControllerAnimated:NO];
    }
    
96、上传图片太大，压缩图片

    -(UIImage *)resizeImage:(UIImage *)image
    {
    float actualHeight = image.size.height;
    float actualWidth = image.size.width;
    float maxHeight = 300.0;
    float maxWidth = 400.0;
    float imgRatio = actualWidth/actualHeight;
    float maxRatio = maxWidth/maxHeight;
    float compressionQuality = 0.5;//50 percent compression

    if (actualHeight > maxHeight || actualWidth > maxWidth)
    {
        if(imgRatio < maxRatio)
        {
            //adjust width according to maxHeight
            imgRatio = maxHeight / actualHeight;
            actualWidth = imgRatio * actualWidth;
            actualHeight = maxHeight;
        }
        else if(imgRatio > maxRatio)
        {
            //adjust height according to maxWidth
            imgRatio = maxWidth / actualWidth;
            actualHeight = imgRatio * actualHeight;
            actualWidth = maxWidth;
        }
        else
        {
            actualHeight = maxHeight;
            actualWidth = maxWidth;
        }
    }

    CGRect rect = CGRectMake(0.0, 0.0, actualWidth, actualHeight);
    UIGraphicsBeginImageContext(rect.size);
    [image drawInRect:rect];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    NSData *imageData = UIImageJPEGRepresentation(img, compressionQuality);
    UIGraphicsEndImageContext();

    return [UIImage imageWithData:imageData];

    }

97.GCD－两个网络请求同步问题    异步gcd组和gcd信号 共同处理请求

    在网络请求的时候有时有这种需求
    两个接口请求数据，然后我们才能做最后的数据处理。但是因为网络请求是移步的 。我们并不知道什么时候两个请求完成 。
    通常面对这样的需求会自然的想到 多线程 啊 。表现真正的技术的时刻来啦，可以使用 group 队列啊 。等队列中的请求任务都完成 ，在通知主线程处理汇总数据嘛 。
    今天我也是这么写的，但是发现主线程并没有等到队列中的分线程网络请求bock回调就返回了 。我给block回调之前打印，确实是队列中的任务都打印之后，才返回的主线程 。那么问题在哪里 ？
    网络请求然后处理响应数据是个耗时的操作，也是我们开发中常见的一种情形，在网络请求以及处理响应数据操作完毕之后我们在执行别的操作这样的过程也是我们开发中常见的情形。我们可以知道，
    网络请求的任务是提交给子线程异步处理了，网络请求这样的任务也就快速执行完毕了，但是网络请求是一个任务，处理收到的网络响应又是一个任务，注意不要把这两个过程混为一谈。
    而收到网络响应以及处理返回响应的数据并不是在子线程中执行的，我们通过在回调响应处理的block中打印当前线程，会发现回调响应处理的block是在主线程中被执行的。
    如果很熟悉block回调这种通信机制的话，就不难理解，这个回调响应的block真正被调用执行的地方应该是AFN框架的底层代码，而这部分代码显然是在主线程中执行的。
    这时候，如果我们需要确定这个主线程中收到网络响应的数据被处理操作结束之后，才最后执行我们需要最后的操作。换句话说，自线程就要等待，收到一个信号，才通知主线程，自己真正的完成任务了 。

    这个信号就是GCD的信号量 dispatch_semaphore_t

    - (void)getNetworkingData{
        NSString *appIdKey = @"8781e4ef1c73ff20a180d3d7a42a8c04";
        NSString* urlString_1 = @"http://api.openweathermap.org/data/2.5/weather";
        NSString* urlString_2 = @"http://api.openweathermap.org/data/2.5/forecast/daily";
        NSDictionary* dictionary =@{@"lat":@"40.04991291",
        @"lon":@"116.25626162",
        @"APPID" : appIdKey};
    
    // 创建组
    dispatch_group_t group = dispatch_group_create();
    
    // 将第一个网络请求任务添加到组中
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 创建信号量
        dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
        // 开始网络请求任务
            AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
            [manager GET:urlString_1 parameters:dictionary progress:nil
                success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSLog(@"成功请求数据1:%@",[responseObject class]);
                // 如果请求成功，发送信号量
                dispatch_semaphore_signal(semaphore);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                NSLog(@"失败请求数据");
                // 如果请求失败，也发送信号量
                dispatch_semaphore_signal(semaphore);
            }];
            // 在网络请求任务成功之前，信号量等待中
            dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    });
    
    // 将第二个网络请求任务添加到组中
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 创建信号量
        dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
        // 开始网络请求任务
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        [manager GET:urlString_2 parameters:dictionary progress:nil
        success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"成功请求数据2:%@",[responseObject class]);
            // 如果请求成功，发送信号量
            dispatch_semaphore_signal(semaphore);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"失败请求数据");
            // 如果请求失败，也发送信号量
            dispatch_semaphore_signal(semaphore);
        }];
        // 在网络请求任务成功之前，信号量等待中
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    });
    
        dispatch_group_notify(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSLog(@"完成了网络请求，不管网络请求失败了还是成功了。");
        });
    }
    
    这样做的具体步骤是这样的 。在自线程队列中 。设置的信号等待 ，一直到block回调完成（主线程中），发送信号 。子线程收到信号，然后才会通知dispatch_group_notify 子线程的请求数据真正返回了。

98.ios 隐私政策模板
    
    (APP名)APP尊重并保护所有使用服务用户的个人隐私权。为了给您提供更准确、更有个性化的服务，本应用会按照本隐私权政策的规定使用和披露您的个人信息。但本应用将以高度的勤勉、审慎义务对待这些信息。除本隐私权政策另有规定外，在未征得您事先许可的情况下，本应用不会将这些信息对外披露或向第三方提供。本应用会不时更新本隐私权政策。 您在同意本应用服务使用协议之时，即视为您已经同意本隐私权政策全部内容。本隐私权政策属于本应用服务使用协议不可分割的一部分。
    1. 适用范围
        (a) 在您使用本应用网络服务，或访问本应用平台网页时，本应用自动接收并记录的您的浏览器和计算机上的信息，包括但不限于您的IP地址、浏览器的类型、使用的语言、访问日期和时间、软硬件特征信息及您需求的网页记录等数据；
        (b) 本应用通过合法途径从商业伙伴处取得的用户个人数据。
    2. 信息使用
        (a)本应用不会向任何无关第三方提供、出售、出租、分享或交易您的个人信息及录音文件，我们数据库都是将您的录音文件加密存放，避免不法分子窃取。如果我们存储发生维修或升级，我们会事先发出推送消息来通知您，请您提前允许本应用消息通知。
        (b) 本应用亦不允许任何第三方以任何手段收集、编辑、出售或者无偿传播您的个人信息。任何本应用平台用户如从事上述活动，一经发现，本应用有权立即终止与该用户的服务协议。
        (c) 为服务用户的目的，本应用可能通过使用您的个人信息，向您提供您感兴趣的信息，包括但不限于向您发出产品和服务信息，或者与本应用合作伙伴共享信        息以便他们向您发送有关其产品和服务的信息（后者需要您的事先同意）。
    3. 信息披露
    在如下情况下，本应用将依据您的个人意愿或法律的规定全部或部分的披露您的个人信息：
        (a) 未经您事先同意，我们不会向第三方披露；
        (b)为提供您所要求的产品和服务，而必须和第三方分享您的个人信息；
        (c) 根据法律的有关规定，或者行政或司法机构的要求，向第三方或者行政、司法机构披露；
        (d) 如您出现违反中国有关法律、法规或者本应用服务协议或相关规则的情况，需要向第三方披露；
        (e) 如您是适格的知识产权投诉人并已提起投诉，应被投诉人要求，向被投诉人披露，以便双方处理可能的权利纠纷；
    4. 信息存储和交换

        本应用收集的有关您的信息和资料将保存在本应用及（或）其关联公司的服务器上，这些信息和资料可能传送至您所在国家、地区或本应用收集信息和资料所在地的境外并在境外被访问、存储和展示。

    5. Cookie的使用

        (a) 在您未拒绝接受cookies的情况下，本应用会在您的计算机上设定或取用cookies ，以便您能登录或使用依赖于cookies的本应用平台服务或功能。本应用使用cookies可为您提供更加周到的个性化服务，包括推广服务。
        (b) 您有权选择接受或拒绝接受cookies。您可以通过修改浏览器设置的方式拒绝接受cookies。但如果您选择拒绝接受cookies，则您可能无法登录或使用依赖于cookies的本应用网络服务或功能。
        (c) 通过本应用所设cookies所取得的有关信息，将适用本政策。
    6.本隐私政策的更改

        (a)如果决定更改隐私政策，我们会在本政策中、本公司网站中以及我们认为适当的位置发布这些更改，以便您了解我们如何收集、使用您的个人信息，哪些人可以访问这些信息，以及在什么情况下我们会透露这些信息。
        (b)本公司保留随时修改本政策的权利，因此请经常查看。如对本政策作出重大更改，本公司会通过网站通知的形式告知。
        方披露自己的个人信息，如联络方式或者邮政地址。请您妥善保护自己的个人信息，仅在必要的情形下向他人提供。如您发现自己的个人信息泄密，尤其是本应用用户名及密码发生泄露，请您立即联络本应用客服，以便本应用采取相应措施。
    7.联系我们

    如果您对本隐私政策有任何意见或问题，或者app 中信息有任何问题，请通过下面邮箱联系我们，并提及“隐私政策 ”。

    电子邮箱：（邮箱名）
    感谢您花时间了解我们的隐私政策！

99.多种请求多个接口的方式 有序 无序 
    
    #pragma mark - 无序请求：使用GCD_GROUP请求多个接口
    - (void)useGCDGroupLoadDataSuccess:(void (^)(void))success failure:(void (^)(void))failure {
        NSLog(@"使用GCD_GROUP请求多个接口");
        dispatch_group_t requestGroup = dispatch_group_create();
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            // 请求接口1
            dispatch_group_enter(requestGroup);
            [self loadData1Success:^{
                dispatch_group_leave(requestGroup);
            } failure:^{
                failure();
            }];
            // 请求接口2
            dispatch_group_enter(requestGroup);
            [self loadData2Success:^{
                dispatch_group_leave(requestGroup);
            } failure:^{
                failure();
            }];
            // 请求接口3
            dispatch_group_enter(requestGroup);
            [self loadData3Success:^{
                dispatch_group_leave(requestGroup);
            } failure:^{
                failure();
            }];
        
            // 所有接口请求完的回调
            dispatch_group_notify(requestGroup, dispatch_get_main_queue(), ^{
                success();
            });
        });
    }

    #pragma mark - 无序请求：使用信号量请求多个接口
    - (void)useSemaphoreLoadDataSuccess:(void (^)(void))success failure:(void (^)(void))failure {
        // 总共3个接口
        NSInteger totalCount = 3;
        __block NSInteger requestCount = 0;
        dispatch_semaphore_t sem = dispatch_semaphore_create(0);
    
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [self loadData1Success:^{
                if (++requestCount == totalCount) {
                    dispatch_semaphore_signal(sem);
                }
            } failure:nil];
            
            [self loadData2Success:^{
                if (++requestCount == totalCount) {
                    dispatch_semaphore_signal(sem);
                }
            } failure:nil];
            
            [self loadData3Success:^{
                if (++requestCount == totalCount) {
                    dispatch_semaphore_signal(sem);
                }
            } failure:nil];
        
            dispatch_semaphore_wait(sem, DISPATCH_TIME_FOREVER);
            dispatch_async(dispatch_get_main_queue(), ^{
                success();
            });
        });
    }
    #pragma mark - 有序请求：使用信号量顺序依次请求
    - (void)loadDataByOrderSuccess:(void (^)(void))success failure:(void (^)(void))failure {
        // first,load data1
        NSBlockOperation * operation1 = [NSBlockOperation blockOperationWithBlock:^{
            dispatch_semaphore_t sema = dispatch_semaphore_create(0);
            [self loadData1Success:^{
                dispatch_semaphore_signal(sema);
            } failure:^{
                !failure ?: failure();
            }];
            dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
        }];
        // then,load data2
        NSBlockOperation * operation2 = [NSBlockOperation blockOperationWithBlock:^{
            dispatch_semaphore_t sema = dispatch_semaphore_create(0);
            [self loadData2Success:^{
                dispatch_semaphore_signal(sema);
            } failure:^{
                !failure ?: failure();
            }];
            dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
        }];
        // finally,load data3
        NSBlockOperation * operation3 = [NSBlockOperation blockOperationWithBlock:^{
            dispatch_semaphore_t sema = dispatch_semaphore_create(0);
            [self loadData3Success:^{
                dispatch_semaphore_signal(sema);
            } failure:^{
                !failure ?: failure();
            }];
            dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
            !success ?: success();
        }];
        [operation2 addDependency:operation1];
        [operation3 addDependency:operation2];
        NSOperationQueue * queue = [[NSOperationQueue alloc] init];
        [queue addOperations:@[operation1, operation2, operation3] waitUntilFinished:NO];
    }

    #pragma mark - 有序请求：使用局部block依次请求接口
    - (void)useLocalBlockLoadDataByOrderSuccess:(void (^)(void))success failure:(void (^)(void))failure {
        // 接口2请求成功
        void (^loadData2Success)(void) = ^{
            // 请求接口3
            [self loadData3Success:^{
                // 所有接口请求成功
                success();
            } failure:^{
                failure();
            }];
        };
        // 接口1请求成功
        void (^loadData1Success)(void) = ^{
            // 请求接口2
            [self loadData2Success:^{
                // 接口2请求成功
                loadData2Success();
            } failure:^{
                failure();
            }];
        };
        // 请求接口1
        [self loadData1Success:^{
            // 接口1请求成功
            loadData1Success();
        } failure:^{
            failure();
        }];
    }

    #pragma mark - 三个接口 模拟数据请求
    // 接口1
    - (void)loadData1Success:(void (^)(void))success failure:(void (^)(void))failure {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSLog(@"接口1请求完毕，耗时0.5秒");
            success();
        });
    }
    // 接口2
    - (void)loadData2Success:(void (^)(void))success failure:(void (^)(void))failure {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSLog(@"接口2请求完毕，耗时0.1秒");
            success();
        });
    }
    // 接口3
    - (void)loadData3Success:(void (^)(void))success failure:(void (^)(void))failure {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSLog(@"接口3请求完毕，耗时0.2秒");
            success();
        });
    }
100.自定义代码块的转移过程

    当我们再更换电脑的时候，我们也是可以把上述我们自定义的代码块转移到别的电脑上的。在我们设置代码块的时候，xcode会自动为我们生成相应的文件。而这文件是可以拷贝到我们新的电脑上的。这样我们换电脑也不用担心了。代码块的具体路径如下：~/Library/Developer/Xcode/UserData/CodeSnippets
    
101.App需要常驻线程 不轻易被iOS系统杀进程（内存回收）
    
    #import <AVFoundation/AVFoundation.h>
    @interface AppDelegate ()
    {
    ///
    UIBackgroundTaskIdentifier _bgTaskId;
    BOOL _played;
    }
    /** audioPlayer */
    @property (nonatomic, strong) AVAudioPlayer *audioPlayer ;
    @property (strong, nonatomic) NSString *startTime;
    @end
    @implementation AppDelegate

    - (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
    {
        [self threadResidentBackgroundMode];
        return YES;
    }

    #pragma mark - 后台无声音乐播放 保证app常驻线程
    - (void)threadResidentBackgroundMode
    {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleInterreption:) name:AVAudioSessionInterruptionNotification object:[AVAudioSession sharedInstance]];
        AVAudioSession *session = [AVAudioSession sharedInstance];
        [session setActive:YES error:nil];
        [session setCategory:AVAudioSessionCategoryPlayback error:nil];
        //让 app 支持接受远程控制事件
        [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
        //播放背景音乐
        NSString *musicPath = [[NSBundle mainBundle] pathForResource:@"wusheng" ofType:@"mp3"];
        NSURL *url = [[NSURL alloc]initFileURLWithPath:musicPath];
        //创建播放器
        AVAudioPlayer *audioPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:nil];
        [audioPlayer prepareToPlay];
        [audioPlayer setVolume:1];
        audioPlayer.numberOfLoops = -1;
        [audioPlayer play];
        self.audioPlayer = audioPlayer;
         _played = YES;
        [NSTimer scheduledTimerWithTimeInterval:1.f target:self selector:@selector(printCurrentTime:) userInfo:nil repeats:YES];
    }
    #pragma mark - 处理中断事件
    - (void)handleInterreption:(NSNotification *)sender
    {
        if(_played){
            [self.audioPlayer pause];
            _played = NO;
        }else{
            [self.audioPlayer play];
            _played = YES;
        }
    }
    - (void)printCurrentTime:(id)sender
    {
        NSLog(@"线程常驻后台===当前的时间是---%@---",[self getCurrentTime]);
    }

    - (NSString *)getCurrentTime
    {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
        [dateFormatter setDateFormat:@"yyyy-MM-DD HH:mm:ss"];
        NSString *dateTime = [dateFormatter stringFromDate:[NSDate date]];
        self.startTime = dateTime;
        return self.startTime;
    }
    -(void)applicationWillResignActive:(UIApplication *)application
    {
        //开启后台处理多媒体事件
        [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
        AVAudioSession *session=[AVAudioSession sharedInstance];
        [session setActive:YES error:nil];
        //后台播放
        [session setCategory:AVAudioSessionCategoryPlayback error:nil];
        //这样做，可以在按home键进入后台后 ，播放一段时间，几分钟吧。但是不能持续播放网络歌曲，若需要持续播放网络歌曲，还需要申请后台任务id，具体做法是：
        _bgTaskId = [AppDelegate backgroundPlayerID:_bgTaskId];
        //其中的_bgTaskId是后台任务UIBackgroundTaskIdentifier _bgTaskId;
    }
    /// 实现一下backgroundPlayerID:这个方法:
    + (UIBackgroundTaskIdentifier)backgroundPlayerID:(UIBackgroundTaskIdentifier)backTaskId
    {
        //设置并激活音频会话类别
        AVAudioSession *session=[AVAudioSession sharedInstance];
        [session setCategory:AVAudioSessionCategoryPlayback error:nil];
        [session setActive:YES error:nil];
        //允许应用程序接收远程控制
        [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
        //设置后台任务ID
        UIBackgroundTaskIdentifier newTaskId=UIBackgroundTaskInvalid;
        newTaskId=[[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:nil];
        if(newTaskId!=UIBackgroundTaskInvalid&&backTaskId!=UIBackgroundTaskInvalid)
        {
            [[UIApplication sharedApplication] endBackgroundTask:backTaskId];
        }
        return newTaskId;
    }

102.创建渐变色的图片

    typedef NS_ENUM(NSInteger,GradientDirection)
    {
        /** 从上至下*/
        topTobottom = 0,
        /** 从左至右*/
        leftToright,
        rightToleft,
        /** 从左上角至右下角*/
        upleftTolowRight,
        /** 从右上角至左下角*/
        uprightTolowLeft
    };

    /**
    *  获取矩形的渐变色的UIImage(此函数还不够完善)
    *
    *  @param bounds       UIImage的bounds
    *  @param colors       渐变色数组，可以设置两种颜色
    *  @param gradientDir  gradientDir
    *
    *  @return 渐变色的UIImage
    */
    + (UIImage *)gradientImageWithBounds:(CGRect)bounds
                           andColors:(NSArray*)colors
                         gradientDir:(GradientDirection)gradientDir;

    /**
    *  获取矩形的渐变色的UIImage(此函数还不够完善)
    *
    *  @param bounds       UIImage的bounds
    *  @param colors       渐变色数组，可以设置两种颜色
    *  @return 渐变色的UIImage
    */
    + (UIImage *)gradientImageWithBounds:(CGRect)bounds
                           andColors:(NSArray*)colors
                         gradientDir:(GradientDirection)gradientDir
    {
        NSMutableArray *ar = [NSMutableArray array];
        for(UIColor *c in colors) {
            [ar addObject:(id)c.CGColor];
        }
        UIGraphicsBeginImageContextWithOptions(bounds.size, YES, 1);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSaveGState(context);
        CGColorSpaceRef colorSpace = CGColorGetColorSpace([[colors lastObject] CGColor]);
        CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (CFArrayRef)ar, NULL);
        CGPoint start;
        CGPoint end;
    
        switch (gradientDir)
        {
            case topTobottom:
            {
                start = CGPointMake(0.0, 0.0);
                end = CGPointMake(0.0, bounds.size.height);
            }
                break;
            case leftToright:
            {
                start = CGPointMake(0.0, 0.0);
                end = CGPointMake(bounds.size.width, 0.0);
            }
                break;
            case rightToleft:
            {   
                start = CGPointMake(bounds.size.width, 0.0);
                end = CGPointMake(0.0, 0.0);;
            }
                break;
            case upleftTolowRight:
            {
                start = CGPointMake(0.0, 0.0);
                end = CGPointMake(bounds.size.width, bounds.size.height);
            }
                break;
            case uprightTolowLeft:
            {
                start = CGPointMake(bounds.size.width, 0.0);
                end = CGPointMake(0.0, bounds.size.height);
            }
                break;
            
            default:
                break;
        }
        CGContextDrawLinearGradient(context, gradient, start, end, kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        CGGradientRelease(gradient);
        CGContextRestoreGState(context);
        CGColorSpaceRelease(colorSpace);
        UIGraphicsEndImageContext();
        return image;
     }
    
103.过滤输入的符号
       
    + (BOOL)panel_filterNewSymbolCodeWithInputString:(NSString *)inputString
    {
        NSArray *array = @[@"=",@"(",@")",@"{",@"}",@"!",@"^",@"/",@"#",@"?",@"~",@"*",@";",@":",@"”",@"|",
        @"%",@"$",@"=",@"<",@">",@",",@"+", @"'", @"&", @"£",@"•", @"¥", @"€"];
        for (NSString *singleCode in array) {
            if ([inputString containsString:singleCode]) {
                return NO;
            }
        }
        if([inputString containsString:@"\\"]||[inputString isEqualToString:@"\\"]){
            return NO;
        }
        return YES;
    }
     
104.限制emoji表情输入（包含键盘和联想） 此方法是通过emoji表情编码所占3或4个字节的过滤
        
    // 只能输入字母和数字
    - (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string 
    {
        if(textField == self.targetAddressTextField.customTextField)
        {
            if ((textField.text.length >= 3) && ![string isEqualToString:@""])
            {
                return NO;
            }
            return [self validateNumber:string];
        }
        if(textField == self.renameTextField.customTextField)
        {
            if ((textField.text.length >= 30) && ![string isEqualToString:@""])
            {
                return NO;
            }
            if([self nowIsEmojiKeyBorad]&&![string isEqualToString:@""]){
                return NO;
            }
            NSUInteger stringUTF8Length = [string lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
            if (stringUTF8Length >= 4&&(stringUTF8Length/string.length != 3)) {
                return NO;
            }
            if (![PanelCommonFunction panel_filterNewSymbolCodeWithInputString:string]) {
                return NO;
            }
            return YES;
        }
        if(textField == self.externalRenameTextField.customTextField)
        {
            if ((textField.text.length >= 30) && ![string isEqualToString:@""])
            {
                return NO;
            }
            if([self nowIsEmojiKeyBorad]&&![string isEqualToString:@""]){
                return NO;
            }
            NSUInteger stringUTF8Length = [string lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
            if (stringUTF8Length >= 4&&(stringUTF8Length/string.length != 3)) {
                return NO;
            }
            if (![PanelCommonFunction panel_filterNewSymbolCodeWithInputString:string]) {
                return NO;
            }
            return YES;
        }
        return YES;
    
    }
    /// emoji表情键盘过滤
    - (BOOL)nowIsEmojiKeyBorad
    {
        for (UITextInputMode *keyboardInputMode in [UITextInputMode activeInputModes]) {
            if ([keyboardInputMode.primaryLanguage isEqualToString:@"emoji"]) {
                NSNumber *isDisplayed = [keyboardInputMode valueForKey:@"isDisplayed"];
    //            Ivar ivarIs =  class_getInstanceVariable([UITextInputMode class], "isDisplayed");
    //            NSNumber *isDisplayed = object_getIvar(keyboardInputMode, ivarIs);
                if ([isDisplayed boolValue] == YES) {
                    return YES;
                }
            }
        }
        return false;

    }

    - (BOOL)friendlyNameValidateNumber:(NSString *)number 
    {
        BOOL res = YES;
        NSCharacterSet *tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890-"];
        int i = 0;
        while (i < number.length) {
            NSString * string = [number substringWithRange:NSMakeRange(i, 1)];
            NSRange range = [string rangeOfCharacterFromSet:tmpSet];
            if (range.length == 0) {
                res = NO;
                break;
            }
            i++;
        }
        return res;
    }

    - (BOOL)validateNumber:(NSString *)number 
    {
        BOOL res = YES;
        NSCharacterSet *tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
        int i = 0;
        while (i < number.length) {
            NSString * string = [number substringWithRange:NSMakeRange(i, 1)];
            NSRange range = [string rangeOfCharacterFromSet:tmpSet];
            if (range.length == 0) {
                res = NO;
                break;
            }
            i++;
        }
        return res;
    }

105.方法二 过滤emoji表情 可过滤绝大多数emoji表情

    /**
    *  判断字符串中是否存在emoji
    * @param string 字符串
    * @return YES(含有表情)
    */
    + (BOOL)stringContainsEmoji:(NSString *)string
    {
        __block BOOL returnValue = NO;
        [string enumerateSubstringsInRange:NSMakeRange(0, [string length])
                              options:NSStringEnumerationByComposedCharacterSequences
                           usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                               const unichar hs = [substring characterAtIndex:0];
                               if (0xd800 <= hs && hs <= 0xdbff) {
                                   if (substring.length > 1) {
                                       const unichar ls = [substring characterAtIndex:1];
                                       const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                                       if (0x1d000 <= uc && uc <= 0x1f9ff) {
                                           returnValue = YES;
                                       }
                                   }
                               } else if (substring.length > 1) {
                                   const unichar ls = [substring characterAtIndex:1];
                                   if (ls == 0x20e3) {
                                       returnValue = YES;
                                   }
                               } else {
                                   if (0x2100 <= hs && hs <= 0x27ff) {
                                       if (0x278b <= hs && hs <= 0x2792) {
                                           //自带九宫格拼音键盘
                                           returnValue = NO;;
                                       }else if (0x263b == hs) {
                                           returnValue = NO;;
                                       }else {
                                           returnValue = YES;
                                       }
                                   } else if (0x2702 <= hs && hs <= 0x27B0){
                                       returnValue = YES;
                                   } else if (0x2B05 <= hs && hs <= 0x2b07) {
                                       returnValue = YES;
                                   } else if (0x2B1B <= hs && hs <= 0x2B1C) {
                                       returnValue = YES;
                                   } else if (0x2934 <= hs && hs <= 0x2935) {
                                       returnValue = YES;
                                   } else if (0x3297 <= hs && hs <= 0x3299) {
                                       returnValue = YES;
                                   } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50|| hs == 0x24c2|| hs == 0x203c || hs == 0x2049) {
                                       returnValue = YES;
                                   }
                               }
                           }];

            return returnValue;
    }

106.方法三 过滤emoji  此方法也可以过滤绝大多数的emoji 与 emoji表情键盘限制配合使用

    - (NSString *)filterEmoji:(NSString *)text{
        if (!text.length) return text;
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"(?:[\\uD83C\\uDF00-\\uD83D\\uDDFF]|[\\uD83E\\uDD00-\\uD83E\\uDDFF]|    [\\uD83D\\uDE00-\\uD83D\\uDE4F]|[\\uD83D\\uDE80-\\uD83D\\uDEFF]|[\\u2600-\\u26FF]\\uFE0F?|[\\u2700-\\u27BF]\\uFE0F?|\\u24C2\\uFE0F?|[\\uD83C\\uDDE6-\\uD83C\\uDDFF]{1,2}|[\\uD83C\\uDD70\\uD83C\\uDD71\\uD83C\\uDD7E\\uD83C\\uDD7F\\uD83C\\uDD8E\\uD83C\\uDD91-\\uD83C\\uDD9A]\\uFE0F?|[\\u0023\\u002A\\u0030-\\u0039]\\uFE0F?\\u20E3|[\\u2194-\\u2199\\u21A9-\\u21AA]\\uFE0F?|[\\u2B05-\\u2B07\\u2B1B\\u2B1C\\u2B50\\u2B55]\\uFE0F?|[\\u2934\\u2935]\\uFE0F?|[\\u3030\\u303D]\\uFE0F?|[\\u3297\\u3299]\\uFE0F?|[\\uD83C\\uDE01\\uD83C\\uDE02\\uD83C\\uDE1A\\uD83C\\uDE2F\\uD83C\\uDE32-\\uD83C\\uDE3A\\uD83C\\uDE50\\uD83C\\uDE51]\\uFE0F?|[\\u203C\\u2049]\\uFE0F?|[\\u25AA\\u25AB\\u25B6\\u25C0\\u25FB-\\u25FE]\\uFE0F?|[\\u00A9\\u00AE]\\uFE0F?|[\\u2122\\u2139]\\uFE0F?|\\uD83C\\uDC04\\uFE0F?|\\uD83C\\uDCCF\\uFE0F?|[\\u231A\\u231B\\u2328\\u23CF\\u23E9-\\u23F3\\u23F8-\\u23FA]\\uFE0F?)" options:NSRegularExpressionCaseInsensitive error:nil];
        NSString *modifiedString = [regex stringByReplacingMatchesInString:text options:0 range:NSMakeRange(0, [text length])withTemplate:@""];
        return modifiedString;
    }




