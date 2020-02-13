#import "Service.h"
#import "CharacteristicContainer.h"

@interface DeviceContainer : NSObject

@property (readonly) NSString *identifier;
@property (readonly) NSString *name;
@property (readonly) NSArray<Service *> *services;
@property (readonly) NSDictionary<NSString *, NSArray<CharacteristicContainer *> *> *characteristicContainers;
@property BOOL isConnected;

- (instancetype)initWithIdentifier:(NSString *)identifier
                              name:(NSString *)name;

- (instancetype)initWithIdentifier:(NSString *)identifier
                              name:(NSString *)name
                          services:(NSArray<Service *> *)services
                   characteristicContainers:(NSDictionary<NSString *, NSArray<CharacteristicContainer *> *> *)characteristicContainers;

- (NSArray *)servicesJsonRepresentation;

- (NSArray *)characteristicsJsonRepresentationForService:(NSString *)serviceUuidString;

@end
