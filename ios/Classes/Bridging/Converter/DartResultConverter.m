#import "DartResultConverter.h"
#import "DomainTypesConverter.h"
#import "DartResultKeys.h"

@implementation DartResultConverter

+ (DeviceContainer *)deviceContainerFromDartResult:(id)result
                           peripheral:(Peripheral *)peripheral {
    NSArray *resultArray = (NSArray *)result;

    NSMutableArray<Service *> *services = [[NSMutableArray alloc] init];
    NSMutableDictionary<NSString *, NSArray<CharacteristicContainer *> *> *characteristicContainers = [[NSMutableDictionary alloc] init];

    for (NSDictionary *serviceDictionary in resultArray) {
        Service *service = [DomainTypesConverter serviceFromDictionary:serviceDictionary
                                              withPeripheralIdentifier:peripheral.identifier];

        NSMutableArray *characteristicContainersArray = [[NSMutableArray alloc] init];
        for (NSDictionary *characteristicDictionary in [serviceDictionary objectForKey:DART_RESULT_CHARACTERISTICS]) {
            Characteristic *characteristic = [DomainTypesConverter characteristicFromDictionary:characteristicDictionary service:service];
            NSMutableArray *descriptorsArray = [[NSMutableArray alloc] init];
            
            for (NSDictionary *descriptorDictionary in [characteristicDictionary objectForKey:DART_RESULT_DESCRIPTORS]) {
                Descriptor *descriptor = [DomainTypesConverter descriptorFromDictionary:descriptorDictionary characteristic:characteristic];
                [descriptorsArray addObject:descriptor];
            }
            
            CharacteristicContainer *container = [[CharacteristicContainer alloc] initWithCharacteristic:characteristic descriptors:descriptorsArray];
            
            [characteristicContainersArray addObject:container];
            
        }

        [services addObject:service];
        [characteristicContainers setObject:characteristicContainersArray forKey:[service.uuid UUIDString].lowercaseString];
    }

    return [[DeviceContainer alloc] initWithIdentifier:peripheral.identifier
                                                  name:peripheral.name
                                              services:services
                                       characteristicContainers:characteristicContainers];
}

+ (Characteristic *)characteristicFromDartResult:(id)result {
    NSDictionary *resultDictionary = (NSDictionary *)result;
    return [DomainTypesConverter characteristicFromDictionary:resultDictionary
                                                      service:[DomainTypesConverter serviceFromDictionary:resultDictionary
                                                                                 withPeripheralIdentifier:[resultDictionary objectForKey:DART_RESULT_DEVICE_IDENTIFIER]]];
}

+ (Descriptor *)descriptorFromDartResult:(id)result {
    NSDictionary *resultDictionary = (NSDictionary *)result;
    Service *service = [DomainTypesConverter serviceFromDictionary:resultDictionary
                                          withPeripheralIdentifier:[resultDictionary objectForKey:DART_RESULT_DEVICE_IDENTIFIER]];
    Characteristic *characteristic = [DomainTypesConverter characteristicFromDictionary:resultDictionary
                                                                                service:service];
    Descriptor *descriptor = [DomainTypesConverter descriptorFromDictionary:resultDictionary
                                                             characteristic:characteristic];
    
    return descriptor;
}

@end
