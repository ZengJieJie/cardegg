//
//  MemoryViewController.m
//  MemoryslotsCard
//
//  Created by adin on 2024/8/14.
//

#import "MemoryViewController.h"
#import <Masonry/Masonry.h>
#import "MemoryScoreViewController.h"
#import "TreasureScoreViewController.h"
@interface MemoryViewController ()
@property (weak, nonatomic) IBOutlet UILabel *points;
@property (weak, nonatomic) IBOutlet UIView *imageviews;
@property (strong,nonatomic)NSMutableArray *buttons;
@property(assign,nonatomic) int pointssss;
@property (weak, nonatomic) IBOutlet UIButton *luckyuibutton;
@property(assign,nonatomic) int luckyBool;
@end

@implementation MemoryViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *retrievedString = [defaults stringForKey:@"mypoints"];
    self.pointssss=[retrievedString intValue];
    NSArray *retrievedArray = [defaults arrayForKey:@"myArrayKey"];
    
    self.points.text=[NSString stringWithFormat:@"%d",self.pointssss];
    
    [self updateButtonState];
    // 网格的行数和列数
        NSInteger rows = 2;
        NSInteger columns = 4;
        
        // 间距
        CGFloat spacing = 10.0;
        
        // 获取视图的宽度和高度
        CGFloat viewWidth = self.imageviews.frame.size.width;
        CGFloat viewHeight = self.imageviews.frame.size.height;
        
        // 计算按钮的宽度和高度
        CGFloat totalHorizontalSpacing = (columns - 1) * spacing;
        CGFloat totalVerticalSpacing = (rows - 1) * spacing;
        
        CGFloat buttonWidth = (viewWidth - totalHorizontalSpacing) / columns;
        CGFloat buttonHeight = (viewHeight - totalVerticalSpacing) / rows;
        
        // 创建按钮并添加到视图
        for (NSInteger row = 0; row < rows; row++) {
            for (NSInteger column = 0; column < columns; column++) {
                UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
                
                // 计算每个按钮的位置
                CGFloat x = column * (buttonWidth + spacing);
                CGFloat y = row * (buttonHeight + spacing);
                
                button.frame = CGRectMake(x, y, buttonWidth, buttonHeight);
                if ([retrievedArray[row * columns + column] isEqual:@"1"]) {
                    button.tag = row * columns + column;
                    [button setBackgroundImage:[UIImage imageNamed:@"backimage"] forState:UIControlStateNormal];
                }else{
                    button.userInteractionEnabled = NO;
                    button.tag = row * columns + column+10;
                    [button setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%ld",(long)(row * columns + column)]] forState:UIControlStateNormal];
                }
                // 设置标签以便后续操作使用
                [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
                
                [self.imageviews addSubview:button];
               
            }
        }
    
    
   
           
        
}


- (void)updateButtonState {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSInteger clickCount = [defaults integerForKey:@"ClickCount"];
    
    if (clickCount >= 3) {
        self.luckyBool=1;
    } else {
        self.luckyBool=2;
    }
}

- (BOOL)isSameDay:(NSDate *)date1 date2:(NSDate *)date2 {
    if (date1 == nil || date2 == nil) {
        return NO;
    }
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components1 = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date1];
    NSDateComponents *components2 = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date2];
    
    return [components1 day] == [components2 day] &&
           [components1 month] == [components2 month] &&
           [components1 year] == [components2 year];
}



- (void)disupdatcoins {
     
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSString *retrievedString = [defaults stringForKey:@"mypoints"];
        self.pointssss=[retrievedString intValue];
        self.points.text=[NSString stringWithFormat:@"%d",self.pointssss];
       
}


