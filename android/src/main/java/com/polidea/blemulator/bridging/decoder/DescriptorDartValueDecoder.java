package com.polidea.blemulator.bridging.decoder;

import android.bluetooth.BluetoothGattDescriptor;

import com.polidea.multiplatformbleadapter.Descriptor;

import java.util.Map;
import java.util.UUID;

public class DescriptorDartValueDecoder {

    private interface Metadata {
        String DESCRIPTOR_UUID = "descriptorUuid";
        String DESCRIPTOR_ID = "descriptorId";
        String CHARACTERISTIC_ID = "characteristicId";
        String CHARACTERISTIC_UUID = "characteristicUuid";
        String SERVICE_ID = "serviceId";
        String SERVICE_UUID = "serviceUuid";
        String DEVICE_ID = "deviceIdentifier";
        String VALUE = "value";
    }

    public Descriptor decode(Map<String, Object> values) {
        BluetoothGattDescriptor gattDescriptor = new BluetoothGattDescriptor(
                UUID.fromString(
                        (String) values.get(Metadata.DESCRIPTOR_UUID)),
                0);

        Descriptor descriptor = new Descriptor(
                (Integer) values.get(Metadata.CHARACTERISTIC_ID),
                (Integer) values.get(Metadata.SERVICE_ID),
                UUID.fromString((String) values.get(Metadata.CHARACTERISTIC_UUID)),
                UUID.fromString((String) values.get(Metadata.SERVICE_UUID)),
                (String) values.get(Metadata.DEVICE_ID),
                gattDescriptor,
                (Integer) values.get(Metadata.DESCRIPTOR_ID),
                UUID.fromString(
                        (String) values.get(Metadata.DESCRIPTOR_UUID))
        );

        byte[] value = (byte[]) values.get(Metadata.VALUE);
        descriptor.setValue(value);

        return descriptor;
    }
}
