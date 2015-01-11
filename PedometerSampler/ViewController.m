//
//  ViewController.m
//  PedometerSampler
//
//  Created by Jesus Antonio Gil on 11/1/15.
//  Copyright (c) 2015 Jesus Antonio Gil. All rights reserved.
//

#import "ViewController.h"
#import "JAGPedometer.h"


@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *startDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *endDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *stepsLabel;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@property (weak, nonatomic) IBOutlet UILabel *floorAscendedLabel;
@property (weak, nonatomic) IBOutlet UILabel *floorDescendedLabel;
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;
@property (weak, nonatomic) IBOutlet UIButton *getDataButton;

@property (strong, nonatomic) JAGPedometer *pedometer;

@end


@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.pedometer = [[JAGPedometer alloc] init];
    if([self.pedometer isStepCountingAvailable])
    {
        [self.pedometer startPedometerUpdatesFromDate:[NSDate date] completion:^(BOOL success, CMPedometerData *pedometerData, NSError *error) {
            
        }];
    }
    else
    {
        self.infoLabel.textColor = [UIColor redColor];
        self.infoLabel.text = @"Step counting is not available";
        self.getDataButton.enabled = NO;
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.pedometer stopPedometerUpdates];
    
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - ACTIONS

- (IBAction)onGetDataPedometerTap:(id)sender
{
    [self getDataPedometer];
}

#pragma mark - PRIVATE

- (void)getDataPedometer
{
    NSDate *endDate = [NSDate date];
    NSDate *startDate = [endDate dateByAddingTimeInterval:-(24.0f * 3600.0f)];
    
    [self.pedometer getPedometerData:startDate endDate:endDate completion:^(BOOL success, CMPedometerData *pedometerData, NSError *error)
     {
         if(success)
         {
             self.startDateLabel.text = [self stringForDate:startDate];
             self.endDateLabel.text = [self stringForDate:endDate];
             self.stepsLabel.text = [pedometerData.numberOfSteps stringValue];
             self.distanceLabel.text = [NSString stringWithFormat:@"%.2f[m]", [pedometerData.distance floatValue]];
             self.floorAscendedLabel.text = [pedometerData.floorsAscended stringValue];
             self.floorDescendedLabel.text = [pedometerData.floorsDescended stringValue];
         }
         else
         {
             self.infoLabel.textColor = [UIColor redColor];
             self.infoLabel.text = error.description;
         }
     }];
}

- (NSString *)stringForDate:(NSDate *)date
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateStyle = NSDateFormatterShortStyle;
    formatter.timeStyle = NSDateFormatterShortStyle;
    
    return [formatter stringFromDate:date];
}


@end
