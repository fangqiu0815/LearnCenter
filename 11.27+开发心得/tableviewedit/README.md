#tableviewEdit
开发过程中或多或少都会遇到tableview的各种功能，这里简单记录一下tableview的删除和全选删除功能，废话不多说先看一下效果图

![tableviewGIF.gif](http://upload-images.jianshu.io/upload_images/2007045-491596a160a4c810.gif?imageMogr2/auto-orient/strip)

既然拿到了需求，就应该想一下如何去实现了，对照上面图片的内容，应该如何实现呢？
看完上图之后发现用到的几个功能：
第一个：左滑删除
第二个：全选删除

####左边滑动删除
实现几个代理方法后就可以了

```
-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
return @"删除";
}
改变左滑后按钮的文字
```
```
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
return UITableViewCellEditingStyleDelete;  
}
滑动删除样式，有多中可选，这里返回删除样式
```

```
- (void)tableView:(UITableView*)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath*)indexPath {
if (editingStyle == UITableViewCellEditingStyleDelete) {
[self.dataArray removeObjectAtIndex: indexPath.row];
[self.tableView deleteRowsAtIndexPaths:[NSMutableArray arrayWithObject:indexPath]
withRowAnimation:UITableViewRowAnimationFade];
[self.tableView reloadData];

}
}
删除点击方法，处理想要删除的数据
这里有一个需要注意点，一定要先更新数据源，在更新UI
```

左滑删除就这些代码了，是不是很easy，在来看全选的代码

####全选删除
这里我用的是全选功能是系统的方法，没有自定义按钮


点击编辑按钮的时候设置tableview
```
[_tableView setEditing:YES animated:YES];

```

返回全选的样式
```
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
return UITableViewCellEditingStyleDelete|UITableViewCellEditingStyleInsert;
}
这样就会出现左侧的选中框
```

再来就是全选按钮的实现方法
```
for (int i = 0; i< self.dataArray.count; i++) {
NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
[_tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionTop];
}

if (self.deleteArray.count >0) {
[self.deleteArray removeAllObjects];
}
[self.deleteArray addObjectsFromArray:self.dataArray];

[btn setTitle:@"取消" forState:UIControlStateNormal];
```

当然取消全选也有方法
```
for (int i = 0; i< self.dataArray.count; i++) {
NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
[_tableView deselectRowAtIndexPath:indexPath animated:NO];

}
```
通过全选按钮实现的选中方法，需要在方法里把所有数据都添加到想要删除的数组里面

通过点击tableviewcell选择删除对象的时候需要把想要删除的数据添加到删除数组里面
```
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

if (self.btn.selected) {
NSLog(@"选中");
[self.deleteArray addObject:[self.dataArray objectAtIndex:indexPath.row]];

}else{
NSLog(@"跳转下一页");
}
}
```

再次点击取消选中的数据
```
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath  {

if (self.btn.selected) {
NSLog(@"撤销");
[self.deleteArray removeObject:[self.dataArray objectAtIndex:indexPath.row]];

}else{
NSLog(@"取消跳转");
}

}
```

####问题一：
按照以上方法实现之后就可以实现想要的功能，但是还有UI的问题，那就是选择之后会出现下图的问题
![Simulator Screen Shot 2017年6月26日 下午3.34.40.png](http://upload-images.jianshu.io/upload_images/2007045-6a6e909fa42a6ef3.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

会有一层背景色的覆盖，这里感谢一位简友的方法，想要了解的请看看这篇文章
<http://www.jianshu.com/p/af08a40a8821>

####问题二：
还有一个问题 ,在自定义的cell上面添加控件的时候一定要添加到self.contentView上面,否则会出现控件不随cell移动的问题
```
[self.contentView addSubview:self.label];
```

####结束
到这里这篇文章的内容基本算完结了，如果还是有不明白的我在此留下Demo链接，里面有更详细的注释，Demo没有做UI适配，想看效果的画在模拟器6，7上面运行最好

Demo地址：<http://git.oschina.net/T1_mine/tableviewedit>
