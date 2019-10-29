@interface Peripheral : NSObject

@property NSString * _Nonnull identifier;
@property NSString * _Nullable name;
@property NSNumber * _Nullable mtu;

- (instancetype _Nonnull)initWithIdentifier:(NSString * _Nonnull)identifier
                                       name:(NSString * _Nullable)name;

- (NSDictionary<NSString *,id> * _Nonnull)jsonObjectRepresentation;

- (NSDictionary<NSString *,id> * _Nonnull)jsonObjectRepresentationWithRssi:(NSNumber * _Nonnull)rssi;

@end
