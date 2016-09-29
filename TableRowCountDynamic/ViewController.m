//
//  ViewController.m
//  TableRowCountDynamic

#import "ViewController.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *dataTableView;

@property (strong, nonatomic) NSArray *allImagesArray;
@property (strong, nonatomic) NSMutableArray *currentImagesArray;
@property (nonatomic, assign) long presentImageCount;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.dataTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    //[self.dataTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"loaderCell"];
    
    [self.dataTableView registerNib:[UINib nibWithNibName:@"CustomLoader"  bundle:nil] forCellReuseIdentifier:@"loaderCell"];
    
    self.allImagesArray = @[[UIImage imageNamed:@"1.jpeg"],[UIImage imageNamed:@"2.jpeg"],[UIImage imageNamed:@"3.jpeg"],
                            [UIImage imageNamed:@"4.jpeg"],[UIImage imageNamed:@"5.jpeg"],[UIImage imageNamed:@"6.jpeg"],
                            [UIImage imageNamed:@"7.jpeg"],[UIImage imageNamed:@"8.jpeg"],[UIImage imageNamed:@"9.jpeg"],
                            [UIImage imageNamed:@"10.jpeg"],[UIImage imageNamed:@"11.jpeg"],[UIImage imageNamed:@"12.jpeg"],
                            [UIImage imageNamed:@"13.jpeg"],[UIImage imageNamed:@"14.jpeg"],[UIImage imageNamed:@"15.jpeg"],
                            [UIImage imageNamed:@"16.jpeg"],[UIImage imageNamed:@"17.jpeg"],[UIImage imageNamed:@"18.jpeg"],
                            [UIImage imageNamed:@"19.jpeg"],[UIImage imageNamed:@"20.jpeg"],[UIImage imageNamed:@"21.jpeg"]];
    self.currentImagesArray = [[NSMutableArray alloc]init];
                            
    [self loadImages];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if([self shouldShowLoadingCell])
    {
         return self.currentImagesArray.count + 1;
    }
    else
    {
        return self.currentImagesArray.count;
    }

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row < self.presentImageCount)
    {
        return 150;
    }
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row < self.presentImageCount)
    {
    UITableViewCell *dataCell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    UIImageView *cellImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, CGRectGetWidth(dataCell.frame) - 20, CGRectGetHeight(dataCell.frame)- 20)];
    cellImageView.image = self.currentImagesArray[indexPath.row];
    [dataCell.contentView addSubview:cellImageView];
         return dataCell;
    }
    else
    {
        UITableViewCell *loaderCell = [tableView dequeueReusableCellWithIdentifier:@"loaderCell" forIndexPath:indexPath];
        NSLog(@"loadimages called..");
        [self loadImages];
        return loaderCell;
    }
}

- (void)loadImages{
    NSArray *tempArray = [[self.allImagesArray subarrayWithRange:NSMakeRange(self.presentImageCount, 7 )] mutableCopy];
    for(UIImage *image in tempArray)
    {
        [self.currentImagesArray addObject:image];
    }
    self.presentImageCount = self.presentImageCount + 7;
    [self.dataTableView reloadData];
}

- (BOOL)shouldShowLoadingCell{
    if(self.presentImageCount < self.allImagesArray.count)
    {
        return YES;
    }
    return NO;
}


@end
