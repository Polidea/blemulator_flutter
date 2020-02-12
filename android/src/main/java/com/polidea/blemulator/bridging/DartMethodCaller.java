package com.polidea.blemulator.bridging;

import androidx.annotation.Nullable;

import android.util.Log;

import com.polidea.blemulator.DeviceContainer;
import com.polidea.blemulator.bridging.constants.ArgumentName;
import com.polidea.blemulator.bridging.constants.DartMethodName;
import com.polidea.blemulator.bridging.constants.SimulationArgumentName;
import com.polidea.blemulator.bridging.decoder.CharacteristicDartValueDecoder;
import com.polidea.blemulator.bridging.decoder.DescriptorDartValueDecoder;
import com.polidea.blemulator.bridging.decoder.ServiceDartValueDecoder;
import com.polidea.multiplatformbleadapter.Characteristic;
import com.polidea.multiplatformbleadapter.ConnectionOptions;
import com.polidea.multiplatformbleadapter.Descriptor;
import com.polidea.multiplatformbleadapter.Device;
import com.polidea.multiplatformbleadapter.OnErrorCallback;
import com.polidea.multiplatformbleadapter.OnSuccessCallback;
import com.polidea.multiplatformbleadapter.Service;
import com.polidea.multiplatformbleadapter.utils.Base64Converter;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import io.flutter.plugin.common.MethodChannel;

public class DartMethodCaller {

    private static final String TAG = DartMethodCaller.class.getSimpleName();
    private MethodChannel dartMethodChannel;
    private JSONToBleErrorConverter jsonToBleErrorConverter = new JSONToBleErrorConverter();
    private DescriptorDartValueDecoder descriptorDartValueDecoder = new DescriptorDartValueDecoder();
    private CharacteristicDartValueDecoder characteristicJsonDecoder = new CharacteristicDartValueDecoder();
    private ServiceDartValueDecoder serviceDartValueDecoder = new ServiceDartValueDecoder();

    public DartMethodCaller(MethodChannel dartMethodChannel) {
        this.dartMethodChannel = dartMethodChannel;
    }

    public void createClient() {
        HashMap<String, Object> arguments = new HashMap<>();
        dartMethodChannel.invokeMethod(DartMethodName.CREATE_CLIENT,
                arguments,
                new MethodChannel.Result() {
                    @Override
                    public void success(@Nullable Object o) {
                        Log.d(TAG, "createClient SUCCESS");
                    }

                    @Override
                    public void error(String s, @Nullable String s1, @Nullable Object o) {
                        Log.e(TAG, s);
                    }

                    @Override
                    public void notImplemented() {
                        Log.e(TAG, "CREATE CLIENT not implemented");
                    }
                });
    }

    public void destroyClient() {
        dartMethodChannel.invokeMethod(DartMethodName.DESTROY_CLIENT,
                null,
                new MethodChannel.Result() {
                    @Override
                    public void success(@Nullable Object o) {
                        Log.d(TAG, "destroyClient SUCCESS");
                    }

                    @Override
                    public void error(String s, @Nullable String s1, @Nullable Object o) {
                        Log.e(TAG, s + " " + s1);
                    }

                    @Override
                    public void notImplemented() {
                        Log.e(TAG, "DESTROY CLIENT not implemented");
                    }
                });
    }

    public void startDeviceScan() {
        HashMap<String, Object> arguments = new HashMap<>();
        dartMethodChannel.invokeMethod(DartMethodName.START_DEVICE_SCAN,
                arguments,
                new MethodChannel.Result() {
                    @Override
                    public void success(@Nullable Object o) {
                        Log.d(TAG, "startDeviceScan SUCCESS");
                    }

                    @Override
                    public void error(String s, @Nullable String s1, @Nullable Object o) {
                        Log.e(TAG, s);
                    }

                    @Override
                    public void notImplemented() {
                        Log.e(TAG, "START DEVICE SCAN not implemented");
                    }
                });
    }

    public void stopDeviceScan() {
        dartMethodChannel.invokeMethod(DartMethodName.STOP_DEVICE_SCAN,
                null,
                new MethodChannel.Result() {
                    @Override
                    public void success(@Nullable Object o) {
                        Log.d(TAG, "stopDeviceScan SUCCESS");
                    }

                    @Override
                    public void error(String s, @Nullable String s1, @Nullable Object o) {
                        Log.e(TAG, s);
                    }

                    @Override
                    public void notImplemented() {
                        Log.e(TAG, "STOP DEVICE SCAN not implemented");
                    }
                });
    }

