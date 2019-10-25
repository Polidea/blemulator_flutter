#import <Flutter/Flutter.h>

@interface BlemulatorPlugin : NSObject<FlutterPlugin>

- (instancetype)initWithPlatformToDartChannel:(FlutterMethodChannel *)platformToDartChannel;

@end
