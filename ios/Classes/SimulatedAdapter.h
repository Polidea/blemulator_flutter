#import "DartMethodCaller.h"
#import "DartValueHandler.h"
@import MultiplatformBleAdapter;

@protocol BleAdapter;

@interface SimulatedAdapter : NSObject<BleAdapter, DartValueHandlerScanEventDelegate, DartValueHandlerConnectionEventDelegate, DartValueHandlerReadEventDelegate>

- (instancetype)initWithDartMethodCaller:(DartMethodCaller *)dartMethodCaller
                        dartValueHandler:(DartValueHandler *)dartValueHandler;

@end
