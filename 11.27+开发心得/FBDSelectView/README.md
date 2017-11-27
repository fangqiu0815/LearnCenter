这个是我自己封装的控件，下面简单介绍一下相关的Class类；

类介绍: ＊＊＊＊＊FBDSelectView 是基于UIView的自定义选项卡类＊＊＊＊；
类使用：

/**
*  FBDSelectView构造函数
*
*  @param frame  大小
*  @param number item的个数
*
*  @return 返回的实例
*/
-(instancetype)initWithFrame:(CGRect)frame withTitles:(NSMutableArray*)titleArray;

/**
*  FBDSelectView构造函数
*
*  @param frame  大小
*  @param number item的个数
*  @param comeBlock selectBlock的回调
*
*  @return 返回的实例
*/-(instancetype)initWithFrame:(CGRect)frame  withTitles:(NSMutableArray*)titleArray selectItemBlock:(selectItemBlock)comeBlock;

PS ：  ＊＊＊＊＊＊SelectItemView类是FBDSelectView上面上的子类；SelectItemView上面有一个Label和一个ImageView成员变量；







类介绍：＊＊＊＊＊FBDItemScrollVIew 是基于UIScrollVIew 封装的自定义ScrollView ＊＊＊＊＊;
类使用：

/**
*  初始化构造方法
*
*  @param frame      大小位置
*  @param titleArray 标题数组
*
*  @return 实例本身
*/
-(instancetype)initWithFrame:(CGRect)frame andItemTitleArray:(NSMutableArray*)titleArray;