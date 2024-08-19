//
//  MemoryScoreViewController.m
//  MemoryslotsCard
//
//  Created by adin on 2024/8/16.
//

#import "MemoryScoreViewController.h"
#import "MemoryViewController.h"
@interface MemoryScoreViewController ()
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) NSInteger timeint;
@property (weak, nonatomic) IBOutlet UILabel *timelab;
@property (weak, nonatomic) IBOutlet UILabel *coinslabb;

@property (weak, nonatomic) IBOutlet UIView *imageview;

@property (nonatomic, strong) NSMutableArray *numberArray;

@property(strong,nonatomic)UIButton *Currentbtn;
@property(strong,nonatomic)UIButton *nextbtn;
@property(assign,nonatomic)int consint;
@end

@implementation MemoryScoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.consint=0;
    [self.timer invalidate];
    self.timer = nil;
    self.timeint = 30;
    [self updatelabb];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                  target:self
                                                selector:@selector(timeupdate)
                                                userInfo:nil
                                                 repeats:YES];
    
    [self numberarraysss];
    [self creatbutton:self.imageview];
}


- (void)numberarraysss {
    
    self.numberArray = [NSMutableArray array];
    
    // 生成 16 对数字，数字范围从 1 到 10
    for (int i = 0; i < 16; i++) {
        int number1 = arc4random_uniform(8) + 1;
        NSString *str=[NSString stringWithFormat:@"%d",number1];
        [self.numberArray addObject:str];
        [self.numberArray addObject:str];
    }
    
    // 打乱数组
    NSUInteger count = [self.numberArray count];
    for (NSUInteger i = 0; i < count; i++) {
        NSUInteger j = arc4random_uniform((uint32_t)count);
        [self.numberArray exchangeObjectAtIndex:i withObjectAtIndex:j];
    }
    
    
}

- (void)creatbutton:(UIView *)view {
    
    CGFloat spacing = 5;
    CGFloat buttonWidth = (view.frame.size.width - 7 * spacing) / 8;
    CGFloat buttonHeight = (view.frame.size.height - 3 * spacing) / 4;
    
    
    for (int row = 0; row < 4; row++) {
        for (int col = 0; col < 8; col++) {
            
            CGFloat x = col * (buttonWidth + spacing);
            CGFloat y = row * (buttonHeight + spacing);
            
            
            NSInteger index = row * 4 + col;
            NSString *number = self.numberArray[index];
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
            button.frame = CGRectMake(x, y, buttonWidth, buttonHeight);
            [button setBackgroundImage:[UIImage imageNamed:@"backimage"] forState:UIControlStateNormal];
       
            button.tag = [number intValue]; // 设置 tag 以便于后续操作
            [button addTarget:self action:@selector(buttap:) forControlEvents:UIControlEventTouchUpInside];
            [view addSubview:button];
        }
    }
   
}


- (void)timeupdate {
    if (self.timeint > 0) {
        self.timeint--;
        [self updatelabb];
    } else {
        [self.timer invalidate];
        self.timer = nil;
        [self timegave];
    }
}

- (void)updatelabb {
    self.timelab.text=[NSString stringWithFormat:@"%ld",(long)self.timeint];
}
- (void)timegave {
       UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Tips"
                                                                                message:@"Game over"
                                                                         preferredStyle:UIAlertControllerStyleAlert];
       UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
          
         
           NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
           
           NSString *coins1 = [defaults stringForKey:@"mypoints"];
           int cint=[coins1 intValue];
           cint+=self.consint;
           [defaults setObject:[NSString stringWithFormat:@"%d",cint] forKey:@"mypoints"];
           [defaults synchronize];
           
          
           MemoryViewController *vcA = (MemoryViewController *)self.presentingViewController;
              
              [self dismissViewControllerAnimated:YES completion:^{
                 
                  [vcA disupdatcoins];
              }];
           
       }];
       [alertController addAction:confirmAction];
       [self presentViewController:alertController animated:YES completion:nil];
}


- (void)buttap:(UIButton *)sender {

    
    if (self.Currentbtn==nil) {
        self.Currentbtn=sender;
        // 创建翻转动画
            [UIView transitionWithView:sender
                              duration:0.5
                               options:UIViewAnimationOptionTransitionFlipFromLeft
                            animations:^{
                               
                [sender setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%ld",(long)sender.tag+10]] forState:UIControlStateNormal];
                sender.userInteractionEnabled = NO;
                            }
                            completion:^(BOOL finished) {
                              
                                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                    [UIView transitionWithView:sender
                                                      duration:0.5
                                                       options:UIViewAnimationOptionTransitionFlipFromRight
                                                    animations:^{
                                        [sender setBackgroundImage:[UIImage imageNamed:@"backimage"] forState:UIControlStateNormal];
                                        sender.userInteractionEnabled = YES;
                                                    }
                                                    completion:nil];
                                });
                            }];
    }else{
        
       
        if (self.Currentbtn.tag==sender.tag&&self.Currentbtn!=sender) {
            // 创建翻转动画
            self.consint=self.consint+=2;
            
            self.coinslabb.text=[NSString stringWithFormat:@"%d",self.consint];
                [UIView transitionWithView:sender
                                  duration:0.5
                                   options:UIViewAnimationOptionTransitionFlipFromLeft
                                animations:^{
                                   
                    [sender setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%ld",(long)sender.tag+10]] forState:UIControlStateNormal];
                    
                                }
                                completion:^(BOOL finished) {
                                  
                                
                                }];
           
            sender.userInteractionEnabled = NO;
            self.Currentbtn.userInteractionEnabled = NO;
               [UIView animateWithDuration:0.2
                                animations:^{
                   self.Currentbtn.alpha = 0.0;
                                }
                                completion:^(BOOL finished) {
                                    if (finished) {
                                        self.Currentbtn.hidden=YES;
                                    }
                                }];
           
               [UIView animateWithDuration:0.2
                                animations:^{
                   sender.alpha = 0.0;
                                }
                                completion:^(BOOL finished) {
                                    if (finished) {
                                        sender.hidden=YES;
                                    }
                                }];
            self.Currentbtn=nil;
        }else{
            self.Currentbtn=sender;
            [UIView transitionWithView:sender
                              duration:0.5
                               options:UIViewAnimationOptionTransitionFlipFromLeft
                            animations:^{
                sender.userInteractionEnabled = NO;
                [sender setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%ld",(long)sender.tag+10]] forState:UIControlStateNormal];
                            }
                            completion:^(BOOL finished) {
                              
                                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                    [UIView transitionWithView:sender
                                                      duration:0.5
                                                       options:UIViewAnimationOptionTransitionFlipFromRight
                                                    animations:^{
                                        [sender setBackgroundImage:[UIImage imageNamed:@"backimage"] forState:UIControlStateNormal];
                                        sender.userInteractionEnabled = YES;
                                                    }
                                                    completion:nil];
                                });
                            }];
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
