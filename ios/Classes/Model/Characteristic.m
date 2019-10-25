#import "Characteristic.h"
#import "BlemulatorCharacteristicResponse.h"
#import <Flutter/Flutter.h>

@implementation Characteristic

- (instancetype)initWithObjectId:(int)objectId
                            uuid:(CBUUID *)uuid
                           value:(NSData *)value
                         service:(Service *)service
                     isNotifying:(BOOL)isNotifying
                      properties:(CBCharacteristicProperties)properties {
    self = [super init];
    if (self) {
        self.objectId = objectId;
        self.uuid = uuid;
        self.value = value;
        self.service = service;
        self.isNotifying = isNotifying;
        self.properties = properties;
    }
    return self;
}

- (NSDictionary<NSString *,id> *)jsonObjectRepresentation {
    return [NSDictionary dictionaryWithObjectsAndKeys:
            [NSNumber numberWithInt:_objectId], CHARACTERISTIC_RESPONSE_ID,
            [_uuid UUIDString].lowercaseString, CHARACTERISTIC_RESPONSE_UUID,
            [NSNumber numberWithInt:_service.objectId], CHARACTERISTIC_RESPONSE_SERVICE_ID,
            [_service.uuid UUIDString].lowercaseString, CHARACTERISTIC_RESPONSE_SERVICE_UUID,
            _service.peripheralIdentifier, CHARACTERISTIC_RESPONSE_DEVICE_ID,
            [NSNumber numberWithBool:_properties & CBCharacteristicPropertyRead], CHARACTERISTIC_RESPONSE_IS_READABLE,
            [NSNumber numberWithBool:_properties & CBCharacteristicPropertyWrite], CHARACTERISTIC_RESPONSE_IS_WRITABLE_WITH_RESPONSE,
            [NSNumber numberWithBool:_properties & CBCharacteristicPropertyWriteWithoutResponse], CHARACTERISTIC_RESPONSE_IS_WRITABLE_WITHOUT_RESPONSE,
            [NSNumber numberWithBool:_properties & CBCharacteristicPropertyNotify], CHARACTERISTIC_RESPONSE_IS_NOTIFIABLE,
            [NSNumber numberWithBool:_isNotifying], CHARACTERISTIC_RESPONSE_IS_NOTIFYING,
            [NSNumber numberWithBool:_properties & CBCharacteristicPropertyIndicate], CHARACTERISTIC_RESPONSE_IS_INDICATABLE,
            [self base64encodedStringFromBytes:_value], CHARACTERISTIC_RESPONSE_VALUE,
            nil];
}

- (NSString *)base64encodedStringFromBytes:(FlutterStandardTypedData *)bytes {
    return [bytes.data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
}

@end
