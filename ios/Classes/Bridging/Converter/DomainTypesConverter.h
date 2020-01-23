#import "Service.h"
#import "Characteristic.h"

@interface DomainTypesConverter: NSObject

+ (Service *)serviceFromDictionary:(NSDictionary *)dictionary
          withPeripheralIdentifier:(NSString *)peripheralIdentifier;

+ (Characteristic *)characteristicFromDictionary:(NSDictionary *)dictionary service:(Service *)service;

@end