- (IBAction)backbbutton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)startbutton:(id)sender {
    UIButton *but=sender;
    if (but.tag==1) {
        if(self.pointssss<10){
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Tips"
                                                                                        message:@"You don't have enough coins go play the game to earn coins"
                                                                                 preferredStyle:UIAlertControllerStyleAlert];
               
              
               UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK"
                                                                  style:UIAlertActionStyleDefault
                                                                handler:^(UIAlertAction * _Nonnull action) {
               }];
               
            
               [alertController addAction:okAction];
               
              
               [self presentViewController:alertController animated:YES completion:nil];
        }else{
            
           
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Title"
                                                                                         message:@"Starting the game costs 10coins"
                                                                                  preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK"
                                                                   style:UIAlertActionStyleDefault
                                                                 handler:^(UIAlertAction * _Nonnull action) {
                    self.pointssss=self.pointssss-10;
                    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                    NSString *myString = [NSString stringWithFormat:@"%d",self.pointssss];
                    [defaults setObject:myString forKey:@"mypoints"];
                    [defaults synchronize];
                    self.points.text=[NSString stringWithFormat:@"%d",self.pointssss];
                    
                    MemoryScoreViewController * vc=[[MemoryScoreViewController alloc]init];
                    [self presentViewController:vc animated:YES completion:nil];
                }];
                
              
                UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel"
                                                                       style:UIAlertActionStyleCancel
                                                                     handler:^(UIAlertAction * _Nonnull action) {
                   
                }];
                
               
                [alertController addAction:okAction];
                [alertController addAction:cancelAction];
                
                
                [self presentViewController:alertController animated:YES completion:nil];
           
        }
       
    }else{
       
        NSDate *currentDate = [NSDate date];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSDate *lastClickDate = [defaults objectForKey:@"LastClickDate"];
        
      
        if (![self isSameDay:currentDate date2:lastClickDate]) {
            [defaults setInteger:0 forKey:@"ClickCount"];
        }
        
       
        [defaults setObject:currentDate forKey:@"LastClickDate"];
        
       
        NSInteger clickCount = [defaults integerForKey:@"ClickCount"];
        
      
        clickCount++;
        [defaults setInteger:clickCount forKey:@"ClickCount"];
        if(self.luckyBool==1){
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Tips"
                                                                                        message:@"You can only dig for treasure three times a day"
                                                                                 preferredStyle:UIAlertControllerStyleAlert];
               
              
               UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK"
                                                                  style:UIAlertActionStyleDefault
                                                                handler:^(UIAlertAction * _Nonnull action) {
               }];
               
            
               [alertController addAction:okAction];
               
              
               [self presentViewController:alertController animated:YES completion:nil];
           
        }else if(self.luckyBool==2){
            TreasureScoreViewController * vc=[[TreasureScoreViewController alloc]init];
            [self presentViewController:vc animated:YES completion:nil];
        }
        // 更新按钮状态
        [self updateButtonState];
       
        
        
    }
}

- (void)buttonClicked:(UIButton *)sender {
    if (self.pointssss<100) {
        // 你可以在这里处理按钮点击事件
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Title"
                                                                       message:@"Your coins are not enough to unlock the egg! Go play a little game to make some coins"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:okAction];

        [self presentViewController:alert animated:YES completion:nil];
    }else{
        if(sender.tag<10){
            self.pointssss=self.pointssss-100;
            self.points.text=[NSString stringWithFormat:@"%d",self.pointssss];
            [UIView transitionWithView:sender
                                 duration:0.5
                                  options:UIViewAnimationOptionTransitionFlipFromRight
                               animations:^{
                [sender setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%ld",(long)sender.tag]] forState:UIControlStateNormal];
                                 
                               }
                               completion:^(BOOL finished) {
                                  
                               }];
            
            
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
           
            
            NSString *myString = [NSString stringWithFormat:@"%d",self.pointssss];
            [defaults setObject:myString forKey:@"mypoints"];
            
          
            NSArray *retrievedArray = [defaults arrayForKey:@"myArrayKey"];
            // 将不可变数组转换为可变数组
            NSMutableArray *mutableArray = [retrievedArray mutableCopy];
            
            [mutableArray setObject:[NSString stringWithFormat:@"%ld",(long)(sender.tag+10)] atIndexedSubscript:sender.tag];
            [defaults setObject:mutableArray forKey:@"myArrayKey"];
            [defaults synchronize];
            sender.tag=sender.tag+10;
            

        }
    }
   
   
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
