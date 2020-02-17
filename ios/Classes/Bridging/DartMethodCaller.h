#import <Flutter/Flutter.h>
#import "BlemulatorCommonTypes.h"

@interface DartMethodCaller : NSObject

- (instancetype)initWithDartMethodChannel:(FlutterMethodChannel *)dartMethodChannel;

// MARK: - Methods - Lifecycle

- (void)createClient;

// MARK: - Methods - Scanning

- (void)startDeviceScan;

- (void)stopDeviceScan;

// MARK: - Methods - Connection

- (void)connectToDevice:(NSString *)deviceIdentifier
                   name:(NSString *)name
                options:(NSDictionary<NSString *,id> *)options
                resolve:(Resolve)resolve
                 reject:(Reject)reject;

- (void)cancelDeviceConnection:(NSString *)deviceIdentifier
                          name:(NSString *)name
                       resolve:(Resolve)resolve
                        reject:(Reject)reject;

- (void)isDeviceConnected:(NSString *)deviceIdentifier
                  resolve:(Resolve)resolve
                   reject:(Reject)reject;

// MARK: - Discovery

- (void)discoverAllServicesAndCharacteristics:(NSString *)deviceIdentifier
                                         name:(NSString *)name
                                transactionId:(NSString *)transactionId
                                      resolve:(Resolve)resolve
                                       reject:(Reject)reject;

// MARK: - Characteristics observation

- (void)readCharacteristicForDevice:(NSString *)deviceIdentifier
                        serviceUUID:(NSString *)serviceUUID
                 characteristicUUID:(NSString *)characteristicUUID
                      transactionId:(NSString *)transactionId
                            resolve:(Resolve)resolve
                             reject:(Reject)reject;

- (void)readCharacteristicForService:(int)serviceIdentifier
                  characteristicUUID:(NSString *)characteristicUUID
                       transactionId:(NSString *)transactionId
                             resolve:(Resolve)resolve
                              reject:(Reject)reject;

- (void)readCharacteristic:(int)characteristicIdentifier
             transactionId:(NSString *)transactionId
                   resolve:(Resolve)resolve
                    reject:(Reject)reject;

- (void)writeCharacteristicForDevice:(NSString *)deviceIdentifier
                         serviceUUID:(NSString *)serviceUUID
                  characteristicUUID:(NSString *)characteristicUUID
                               value:(NSString *)value
                       transactionId:(NSString *)transactionId
                             resolve:(Resolve)resolve
                              reject:(Reject)reject;

- (void)writeCharacteristicForService:(int)serviceIdentifier
                   characteristicUUID:(NSString *)characteristicUUID
                                value:(NSString *)value
                        transactionId:(NSString *)transactionId
                              resolve:(Resolve)resolve
                               reject:(Reject)reject;

- (void)writeCharacteristic:(int)characteristicIdentifier
                      value:(NSString *)value
              transactionId:(NSString *)transactionId
                    resolve:(Resolve)resolve
                     reject:(Reject)reject;

- (void)monitorCharacteristicForDevice:(NSString *)deviceIdentifier
                           serviceUUID:(NSString *)serviceUUID
                    characteristicUUID:(NSString *)characteristicUUID
                         transactionId:(NSString *)transactionId
                               resolve:(Resolve)resolve
                                reject:(Reject)reject;

- (void)monitorCharacteristicForService:(int)serviceIdentifier
                     characteristicUUID:(NSString *)characteristicUUID
                          transactionId:(NSString *)transactionId
                                resolve:(Resolve)resolve
                                 reject:(Reject)reject;

- (void)monitorCharacteristic:(int)characteristicIdentifier
                transactionId:(NSString *)transactionId
                      resolve:(Resolve)resolve
                       reject:(Reject)reject;


// MARK: - Descriptors

- (void)readDescriptorForIdentifier:(int)descriptorIdentifier
                      transactionId:(NSString *)transactionId
                            resolve:(Resolve)resolve
                             reject:(Reject)reject;

- (void)readDescriptorForCharacteristic:(int)characteristicIdentifier
                         descriptorUuid:(NSString *)descriptorUuid
                          transactionId:(NSString *)transactionId
                                resolve:(Resolve)resolve
                                 reject:(Reject)reject;

- (void)readDescriptorForService:(int)serviceIdentifier
              characteristicUuid:(NSString *)characteristicUuid
                  descriptorUuid:(NSString *)descriptorUuid
                   transactionId:(NSString *)transactionId
                         resolve:(Resolve)resolve
                          reject:(Reject)reject;

- (void)readDescriptorForDevice:(NSString *)deviceIdentifier
                    serviceUuid:(NSString *)serviceUuid
             characteristicUuid:(NSString *)characteristicUuid
                 descriptorUuid:(NSString *)descriptorUuid
                  transactionId:(NSString *)transactionId
                        resolve:(Resolve)resolve
                         reject:(Reject)reject;

- (void)writeDescriptorForIdentifier:(int)descriptorIdentifier
                       transactionId:(NSString *)transactionId
                               value:(NSString *)value
                             resolve:(Resolve)resolve
                              reject:(Reject)reject;

- (void)writeDescriptorForCharacteristic:(int)characteristicIdentifier
                          descriptorUuid:(NSString *)descriptorUuid
                           transactionId:(NSString *)transactionId
                                   value:(NSString *)value
                                 resolve:(Resolve)resolve
                                  reject:(Reject)reject;

- (void)writeDescriptorForService:(int)serviceIdentifier
               characteristicUuid:(NSString *)characteristicUuid
                   descriptorUuid:(NSString *)descriptorUuid
                    transactionId:(NSString *)transactionId
                            value:(NSString *)value
                          resolve:(Resolve)resolve
                           reject:(Reject)reject;

- (void)writeDescriptorForDevice:(NSString *)deviceIdentifier
                     serviceUuid:(NSString *)serviceUuid
              characteristicUuid:(NSString *)characteristicUuid
                  descriptorUuid:(NSString *)descriptorUuid
                   transactionId:(NSString *)transactionId
                           value:(NSString *)value
                         resolve:(Resolve)resolve
                          reject:(Reject)reject;

// MARK: - MTU

- (void)requestMTUForDevice:(NSString *)deviceIdentifier
                       name:(NSString *)name
                    resolve:(Resolve)resolve
                     reject:(Reject)reject;

// MARK: - RSSI

- (void)readRSSIForDevice:(NSString *)deviceIdentifier
                     name:(NSString *)name
                  resolve:(Resolve)resolve
                   reject:(Reject)reject;

// MARK: - Cancel transaction

- (void)cancelTransaction:(NSString *)transactionId;

@end
