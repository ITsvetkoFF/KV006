//
//  PieChartViewController.m
//  EcomapStatistics
//
//  Created by ohuratc on 03.02.15.
//  Copyright (c) 2015 Huralnyk. All rights reserved.
//

#import "PieChartViewController.h"
#import "EcomapRevealViewController.h"
#import "XYPieChart.h"
#import "EcomapURLFetcher.h"
#import "EcomapPathDefine.h"
#import "EcomapStatsParser.h"

@interface PieChartViewController ()

@property (weak, nonatomic) IBOutlet UILabel *numOfProblemsLabel;
@property (weak, nonatomic) IBOutlet UILabel *numOfVotesLabel;
@property (weak, nonatomic) IBOutlet UILabel *numOfCommentsLabel;
@property (weak, nonatomic) IBOutlet UILabel *numOfPhotosLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *statsRangeSegmentedControl;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *revealButtonItem;

@property(nonatomic, strong) NSMutableArray *slices;
@property(nonatomic, strong) NSArray *sliceColors;

@end

@implementation PieChartViewController

-(void)setStatsForPieChart:(NSArray *)statsForPieChart
{
    _statsForPieChart = statsForPieChart;
    [self drawPieChart];
}

- (IBAction)changeRangeOfShowingStats:(UISegmentedControl *)sender
{
    [self fetchStats];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self changeRangeOfShowingStats:self.statsRangeSegmentedControl];
    [self fetchGeneralStats];
    [self customSetup];
}

- (void)drawPieChart
{
    self.slices = [[NSMutableArray alloc] init];
    
    for(int i = 0; i < [self.statsForPieChart count]; i++)
    {
        NSDictionary *problems = self.statsForPieChart[i];
        NSNumber *number = [NSNumber numberWithInteger:[[problems valueForKey:ECOMAP_PROBLEM_VALUE] integerValue]];
        [self.slices addObject:number];
    }
    
    [self.pieChartView setDelegate:self];
    [self.pieChartView setDataSource:self];
    [self.pieChartView setAnimationSpeed:1.0];
    [self.pieChartView setShowPercentage:NO];
    [self.pieChartView setPieCenter:CGPointMake(self.pieChartView.bounds.size.width /2 , self.pieChartView.bounds.size.height / 2)];
    [self.pieChartView setUserInteractionEnabled:NO];
    [self.pieChartView setLabelColor:[UIColor whiteColor]];
    
    self.sliceColors = [self generateSliceColors];
    
    [self.pieChartView reloadData];
}

- (UIColor *)getSliceColorForProblemType:(NSNumber *)problemTypeID
{
    NSInteger iProblemTypeID = [problemTypeID integerValue];
    
    switch (iProblemTypeID) {
        case 1: return [UIColor colorWithRed:9/255.0 green:91/255.0 blue:15/255.0 alpha:1];
        case 2: return [UIColor colorWithRed:35/255.0 green:31/255.0 blue:32/255.0 alpha:1];
        case 3: return [UIColor colorWithRed:152/255.0 green:68/255.0 blue:43/255.0 alpha:1];
        case 4: return [UIColor colorWithRed:27/255.0 green:154/255.0 blue:214/255.0 alpha:1];
        case 5: return [UIColor colorWithRed:113/255.0 green:191/255.0 blue:68/255.0 alpha:1];
        case 6: return [UIColor colorWithRed:255/255.0 green:171/255.0 blue:9/255.0 alpha:1];
        case 7: return [UIColor colorWithRed:80/255.0 green:9/255.0 blue:91/255.0 alpha:1];
    }
    
    return [UIColor clearColor];
}

- (NSArray *)generateSliceColors
{
    NSMutableArray *mutableSliceColors = [[NSMutableArray alloc] init];
    
    for(int i = 0; i < [self.statsForPieChart count]; i++)
    {
        NSDictionary *problems = self.statsForPieChart[i];
        NSNumber *problemID = [NSNumber numberWithInteger:[[problems valueForKey:@"id"] integerValue]];
        UIColor *sliceColor = [self getSliceColorForProblemType:problemID];
        [mutableSliceColors addObject:sliceColor];
    }
    
    return mutableSliceColors;
}

