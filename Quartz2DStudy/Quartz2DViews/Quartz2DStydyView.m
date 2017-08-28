//
//  Quartz2DStydyView.m
//  Quartz2DStudy
//
//  Created by bjovov on 2017/8/17.
//  Copyright © 2017年 ovov.cn. All rights reserved.
//

#import "Quartz2DStydyView.h"
#import <YYCategories/YYCategories.h>

#define centerX self.frame.size.width/2.0
#define centerY self.frame.size.height/2.0
#define TILE_SIZE 20

@implementation Quartz2DStydyView
#pragma mark - Init Menthod
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

#pragma mark - Draw Menthod
- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    
    /*1.基本图形绘制*/
    //[self drawBasicGraphic];
    
    /*2.绘制虚线*/
    //[self drawDashLine];
    
    /*3.绘制阴影*/
    //[self drawShadowMenthod];
    
    /*4.透明层的使用*/
    //[self transparencyMenthod];
    
    /*5.文字绘制*/
    //[self drawText];
    
    /*6.图像绘制*/
    //[self drawImage];
    
    /*7.绘制轴向渐变*/
    //[self drawAxialGradualChange];
    
    /*8.绘制径向渐变*/
    //[self drawRadialGradualChange];
    
    /*9.扩展-渐变填充*/
    //[self drawGradualFill];
    
    /*10.叠加混合模式*/
    //[self superpositionPattern];
    
    /*11.填充模式*/
    [self coloredFillPattern];
    //[self unColoredFillPattern];
    
    /*12.上下文变换*/
    //[self transformMenthod];
 
    /*13.使用Core Graphics绘制图像*/
    //[self CoreGraphicsDrawImage];
    
    /*14.绘制到位图*/
    //[self drawBitmap];
}

#pragma mark - Private Menthod
/*基本图形绘制*/
- (void)drawBasicGraphic{
    /*
     1.获取图形上下文
     2.绘制路径
     3.设置图形上下文
     4.绘制路径
     */
    
    //绘制矩形
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextAddRect(context, CGRectMake(50, 50, 100, 70));
    CGContextSetStrokeColorWithColor(context, [UIColor blueColor].CGColor);
    CGContextDrawPath(context, kCGPathStroke);
    
    //绘制椭圆
    CGContextAddEllipseInRect(context, CGRectMake(50, 150, 100, 70));
    CGContextSetStrokeColorWithColor(context, [UIColor blueColor].CGColor);
    CGContextDrawPath(context, kCGPathStroke);
    
    /*绘制弧形,圆形
     x:中心点x坐标
     y:中心点y坐标
     radius:半径
     startAngle:起始弧度
     endAngle:终止弧度
     closewise:是否逆时针绘制，0则顺时针绘制
     */
    CGContextAddArc(context, 100, 300, 50, 0, M_PI_2*3, 0);
    CGContextSetFillColorWithColor(context, [UIColor yellowColor].CGColor);
    CGContextDrawPath(context, kCGPathFillStroke);
    
    /*绘制二次贝塞尔曲线
     c:图形上下文
     cpx:控制点x坐标
     cpy:控制点y坐标
     x:结束点x坐标
     y:结束点y坐标
     */
    CGContextMoveToPoint(context, 50, 450);
    CGContextAddQuadCurveToPoint(context, 150, 300, 250, 450);
    CGContextDrawPath(context, kCGPathStroke);
    
    /*绘制三次贝塞尔曲线
     c:图形上下文
     cp1x:第一个控制点x坐标
     cp1y:第一个控制点y坐标
     cp2x:第二个控制点x坐标
     cp2y:第二个控制点y坐标
     x:结束点x坐标
     y:结束点y坐标
     */
    CGContextMoveToPoint(context, 50, 500);
    CGContextAddCurveToPoint(context, 150, 350, 250, 500, 300, 300);
    CGContextDrawPath(context, kCGPathStroke);
}

/*文字绘制*/
- (void)drawText{
    //绘制到指定的区域内容
    NSString *str=@"Star Walk is the most beautiful stargazing app you’ve ever seen on a mobile device. It will become your go-to interactive astro guide to the night sky, following your every movement in real-time and allowing you to explore over 200, 000 celestial bodies with extensive information about stars and constellations that you find.";
    CGRect rect = CGRectMake(20, 50, kScreenWidth-40, kScreenHeight-100);
    [str drawInRect:rect withAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13],NSForegroundColorAttributeName:[UIColor blueColor]}];
}

