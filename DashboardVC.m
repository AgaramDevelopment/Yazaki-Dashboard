//
//  DashboardVC.m
//  Yazaki
//
//  Created by apple on 4/1/16.
//  Copyright (c) 2016 apple. All rights reserved.
//

#import "DashboardVC.h"
#import "AppDelegate.h"
@interface DashboardVC ()

@end

@implementation DashboardVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [super viewDidLoad];
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(150, 225, 20, 30)];
    [spinner setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
    spinner.color = [UIColor blackColor];
    [self.view addSubview:spinner];  // Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    AppDelegate *delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [delegate hideLoading];
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

- (IBAction)Canteen_btn:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    
    UITabBarController *initView =  (UITabBarController*)[storyboard instantiateViewControllerWithIdentifier:@"Homevc"];
    
    [initView setModalPresentationStyle:UIModalPresentationFullScreen];
    
    [self presentViewController:initView animated:NO completion:nil];
}
@end
