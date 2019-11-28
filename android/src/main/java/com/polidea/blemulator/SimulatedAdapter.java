package com.polidea.blemulator;

import android.util.Log;

import com.polidea.blemulator.bridging.DartMethodCaller;
import com.polidea.blemulator.bridging.DartValueHandler;
import com.polidea.multiplatformbleadapter.BleAdapter;
import com.polidea.multiplatformbleadapter.Characteristic;
import com.polidea.multiplatformbleadapter.ConnectionOptions;
import com.polidea.multiplatformbleadapter.ConnectionState;
import com.polidea.multiplatformbleadapter.Device;
import com.polidea.multiplatformbleadapter.OnErrorCallback;
import com.polidea.multiplatformbleadapter.OnEventCallback;
import com.polidea.multiplatformbleadapter.OnSuccessCallback;
import com.polidea.multiplatformbleadapter.ScanResult;
import com.polidea.multiplatformbleadapter.Service;
import com.polidea.multiplatformbleadapter.errors.BleError;
import com.polidea.multiplatformbleadapter.errors.BleErrorCode;
import com.polidea.multiplatformbleadapter.utils.Constants;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

public class SimulatedAdapter implements BleAdapter {

    private static final String TAG = SimulatedAdapter.class.getSimpleName();

    private Map<String, DeviceContainer> knownPeripherals = new HashMap<>();
    private DartMethodCaller dartMethodCaller;
    private DartValueHandler dartValueHandler;
    private String logLevel = Constants.BluetoothLogLevel.NONE;
    private String bluetoothState = Constants.BluetoothState.POWERED_ON;

    SimulatedAdapter(DartMethodCaller dartMethodCaller, DartValueHandler dartValueHandler) {
        this.dartMethodCaller = dartMethodCaller;
        this.dartValueHandler = dartValueHandler;
    }

    @Override
    public void createClient(String restoreStateIdentifier,
                             OnEventCallback<String> onAdapterStateChangeCallback,
                             OnEventCallback<Integer> onStateRestored) {
        onStateRestored.onEvent(null);
        dartMethodCaller.createClient();
        Log.i(TAG, "createClient");
    }

    @Override
    public void destroyClient() {
        dartMethodCaller.destroyClient();
        Log.i(TAG, "destroyClient");
    }

    @Override
    public void enable(String transactionId,
                       OnSuccessCallback<Void> onSuccessCallback,
                       OnErrorCallback onErrorCallback) {
        Log.i(TAG, "enable");
        bluetoothState = Constants.BluetoothState.POWERED_ON;
        onSuccessCallback.onSuccess(null);

    }

    @Override
    public void disable(String transactionId,
                        OnSuccessCallback<Void> onSuccessCallback,
                        OnErrorCallback onErrorCallback) {
        Log.i(TAG, "disable");
        bluetoothState = Constants.BluetoothState.POWERED_OFF;
        onSuccessCallback.onSuccess(null);
    }

    @Override
    public String getCurrentState() {
        Log.i(TAG, "getCurrentState");
        return bluetoothState;
    }

    @Override
    public void startDeviceScan(String[] filteredUUIDs,
                                int scanMode,
                                int callbackType,
                                final OnEventCallback<ScanResult> onEventCallback,
                                OnErrorCallback onErrorCallback) {
        Log.i(TAG, "startDeviceScan");

        OnEventCallback<ScanResult> resultCallback = new OnEventCallback<ScanResult>() {
            @Override
            public void onEvent(ScanResult data) {
                if (!knownPeripherals.containsKey(data.getDeviceId())) {
                    knownPeripherals.put(
                            data.getDeviceId(),
                            new DeviceContainer(data.getDeviceId(), data.getDeviceName(), null, null)
                    );
                }

                onEventCallback.onEvent(data);
            }
        };

        dartValueHandler.setScanResultPublisher(resultCallback);
        dartMethodCaller.startDeviceScan();
    }

