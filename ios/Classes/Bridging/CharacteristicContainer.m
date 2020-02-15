#import "CharacteristicContainer.h"

@interface CharacteristicContainer ()

@property (readwrite) Characteristic *characteristic;
@property (readwrite) NSArray<Descriptor *> *descriptors;

@end

@implementation CharacteristicContainer

- (instancetype)initWithCharacteristic:(Characteristic *)characteristic descriptors:(NSArray *)descriptors {
    self = [super init];
    if (self) {
        self.characteristic = characteristic;
        self.descriptors = descriptors;
    }
    return self;
}

- (NSArray *)descriptorsJsonRepresentationForCharacteristic {
    NSMutableArray *result = [[NSMutableArray alloc] init];
    for (Descriptor *descriptor in self.descriptors) {
        [result addObject:[descriptor jsonObjectRepresentation]];
    }
    
    return result;
}

@end
