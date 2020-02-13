#import "Service.h"
#import "Characteristic.h"
#import "Descriptor.h"

@interface DomainTypesConverter: NSObject

+ (Service *)serviceFromDictionary:(NSDictionary *)dictionary
          withPeripheralIdentifier:(NSString *)peripheralIdentifier;

+ (Characteristic *)characteristicFromDictionary:(NSDictionary *)dictionary service:(Service *)service;

+ (Descriptor *)descriptorFromDictionary:(NSDictionary *)dictionary
                          characteristic:(Characteristic *)characteristic;

@end