    public void connectToDevice(final String deviceIdentifier,
                                final String name,
                                ConnectionOptions connectionOptions,
                                final OnSuccessCallback<Device> onSuccessCallback,
                                final OnErrorCallback onErrorCallback) {
        HashMap<String, Object> arguments = new HashMap<String, Object>();
        arguments.put(SimulationArgumentName.DEVICE_ID, deviceIdentifier);
        dartMethodChannel.invokeMethod(DartMethodName.CONNECT_TO_DEVICE, arguments, new MethodChannel.Result() {
            @Override
            public void success(@Nullable Object o) {
                Log.d(TAG, "connectToDevice SUCCESS");
                onSuccessCallback.onSuccess(new Device(deviceIdentifier, name));
            }

            @Override
            public void error(String s, @Nullable String s1, @Nullable Object o) {
                Log.e(TAG, "connectToDevice error " + s1);
                onErrorCallback.onError(jsonToBleErrorConverter.bleErrorFromJSON(s1));
            }

            @Override
            public void notImplemented() {
                Log.e(TAG, "CONNECT TO DEVICE not implemented");
            }
        });
    }

    public void isDeviceConnected(String deviceIdentifier,
                                  final OnSuccessCallback<Boolean> onSuccessCallback,
                                  final OnErrorCallback onErrorCallback) {
        HashMap<String, Object> arguments = new HashMap<String, Object>();
        arguments.put(SimulationArgumentName.DEVICE_ID, deviceIdentifier);
        dartMethodChannel.invokeMethod(DartMethodName.IS_DEVICE_CONNECTED, arguments, new MethodChannel.Result() {
            @Override
            public void success(@Nullable Object o) {
                Log.d(TAG, "connectToDevice SUCCESS");
                onSuccessCallback.onSuccess((Boolean) o);
            }

            @Override
            public void error(String s, @Nullable String s1, @Nullable Object o) {
                Log.e(TAG, s);
                onErrorCallback.onError(jsonToBleErrorConverter.bleErrorFromJSON(s1));
            }

            @Override
            public void notImplemented() {
                Log.e(TAG, "CONNECT TO DEVICE not implemented");
            }
        });
    }

    public void disconnectOrCancelConnection(final String deviceIdentifier,
                                             final String name,
                                             final OnSuccessCallback<Device> onSuccessCallback,
                                             final OnErrorCallback onErrorCallback) {
        HashMap<String, Object> arguments = new HashMap<String, Object>();
        arguments.put(SimulationArgumentName.DEVICE_ID, deviceIdentifier);
        dartMethodChannel.invokeMethod(DartMethodName.DISCONNECT_OR_CANCEL_CONNECTION, arguments, new MethodChannel.Result() {
            @Override
            public void success(@Nullable Object o) {
                Log.d(TAG, "connectToDevice SUCCESS");
                onSuccessCallback.onSuccess(new Device(deviceIdentifier, name));
            }

            @Override
            public void error(String errorCode, @Nullable String jsonBody, @Nullable Object irrelevant) {
                onErrorCallback.onError(jsonToBleErrorConverter.bleErrorFromJSON(jsonBody));
            }

            @Override
            public void notImplemented() {
                Log.e(TAG, "CONNECT TO DEVICE not implemented");
            }
        });
    }

    public void discoverAllServicesAndCharacteristicsForDevice(
            final String deviceIdentifier,
            final String name,
            final String transactionId,
            final OnSuccessCallback<DeviceContainer> onSuccessCallback,
            final OnErrorCallback onErrorCallback) {
        dartMethodChannel.invokeMethod(DartMethodName.DISCOVER_ALL_SERVICES_AND_CHARACTERISTICS, new HashMap<String, Object>() {{
            put(ArgumentName.IDENTIFIER, deviceIdentifier);
            put(ArgumentName.TRANSACTION_ID, transactionId);
        }}, new MethodChannel.Result() {
            @Override
            public void success(@Nullable Object discoveryResponse) {
                onSuccessCallback.onSuccess(parseDiscoveryResponse(deviceIdentifier, name, discoveryResponse));
            }

            @Override
            public void error(String errorCode, @Nullable String jsonBody, @Nullable Object irrelevant) {
                onErrorCallback.onError(jsonToBleErrorConverter.bleErrorFromJSON(jsonBody));
            }

            @Override
            public void notImplemented() {
                Log.e(TAG, DartMethodName.DISCOVER_ALL_SERVICES_AND_CHARACTERISTICS + " not implemented");
            }
        });
    }

