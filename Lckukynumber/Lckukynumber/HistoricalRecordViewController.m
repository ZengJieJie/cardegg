//
//  HistoricalRecordViewController.m
//  Lckukynumber
//
//  Created by adin on 2024/8/21.
//

#import "HistoricalRecordViewController.h"
#import "HISTableViewCell.h"
@interface HistoricalRecordViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *histableview;

@property (strong,nonatomic)NSArray * tabarray;

@end

@implementation HistoricalRecordViewController

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscape;
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

   self.tabarray = [defaults arrayForKey:@"myDictArray"];
    

        
        self.histableview.delegate = self;
        self.histableview.dataSource = self;
        [self.histableview registerNib:[UINib nibWithNibName:@"HISTableViewCell" bundle:nil] forCellReuseIdentifier:@"HISTableViewCell"];
       
        self.histableview.rowHeight = 100.0;
   
        self.histableview.allowsSelection = NO;
        self.histableview.backgroundColor = [UIColor clearColor];
        
      
        self.histableview.backgroundView = [[UIView alloc] init];
        self.histableview.backgroundView.backgroundColor = [UIColor clearColor];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tabarray.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HISTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HISTableViewCell" forIndexPath:indexPath];
    NSArray * cellarray=self.tabarray[indexPath.row];
    cell.timerlab.text=cellarray[2];
    cell.scorelab.text=[NSString stringWithFormat:@"Score : %@",cellarray[1]];
    [cell.leixingimage setImage:[UIImage imageNamed:cellarray[0]]];
    
    return cell;
}



- (IBAction)backclikc:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    
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