    @Override
    public void stopDeviceScan() {
        Log.i(TAG, "stopDeviceScan");
        dartMethodCaller.stopDeviceScan();
        dartValueHandler.setScanResultPublisher(null);
    }

    @Override
    public void requestConnectionPriorityForDevice(String deviceIdentifier,
                                                   int connectionPriority,
                                                   String transactionId,
                                                   OnSuccessCallback<Device> onSuccessCallback,
                                                   OnErrorCallback onErrorCallback) {
        Log.i(TAG, "requestConnectionPriorityForDevice");
    }

    @Override
    public void readRSSIForDevice(String deviceIdentifier,
                                  String transactionId,
                                  OnSuccessCallback<Device> onSuccessCallback,
                                  OnErrorCallback onErrorCallback) {
        Log.i(TAG, "readRSSIForDevice");
        dartMethodCaller.readRSSIForDevice(deviceIdentifier, onSuccessCallback, onErrorCallback);
    }

    @Override
    public void requestMTUForDevice(String deviceIdentifier,
                                    int mtu, String transactionId,
                                    OnSuccessCallback<Device> onSuccessCallback,
                                    OnErrorCallback onErrorCallback) {
        Log.i(TAG, "requestMTUForDevice");
        dartMethodCaller.requestMTUForDevice(deviceIdentifier, mtu, onSuccessCallback, onErrorCallback);
    }

    @Override
    public void getKnownDevices(String[] deviceIdentifiers,
                                OnSuccessCallback<Device[]> onSuccessCallback,
                                OnErrorCallback onErrorCallback) {
        Log.i(TAG, "getKnownDevices");
        if (deviceIdentifiers.length == 0) {
            Log.d(TAG, "There is no deviceIdentifiers, return empty list");
            onSuccessCallback.onSuccess(new Device[0]);
            return;
        }
        List<Device> filteredDevices = new ArrayList<>();
        for (String deviceId : deviceIdentifiers) {
            if (knownPeripherals.containsKey(deviceId)) {
                DeviceContainer deviceContainer = knownPeripherals.get(deviceId);
                Device device = new Device(deviceContainer.getIdentifier(), deviceContainer.getName());
                device.setServices(deviceContainer.getServices());
                filteredDevices.add(device);
            }
        }
        onSuccessCallback.onSuccess(filteredDevices.toArray(new Device[filteredDevices.size()]));
    }

    @Override
    public void getConnectedDevices(String[] serviceUUIDs,
                                    OnSuccessCallback<Device[]> onSuccessCallback,
                                    OnErrorCallback onErrorCallback) {
        Log.i(TAG, "getConnectedDevices");
        if (serviceUUIDs.length == 0) {
            Log.d(TAG, "There is no servicesUUID, return empty list");
            onSuccessCallback.onSuccess(new Device[0]);
            return;
        }

        List<Device> filteredDevices = new ArrayList<>();
        for (String serviceUuid : serviceUUIDs) {
            for (Map.Entry<String, DeviceContainer> entry : knownPeripherals.entrySet()) {
                DeviceContainer deviceContainer = entry.getValue();
                if (!deviceContainer.isConnected() || deviceContainer.getServices() == null) {
                    continue;
                }
                for (Service service : deviceContainer.getServices()) {
                    if (serviceUuid.equalsIgnoreCase(service.getUuid().toString())) {
                        Device device = new Device(deviceContainer.getIdentifier(), deviceContainer.getName());
                        device.setServices(deviceContainer.getServices());
                        filteredDevices.add(device);
                    }
                }
            }
        }
        onSuccessCallback.onSuccess(filteredDevices.toArray(new Device[filteredDevices.size()]));
    }

