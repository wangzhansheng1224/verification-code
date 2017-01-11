//
//  SearchResultViewController.m
//  APPLaunchScreen
//
//  Created by love on 2016/11/14.
//  Copyright © 2016年 love. All rights reserved.
//

#import "SearchResultViewController.h"
#import "PYSearchConst.h"
@interface SearchResultViewController ()

@end

@implementation SearchResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.title = @"SearchResultViewController";
    self.view.backgroundColor = PYRandomColor;
    
    
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 50)];
    label.center = CGPointMake(self.view.frame.size.width * 0.5, self.view.frame.size.height * 0.5);
    
    label.textAlignment = NSTextAlignmentCenter;
    [label setFont:[UIFont systemFontOfSize:23 weight:1]];
    label.text = self.searchStr;
    
    label.textColor = [UIColor greenColor];
    
    //    UIImageView * imagev = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 200, 100)];
    //
    ////    [imagev sd]
    //
    [self.view addSubview:label];

    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
