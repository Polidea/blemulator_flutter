#import "Descriptor.h"
#import <Flutter/Flutter.h>
#import "BlemulatorDescriptorResponse.h"

@implementation Descriptor

- (instancetype)initWithObjectId:(int)objectId
                            uuid:(CBUUID *)uuid
                           value:(NSData *)value
                  characteristic:(Characteristic *)characteristic {
    self = [super init];
    if (self) {
        self.objectId = objectId;
        self.uuid = uuid;
        self.characteristic = characteristic;
        self.value = value;
    }
    
    return self;
}

- (NSDictionary<NSString *, id> *)jsonObjectRepresentation {
    return [NSDictionary dictionaryWithObjectsAndKeys:
            [NSNumber numberWithInt:self.objectId], BLEMULATOR_DESCRIPTOR_RESPONSE_DESCRIPTOR_ID,
            [self.uuid UUIDString].lowercaseString, BLEMULATOR_DESCRIPTOR_RESPONSE_DESCRIPTOR_UUID,
            [NSNumber numberWithInt:self.characteristic.objectId], BLEMULATOR_DESCRIPTOR_RESPONSE_CHARACTERISTIC_ID,
            [self.characteristic.uuid UUIDString].lowercaseString, BLEMULATOR_DESCRIPTOR_RESPONSE_CHARACTERISTIC_UUID,
            [self.characteristic.service.uuid UUIDString].lowercaseString, BLEMULATOR_DESCRIPTOR_RESPONSE_SERVICE_UUID,
            [NSNumber numberWithInt:self.characteristic.service.objectId], BLEMULATOR_DESCRIPTOR_RESPONSE_SERVICE_ID,
            self.characteristic.service.peripheralIdentifier, BLEMULATOR_DESCRIPTOR_RESPONSE_DEVICE_ID,
            [self base64encodedStringFromBytes:self.value], BLEMULATOR_DESCRIPTOR_RESPONSE_VALUE,
            nil];
}

- (NSString *)base64encodedStringFromBytes:(FlutterStandardTypedData *)bytes {
    return [bytes.data base64EncodedStringWithOptions:0];
}

@end