    @Override
    public void connectToDevice(final String deviceIdentifier,
                                ConnectionOptions connectionOptions,
                                OnSuccessCallback<Device> onSuccessCallback,
                                final OnEventCallback<ConnectionState> onConnectionStateChangedCallback,
                                OnErrorCallback onErrorCallback) {
        Log.i(TAG, "connectToDevice");

        OnEventCallback<ConnectionState> onEventCallback = new OnEventCallback<ConnectionState>() {
            @Override
            public void onEvent(ConnectionState newState) {
                if (newState == ConnectionState.CONNECTED) {
                    knownPeripherals.get(deviceIdentifier).setConnected(true);
                } else {
                    knownPeripherals.get(deviceIdentifier).setConnected(false);
                }
                onConnectionStateChangedCallback.onEvent(newState);
            }
        };

        dartValueHandler.addConnectionStatePublisher(deviceIdentifier, onEventCallback);

        dartMethodCaller.connectToDevice(
                deviceIdentifier,
                knownPeripherals.get(deviceIdentifier).getName(),
                connectionOptions,
                onSuccessCallback,
                onErrorCallback
        );
    }

    @Override
    public void cancelDeviceConnection(String deviceIdentifier,
                                       OnSuccessCallback<Device> onSuccessCallback,
                                       OnErrorCallback onErrorCallback) {
        Log.i(TAG, "cancelDeviceConnection");
        dartMethodCaller.disconnectOrCancelConnection(
                deviceIdentifier,
                knownPeripherals.get(deviceIdentifier).getName(),
                onSuccessCallback,
                onErrorCallback);
    }

    @Override
    public void isDeviceConnected(String deviceIdentifier,
                                  OnSuccessCallback<Boolean> onSuccessCallback,
                                  OnErrorCallback onErrorCallback) {
        Log.i(TAG, "isDeviceConnected");
        dartMethodCaller.isDeviceConnected(deviceIdentifier, onSuccessCallback, onErrorCallback);
    }

    @Override
    public void discoverAllServicesAndCharacteristicsForDevice(
            final String deviceIdentifier,
            String transactionId,
            final OnSuccessCallback<Device> onSuccessCallback,
            OnErrorCallback onErrorCallback) {
        Log.i(TAG, "discoverAllServicesAndCharacteristicsForDevice");
        OnSuccessCallback<DeviceContainer> resultCallback = new OnSuccessCallback<DeviceContainer>() {
            @Override
            public void onSuccess(DeviceContainer deviceContainer) {
                DeviceContainer oldContainer = knownPeripherals.get(deviceIdentifier);
                if (oldContainer != null) {
                    deviceContainer.setConnected(oldContainer.isConnected());
                }
                knownPeripherals.put(deviceContainer.getIdentifier(), deviceContainer);
                onSuccessCallback.onSuccess(new Device(deviceContainer.getIdentifier(), deviceContainer.getName()));
            }
        };
        dartMethodCaller
                .discoverAllServicesAndCharacteristicsForDevice(
                        deviceIdentifier,
                        knownPeripherals.get(deviceIdentifier).getName(),
                        transactionId,
                        resultCallback,
                        onErrorCallback);
    }

    @Override
    public Service[] getServicesForDevice(String deviceIdentifier) throws BleError {
        Log.i(TAG, "getServicesForDevice");
        if (knownPeripherals.get(deviceIdentifier) == null) {
            throw new BleError(BleErrorCode.DeviceNotFound, "Device unknown", 0);
        }

        if (!knownPeripherals.get(deviceIdentifier).isConnected()) {
            throw new BleError(BleErrorCode.DeviceNotConnected, "Device not connected", 0);
        }

        if (knownPeripherals.get(deviceIdentifier).getServices() == null) {
            throw new BleError(BleErrorCode.ServicesNotDiscovered, "Discovery not done on this device", 0);
        }
        return knownPeripherals
                .get(deviceIdentifier)
                .getServices()
                .toArray(new Service[0]);
    }

