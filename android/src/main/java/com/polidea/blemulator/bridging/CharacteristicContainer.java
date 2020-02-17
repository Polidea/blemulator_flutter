package com.polidea.blemulator.bridging;

import com.polidea.multiplatformbleadapter.Characteristic;
import com.polidea.multiplatformbleadapter.Descriptor;

import java.util.List;

public class CharacteristicContainer {
    private final Characteristic characteristic;
    private final List<Descriptor> descriptors;

    public CharacteristicContainer(Characteristic characteristic, List<Descriptor> descriptors) {
        this.characteristic = characteristic;
        this.descriptors = descriptors;
    }

    public Characteristic getCharacteristic() {
        return characteristic;
    }

    public List<Descriptor> getDescriptors() {
        return descriptors;
    }
}