    private DeviceContainer parseDiscoveryResponse(String deviceIdentifier, String deviceName, Object responseObject) {
        List<Map<String, Object>> response = (List<Map<String, Object>>) responseObject;
        List<Service> services = new ArrayList<>();
        Map<String, List<CharacteristicContainer>> characteristics = new HashMap<>();
        for (Map<String, Object> mappedService : response) {
            Service service = serviceDartValueDecoder.decode(deviceIdentifier, mappedService);
            services.add(service);
            characteristics.put(
                    ((String) mappedService.get(SimulationArgumentName.SERVICE_UUID)).toUpperCase(),
                    parseCharacteristicsForServicesResponse(
                            (List<Map<String, Object>>) mappedService.get(SimulationArgumentName.CHARACTERISTICS))
            );
        }
        return new DeviceContainer(deviceIdentifier, deviceName, services, characteristics);
    }

    private List<CharacteristicContainer> parseCharacteristicsForServicesResponse(List<Map<String, Object>> response) {
        List<CharacteristicContainer> characteristicContainers = new ArrayList<>();
        for (Map<String, Object> mappedCharacteristic : response) {
            Characteristic characteristic = characteristicJsonDecoder.decode(mappedCharacteristic);

            List<Descriptor> descriptors = new ArrayList<>();
            for (Map<String, Object> mappedDescriptor : (List<Map<String, Object>>) mappedCharacteristic.get(SimulationArgumentName.DESCRIPTORS)) {
                descriptors.add(descriptorDartValueDecoder.decode(mappedDescriptor));
            }

            characteristicContainers.add(new CharacteristicContainer(characteristic, descriptors));
        }
        return characteristicContainers;
    }

    public void readCharacteristicForDevice(
            final String deviceIdentifier,
            final String serviceUUID,
            final String characteristicUUID,
            final String transactionId,
            final OnSuccessCallback<Characteristic> onSuccessCallback,
            final OnErrorCallback onErrorCallback) {
        HashMap<String, Object> arguments = new HashMap<String, Object>() {{
            put(ArgumentName.DEVICE_IDENTIFIER, deviceIdentifier);
            put(ArgumentName.SERVICE_UUID, serviceUUID);
            put(ArgumentName.CHARACTERISTIC_UUID, characteristicUUID);
            put(ArgumentName.TRANSACTION_ID, transactionId);
        }};
        dartMethodChannel.invokeMethod(DartMethodName.READ_CHARACTERISTIC_FOR_DEVICE,
                arguments,
                new MethodChannel.Result() {
                    @Override
                    public void success(@Nullable Object characteristicJsonObject) {
                        onSuccessCallback.onSuccess(characteristicJsonDecoder.decode((Map<String, Object>) characteristicJsonObject));
                    }

                    @Override
                    public void error(String errorCode, @Nullable String jsonBody, @Nullable Object irrelevant) {
                        onErrorCallback.onError(jsonToBleErrorConverter.bleErrorFromJSON(jsonBody));
                    }

                    @Override
                    public void notImplemented() {
                        Log.e(TAG, "readCharacteristicForDevice not implemented");
                    }
                });
    }

    public void readCharacteristicForService(
            final int serviceIdentifier,
            final String characteristicUUID,
            final String transactionId,
            final OnSuccessCallback<Characteristic> onSuccessCallback,
            final OnErrorCallback onErrorCallback) {
        HashMap<String, Object> arguments = new HashMap<String, Object>() {{
            put(ArgumentName.SERVICE_IDENTIFIER, serviceIdentifier);
            put(ArgumentName.CHARACTERISTIC_UUID, characteristicUUID);
            put(ArgumentName.TRANSACTION_ID, transactionId);
        }};
        dartMethodChannel.invokeMethod(DartMethodName.READ_CHARACTERISTIC_FOR_SERVICE,
                arguments,
                new MethodChannel.Result() {
                    @Override
                    public void success(@Nullable Object characteristicJsonObject) {
                        onSuccessCallback.onSuccess(characteristicJsonDecoder.decode((Map<String, Object>) characteristicJsonObject));
                    }

                    @Override
                    public void error(String errorCode, @Nullable String jsonBody, @Nullable Object irrelevant) {
                        onErrorCallback.onError(jsonToBleErrorConverter.bleErrorFromJSON(jsonBody));
                    }

                    @Override
                    public void notImplemented() {
                        Log.e(TAG, "readCharacteristicForService not implemented");
                    }
                });
    }

