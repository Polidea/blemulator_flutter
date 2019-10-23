package com.polidea.blemulator;

import android.content.Context;
import android.support.annotation.NonNull;

import com.polidea.blemulator.bridging.DartMethodCaller;
import com.polidea.blemulator.bridging.DartValueHandler;
import com.polidea.blemulator.bridging.constants.ChannelName;
import com.polidea.blemulator.bridging.constants.PlatformMethodName;
import com.polidea.multiplatformbleadapter.BleAdapter;
import com.polidea.multiplatformbleadapter.BleAdapterCreator;
import com.polidea.multiplatformbleadapter.BleAdapterFactory;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.PluginRegistry;

public class BlemulatorPlugin implements MethodCallHandler {

    private DartMethodCaller dartMethodCaller;
    private DartValueHandler dartValueHandler;

    public static void registerWith(PluginRegistry.Registrar registrar) {
        MethodChannel dartToPlatformChannel = new MethodChannel(registrar.messenger(), ChannelName.TO_PLATFORM);
        MethodChannel platformToDartChannel = new MethodChannel(registrar.messenger(), ChannelName.TO_DART);

        dartToPlatformChannel.setMethodCallHandler(new BlemulatorPlugin(platformToDartChannel));
    }

    private BlemulatorPlugin(MethodChannel platformToDartChannel) {
        dartMethodCaller = new DartMethodCaller(platformToDartChannel);
        dartValueHandler = new DartValueHandler();
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        switch (call.method) {
            case PlatformMethodName.SIMULATE:
                switchToSimulation(result);
                return;
            default:
                dartValueHandler.onMethodCall(call, result);
                return;
        }
    }

    private void switchToSimulation(MethodChannel.Result result) {
        BleAdapterFactory.setBleAdapterCreator(new BleAdapterCreator() {
            @Override
            public BleAdapter createAdapter(Context context) {
                SimulatedAdapter adapter = new SimulatedAdapter(dartMethodCaller, dartValueHandler);
                return adapter;
            }
        });
        result.success(null);
    }
}
