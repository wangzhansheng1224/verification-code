//
//  ViewController.m
//  APPLaunchScreen
//
//  Created by love on 2016/11/8.
//  Copyright © 2016年 love. All rights reserved.
//

#import "ViewController.h"
#import "UIImageView+WebCache.h"
#import "AFNetworking.h"
#import <PYSearch.h>
#import "SearchResultViewController.h"

#import "GALCaptcha.h"//加载验证码

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

@interface ViewController ()<PYSearchViewControllerDelegate,UITextFieldDelegate,UIAlertViewDelegate>
{
    UIWebView *webView;
    
    GALCaptcha * galCaptcha;
    UITextField * _input;
}

@property (nonatomic,strong) UISearchBar *searchBar;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //显示验证码界面
    galCaptcha = [[GALCaptcha alloc] initWithFrame:CGRectMake(40, 70, 150, 40)];
    [self.view addSubview:galCaptcha];
    
    
    //提示文字
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(210, 70, 100, 40)];
    label.text = @"点击图片换验证码";
    label.font = [UIFont systemFontOfSize:12];
    label.textColor = [UIColor grayColor];
    [self.view addSubview:label];
    
    //添加输入框
    _input = [[UITextField alloc] initWithFrame:CGRectMake(40, 130, 150, 40)];
    _input.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _input.layer.borderWidth = 1.0;
    _input.layer.cornerRadius = 5.0;
    _input.font = [UIFont systemFontOfSize:18];
    _input.placeholder = @"请输入验证码.";
    _input.clearButtonMode = UITextFieldViewModeWhileEditing;
    _input.backgroundColor = [UIColor clearColor];
    _input.textAlignment = NSTextAlignmentCenter;
    _input.returnKeyType = UIReturnKeyDone;
    _input.delegate = self;
    [self.view addSubview:_input];
    
    
    UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 200, 50)];
    button.center = CGPointMake(self.view.frame.size.width * 0.5, self.view.frame.size.height * 0.5);
    [button setTitleColor: [UIColor orangeColor] forState:UIControlStateNormal];
    
    [button setTitle:NSLocalizedString(@"labelTitle", nil) forState:UIControlStateNormal];
    
    [button addTarget:self action:@selector(ButtonSelect:) forControlEvents:UIControlEventTouchUpInside];
//    UIImageView * imagev = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 200, 100)];
//    
////    [imagev sd]
//    
    [self.view addSubview:button];
    
    
//    webView = [[UIWebView alloc] initWithFrame:self.view.frame];
//    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://172.20.95.200:8089/lapp_www?smartid="]];
//    [self.view addSubview: webView];
//    [webView loadRequest:request];

    
    // Do any additional setup after loading the view, typically from a nib.
}


-(void)ButtonSelect:(UIButton*)sender
{
//    exit(3);
    
//    if (1) {
//        [self snapshotScreen];
////        [self screenShot];
//    }
//    return;
    
    
    // 1. 创建热门搜索数组
    NSArray *hotSeaches = @[@"Java", @"Python", @"Objective-C", @"Swift", @"C", @"C++", @"PHP", @"C#", @"Perl", @"Go", @"JavaScript", @"R", @"Ruby", @"MATLAB"];
    // 2. 创建搜索控制器
    PYSearchViewController *searchViewController = [PYSearchViewController searchViewControllerWithHotSearches:hotSeaches searchBarPlaceholder:@"搜索编程语言" didSearchBlock:^(PYSearchViewController *searchViewController, UISearchBar *searchBar, NSString *searchText) {
        // 开始(点击)搜索时执行以下代码
        // 如：跳转到指定控制器
//        [searchViewController.navigationController pushViewController:[[SearchResultViewController alloc] init] animated:YES];
        
        SearchResultViewController * searchResult = [[SearchResultViewController alloc]init];
        
        searchResult.searchStr = searchText;
        
        [searchViewController.navigationController pushViewController:searchResult animated:YES];
       
        
//        [self presentViewController:searchResult animated:YES completion:nil];
        
        
    }];
    
    //3. 设置风格
    // 设置热门搜索为彩色标签风格
    searchViewController.hotSearchStyle = PYHotSearchStyleColorfulTag;
    // 设置搜索历史为带边框标签风格
    searchViewController.searchHistoryStyle = PYSearchHistoryStyleARCBorderTag;
    // 设置搜索模式为内嵌
    searchViewController.searchResultShowMode = PYSearchResultShowModeDefault;
    // 隐藏搜索建议s
    searchViewController.searchSuggestionHidden = NO;
    
    // 4. 设置代理
    searchViewController.delegate = self;
    
    // 5. 跳转到搜索控制器
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:searchViewController];
    [self presentViewController:nav  animated:NO completion:nil];

    
}