    public void readCharacteristic(
            final int characteristicIdentifier,
            final String transactionId,
            final OnSuccessCallback<Characteristic> onSuccessCallback,
            final OnErrorCallback onErrorCallback) {
        HashMap<String, Object> arguments = new HashMap<String, Object>() {{
            put(ArgumentName.CHARACTERISTIC_IDENTIFIER, characteristicIdentifier);
            put(ArgumentName.TRANSACTION_ID, transactionId);
        }};
        dartMethodChannel.invokeMethod(DartMethodName.READ_CHARACTERISTIC_FOR_IDENTIFIER,
                arguments,
                new MethodChannel.Result() {
                    @Override
                    public void success(@Nullable Object characteristicJsonObject) {
                        onSuccessCallback.onSuccess(characteristicJsonDecoder.decode((Map<String, Object>) characteristicJsonObject));
                    }

                    @Override
                    public void error(String errorCode, @Nullable String jsonBody, @Nullable Object irrelevant) {
                        onErrorCallback.onError(jsonToBleErrorConverter.bleErrorFromJSON(jsonBody));
                    }

                    @Override
                    public void notImplemented() {
                        Log.e(TAG, "readCharacteristic not implemented");
                    }
                });
    }

    public void writeCharacteristicForDevice(
            final String deviceIdentifier,
            final String serviceUUID,
            final String characteristicUUID,
            final String valueBase64,
            final String transactionId,
            final OnSuccessCallback<Characteristic> onSuccessCallback,
            final OnErrorCallback onErrorCallback) {
        HashMap<String, Object> arguments = new HashMap<String, Object>() {{
            put(ArgumentName.DEVICE_IDENTIFIER, deviceIdentifier);
            put(ArgumentName.SERVICE_UUID, serviceUUID);
            put(ArgumentName.CHARACTERISTIC_UUID, characteristicUUID);
            put(ArgumentName.VALUE, Base64Converter.decode(valueBase64));
            put(ArgumentName.TRANSACTION_ID, transactionId);
        }};
        dartMethodChannel.invokeMethod(DartMethodName.WRITE_CHARACTERISTIC_FOR_DEVICE,
                arguments,
                new MethodChannel.Result() {
                    @Override
                    public void success(@Nullable Object characteristicJsonObject) {
                        onSuccessCallback.onSuccess(characteristicJsonDecoder.decode((Map<String, Object>) characteristicJsonObject));
                    }

                    @Override
                    public void error(String errorCode, @Nullable String jsonBody, @Nullable Object irrelevant) {
                        onErrorCallback.onError(jsonToBleErrorConverter.bleErrorFromJSON(jsonBody));
                    }

                    @Override
                    public void notImplemented() {
                        Log.e(TAG, "writeCharacteristicForDevice not implemented");
                    }
                });
    }

    public void writeCharacteristicForService(
            final int serviceIdentifier,
            final String characteristicUUID,
            final String valueBase64,
            final String transactionId,
            final OnSuccessCallback<Characteristic> onSuccessCallback,
            final OnErrorCallback onErrorCallback) {
        HashMap<String, Object> arguments = new HashMap<String, Object>() {{
            put(ArgumentName.SERVICE_IDENTIFIER, serviceIdentifier);
            put(ArgumentName.CHARACTERISTIC_UUID, characteristicUUID);
            put(ArgumentName.VALUE, Base64Converter.decode(valueBase64));
            put(ArgumentName.TRANSACTION_ID, transactionId);
        }};
        dartMethodChannel.invokeMethod(DartMethodName.WRITE_CHARACTERISTIC_FOR_SERVICE,
                arguments,
                new MethodChannel.Result() {
                    @Override
                    public void success(@Nullable Object characteristicJsonObject) {
                        onSuccessCallback.onSuccess(characteristicJsonDecoder.decode((Map<String, Object>) characteristicJsonObject));
                    }

                    @Override
                    public void error(String errorCode, @Nullable String jsonBody, @Nullable Object irrelevant) {
                        onErrorCallback.onError(jsonToBleErrorConverter.bleErrorFromJSON(jsonBody));
                    }

                    @Override
                    public void notImplemented() {
                        Log.e(TAG, "writeCharacteristicForService not implemented");
                    }
                });
    }

    public void writeCharacteristic(
            final int characteristicIdentifier,
            final String valueBase64,
            final String transactionId,
            final OnSuccessCallback<Characteristic> onSuccessCallback,
            final OnErrorCallback onErrorCallback) {
        HashMap<String, Object> arguments = new HashMap<String, Object>() {{
            put(ArgumentName.CHARACTERISTIC_IDENTIFIER, characteristicIdentifier);
            put(ArgumentName.VALUE, Base64Converter.decode(valueBase64));
            put(ArgumentName.TRANSACTION_ID, transactionId);
        }};
        dartMethodChannel.invokeMethod(DartMethodName.WRITE_CHARACTERISTIC_FOR_IDENTIFIER,
                arguments,
                new MethodChannel.Result() {
                    @Override
                    public void success(@Nullable Object characteristicJsonObject) {
                        onSuccessCallback.onSuccess(characteristicJsonDecoder.decode((Map<String, Object>) characteristicJsonObject));
                    }

                    @Override
                    public void error(String errorCode, @Nullable String jsonBody, @Nullable Object irrelevant) {
                        onErrorCallback.onError(jsonToBleErrorConverter.bleErrorFromJSON(jsonBody));
                    }

                    @Override
                    public void notImplemented() {
                        Log.e(TAG, "writeCharacteristic not implemented");
                    }
                });
    }

