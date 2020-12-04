#import "Base64Coder.h"

@implementation Base64Coder

+ (NSString *)base64StringFromData:(NSData *)data {
    return [data base64EncodedStringWithOptions:nil];
}

+ (NSData *)dataFromBase64String:(NSString *)string {
    return [[NSData alloc] initWithBase64EncodedString:string options:0];
}

@end