#pragma mark - PYSearchViewControllerDelegate
- (void)searchViewController:(PYSearchViewController *)searchViewController searchTextDidChange:(UISearchBar *)seachBar searchText:(NSString *)searchText
{
    if (searchText.length) { // 与搜索条件再搜索
        // 根据条件发送查询（这里模拟搜索）
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{ // 搜素完毕
            // 显示建议搜索结果
            NSMutableArray *searchSuggestionsM = [NSMutableArray array];
            for (int i = 0; i < arc4random_uniform(5) + 10; i++) {
                NSString *searchSuggestion = [NSString stringWithFormat:@"搜索建议 %d", i];
                [searchSuggestionsM addObject:searchSuggestion];
            }
            // 返回
            searchViewController.searchSuggestions = searchSuggestionsM;
        });
    }
}



/**
 *截图功能
 */
-(void)screenShot{
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(640, 960), YES, 0);
    
    //设置截屏大小
    
    [[self.view layer] renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    CGImageRef imageRef = viewImage.CGImage;
    CGRect rect = CGRectMake(0, 0, 641, 300);//这里可以设置想要截图的区域
    
    CGImageRef imageRefRect =CGImageCreateWithImageInRect(imageRef, rect);
    UIImage *sendImage = [[UIImage alloc] initWithCGImage:imageRefRect];
    
    
    //以下为图片保存代码
    
    UIImageWriteToSavedPhotosAlbum(sendImage, nil, nil, nil);//保存图片到照片库
    
    NSData *imageViewData = UIImagePNGRepresentation(sendImage);
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *pictureName= @"screenShow.png";
    NSString *savedImagePath = [documentsDirectory stringByAppendingPathComponent:pictureName];
    [imageViewData writeToFile:savedImagePath atomically:YES];//保存照片到沙盒目录
    
    CGImageRelease(imageRefRect);
    
    
    
    //从手机本地加载图片
    
    UIImage *bgImage2 = [[UIImage alloc]initWithContentsOfFile:savedImagePath];
    
    
}


- (void)snapshotScreen
{
    // 判断是否为retina屏, 即retina屏绘图时有放大因子
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]){
        UIGraphicsBeginImageContextWithOptions(self.view.window.bounds.size, NO, [UIScreen mainScreen].scale);
    } else {
        UIGraphicsBeginImageContext(self.view.window.bounds.size);
    }
    [self.view.window.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    // 保存到相册
    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




#pragma mark 输入框协议中方法,点击return按钮
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    //验证码比较应该不区分大小写
    int result = [_input.text compare:galCaptcha.CatString options:NSCaseInsensitiveSearch];
    
    NSLog(@"%d",result);
    //正确弹出警告款提示正确
    if (result == 0) {
        UIAlertView *alview = [[UIAlertView alloc] initWithTitle:@"恭喜您 ^o^" message:@"验证成功" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alview show];
    }else
    {
//        UIAlertView *alview = [[UIAlertView alloc] initWithTitle:nil message:@"验证失败" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//        [alview show];
        
        //验证不匹配，验证码和输入框晃动
        CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
        anim.repeatCount = 1;
        anim.values = @[@-20, @20, @-20];
        [galCaptcha.layer addAnimation:anim forKey:nil];
        [_input.layer addAnimation:anim forKey:nil];

    }
    
    
//    //判断输入的是否为验证图片显示的验证码
//    if ([_input.text isEqualToString:galCaptcha.CatString]) {
//        //正确弹出警告款提示正确
//        UIAlertView *alview = [[UIAlertView alloc] initWithTitle:@"恭喜您 ^o^" message:@"验证成功" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//        [alview show];
//    }
//    else
//    {
//        //验证不匹配，验证码和输入框晃动
//        CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
//        anim.repeatCount = 1;
//        anim.values = @[@-20, @20, @-20];
//        [galCaptcha.layer addAnimation:anim forKey:nil];
//        [_input.layer addAnimation:anim forKey:nil];
//    }
    return YES;
}

#pragma mark 警告框中方法
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //清空输入框内容，收回键盘
    if (buttonIndex==0) {
        _input.text = @"";
        [_input resignFirstResponder];
    }
}


@end
