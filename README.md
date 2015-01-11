![alt tag](http://www.userzoom.com/wp-content/uploads/2014/06/7-steps.jpg)
# JAGPedometer

## Overview

JAGPedometer provides supportive methods to get data of CMPedometer on iOS.

## Usage

  - Link CoreMotion library on your project

  - Import
```
#import "JAGPedometer.h"
```

  - Property
```
@property (strong, nonatomic) JAGPedometer *pedometer;
```

  - Init, check and start JAGPedometer
```
self.pedometer = [[JAGPedometer alloc] init];
if([self.pedometer isStepCountingAvailable])
{
  [self.pedometer startPedometerUpdatesFromDate:[NSDate date] completion:^(BOOL success, CMPedometerData *pedometerData, NSError *error) {
 
  }];
}
  ```
  
  - Get pedometer data
```
[self.pedometer getPedometerData:startDate endDate:endDate completion:^(BOOL success, CMPedometerData *pedometerData, NSError *error){

}
```

  - Stop pedometer updates
```
[self.pedometer stopPedometerUpdates];
```

## License

JAGPedometer is available under the MIT license. See the LICENSE file for more info.

