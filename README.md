#APPLaunchScreen


https://github.com/wangzhansheng1224/verification-code.git


## <a id="如何使用PYSearch"></a>如何使用PYSearch
* 使用CocoaPods:
- `pod "PYSearch"`
- 导入主头文件`#import <PYSearch.h>`
* 手动导入：
- 将`PYSearch`文件夹中的所有文件拽入项目中
- 导入主头文件`#import "PYSearch.h"`


## <a id="具体使用（详情见示例程序PYSearchExample）"></a>具体使用（详情见示例程序PYSearchExample）
```objc
// 1. 创建热门搜索数组
NSArray *hotSeaches = @[@"Java", @"Python", @"Objective-C", @"Swift", @"C", @"C++", @"PHP", @"C#", @"Perl", @"Go", @"JavaScript", @"R", @"Ruby", @"MATLAB"];
// 2. 创建搜索控制器
PYSearchViewController *searchViewController = [PYSearchViewController searchViewControllerWithHotSearches:hotSeaches searchBarPlaceholder:@"搜索编程语言" didSearchBlock:^(PYSearchViewController *searchViewController, UISearchBar *searchBar, NSString *searchText) {
// 开始(点击)搜索时执行以下代码
// 如：跳转到指定控制器
[searchViewController.navigationController pushViewController:[[UIViewController alloc] init] animated:YES];

}];
// 3. 跳转到搜索控制器
UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:searchViewController];
[self presentViewController:nav  animated:NO completion:nil];

```



## <a id="自定义PYSearch"></a>自定义PYSearch

### 通过设置searchViewContoller的对象属性值即可修改

* 设置热门搜索风格（默认为PYHotSearchStyleNormalTag）
```objc
// 设置热门搜索为彩色标签风格
searchViewController.hotSearchStyle = PYHotSearchStyleColorfulTag;
```

* 设置搜索历史风格（默认为PYSearchHistoryStyleCell）
```objc
// 设置搜索历史为带边框标签风格
searchViewController.searchHistoryStyle = PYSearchHistoryStyleBorderTag;
```

* 设置搜索结果显示模式（默认为PYSearchResultShowModePush）
```objc
// 设置搜索模式为内嵌
searchViewController.searchResultShowMode = PYSearchResultShowModeEmbed;
```

* 隐藏搜索建议（默认为：NO）
```objc
// 隐藏搜索建议
searchViewController.searchSuggestionHidden = YES;
```

## <a id="期待"></a>期待
