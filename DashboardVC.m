//
//  DashboardVC.m
//  Yazaki
//
//  Created by apple on 4/1/16.
//  Copyright (c) 2016 apple. All rights reserved.
//


#import "DashboardVC.h"
#import "AppDelegate.h"
#import "CustomNavigationVC.h"
#import "DashBoardCell.h"
#import "Common.h"
#import "HomeMonthVC.h"

@interface DashboardVC ()
{
    CustomNavigationVC * objCustomNavigation;
    NSMutableArray * dashBoard_Array;
}
@end

@implementation DashboardVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [super viewDidLoad];
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(150, 225, 20, 30)];
    [spinner setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
    spinner.color = [UIColor blackColor];
    [self.view addSubview:spinner];
    [self customnavigationmethod];
    [objCustomNavigation.Home_Btn setHidden:YES];
    dashBoard_Array =[[NSMutableArray alloc]init];
    dashBoard_Array =self.dashBoardList;
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    AppDelegate *delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [delegate hideLoading];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return dashBoard_Array.count;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    if(IS_OS_5_OR_LATER)
    {
        return UIEdgeInsetsMake(10,10, 10, 20);
    }
    else
    {
    return UIEdgeInsetsMake(10, 50, 10, 50);
    }
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(120, 145);
}
-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    DashBoardCell *cell = (DashBoardCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"dashCell" forIndexPath:indexPath];
    
    NSDictionary *list= [dashBoard_Array objectAtIndex:indexPath.row];
    cell.iconName_Lbl.text = [list valueForKey:@"DISPLAYNAME"];
    
    cell.common_View.layer.cornerRadius=10;
    cell.common_View.backgroundColor=[UIColor colorWithRed:(223/255.0f) green:(37/255.0f) blue:(13/255.0f) alpha:1.0f];
    NSString *imgName_Str;
    
    if([cell.iconName_Lbl.text isEqualToString: @"Canteen"])
    {
        
        imgName_Str = @"canteenImg";
    }
    else if([cell.iconName_Lbl.text isEqualToString: @"Box Completion"])
    {
        
        imgName_Str = @"productionImg";
    }
    
    else if([cell.iconName_Lbl.text isEqualToString: @"Scrap"])
    {
               imgName_Str = @"scrapImg";
    }

    else if([cell.iconName_Lbl.text isEqualToString: @"Efficency"])
    {
        
        imgName_Str = @"efficiencyImg";
    }
    
    
    else if([cell.iconName_Lbl.text isEqualToString: @"QMS"])
    {
        
        imgName_Str = @"quoteIMg";
    }
    
    
    else if([cell.iconName_Lbl.text isEqualToString: @"Training"])
    {
        
        imgName_Str = @"trainingImg";
    }
    
    else if([cell.iconName_Lbl.text isEqualToString: @"Gate Pass"])
    {
        
        imgName_Str = @"gatepassImg";
    }
    
    else if([cell.iconName_Lbl.text isEqualToString: @"Gift"])
    {
        
        imgName_Str = @"giftImg";
    }
    
    else if([cell.iconName_Lbl.text isEqualToString: @"PM"])
    {
        
        imgName_Str = @"projectImg";
    }
    
    else if([cell.iconName_Lbl.text isEqualToString: @"Attendance"])
    {
        imgName_Str = @"attendanceImg";
    }

    
    cell.icon_Img.image    =[UIImage imageNamed:imgName_Str];
    return cell;
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
   // UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    NSDictionary *list= [dashBoard_Array objectAtIndex:indexPath.row];
    
    NSString * selectOptionTye= [list valueForKey:@"DISPLAYNAME"];
    
    UITabBarController *initView =  (UITabBarController*)[self.storyboard instantiateViewControllerWithIdentifier:@"Homevc"];

     HomeMonthVC * destViewController = [initView.viewControllers objectAtIndex:0];
     destViewController.selectType = selectOptionTye;
    
    [self.navigationController pushViewController:initView animated:YES];
    
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

-(void)customnavigationmethod
{
    objCustomNavigation=[[CustomNavigationVC alloc] initWithNibName:@"CustomNavigationVC" bundle:nil];
    [self.view addSubview:objCustomNavigation.view];
    objCustomNavigation.lbl_titleName.text=@"CANTEEN";
    [objCustomNavigation.Btn_Back addTarget:self action:@selector(Back_BtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
}

-(IBAction)Back_BtnAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)Canteen_btn:(id)sender {
    
    
  
   UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    
    UITabBarController *initView =  (UITabBarController*)[storyboard instantiateViewControllerWithIdentifier:@"Homevc"];
    [self.navigationController pushViewController:initView animated:YES];
}
@end
