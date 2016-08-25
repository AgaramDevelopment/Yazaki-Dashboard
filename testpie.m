////
////  testpie.m
////  Yazaki
////
////  Created by apple on 3/25/16.
////  Copyright (c) 2016 apple. All rights reserved.
////
////#define M_PI_2
//#define OUTER_RADIOUS 95
//#define IMAGINARY_CIRCLE_RADIOUS 140
//#import "testpie.h"
//#import "ViewController.h"
//#import <UIKit/UIKit.h>
//#import <UIKit/UIFont.h>
//
//@implementation testpie
//@synthesize circleRadious=_circleRadious;
//@synthesize sliceArray=_sliceArray;
//@synthesize colorsArray=_colorsArray;
//
//
//-(void)drawRect:(CGRect)rect
//{  CGContextRef context=UIGraphicsGetCurrentContext();
//    //[self drawPieChart:context]
//    
//    CGPoint circleCenter=CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
//    
//    
//    //set up the radious for the pie chart
//    self.circleRadious=150;
//    
//    //set up the colours for the slice
//    NSArray *colors =[NSArray arrayWithObjects:(id)[UIColor greenColor].CGColor,(id)[UIColor yellowColor].CGColor,(id)[UIColor redColor].CGColor, nil];
//    _colorsArray=[[NSArray alloc] initWithArray:colors];
//    
//    //self.colorsArray =colors;
//    
//    CGFloat startAngle= (3*M_PI_2);
//    CGFloat endAngle =(3*M_PI_2);
//    CGFloat delta=0.0;
//    
//    int index=0;
//    NSString *percentage;
//    NSNumber *percentageValue;
//    NSInteger *labelVale;
//    
//    NSInteger arcCount=self.sliceArray.count; //sliceArray1 is used to store vales,arcCount is for getting the sliceArray1 Count.
//    
//    for (index=0; index<arcCount; index++) {
//        NSNumber *arcData=[self.sliceArray objectAtIndex:index];
//        
//        percentageValue= [NSNumber numberWithFloat:[arcData floatValue]/100];
//        percentage =[percentageValue stringValue];
//        
//        double temPercent=(M_PI*2)*percentage.floatValue;
//        
//        labelVale= [NSString stringWithFormat:@"$%0.2f USD",([percentageValue floatValue]* 100.0f)];
//        
//        
//        if (temPercent<0) {
//            temPercent =temPercent *(-1);
//            
//        }
//        startAngle =endAngle +delta;
//        endAngle=startAngle +temPercent-delta;
//        
//        
//        CGContextSetFillColorWithColor(context, (CGColorRef)[_colorsArray objectAtIndex:index]);
//        
//        CGContextBeginPath(context);
//        CGContextMoveToPoint(context, circleCenter.x, circleCenter.y);
//        CGContextAddArc(context, circleCenter.x, circleCenter.y, self.circleRadious, startAngle, endAngle, 0);
//        CGContextClosePath(context);
//        CGContextFillPath(context);
//    }
//    
//}
///*
//// Only override drawRect: if you perform custom drawing.
//// An empty implementation adversely affects performance during animation.
//- (void)drawRect:(CGRect)rect {
//    // Drawing code
//}
//*/
//
//@end