    public void monitorCharacteristicForDevice(
            final String deviceIdentifier,
            final String serviceUUID,
            final String characteristicUUID,
            final String transactionId,
            final OnErrorCallback onErrorCallback) {
        HashMap<String, Object> arguments = new HashMap<String, Object>() {{
            put(ArgumentName.DEVICE_IDENTIFIER, deviceIdentifier);
            put(ArgumentName.SERVICE_UUID, serviceUUID);
            put(ArgumentName.CHARACTERISTIC_UUID, characteristicUUID);
            put(ArgumentName.TRANSACTION_ID, transactionId);
        }};
        dartMethodChannel.invokeMethod(DartMethodName.MONITOR_CHARACTERISTIC_FOR_DEVICE,
                arguments,
                new MethodChannel.Result() {
                    @Override
                    public void success(@Nullable Object characteristicJsonObject) {
                        Log.i(TAG, "monitorCharacteristicForDevice SUCCESS");
                    }

                    @Override
                    public void error(String errorCode, @Nullable String jsonBody, @Nullable Object irrelevant) {
                        onErrorCallback.onError(jsonToBleErrorConverter.bleErrorFromJSON(jsonBody));
                    }

                    @Override
                    public void notImplemented() {
                        Log.e(TAG, "monitorCharacteristicForDevice not implemented");
                    }
                });
    }

    public void monitorCharacteristicForService(
            final int serviceIdentifier,
            final String characteristicUUID,
            final String transactionId,
            final OnErrorCallback onErrorCallback) {
        HashMap<String, Object> arguments = new HashMap<String, Object>() {{
            put(ArgumentName.SERVICE_IDENTIFIER, serviceIdentifier);
            put(ArgumentName.CHARACTERISTIC_UUID, characteristicUUID);
            put(ArgumentName.TRANSACTION_ID, transactionId);
        }};
        dartMethodChannel.invokeMethod(DartMethodName.MONITOR_CHARACTERISTIC_FOR_SERVICE,
                arguments,
                new MethodChannel.Result() {
                    @Override
                    public void success(@Nullable Object characteristicJsonObject) {
                        Log.i(TAG, "monitorCharacteristicForService SUCCESS");
                    }

                    @Override
                    public void error(String errorCode, @Nullable String jsonBody, @Nullable Object irrelevant) {
                        onErrorCallback.onError(jsonToBleErrorConverter.bleErrorFromJSON(jsonBody));
                    }

                    @Override
                    public void notImplemented() {
                        Log.e(TAG, "monitorCharacteristicForService not implemented");
                    }
                });
    }

    public void monitorCharacteristic(
            final int characteristicIdentifier,
            final String transactionId,
            final OnErrorCallback onErrorCallback) {
        HashMap<String, Object> arguments = new HashMap<String, Object>() {{
            put(ArgumentName.CHARACTERISTIC_IDENTIFIER, characteristicIdentifier);
            put(ArgumentName.TRANSACTION_ID, transactionId);
        }};
        dartMethodChannel.invokeMethod(DartMethodName.MONITOR_CHARACTERISTIC_FOR_IDENTIFIER,
                arguments,
                new MethodChannel.Result() {
                    @Override
                    public void success(@Nullable Object characteristicJsonObject) {
                        Log.i(TAG, "monitorCharacteristic SUCCESS");
                    }

                    @Override
                    public void error(String errorCode, @Nullable String jsonBody, @Nullable Object irrelevant) {
                        onErrorCallback.onError(jsonToBleErrorConverter.bleErrorFromJSON(jsonBody));
                    }

                    @Override
                    public void notImplemented() {
                        Log.e(TAG, "monitorCharacteristic not implemented");
                    }
                });
    }

