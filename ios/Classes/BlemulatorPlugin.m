#import "BlemulatorPlugin.h"
#import <blemulator/blemulator-Swift.h>

@implementation BlemulatorPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftBlemulatorPlugin registerWithRegistrar:registrar];
}
@end
