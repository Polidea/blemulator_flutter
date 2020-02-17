#import "DeviceContainer.h"
#import "CharacteristicContainer.h"

@interface DartResultConverter : NSObject

+ (DeviceContainer *)deviceContainerFromDartResult:(id)result
                           peripheral:(Peripheral *)peripheral;

+ (Characteristic *)characteristicFromDartResult:(id)result;

+ (Descriptor *)descriptorFromDartResult:(id)result;
@end
