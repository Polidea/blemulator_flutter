#import <CoreBluetooth/CoreBluetooth.h>
#import "Characteristic.h"

@interface Descriptor : NSObject

@property int objectId;
@property CBUUID * _Nonnull uuid;
@property Characteristic * _Nonnull characteristic;
@property NSData * _Nullable value;

- (_Nonnull instancetype)initWithObjectId:(int)objectId
                            uuid:(CBUUID * _Nonnull)uuid
                           value:(NSData * _Nullable)value
                  characteristic:(Characteristic * _Nonnull)characteristic;

- (NSDictionary<NSString *, id> * _Nonnull)jsonObjectRepresentation;

@end
