#import "DeviceContainer.h"

@interface DeviceContainer ()

@property (readwrite) NSString *identifier;
@property (readwrite) NSString *name;
@property (readwrite) NSArray<Service *> *services;
@property (readwrite) NSDictionary<NSString *, NSArray<CharacteristicContainer *> *> *characteristicContainers;

@end

@implementation DeviceContainer

- (instancetype)initWithIdentifier:(NSString *)identifier name:(NSString *)name {
    self = [super init];
    if (self) {
        self.identifier = identifier;
        self.name = name;
        self.services = nil;
        self.characteristicContainers = nil;
        self.isConnected = false;
    }
    return self;
}

- (instancetype)initWithIdentifier:(NSString *)identifier
                              name:(NSString *)name
                          services:(NSArray<Service *> *)services
                   characteristicContainers:(NSDictionary<NSString *, NSArray<CharacteristicContainer *> *> *)characteristicContainers {
    self = [super init];
    if (self) {
        self.identifier = identifier;
        self.name = name;
        self.services = services;
        self.characteristicContainers = characteristicContainers;
        self.isConnected = false;
    }
    return self;
}

- (NSArray *)servicesJsonRepresentation {
    NSMutableArray *result = [[NSMutableArray alloc] init];
    for (Service *service in _services) {
        [result addObject:[service jsonObjectRepresentation]];
    }
    return result;
}

- (NSArray *)characteristicsJsonRepresentationForService:(NSString *)serviceUuidString {
    NSMutableArray *result = [[NSMutableArray alloc] init];
    for (CharacteristicContainer *characteristicContainer in [_characteristicContainers objectForKey:serviceUuidString.lowercaseString]) {
        [result addObject:[characteristicContainer.characteristic jsonObjectRepresentation]];
    }
    return result;
}

@end