    @Override
    public Characteristic[] getCharacteristicsForDevice(String deviceIdentifier,
                                                        String serviceUUID) throws BleError {
        Log.i(TAG, "getCharacteristicsForDevice");

        if (knownPeripherals.get(deviceIdentifier) == null) {
            throw new BleError(BleErrorCode.DeviceNotFound, "Device unknown", 0);
        }

        if (!knownPeripherals.get(deviceIdentifier).isConnected()) {
            throw new BleError(BleErrorCode.DeviceNotConnected, "Device not connected", 0);
        }

        if (knownPeripherals.get(deviceIdentifier).getCharacteristics() == null) {
            throw new BleError(BleErrorCode.CharacteristicsNotDiscovered, "Discovery not done on this device", 0);
        }

        return knownPeripherals
                .get(deviceIdentifier)
                .getCharacteristics()
                .get(serviceUUID)
                .toArray(new Characteristic[0]);
    }

    @Override
    public Characteristic[] getCharacteristicsForService(int serviceIdentifier) throws BleError {
        Log.i(TAG, "getCharacteristicForService");


        for (DeviceContainer deviceContainer : knownPeripherals.values()) {
            if (deviceContainer.getServices() != null) {
                for (Service service : deviceContainer.getServices()) {
                    if (service.getId() == serviceIdentifier) {
                        return deviceContainer
                                .getCharacteristics()
                                .get(service.getUuid().toString().toUpperCase())
                                .toArray(new Characteristic[0]);
                    }
                }
            }

        }

        throw new BleError(BleErrorCode.ServiceNotFound, "Service with id " + serviceIdentifier + " not found", 0);
    }

    @Override
    public void readCharacteristicForDevice(String deviceIdentifier,
                                            String serviceUUID,
                                            String characteristicUUID,
                                            String transactionId,
                                            OnSuccessCallback<Characteristic> onSuccessCallback,
                                            OnErrorCallback onErrorCallback) {
        Log.i(TAG, "readCharacteristicForDevice");
        dartMethodCaller.readCharacteristicForDevice(
                deviceIdentifier, serviceUUID, characteristicUUID, transactionId, onSuccessCallback, onErrorCallback);
    }

    @Override
    public void readCharacteristicForService(int serviceIdentifier,
                                             String characteristicUUID,
                                             String transactionId,
                                             OnSuccessCallback<Characteristic> onSuccessCallback,
                                             OnErrorCallback onErrorCallback) {
        Log.i(TAG, "readCharacteristicForService");
        dartMethodCaller.readCharacteristicForService(
                serviceIdentifier, characteristicUUID, transactionId, onSuccessCallback, onErrorCallback);
    }

    @Override
    public void readCharacteristic(int characteristicIdentifer,
                                   String transactionId,
                                   OnSuccessCallback<Characteristic> onSuccessCallback,
                                   OnErrorCallback onErrorCallback) {
        Log.i(TAG, "readCharacteristic");
        dartMethodCaller.readCharacteristic(
                characteristicIdentifer, transactionId, onSuccessCallback, onErrorCallback);
    }

    @Override
    public void writeCharacteristicForDevice(String deviceIdentifier,
                                             String serviceUUID,
                                             String characteristicUUID,
                                             String valueBase64,
                                             boolean withResponse,
                                             String transactionId,
                                             OnSuccessCallback<Characteristic> onSuccessCallback,
                                             OnErrorCallback onErrorCallback) {
        Log.i(TAG, "writeCharacteristicForDevice");
        dartMethodCaller.writeCharacteristicForDevice(deviceIdentifier, serviceUUID, characteristicUUID,
                valueBase64, transactionId, onSuccessCallback, onErrorCallback);
    }

    @Override
    public void writeCharacteristicForService(int serviceIdentifier,
                                              String characteristicUUID,
                                              String valueBase64,
                                              boolean withResponse,
                                              String transactionId,
                                              OnSuccessCallback<Characteristic> onSuccessCallback,
                                              OnErrorCallback onErrorCallback) {
        Log.i(TAG, "writeCharacteristicForService");
        dartMethodCaller.writeCharacteristicForService(serviceIdentifier, characteristicUUID,
                valueBase64, transactionId, onSuccessCallback, onErrorCallback);
    }