- (void)fetchStats
{
    NSURL *url = [EcomapURLFetcher URLforStatsForParticularPeriod:[self getPeriodForStats]];
    dispatch_queue_t fetchQ = dispatch_queue_create("fetchQ", NULL);
    dispatch_async(fetchQ, ^{
        NSData *jsonResults = [NSData dataWithContentsOfURL:url];
        NSArray *propertyListResults = [NSJSONSerialization JSONObjectWithData:jsonResults
                                                                   options:0
                                                                     error:NULL];
      dispatch_async(dispatch_get_main_queue(), ^{
            self.statsForPieChart = propertyListResults;
            //NSLog(@"%@", propertyListResults);
      });
    });

}

- (void)fetchGeneralStats
{
    NSURL *url = [EcomapURLFetcher URLforGeneralStats];
    dispatch_queue_t fetchGSQ = dispatch_queue_create("fetchGSQ", NULL);
    dispatch_async(fetchGSQ, ^{
        NSData *jsonResults = [NSData dataWithContentsOfURL:url];
        NSArray *propertyListResults = [NSJSONSerialization JSONObjectWithData:jsonResults
                                                                       options:0
                                                                         error:NULL];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.generalStats = propertyListResults;
            [self updateUI];
            NSLog(@"%@", propertyListResults);
        });
    });
}

- (void)updateUI
{
    self.numOfProblemsLabel.text = [NSString stringWithFormat:@"Problems: %@", [EcomapStatsParser valueForKey:ECOMAP_GENERAL_STATS_PROBLEMS inGeneralStatsArray:self.generalStats]];
    self.numOfVotesLabel.text = [NSString stringWithFormat:@"Votes: %@", [EcomapStatsParser valueForKey:ECOMAP_GENERAL_STATS_VOTES inGeneralStatsArray:self.generalStats]];
    self.numOfPhotosLabel.text = [NSString stringWithFormat:@"Photos: %@", [EcomapStatsParser valueForKey:ECOMAP_GENERAL_STATS_PHOTOS inGeneralStatsArray:self.generalStats]];
    self.numOfCommentsLabel.text = [NSString stringWithFormat:@"Comments: %@", [EcomapStatsParser valueForKey:ECOMAP_GENERAL_STATS_COMMENTS inGeneralStatsArray:self.generalStats]];
}

-(EcomapStatsTimePeriod)getPeriodForStats
{
    switch(self.statsRangeSegmentedControl.selectedSegmentIndex) {
        case 0: return EcomapStatsForLastDay;
        case 1: return EcomapStatsForLastWeek;
        case 2: return EcomapStatsForLastMonth;
        case 3: return EcomapStatsForLastYear;
        case 4: return EcomapStatsForAllTheTime;
        default: return EcomapStatsForAllTheTime;
    }
}

-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    
}

- (void)customSetup
{
    EcomapRevealViewController *revealViewController = (EcomapRevealViewController *)self.revealViewController;
    if ( revealViewController )
    {
        [self.revealButtonItem setTarget: self.revealViewController];
        [self.revealButtonItem setAction: @selector( revealToggle: )];
        [self.navigationController.navigationBar addGestureRecognizer: self.revealViewController.panGestureRecognizer];
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

#pragma mark - XYPieChart Data Source

- (NSUInteger)numberOfSlicesInPieChart:(XYPieChart *)pieChart
{
    return self.slices.count;
}

- (CGFloat)pieChart:(XYPieChart *)pieChart valueForSliceAtIndex:(NSUInteger)index
{
    return [[self.slices objectAtIndex:index] intValue];
}

- (UIColor *)pieChart:(XYPieChart *)pieChart colorForSliceAtIndex:(NSUInteger)index
{
    return [self.sliceColors objectAtIndex:(index % self.sliceColors.count)];
}

#pragma mark - XYPieChart Delegate
- (void)pieChart:(XYPieChart *)pieChart willSelectSliceAtIndex:(NSUInteger)index
{
    NSLog(@"will select slice at index %lu",(unsigned long)index);
}
- (void)pieChart:(XYPieChart *)pieChart willDeselectSliceAtIndex:(NSUInteger)index
{
    NSLog(@"will deselect slice at index %lu",(unsigned long)index);
}
- (void)pieChart:(XYPieChart *)pieChart didDeselectSliceAtIndex:(NSUInteger)index
{
    NSLog(@"did deselect slice at index %lu",(unsigned long)index);
}
- (void)pieChart:(XYPieChart *)pieChart didSelectSliceAtIndex:(NSUInteger)index
{
    NSLog(@"did select slice at index %lu",(unsigned long)index);
}


@end