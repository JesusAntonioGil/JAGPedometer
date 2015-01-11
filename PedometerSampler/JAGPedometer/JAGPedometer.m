//
//  JAGPedometer.m
//  PedometerSampler
//
//  Created by Jesus Antonio Gil on 11/1/15.
//  Copyright (c) 2015 Jesus Antonio Gil. All rights reserved.
//

#import "JAGPedometer.h"


@interface JAGPedometer ()

@property (strong, nonatomic) CMPedometer *pedometer;
@property (strong, nonatomic) JAGPedometerCompletion completion;

@end


@implementation JAGPedometer

- (instancetype)init
{
    self = [super init];
    if(self)
    {
        
    }
    return self;
}

#pragma mark - PUBLIC

- (BOOL)isStepCountingAvailable
{
    if([CMPedometer isStepCountingAvailable])
    {
        self.pedometer = [[CMPedometer alloc] init];
    }
    
    return [CMPedometer isStepCountingAvailable];
}

- (void)startPedometerUpdatesFromDate:(NSDate *)date completion:(JAGPedometerCompletion)completion
{
    self.completion = completion;
    
    [self.pedometer startPedometerUpdatesFromDate:date withHandler:^(CMPedometerData *pedometerData, NSError *error)
    {
        [self respondsCompletion:pedometerData error:error];
    }];
}

- (void)getPedometerData:(NSDate *)startDate endDate:(NSDate *)enDate completion:(JAGPedometerCompletion) completion
{
    self.completion = completion;
    
    [self.pedometer queryPedometerDataFromDate:startDate toDate:enDate withHandler:^(CMPedometerData *pedometerData, NSError *error)
    {
        [self respondsCompletion:pedometerData error:error];
    }];
}

- (void)stopPedometerUpdates
{
    [self.pedometer stopPedometerUpdates];
}

#pragma mark - PRIVATE

- (void)respondsCompletion:(CMPedometerData *)pedometerData error:(NSError *)error
{
    dispatch_async(dispatch_get_main_queue(), ^{
        if(error)
            self.completion(NO, nil, error);
        else
            self.completion(YES, pedometerData, nil);
    });
}

@end