    public void readDescriptorForDevice(final String deviceId,
                                        final String serviceUUID,
                                        final String characteristicUUID,
                                        final String descriptorUUID,
                                        final String transactionId,
                                        final OnSuccessCallback<Descriptor> successCallback,
                                        final OnErrorCallback errorCallback) {
        Map<String, Object> arguments = new HashMap<String, Object>() {{
            put(ArgumentName.DEVICE_IDENTIFIER, deviceId);
            put(ArgumentName.SERVICE_UUID, serviceUUID);
            put(ArgumentName.CHARACTERISTIC_UUID, characteristicUUID);
            put(ArgumentName.DESCRIPTOR_UUID, descriptorUUID);
            put(ArgumentName.TRANSACTION_ID, transactionId);
        }};

        dartMethodChannel.invokeMethod(
                DartMethodName.READ_DESCRIPTOR_FOR_DEVICE,
                arguments,
                new MethodChannel.Result() {
                    @Override
                    public void success(Object descriptorJsonObject) {
                        successCallback.onSuccess(descriptorDartValueDecoder.decode((Map<String, Object>) descriptorJsonObject));
                    }

                    @Override
                    public void error(String errorCode, String jsonBody, Object irrelevant) {
                        errorCallback.onError(jsonToBleErrorConverter.bleErrorFromJSON(jsonBody));
                    }

                    @Override
                    public void notImplemented() {
                        Log.e(TAG, "readDescriptorForDevice not implemented");
                    }
                });
    }

    public void readDescriptorForService(final int serviceIdentifier,
                                         final String characteristicUUID,
                                         final String descriptorUUID,
                                         final String transactionId,
                                         final OnSuccessCallback<Descriptor> successCallback,
                                         final OnErrorCallback errorCallback) {
        Map<String, Object> arguments = new HashMap<String, Object>() {{
            put(ArgumentName.SERVICE_IDENTIFIER, serviceIdentifier);
            put(ArgumentName.CHARACTERISTIC_UUID, characteristicUUID);
            put(ArgumentName.DESCRIPTOR_UUID, descriptorUUID);
            put(ArgumentName.TRANSACTION_ID, transactionId);
        }};

        dartMethodChannel.invokeMethod(
                DartMethodName.READ_DESCRIPTOR_FOR_DEVICE,
                arguments,
                new MethodChannel.Result() {
                    @Override
                    public void success(Object descriptorJsonObject) {
                        successCallback.onSuccess(descriptorDartValueDecoder.decode((Map<String, Object>) descriptorJsonObject));
                    }

                    @Override
                    public void error(String errorCode, String jsonBody, Object irrelevant) {
                        errorCallback.onError(jsonToBleErrorConverter.bleErrorFromJSON(jsonBody));
                    }

                    @Override
                    public void notImplemented() {
                        Log.e(TAG, "readDescriptorForService not implemented");
                    }
                });
    }

    public void readDescriptorForCharacteristic(final int characteristicIdentifier,
                                                final String descriptorUUID,
                                                final String transactionId,
                                                final OnSuccessCallback<Descriptor> successCallback,
                                                final OnErrorCallback errorCallback) {
        Map<String, Object> arguments = new HashMap<String, Object>() {{
            put(ArgumentName.CHARACTERISTIC_IDENTIFIER, characteristicIdentifier);
            put(ArgumentName.DESCRIPTOR_UUID, descriptorUUID);
            put(ArgumentName.TRANSACTION_ID, transactionId);
        }};

        dartMethodChannel.invokeMethod(
                DartMethodName.READ_DESCRIPTOR_FOR_DEVICE,
                arguments,
                new MethodChannel.Result() {
                    @Override
                    public void success(Object descriptorJsonObject) {
                        successCallback.onSuccess(descriptorDartValueDecoder.decode((Map<String, Object>) descriptorJsonObject));
                    }

                    @Override
                    public void error(String errorCode, String jsonBody, Object irrelevant) {
                        errorCallback.onError(jsonToBleErrorConverter.bleErrorFromJSON(jsonBody));
                    }

                    @Override
                    public void notImplemented() {
                        Log.e(TAG, "readDescriptorForCharacteristic not implemented");
                    }
                });
    }

    public void readDescriptor(final int descriptorIdentifier,
                               final String transactionId,
                               final OnSuccessCallback<Descriptor> successCallback,
                               final OnErrorCallback errorCallback) {
        Map<String, Object> arguments = new HashMap<String, Object>() {{
            put(ArgumentName.DESCRIPTOR_IDENTIFIER, descriptorIdentifier);
            put(ArgumentName.TRANSACTION_ID, transactionId);
        }};

        dartMethodChannel.invokeMethod(
                DartMethodName.READ_DESCRIPTOR_FOR_DEVICE,
                arguments,
                new MethodChannel.Result() {
                    @Override
                    public void success(Object descriptorJsonObject) {
                        successCallback.onSuccess(descriptorDartValueDecoder.decode((Map<String, Object>) descriptorJsonObject));
                    }

                    @Override
                    public void error(String errorCode, String jsonBody, Object irrelevant) {
                        errorCallback.onError(jsonToBleErrorConverter.bleErrorFromJSON(jsonBody));
                    }

                    @Override
                    public void notImplemented() {
                        Log.e(TAG, "readDescriptor not implemented");
                    }
                });
    }

