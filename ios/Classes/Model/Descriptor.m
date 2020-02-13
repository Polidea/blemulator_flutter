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
            [NSNumber numberWithInt:_objectId], DESCRIPTOR_RESPONSE_DESCRIPTOR_ID,
            [_uuid UUIDString].lowercaseString, DESCRIPTOR_RESPONSE_DESCRIPTOR_UUID,
            [NSNumber numberWithInt:_characteristic.objectId], DESCRIPTOR_RESPONSE_CHARACTERISTIC_ID,
            [_characteristic.uuid UUIDString].lowercaseString, DESCRIPTOR_RESPONSE_CHARACTERISTIC_UUID,
            [_characteristic.service.uuid UUIDString].lowercaseString, DESCRIPTOR_RESPONSE_SERVICE_UUID,
            [NSNumber numberWithInt:_characteristic.service.objectId], DESCRIPTOR_RESPONSE_SERVICE_ID,
            _characteristic.service.peripheralIdentifier, DESCRIPTOR_RESPONSE_DEVICE_ID,
            [self base64encodedStringFromBytes:_value], DESCRIPTOR_RESPONSE_VALUE,
            nil];
}

- (NSString *)base64encodedStringFromBytes:(FlutterStandardTypedData *)bytes {
    return [bytes.data base64EncodedStringWithOptions:0];
}

@end
