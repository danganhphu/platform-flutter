package com.example.platform_flutter;

import androidx.annotation.NonNull;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.JSONMethodCodec;
import io.flutter.plugin.common.MethodChannel;

import android.content.ContextWrapper;
import android.content.Intent;
import android.content.IntentFilter;
import android.os.BatteryManager;
import android.os.Build;
import android.os.Build.VERSION;
import android.os.Build.VERSION_CODES;
import android.os.Bundle;

import org.json.JSONException;
import org.json.JSONObject;

import java.util.Objects;

public class MainActivity extends FlutterActivity {
    private static final String CHANNELBATTERY = "com.example/battery";
    private static final String CHANNELDEVICEINFO = "com.example/deviceinfo";
    private static final String CHANNELDEVICEINFO2 = "com.example/deviceinfo2";

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);
        demoMethodChannelBattery(flutterEngine);
        demoMethodChannelDeviceInfo(flutterEngine);
        demoMethodChannelDeviceInfo2(flutterEngine);
    }

    //phương thức của Battery
    public void demoMethodChannelBattery(@NonNull FlutterEngine flutterEngine) {
        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNELBATTERY)
                .setMethodCallHandler(
                        (call, result) -> {
                            // This method is invoked on the main thread.
                            if (call.method.equals("getBatteryLevel")) {
                                int batteryLevel = getBatteryLevel();

                                if (batteryLevel != -1) {
                                    result.success(batteryLevel);
                                } else {
                                    result.error("UNAVAILABLE", "Battery level not available.", null);
                                }
                            } else {
                                result.notImplemented();
                            }
                        }
                );
    }

    public void demoMethodChannelDeviceInfo(@NonNull FlutterEngine flutterEngine) {
        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNELDEVICEINFO)
                .setMethodCallHandler(
                        (call, result) -> {
                            // This method is invoked on the main thread.
                            if (call.method.equals("getDeviceInfo")) {
                                String deviceInfo = getDeviceInfo();
                                if (!Objects.equals(deviceInfo, "Unknown")) {
                                    result.success(deviceInfo);
                                } else {
                                    result.error("UNAVAILABLE", "DeviceInfo not available.", null);
                                }
                            } else {
                                result.notImplemented();
                            }
                        }
                );
    }

    public void demoMethodChannelDeviceInfo2(@NonNull FlutterEngine flutterEngine) {
        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNELDEVICEINFO2, JSONMethodCodec.INSTANCE)
                .setMethodCallHandler(
                        (call, result) -> {
                            // This method is invoked on the main thread.
                            if (call.method.equals("getDeviceInfo2")) {
                                String type = call.argument("type");
                                if (!(type == null || type.isEmpty())) {
                                    result.success(getDeviceInfo2(type));
                                } else {
                                    result.error("ERROR", "type can not null", null);
                                }


                            } else {
                                result.notImplemented();
                            }
                        }
                );
    }



    private int getBatteryLevel() {
        int batteryLevel = -1;
        if (VERSION.SDK_INT >= VERSION_CODES.LOLLIPOP) {
            BatteryManager batteryManager = (BatteryManager) getSystemService(BATTERY_SERVICE);
            batteryLevel = batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY);
        } else {
            Intent intent = new ContextWrapper(getApplicationContext()).
                    registerReceiver(null, new IntentFilter(Intent.ACTION_BATTERY_CHANGED));
            batteryLevel = (intent.getIntExtra(BatteryManager.EXTRA_LEVEL, -1) * 100) /
                    intent.getIntExtra(BatteryManager.EXTRA_SCALE, -1);
        }

        return batteryLevel;
    }

    private String getDeviceInfo() {
        String deviceInfo = "Unknown";
        if (VERSION.SDK_INT >= VERSION_CODES.LOLLIPOP) {
            deviceInfo = Build.MODEL;
        } else {
            deviceInfo = "Loi roi";
        }

        return deviceInfo;
    }

    private JSONObject getDeviceInfo2(String type) {
        JSONObject json = new JSONObject();
        if (type.equals("MODEL")) {
            try {
                json.put("result", Build.MODEL);
            } catch (JSONException e) {
                e.printStackTrace();
            }
            return json;
        }

        return null;
    }
}
