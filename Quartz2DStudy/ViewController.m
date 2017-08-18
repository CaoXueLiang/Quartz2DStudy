//
//  ViewController.m
//  Quartz2DStudy
//
//  Created by bjovov on 2017/8/10.
//  Copyright © 2017年 ovov.cn. All rights reserved.
//

#import "ViewController.h"
#import <YYCategories/YYCategories.h>
#import "Quartz2DStydyView.h"

@interface ViewController ()
@property (nonatomic,strong) UIImageView *centerImageView;
@end

@implementation ViewController
#pragma mark - LifeCycle Menthod
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self addDrawView];
    //[self addImageView];
    [self drawPDFMenthod];
}

- (void)addDrawView{
    Quartz2DStydyView *drawView = [[Quartz2DStydyView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:drawView];
}

- (void)addImageView{
    UIImage *image = [self drawBitmapWithName:@"IMG_1393"];
    self.centerImageView.image = image;
    [self.view addSubview:self.centerImageView];
    self.centerImageView.frame = CGRectMake(0, 0, 300, 300);
}

#pragma private Menthod
/*绘制到位图*/
- (UIImage *)drawBitmapWithName:(NSString *)imageName{
    /*要得到位图或者PDF的上下文可以利用UIGraphicsBeginImageContext(CGSize size)和UIGraphicsBeginPDFPageWithInfo(CGRect bounds, NSDictionary *pageInfo)方法。
     位图图形上下文和PDF图形上下文UIKit是不会负责创建的，所以需要用户手动创建，并且在使用完后关闭它。
     在使用UIKit中系统创建的图形上下文的时候，我们只能在drawRect：方法中使用,由于这两类图形上下文是由我们手动创建的因此可以放到任何方法中调用
     */
    
    //获得一个位图上下文
    UIGraphicsBeginImageContext(CGSizeMake(300, 300));
    
    //注意绘图的位置是相对于画布顶点而言，不是屏幕
    UIImage *image = [UIImage imageNamed:imageName];
    [image drawInRect:CGRectMake(0, 0, 300, 300)];
    CGFloat height = image.size.height;
    CGFloat width = image.size.width;
    
    //添加水印
    CGContextRef context = UIGraphicsGetCurrentContext();
    NSString *str = @"呵呵呵...";
    [str drawInRect:CGRectMake(width-100, height - 70, 100, 30) withAttributes:@{NSFontAttributeName : [UIFont fontWithName:@"Marker Felt" size:20],NSForegroundColorAttributeName : [UIColor blueColor]}];
    CGContextMoveToPoint(context, width-100, height-70+30);
    CGContextAddLineToPoint(context, width, height-70+30);
    CGContextSetLineWidth(context, 3);
    CGContextSetStrokeColorWithColor(context, [UIColor greenColor].CGColor);
    CGContextDrawPath(context, kCGPathStroke);
    
    //返回绘制的新图形
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 存储图片到"相机胶卷"
    UIImageWriteToSavedPhotosAlbum(newImage, self, NULL, nil);
    
    //最后一定要关闭图形上下文
    UIGraphicsEndImageContext();
    return newImage;
}


/*利用pdf图形上下文绘制内容到pdf文档*/
- (void)drawPDFMenthod{
  /*绘制内容到PDF时需要创建分页，每页内容的开始都要调用一次UIGraphicsBeginPDFPage();方法*/
    
    //获取沙盒路径
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [[paths lastObject] stringByAppendingPathComponent:@"myPDF.pdf"];
    NSLog(@"%@",path);
    /**
     path:保存路径
     bounds:pdf文档大小，如果设置为CGRectZero则使用默认值：612*792
     pageInfo:页面设置,为nil则不设置任何信息
     */
    UIGraphicsBeginPDFContextToFile(path, CGRectZero, [NSDictionary dictionaryWithObjectsAndKeys:@"xueliang cao",kCGPDFContextAuthor, nil]);
    
    //由于pdf是分页的,所以首先要创建一页画布供我们绘制
    UIGraphicsBeginPDFPage();
    NSString *title=@"Welcome to Apple Support";
    NSMutableParagraphStyle *style=[[NSMutableParagraphStyle alloc]init];
    NSTextAlignment align=NSTextAlignmentCenter;
    style.alignment=align;
    [title drawInRect:CGRectMake(26, 20, 300, 50) withAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSParagraphStyleAttributeName:style}];
    NSString *content=@"Learn about Apple products, view online manuals, get the latest downloads, and more. Connect with other Apple users, or get service, support, and professional advice from Apple.";
    NSMutableParagraphStyle *style2=[[NSMutableParagraphStyle alloc]init];
    style2.alignment=NSTextAlignmentLeft;
    [content drawInRect:CGRectMake(26, 56, 300, 255) withAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:[UIColor grayColor],NSParagraphStyleAttributeName:style2}];
    
    UIImage *image=[UIImage imageNamed:@"IMG_1909.png"];
    [image drawInRect:CGRectMake(316, 20, 300, 300*776/400.0)];
    
    
    //创建新的一页继续绘制其他内容
    UIGraphicsBeginPDFPage();
    UIImage *image2 = [UIImage imageNamed:@"IMG_1909.png"];
    [image2 drawInRect:CGRectMake(6, 20, 400, 776)];
    
    //结束PDF上下文
    UIGraphicsEndPDFContext();
}

#pragma mark - Setter && Getter
- (UIImageView *)centerImageView{
    if (!_centerImageView) {
        _centerImageView = [[UIImageView alloc]init];
    }
    return _centerImageView;
}

@end

