package com.polidea.blemulator.bridging;

import androidx.annotation.NonNull;
import android.util.Log;
import android.util.Pair;

import com.polidea.blemulator.bridging.constants.PlatformMethodName;
import com.polidea.blemulator.bridging.constants.SimulationArgumentName;
import com.polidea.blemulator.bridging.decoder.BleErrorDartValueDecoder;
import com.polidea.blemulator.bridging.decoder.CharacteristicDartValueDecoder;
import com.polidea.multiplatformbleadapter.AdvertisementData;
import com.polidea.multiplatformbleadapter.Characteristic;
import com.polidea.multiplatformbleadapter.ConnectionState;
import com.polidea.multiplatformbleadapter.OnErrorCallback;
import com.polidea.multiplatformbleadapter.OnEventCallback;
import com.polidea.multiplatformbleadapter.ScanResult;
import com.polidea.multiplatformbleadapter.errors.BleError;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class DartValueHandler implements MethodChannel.MethodCallHandler {

    private static final String TAG = DartValueHandler.class.getSimpleName();

    private CharacteristicDartValueDecoder characteristicDartValueDecoder = new CharacteristicDartValueDecoder();
    private BleErrorDartValueDecoder bleErrorDartValueDecoder = new BleErrorDartValueDecoder();
    private OnEventCallback<ScanResult> scanResultPublisher;
    private Map<String, OnEventCallback<ConnectionState>> connectionStatePublishers = new HashMap<>();
    private Map<String, Pair<OnEventCallback<Characteristic>, OnErrorCallback>> characteristicsUpdatePublishers = new HashMap<>();

    public void setScanResultPublisher(OnEventCallback<ScanResult> scanResultPublisher) {
        this.scanResultPublisher = scanResultPublisher;
    }

    public void addConnectionStatePublisher(String identifier, OnEventCallback<ConnectionState> publisher) {
        connectionStatePublishers.put(identifier, publisher);
    }

    public synchronized void addCharacteristicsUpdatePublishers(String transactionId, OnEventCallback<Characteristic> eventPublisher, OnErrorCallback errorPublisher) {
        characteristicsUpdatePublishers.put(transactionId, new Pair<>(eventPublisher, errorPublisher));
    }

    public synchronized void removeCharacteristicsUpdatePublisher(String transactionId) {
        characteristicsUpdatePublishers.remove(transactionId);
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        switch (call.method) {
            case PlatformMethodName.PUBLISH_SCAN_RESULT:
                publishScanResult(call, result);
                return;
            case PlatformMethodName.PUBLISH_CONNECTION_STATE:
                publishConnectionState(call, result);
                return;
            case PlatformMethodName.PUBLISH_CHARACTERISTIC_UPDATE:
                publishCharacteristicUpdate(call, result);
                return;
            case PlatformMethodName.PUBLISH_CHARACTERISTIC_MONITORING_ERROR:
                publishCharacteristicUpdateError(call, result);
                return;
            default:
                result.notImplemented();
        }
    }

    private void publishScanResult(MethodCall call, MethodChannel.Result result) {
        HashMap<UUID, byte[]> serviceData = null;
        HashMap<String, byte[]> stringServiceData = call.argument(SimulationArgumentName.SERVICE_DATA);
        if (stringServiceData != null) {
            serviceData = new HashMap<>();
            for (Map.Entry<String, byte[]> entry
                    : stringServiceData.entrySet()) {
                serviceData.put(UUID.fromString(entry.getKey()), entry.getValue());
            }
        }

        ArrayList<UUID> serviceUuids = null;
        List<String> stringServiceUuids = call.argument(SimulationArgumentName.SERVICE_UUIDS);
        if (stringServiceUuids != null) {
            serviceUuids = new ArrayList<>();
            for (String uuid : stringServiceUuids) {
                serviceUuids.add(UUID.fromString(uuid));
            }
        }

        ArrayList<UUID> solicitedServiceUuids = null;
        List<String> stringSolicitedServiceUuids = call.argument(SimulationArgumentName.SOLICITED_SERVICE_UUIDS);
        if (stringSolicitedServiceUuids != null) {
            solicitedServiceUuids = new ArrayList<>();
            for (String uuid : stringSolicitedServiceUuids) {
                solicitedServiceUuids.add(UUID.fromString(uuid));
            }
        }

        AdvertisementData advertisementData = new AdvertisementData(
                call.<byte[]>argument(SimulationArgumentName.MANUFACTURER_DATA),
                serviceData,
                serviceUuids,
                call.<String>argument(SimulationArgumentName.LOCAL_NAME),
                call.<Integer>argument(SimulationArgumentName.TX_POWER_LEVEL),
                solicitedServiceUuids
        );

        ArrayList<UUID> overflowServiceUuids;
        UUID[] overflowServiceUuidsArray = null;
        List<String> stringOverflowServiceUuids = call.argument(SimulationArgumentName.OVERFLOW_SERVICE_UUIDS);
        if (stringOverflowServiceUuids != null) {
            overflowServiceUuids = new ArrayList<>();
            for (String uuid : stringOverflowServiceUuids) {
                overflowServiceUuids.add(UUID.fromString(uuid));
            }
            overflowServiceUuidsArray = overflowServiceUuids.toArray(new UUID[0]);
        }

        ScanResult scanResult = new ScanResult(
                call.<String>argument(SimulationArgumentName.DEVICE_ID),
                call.<String>argument(SimulationArgumentName.DEVICE_NAME),
                call.<Integer>argument(SimulationArgumentName.RSSI),
                -1, //shouldn't be in ScanResult at all, it is there for legacy reasons
                call.<Boolean>argument(SimulationArgumentName.IS_CONNECTABLE),
                overflowServiceUuidsArray,
                advertisementData
        );
        scanResultPublisher.onEvent(scanResult);
        result.success(null);
    }

    private void publishConnectionState(MethodCall call, MethodChannel.Result result) {
        String deviceId = call.argument(SimulationArgumentName.DEVICE_ID);
        ConnectionState state = ConnectionState.valueOf(
                call.<String>argument(SimulationArgumentName.CONNECTION_STATE));

        connectionStatePublishers.get(deviceId).onEvent(state);

        if (state == ConnectionState.DISCONNECTED) {
            connectionStatePublishers.remove(deviceId);
        }

        result.success(null);
    }

    private synchronized void publishCharacteristicUpdate(MethodCall call, MethodChannel.Result result) {
        String transactionId = call.argument(SimulationArgumentName.TRANSACTION_ID);
        Characteristic characteristic = characteristicDartValueDecoder.decode((Map<String, Object>) call.arguments);
        characteristicsUpdatePublishers.get(transactionId).first.onEvent(characteristic);
        result.success(null);
    }

    private synchronized void publishCharacteristicUpdateError(MethodCall call, MethodChannel.Result result) {
        String transactionId = call.argument(SimulationArgumentName.TRANSACTION_ID);
        BleError bleError = bleErrorDartValueDecoder.decode((Map<String, Object>) call.arguments);
        characteristicsUpdatePublishers.get(transactionId).second.onError(bleError);
        result.success(null);
    }
}
