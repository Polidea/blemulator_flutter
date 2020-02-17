#import "Characteristic.h"
#import "Descriptor.h"

@interface CharacteristicContainer : NSObject

@property (readonly) Characteristic *characteristic;
@property (readonly) NSArray<Descriptor *> *descriptors;

- (instancetype)initWithCharacteristic:(Characteristic *)characteristic
                           descriptors:(NSArray<Descriptor *> *)descriptors;

- (NSArray *)descriptorsJsonRepresentation;

@end

