package com.polidea.blemulator;

import com.polidea.blemulator.bridging.CharacteristicContainer;
import com.polidea.multiplatformbleadapter.Service;

import java.util.List;
import java.util.Map;

public class DeviceContainer {
    private String identifier;
    private String name;
    private List<Service> services;
    private Map<String, List<CharacteristicContainer>> characteristicContainersIndexByServiceUuids;
    private boolean isConnected = false;

    public DeviceContainer(String identifier, String name, List<Service> services, Map<String, List<CharacteristicContainer>> characteristicContainersIndexByServiceUuids) {
        this.identifier = identifier;
        this.name = name;
        this.services = services;
        this.characteristicContainersIndexByServiceUuids = characteristicContainersIndexByServiceUuids;
    }

    public boolean isConnected() {
        return isConnected;
    }

    public void setConnected(boolean connected) {
        isConnected = connected;
    }

    public String getIdentifier() {
        return identifier;
    }

    public String getName() {
        return name;
    }

    public List<Service> getServices() {
        return services;
    }

    public Map<String, List<CharacteristicContainer>> getCharacteristicContainersIndexedByServiceUuids() {
        return characteristicContainersIndexByServiceUuids;
    }
}
