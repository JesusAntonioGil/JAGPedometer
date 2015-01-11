//
//  JAGPedometer.h
//  PedometerSampler
//
//  Created by Jesus Antonio Gil on 11/1/15.
//  Copyright (c) 2015 Jesus Antonio Gil. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreMotion/CoreMotion.h>


typedef void (^JAGPedometerCompletion)(BOOL success, CMPedometerData *pedometerData, NSError *error);


@interface JAGPedometer : NSObject

- (BOOL)isStepCountingAvailable;
- (void)startPedometerUpdatesFromDate:(NSDate *)date completion:(JAGPedometerCompletion)completion;
- (void)getPedometerData:(NSDate *)startDate endDate:(NSDate *)enDate completion:(JAGPedometerCompletion) completion;
- (void)stopPedometerUpdates;

@end