    public void writeDescriptorForDevice(final String deviceId,
                                         final String serviceUUID,
                                         final String characteristicUUID,
                                         final String descriptorUUID,
                                         final String valueBase64,
                                         final String transactionId,
                                         final OnSuccessCallback<Descriptor> successCallback,
                                         final OnErrorCallback errorCallback) {
        Map<String, Object> arguments = new HashMap<String, Object>() {{
            put(ArgumentName.DEVICE_IDENTIFIER, deviceId);
            put(ArgumentName.SERVICE_UUID, serviceUUID);
            put(ArgumentName.CHARACTERISTIC_UUID, characteristicUUID);
            put(ArgumentName.DESCRIPTOR_UUID, descriptorUUID);
            put(ArgumentName.TRANSACTION_ID, transactionId);
            put(ArgumentName.VALUE, Base64Converter.decode(valueBase64));
        }};

        dartMethodChannel.invokeMethod(
                DartMethodName.WRITE_DESCRIPTOR_FOR_DEVICE,
                arguments,
                new MethodChannel.Result() {
                    @Override
                    public void success(Object descriptorJsonObject) {
                        successCallback.onSuccess(descriptorDartValueDecoder.decode((Map<String, Object>) descriptorJsonObject));
                    }

                    @Override
                    public void error(String errorCode, String jsonBody, Object irrelevant) {
                        errorCallback.onError(jsonToBleErrorConverter.bleErrorFromJSON(jsonBody));
                    }

                    @Override
                    public void notImplemented() {
                        Log.e(TAG, "writeDescriptorForDevice not implemented");
                    }
                });
    }

    public void writeDescriptorForService(final int serviceIdentifier,
                                          final String characteristicUUID,
                                          final String descriptorUUID,
                                          final String valueBase64,
                                          final String transactionId,
                                          final OnSuccessCallback<Descriptor> successCallback,
                                          final OnErrorCallback errorCallback) {
        Map<String, Object> arguments = new HashMap<String, Object>() {{
            put(ArgumentName.SERVICE_IDENTIFIER, serviceIdentifier);
            put(ArgumentName.CHARACTERISTIC_UUID, characteristicUUID);
            put(ArgumentName.DESCRIPTOR_UUID, descriptorUUID);
            put(ArgumentName.TRANSACTION_ID, transactionId);
            put(ArgumentName.VALUE, Base64Converter.decode(valueBase64));
        }};

        dartMethodChannel.invokeMethod(
                DartMethodName.WRITE_DESCRIPTOR_FOR_SERVICE,
                arguments,
                new MethodChannel.Result() {
                    @Override
                    public void success(Object descriptorJsonObject) {
                        successCallback.onSuccess(descriptorDartValueDecoder.decode((Map<String, Object>) descriptorJsonObject));
                    }

                    @Override
                    public void error(String errorCode, String jsonBody, Object irrelevant) {
                        errorCallback.onError(jsonToBleErrorConverter.bleErrorFromJSON(jsonBody));
                    }

                    @Override
                    public void notImplemented() {
                        Log.e(TAG, "writeDescriptorForService not implemented");
                    }
                });
    }

    public void writeDescriptorForCharacteristic(final int characteristicIdentifier,
                                                 final String descriptorUUID,
                                                 final String valueBase64,
                                                 final String transactionId,
                                                 final OnSuccessCallback<Descriptor> successCallback,
                                                 final OnErrorCallback errorCallback) {
        Map<String, Object> arguments = new HashMap<String, Object>() {{
            put(ArgumentName.CHARACTERISTIC_IDENTIFIER, characteristicIdentifier);
            put(ArgumentName.DESCRIPTOR_UUID, descriptorUUID);
            put(ArgumentName.TRANSACTION_ID, transactionId);
            put(ArgumentName.VALUE, Base64Converter.decode(valueBase64));
        }};

        dartMethodChannel.invokeMethod(
                DartMethodName.WRITE_DESCRIPTOR_FOR_CHARACTERISTIC,
                arguments,
                new MethodChannel.Result() {
                    @Override
                    public void success(Object descriptorJsonObject) {
                        successCallback.onSuccess(descriptorDartValueDecoder.decode((Map<String, Object>) descriptorJsonObject));
                    }

                    @Override
                    public void error(String errorCode, String jsonBody, Object irrelevant) {
                        errorCallback.onError(jsonToBleErrorConverter.bleErrorFromJSON(jsonBody));
                    }

                    @Override
                    public void notImplemented() {
                        Log.e(TAG, "writeDescriptorForCharacteristic not implemented");
                    }
                });
    }