/*图片绘制*/
- (void)drawImage{
    UIImage *image = [UIImage imageNamed:@"IMG_1909"];
    /*从某一点开始绘制*/
    [image drawAtPoint:CGPointMake(50, 50)];
    
    /*绘制在指定的矩形区域内，如果大小不合适会进行拉伸*/
    [image drawInRect:CGRectMake(50, 50, kScreenWidth-100, 200)];
    
    /*平铺图片*/
    [image drawAsPatternInRect:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
}

/*绘制虚线*/
- (void)drawDashLine{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextMoveToPoint(context, 50, 100);
    CGContextAddLineToPoint(context,kScreenWidth-50, 100);
    /*phase值为13，则首先绘制【15减去13】，再跳过5，绘制15，反复绘制*/
    CGFloat length[2] = {15,5};
    CGContextSetLineDash(context,13,length,2);
    CGContextSetLineWidth(context, 3);
    CGContextDrawPath(context, kCGPathStroke);
    
    CGContextMoveToPoint(context, 50, 200);
    CGContextAddLineToPoint(context, kScreenWidth - 50, 200);
    /*表示填充线和非填充线相交*/
    CGFloat lenght[3] = {5,10,5};
    CGContextSetLineDash(context, 0, lenght, 3);
    CGContextStrokePath(context);
    
    CGPoint p[2] = {CGPointMake(50, 150),CGPointMake(kScreenWidth - 50, 150)};
    CGContextStrokeLineSegments(context,p, 2);
}


/*绘制阴影*/
- (void)drawShadowMenthod{
    /*1.保存图形状态
     2.调用函数CGContextSetShadow，传递相应的值
     3.使用阴影绘制所有的对象
     4.恢复图形状态*/
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextAddArc(context, centerX, centerY, 100, 0, M_PI*2, 0);
    /*blur的值越大，阴影的虚化层度越大*/
    CGContextSetShadow(context, CGSizeMake(10,10), 10);
    CGContextSetShadowWithColor(context, CGSizeMake(10,10), 10, [UIColor redColor].CGColor);
    CGContextSetFillColorWithColor(context, [UIColor grayColor].CGColor);
    CGContextDrawPath(context, kCGPathFill);
    
    CGContextSetShadowWithColor(context, CGSizeMake(10, 10), 10, [UIColor blueColor].CGColor);
    CGContextSetFillColorWithColor(context, [UIColor yellowColor].CGColor);
    CGContextFillRect(context, CGRectMake(100, 50, 200, 100));
}


/*透明层的使用*/
- (void)transparencyMenthod{
    /*
     调用函数CGContextBeginTransparencyLayer
     在透明层中绘制需要组合的对象
     调用函数CGContextEndTransparencyLayer
     */
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetShadowWithColor(context, CGSizeMake(-10, 10), 10, [UIColor grayColor].CGColor);
    
    CGContextBeginTransparencyLayer(context, NULL);
    CGContextAddArc(context, centerX-50, centerY+50, 100, 0, M_PI*2, 0);
    CGContextSetFillColorWithColor(context, [UIColor blueColor].CGColor);
    CGContextDrawPath(context, kCGPathFill);
    
    CGContextAddArc(context, centerX+50, centerY+50, 100, 0, M_PI*2, 0);
    CGContextSetFillColorWithColor(context, [UIColor orangeColor].CGColor);
    CGContextDrawPath(context, kCGPathFill);
    
    CGContextAddArc(context, centerX, centerY-50, 100, 0, M_PI*2, 0);
    CGContextSetFillColorWithColor(context, [UIColor redColor].CGColor);
    CGContextDrawPath(context, kCGPathFill);
    CGContextEndTransparencyLayer(context);
}


/*轴向渐变*/
- (void)drawAxialGradualChange{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGColorSpaceRef coloSpace = CGColorSpaceCreateDeviceRGB();
    
    /*指定渐变色
     space:颜色空间
     components:颜色数组,注意由于指定了RGB颜色空间，那么四个数组元素表示一个颜色（red、green、blue、alpha），
     如果有三个颜色则这个数组有4*3个元素
     locations:颜色所在位置（范围0~1），这个数组的个数不小于components中存放颜色的个数
     count:渐变个数，等于locations的个数
     */
    CGFloat compoents[12]={
        248.0/255.0,86.0/255.0,86.0/255.0,1,
        249.0/255.0,127.0/255.0,127.0/255.0,1,
        1.0,1.0,1.0,1.0
    };
    CGFloat locations[3] = {0,3/10.0,1};
    CGGradientRef gradient = CGGradientCreateWithColorComponents(coloSpace, compoents, locations, 3);
    
    /*绘制线性渐变
     context:图形上下文
     gradient:渐变色
     startPoint:起始位置
     endPoint:终止位置
     options:绘制方式,kCGGradientDrawsBeforeStartLocation 开始位置之前就进行绘制，到结束位置之后不再绘制，
     kCGGradientDrawsAfterEndLocation开始位置之前不进行绘制，到结束点之后继续填充
     */
    CGContextDrawLinearGradient(context, gradient, CGPointMake(50, 100), CGPointMake(300, 100), kCGGradientDrawsAfterEndLocation);
    
    //释放颜色空间(**使用create和copy创建的对象记得释放**)
    CGColorSpaceRelease(coloSpace);
}


/*绘制径向渐变*/
- (void)drawRadialGradualChange{
    //获取图形上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //创建RGB颜色空间
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    /*指定渐变色
     space:颜色空间
     components:颜色数组,注意由于指定了RGB颜色空间，那么四个数组元素表示一个颜色（red、green、blue、alpha），
     如果有三个颜色则这个数组有4*3个元素
     locations:颜色所在位置（范围0~1），这个数组的个数不小于components中存放颜色的个数
     count:渐变个数，等于locations的个数
     */
    CGFloat compoents[12]={
        248.0/255.0,86.0/255.0,86.0/255.0,1,
        249.0/255.0,127.0/255.0,127.0/255.0,1,
        1.0,1.0,1.0,1.0
    };
    CGFloat locations[3]={0,0.3,1.0};
    CGGradientRef gradient= CGGradientCreateWithColorComponents(colorSpace, compoents, locations, 3);
    
    /*绘制径向渐变
     context:图形上下文
     gradient:渐变色
     startCenter:起始点位置
     startRadius:起始半径（通常为0，否则在此半径范围内容无任何填充）
     endCenter:终点位置（通常和起始点相同，否则会有偏移）
     endRadius:终点半径（也就是渐变的扩散长度）
     options:绘制方式,kCGGradientDrawsBeforeStartLocation 开始位置之前就进行绘制，但是到结束位置之后不再绘制，
     kCGGradientDrawsAfterEndLocation开始位置之前不进行绘制，但到结束点之后继续填充
     */
    CGContextDrawRadialGradient(context, gradient, CGPointMake(160, 284),0, CGPointMake(165, 289), 150, kCGGradientDrawsAfterEndLocation);
    
    //释放颜色空间
    CGColorSpaceRelease(colorSpace);
}


/*扩展-渐变填充*/
- (void)drawGradualFill{
   /*上面我们只是绘制渐变到图形上下文
     实际开发中有时候我们还需要填充对应的渐变色，例如现在绘制了一个矩形，如何填充成渐变色
     可以利用渐变裁切来完成
    */
    
    //裁切处一块矩形用于显示，注意必须先裁切再调用渐变
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextClipToRect(context, CGRectMake(50, 100, kScreenWidth-100, 300));
    
    CGColorSpaceRef colorSpace=CGColorSpaceCreateDeviceRGB();
    CGFloat compoents[12]={
        248.0/255.0,86.0/255.0,86.0/255.0,1,
        249.0/255.0,127.0/255.0,127.0/255.0,1,
        1.0,1.0,1.0,1.0
    };
    CGFloat locations[3]={0,0.3,1.0};
    CGGradientRef gradient= CGGradientCreateWithColorComponents(colorSpace, compoents, locations, 3);
    CGContextDrawLinearGradient(context, gradient, CGPointMake(20, 50), CGPointMake(300, 300), kCGGradientDrawsAfterEndLocation);
    CGColorSpaceRelease(colorSpace);
}


/*叠加混合模式*/
- (void)superpositionPattern{
    /*
     使用Quartz 2D绘图时后面绘制的图像会覆盖前面的，默认情况下如果前面的被覆盖后将看不到后面的内容，
     但是有时候这个结果并不是我们想要的，因此在Quartz 2D中提供了填充模式供开发者配置调整
     */
    CGRect rect= CGRectMake(0, 130.0, 320.0, 50.0);
    CGRect rect1= CGRectMake(0, 390.0, 320.0, 50.0);
    
    
    CGRect rect2=CGRectMake(20, 50.0, 10.0, 250.0);
    CGRect rect3=CGRectMake(40.0, 50.0, 10.0, 250.0);
    CGRect rect4=CGRectMake(60.0, 50.0, 10.0, 250.0);
    CGRect rect5=CGRectMake(80.0, 50.0, 10.0, 250.0);
    CGRect rect6=CGRectMake(100.0, 50.0, 10.0, 250.0);
    CGRect rect7=CGRectMake(120.0, 50.0, 10.0, 250.0);
    CGRect rect8=CGRectMake(140.0, 50.0, 10.0, 250.0);
    CGRect rect9=CGRectMake(160.0, 50.0, 10.0, 250.0);
    CGRect rect10=CGRectMake(180.0, 50.0, 10.0, 250.0);
    CGRect rect11=CGRectMake(200.0, 50.0, 10.0, 250.0);
    CGRect rect12=CGRectMake(220.0, 50.0, 10.0, 250.0);
    CGRect rect13=CGRectMake(240.0, 50.0, 10.0, 250.0);
    CGRect rect14=CGRectMake(260.0, 50.0, 10.0, 250.0);
    CGRect rect15=CGRectMake(280.0, 50.0, 10.0, 250.0);
    
    CGRect rect16=CGRectMake(30.0, 310.0, 10.0, 250.0);
    CGRect rect17=CGRectMake(50.0, 310.0, 10.0, 250.0);
    CGRect rect18=CGRectMake(70.0, 310.0, 10.0, 250.0);
    CGRect rect19=CGRectMake(90.0, 310.0, 10.0, 250.0);
    CGRect rect20=CGRectMake(110.0, 310.0, 10.0, 250.0);
    CGRect rect21=CGRectMake(130.0, 310.0, 10.0, 250.0);
    CGRect rect22=CGRectMake(150.0, 310.0, 10.0, 250.0);
    CGRect rect23=CGRectMake(170.0, 310.0, 10.0, 250.0);
    CGRect rect24=CGRectMake(190.0, 310.0, 10.0, 250.0);
    CGRect rect25=CGRectMake(210.0, 310.0, 10.0, 250.0);
    CGRect rect26=CGRectMake(230.0, 310.0, 10.0, 250.0);
    CGRect rect27=CGRectMake(250.0, 310.0, 10.0, 250.0);
    CGRect rect28=CGRectMake(270.0, 310.0, 10.0, 250.0);
    CGRect rect29=CGRectMake(290.0, 310.0, 10.0, 250.0);
    
    
    [[UIColor yellowColor]set];
    UIRectFill(rect);
    
    [[UIColor greenColor]setFill];
    UIRectFill(rect1);
    
    [[UIColor redColor]setFill];
    UIRectFillUsingBlendMode(rect2, kCGBlendModeClear);
    UIRectFillUsingBlendMode(rect3, kCGBlendModeColor);
    UIRectFillUsingBlendMode(rect4, kCGBlendModeColorBurn);
    UIRectFillUsingBlendMode(rect5, kCGBlendModeColorDodge);
    UIRectFillUsingBlendMode(rect6, kCGBlendModeCopy);
    UIRectFillUsingBlendMode(rect7, kCGBlendModeDarken);
    UIRectFillUsingBlendMode(rect8, kCGBlendModeDestinationAtop);
    UIRectFillUsingBlendMode(rect9, kCGBlendModeDestinationIn);
    UIRectFillUsingBlendMode(rect10, kCGBlendModeDestinationOut);
    UIRectFillUsingBlendMode(rect11, kCGBlendModeDestinationOver);
    UIRectFillUsingBlendMode(rect12, kCGBlendModeDifference);
    UIRectFillUsingBlendMode(rect13, kCGBlendModeExclusion);
    UIRectFillUsingBlendMode(rect14, kCGBlendModeHardLight);
    UIRectFillUsingBlendMode(rect15, kCGBlendModeHue);
    UIRectFillUsingBlendMode(rect16, kCGBlendModeLighten);
    
    UIRectFillUsingBlendMode(rect17, kCGBlendModeLuminosity);
    UIRectFillUsingBlendMode(rect18, kCGBlendModeMultiply);
    UIRectFillUsingBlendMode(rect19, kCGBlendModeNormal);
    UIRectFillUsingBlendMode(rect20, kCGBlendModeOverlay);
    UIRectFillUsingBlendMode(rect21, kCGBlendModePlusDarker);
    UIRectFillUsingBlendMode(rect22, kCGBlendModePlusLighter);
    UIRectFillUsingBlendMode(rect23, kCGBlendModeSaturation);
    UIRectFillUsingBlendMode(rect24, kCGBlendModeScreen);
    UIRectFillUsingBlendMode(rect25, kCGBlendModeSoftLight);
    UIRectFillUsingBlendMode(rect26, kCGBlendModeSourceAtop);
    UIRectFillUsingBlendMode(rect27, kCGBlendModeSourceIn);
    UIRectFillUsingBlendMode(rect28, kCGBlendModeSourceOut);
    UIRectFillUsingBlendMode(rect29, kCGBlendModeXOR);
}


void drawColoredTitle(void *info,CGContextRef context){
     //有颜色填充，在这里设置颜色，创建瓷砖
    CGContextSetRGBFillColor(context, 254.0/255.0, 52.0/255.0, 90.0/255.0, 1);
    CGContextFillRect(context, CGRectMake(0, 0, TILE_SIZE, TILE_SIZE));
    CGContextFillRect(context, CGRectMake(TILE_SIZE, TILE_SIZE, TILE_SIZE, TILE_SIZE));
    
    CGContextSetFillColorWithColor(context, [UIColor blackColor].CGColor);
    CGContextFillRect(context, CGRectMake(0, TILE_SIZE, TILE_SIZE, TILE_SIZE));
    CGContextFillRect(context, CGRectMake(TILE_SIZE, 0, TILE_SIZE, TILE_SIZE));
}

/*有颜色填充模式*/
- (void)coloredFillPattern{

    /*
     使用步骤:
     1.首先要构建一个符合CGPatternDrawPatternCallback签名的方法，这个方法专门用来创建“瓷砖”
     2.接着需要指定一个填充的颜色空间，这个颜色空间跟前面绘制渐变的颜色空间不太一样，前面创建渐变使用的颜色空间是设备无关的，我们需要基于这个颜色空间创建一个颜色空间专门用于填充（注意对于有颜色填充创建填充颜色空间参数为NULL，不用基于设备无关的颜色空间创建）
     3.然后我们就可以使用CGPatternCreate方法创建一个填充模式，创建填充模式时需要注意其中的参数，在代码中已经做了一一解释（这里注意对于有颜色填充模式isColored设置为true，否则为false）
     4.最后调用CGContextSetFillPattern方法给图形上下文指定填充模式（这个时候注意最后一个参数，如果是有颜色填充模式最后一个参数为透明度alpa的地址，对于无颜色填充模式最后一个参数是当前填充颜色空间的颜色数组）
     5.绘制图形，这里我们绘制一个矩形。
     6.释放资源。
     */
    
    //获得图形上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //模式填充颜色空间，注意对于有颜色填充模式，这里传null
    CGColorSpaceRef colorSpace = CGColorSpaceCreatePattern(NULL);
    
    //将填充色颜色空间，设置为模式填充的颜色空间
    CGContextSetFillColorSpace(context, colorSpace);
    
    //填充模式回调函数结构体
    CGPatternCallbacks callback = {0,&drawColoredTitle,NULL};
    
    /*填充模式
     info://传递给callback的参数
     bounds:瓷砖大小
     matrix:形变
     xStep:瓷砖横向间距
     yStep:瓷砖纵向间距
     tiling:贴砖的方法
     isClored:绘制的瓷砖是否已经指定了颜色(对于有颜色瓷砖此处指定位true)
     callbacks:回调函数
     */
    CGPatternRef patternRef = CGPatternCreate(NULL, CGRectMake(0, 0, 2*TILE_SIZE, 2*TILE_SIZE), CGAffineTransformIdentity, 2*TILE_SIZE, 2*TILE_SIZE, kCGPatternTilingNoDistortion, YES, &callback);
    
    //注意最后一个参数对于有颜色瓷砖指定为透明度的参数地址，对于无颜色瓷砖则指定当前颜色空间对应的颜色数组
    CGFloat alpha=1;
    CGContextSetFillPattern(context, patternRef, &alpha);
    
    CGContextFillRect(context, CGRectMake(0, 0, kScreenWidth, kScreenHeight));
    
    //释放资源
    CGColorSpaceRelease(colorSpace);
    CGPatternRelease(patternRef);
}


void drawTitle(void *info,CGContextRef context){
    CGContextFillRect(context, CGRectMake(0, 0, TILE_SIZE, TILE_SIZE));
    CGContextFillRect(context, CGRectMake(TILE_SIZE, TILE_SIZE, TILE_SIZE, TILE_SIZE));
}

/*无颜色填充*/
- (void)unColoredFillPattern{
    CGContextRef context = UIGraphicsGetCurrentContext();
    //设备无关的颜色空间
    CGColorSpaceRef rgbSpace = CGColorSpaceCreateDeviceRGB();
    //模式填充颜色空间
    CGColorSpaceRef colorSpace = CGColorSpaceCreatePattern(rgbSpace);
    //将填充色颜色空间设置为模式填充的颜色空间
    CGContextSetFillColorSpace(context, colorSpace);
    
    //填充模式回调函数结构体
    CGPatternCallbacks callback = {0,&drawTitle,NULL};
    
    CGPatternRef patternRef = CGPatternCreate(NULL, CGRectMake(0, 0, 2*TILE_SIZE, 2*TILE_SIZE), CGAffineTransformIdentity, 2*TILE_SIZE, 2*TILE_SIZE, kCGPatternTilingNoDistortion, NO, &callback);
    CGFloat compoent[] = {254.0/255.0,52.0/255.0,90.0/255.0,1.0};
    CGContextSetFillPattern(context, patternRef, compoent);
    
    CGContextFillRect(context, CGRectMake(0, 0, kScreenWidth, kScreenHeight));
    
    //释放资源
    CGColorSpaceRelease(colorSpace);
    CGColorSpaceRelease(rgbSpace);
    CGPatternRelease(patternRef);
}


/*上下文变换*/
- (void)transformMenthod{
   /*Quartz 2D的坐标系同UIKit并不一样，它的坐标原点在屏幕左下方，但是为了统一编程方式，UIKit对其进行了转换，坐标原点统一在屏幕左上角。
    注意在设置图形上下文形变之前一定要注意保存上下文的初始状态，在使用完之后进行恢复。*/
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    //保存图形上下文
    CGContextSaveGState(context);
    
    //形变第一步，向右平移50，向下平移50
    CGContextTranslateCTM(context, 50, 50);
    
    //形变第二步，缩放0.5
    CGContextScaleCTM(context, 0.7, 0.7);
    
    //形变第三部，旋转以左上角为端点进行顺时针旋转)
    CGContextRotateCTM(context, M_PI_4*0.5);
    
    UIImage *image = [UIImage imageNamed:@"IMG_1909"];
    [image drawAtPoint:CGPointMake(0, 0)];
    
    //恢复到初始状态
    CGContextRestoreGState(context);
}


/*使用Core Graphics绘制图像*/
- (void)CoreGraphicsDrawImage{
    /*在Core Graphics中坐标系的y轴正方向是向上的，坐标原点在屏幕左下角，y轴方向刚好和UIKit中y轴方向相反。
      而使用UIKit进行绘图之所以没有问题是因为UIKit中进行了处理，事实上对于其他图形即使使用Core Graphics绘制也没有问题，
      因为UIKit统一了编程方式。但是使用Core Graphics中内置方法绘制图像是存在这种问题的
     */
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    UIImage *image = [UIImage imageNamed:@"IMG_1909"];
    CGSize size=[UIScreen mainScreen].bounds.size;
    CGFloat height=200*776/400.0,y=50;
    //上下文形变
    CGContextScaleCTM(context, 1.0, -1.0);//在y轴缩放-1相当于沿着x张旋转180
    CGContextTranslateCTM(context, 0, -(size.height-(size.height-2*y-height)));//向上平移
    //图像绘制
    CGRect rect= CGRectMake(10, y, 200, height);
    CGContextDrawImage(context, rect, image.CGImage);
    
    CGContextRestoreGState(context);
}

@end