    @Override
    public void writeCharacteristic(int characteristicIdentifier,
                                    String valueBase64,
                                    boolean withResponse,
                                    String transactionId,
                                    OnSuccessCallback<Characteristic> onSuccessCallback,
                                    OnErrorCallback onErrorCallback) {
        Log.i(TAG, "writeCharacteristic");
        dartMethodCaller.writeCharacteristic(characteristicIdentifier, valueBase64,
                transactionId, onSuccessCallback, onErrorCallback);
    }

    @Override
    public void monitorCharacteristicForDevice(final String deviceIdentifier,
                                               final String serviceUUID,
                                               final String characteristicUUID,
                                               final String transactionId,
                                               final OnEventCallback<Characteristic> onEventCallback,
                                               final OnErrorCallback onErrorCallback) {
        Log.i(TAG, "monitorCharacteristicForDevice");
        final OnErrorCallback localOnErrorCallback = new OnErrorCallback() {
            @Override
            public void onError(BleError error) {
                dartValueHandler.removeCharacteristicsUpdatePublisher(transactionId);
                onErrorCallback.onError(error);
            }
        };
        dartMethodCaller.cancelTransaction(transactionId, new OnSuccessCallback<Void>() {
            @Override
            public void onSuccess(Void irrelevant) {
                dartValueHandler.addCharacteristicsUpdatePublishers(transactionId, onEventCallback, localOnErrorCallback);
                dartMethodCaller.monitorCharacteristicForDevice(deviceIdentifier, serviceUUID, characteristicUUID, transactionId, localOnErrorCallback);
            }
        });
    }

    @Override
    public void monitorCharacteristicForService(final int serviceIdentifier,
                                                final String characteristicUUID,
                                                final String transactionId,
                                                final OnEventCallback<Characteristic> onEventCallback,
                                                final OnErrorCallback onErrorCallback) {
        Log.i(TAG, "monitorCharacteristicForService");
        final OnErrorCallback localOnErrorCallback = new OnErrorCallback() {
            @Override
            public void onError(BleError error) {
                dartValueHandler.removeCharacteristicsUpdatePublisher(transactionId);
                onErrorCallback.onError(error);
            }
        };
        dartMethodCaller.cancelTransaction(transactionId, new OnSuccessCallback<Void>() {
            @Override
            public void onSuccess(Void irrelevant) {
                dartValueHandler.addCharacteristicsUpdatePublishers(transactionId, onEventCallback, localOnErrorCallback);
                dartMethodCaller.monitorCharacteristicForService(serviceIdentifier, characteristicUUID, transactionId, localOnErrorCallback);
            }
        });
    }

    @Override
    public void monitorCharacteristic(final int characteristicIdentifier,
                                      final String transactionId,
                                      final OnEventCallback<Characteristic> onEventCallback,
                                      final OnErrorCallback onErrorCallback) {
        Log.i(TAG, "monitorCharacteristic");
        final OnErrorCallback localOnErrorCallback = new OnErrorCallback() {
            @Override
            public void onError(BleError error) {
                dartValueHandler.removeCharacteristicsUpdatePublisher(transactionId);
                onErrorCallback.onError(error);
            }
        };
        dartMethodCaller.cancelTransaction(transactionId, new OnSuccessCallback<Void>() {
            @Override
            public void onSuccess(Void irrelevant) {
                dartValueHandler.addCharacteristicsUpdatePublishers(transactionId, onEventCallback, localOnErrorCallback);
                dartMethodCaller.monitorCharacteristic(characteristicIdentifier, transactionId, localOnErrorCallback);
            }
        });
    }

    @Override
    public void cancelTransaction(String transactionId) {
        Log.i(TAG, "cancelTransaction");
        dartMethodCaller.cancelTransaction(transactionId, null);
    }

    @Override
    public void setLogLevel(String logLevel) {
        Log.i(TAG, "setLogLevel");
        this.logLevel = logLevel;
    }

    @Override
    public String getLogLevel() {
        Log.i(TAG, "getLogLevel");
        return logLevel;
    }
}