    public void writeDescriptor(final int descriptorIdentifier,
                                final String valueBase64,
                                final String transactionId,
                                final OnSuccessCallback<Descriptor> successCallback,
                                final OnErrorCallback errorCallback) {
        Map<String, Object> arguments = new HashMap<String, Object>() {{
            put(ArgumentName.DESCRIPTOR_IDENTIFIER, descriptorIdentifier);
            put(ArgumentName.TRANSACTION_ID, transactionId);
            put(ArgumentName.VALUE, Base64Converter.decode(valueBase64));
        }};

        dartMethodChannel.invokeMethod(
                DartMethodName.WRITE_DESCRIPTOR_FOR_IDENTIFIER,
                arguments,
                new MethodChannel.Result() {
                    @Override
                    public void success(Object descriptorJsonObject) {
                        successCallback.onSuccess(descriptorDartValueDecoder.decode((Map<String, Object>) descriptorJsonObject));
                    }

                    @Override
                    public void error(String errorCode, String jsonBody, Object irrelevant) {
                        errorCallback.onError(jsonToBleErrorConverter.bleErrorFromJSON(jsonBody));
                    }

                    @Override
                    public void notImplemented() {
                        Log.e(TAG, "writeDescriptor not implemented");
                    }
                });
    }

    public void readRSSIForDevice(final String deviceIdentifier,
                                  final OnSuccessCallback<Device> onSuccessCallback,
                                  final OnErrorCallback onErrorCallback) {
        HashMap<String, Object> arguments = new HashMap<String, Object>();
        arguments.put(SimulationArgumentName.DEVICE_ID, deviceIdentifier);
        dartMethodChannel.invokeMethod(DartMethodName.RSSI, arguments, new MethodChannel.Result() {
            @Override
            public void success(@Nullable Object rssi) {
                Log.d(TAG, "Fetch RSSI");
                String placeholderName = "Simulated device"; // the name does not matter but API of MBA requires it
                Device device = new Device(deviceIdentifier, placeholderName);
                device.setRssi((int) rssi);
                onSuccessCallback.onSuccess(device);
            }

            @Override
            public void error(String s, @Nullable String s1, @Nullable Object o) {
                Log.e(TAG, "Error during reading rssi of simulating peripheral: " + s1);
                onErrorCallback.onError(jsonToBleErrorConverter.bleErrorFromJSON(s1));
            }

            @Override
            public void notImplemented() {
                Log.e(TAG, "readRSSIForDevice not implemented");
            }
        });
    }

    public void requestMTUForDevice(final String deviceIdentifier,
                                    final int mtu,
                                    final OnSuccessCallback<Device> onSuccessCallback,
                                    final OnErrorCallback onErrorCallback) {
        HashMap<String, Object> arguments = new HashMap<String, Object>();
        arguments.put(SimulationArgumentName.DEVICE_IDENTIFIER, deviceIdentifier);
        arguments.put(SimulationArgumentName.MTU, mtu);
        dartMethodChannel.invokeMethod(DartMethodName.REQUEST_MTU, arguments, new MethodChannel.Result() {
            @Override
            public void success(@Nullable Object mtu) {
                Log.d(TAG, "request MTU");
                String placeholderName = "Simulated device"; // the name does not matter but API of MBA requires it
                Device device = new Device(deviceIdentifier, placeholderName);
                device.setMtu((int) mtu);
                onSuccessCallback.onSuccess(device);
            }

            @Override
            public void error(String s, @Nullable String s1, @Nullable Object o) {
                Log.e(TAG, "Error during requesting MTU of simulating peripheral: " + s1);
                onErrorCallback.onError(jsonToBleErrorConverter.bleErrorFromJSON(s1));
            }

            @Override
            public void notImplemented() {
                Log.e(TAG, "requestMTUForDevice not implemented");
            }
        });
    }

    public void cancelTransaction(final String transactionId,
                                  final OnSuccessCallback<Void> onSuccessCallback) {
        Log.i(TAG, "cancelTransaction");
        dartMethodChannel.invokeMethod(DartMethodName.CANCEL_TRANSACTION, new HashMap<String, String>() {{
            put(ArgumentName.TRANSACTION_ID, transactionId);
        }}, new MethodChannel.Result() {
            @Override
            public void success(@Nullable Object o) {
                if (onSuccessCallback != null) {
                    onSuccessCallback.onSuccess(null);
                }
            }

            @Override
            public void error(String s, @Nullable String jsonBody, @Nullable Object o) {
                Log.e(TAG, "Error while cancelling transaction with id: " + transactionId + "}. " + jsonBody);
                if (onSuccessCallback != null) {
                    onSuccessCallback.onSuccess(null);
                }
            }

            @Override
            public void notImplemented() {
                Log.e(TAG, "cancelTransaction not implemented");
            }
        });
    }
}
