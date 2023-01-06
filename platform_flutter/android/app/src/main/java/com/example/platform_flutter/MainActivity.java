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

import com.example.platform_flutter.platform_views_textview.NativeTextViewFactory;

import org.json.JSONException;
import org.json.JSONObject;

import java.util.HashMap;
import java.util.Objects;

public class MainActivity extends FlutterActivity {
    private static final String CHANNELBATTERY = "com.example/battery";
    private static final String CHANNELDEVICEINFO = "com.example/deviceinfo";
    private static final String CHANNELANDROIDVERSION = "com.example/android_version";
    private static final String CHANNEL_TOAST = "com.example/toast_channel";
    private static final String CHANNEL_CALCULATE = "com.example/calculate_channel";

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);
        demoMethodChannelBattery(flutterEngine);
        demoToastMessage(flutterEngine);
        demoCalculate(flutterEngine);
        demoMethodChannelDeviceInfo(flutterEngine);
        demoMethodChannelAndroidVersion(flutterEngine);
        flutterEngine
                .getPlatformViewsController()
                .getRegistry()
                .registerViewFactory("<platform-textview-type>", new NativeTextViewFactory());
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
        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNELDEVICEINFO, JSONMethodCodec.INSTANCE)
                .setMethodCallHandler(
                        (call, result) -> {
                            // This method is invoked on the main thread.
                            if (call.method.equals("getDeviceInfo")) {
                                String type = call.argument("type");
                                if (!(type == null || type.isEmpty())) {
                                    result.success(deviceInfo(type));
                                } else {
                                    result.error("ERROR", "type can not null", null);
                                }


                            } else {
                                result.notImplemented();
                            }
                        }
                );
    }

    public void demoToastMessage(@NonNull FlutterEngine flutterEngine) {
        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL_TOAST, JSONMethodCodec.INSTANCE)
                .setMethodCallHandler(
                        (call, result) -> {
                            // This method is invoked on the main thread.
                            if (call.method.equals("getToastMessage")) {
                                String type = call.argument("type");
                                if (!(type == null || type.isEmpty())) {
                                    result.success(toastMessage(type));
                                } else {
                                    result.error("ERROR", "type can not null", null);
                                }


                            } else {
                                result.notImplemented();
                            }
                        }
                );
    }

    public void demoMethodChannelAndroidVersion(@NonNull FlutterEngine flutterEngine) {
        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNELANDROIDVERSION)
                .setMethodCallHandler(
                        (call, result) -> {
                            // This method is invoked on the main thread.
                            if (call.method.equals("getAndroidVersion")) {
                                String androidVersion = getAndroidVersion();
                                if (!Objects.equals(androidVersion, "Unknown")) {
                                    result.success(androidVersion);
                                } else {
                                    result.error("UNAVAILABLE", "Android version not available.", null);
                                }
                            } else {
                                result.notImplemented();
                            }
                        }
                );
    }


    public void demoCalculate(@NonNull FlutterEngine flutterEngine) {
        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL_CALCULATE, JSONMethodCodec.INSTANCE)
                .setMethodCallHandler(
                        (call, result) -> {
                            // This method is invoked on the main thread.
                            if (call.method.equals("getCaculate")) {
                                Integer num1 = call.argument("numberOne");
                                Integer num2 = call.argument("numberTwo");
                                Integer num3 = call.argument("numberThree");

                                int numb1 = num1 != null ? num1 : 0;
                                int numb2 = num2 != null ? num2 : 0;
                                int numb3 = num3 != null ? num3 : 0;

                               String kqua = giaiPTBac2((float) numb1, (float) numb2, (float) numb3);
                                if (!kqua.isEmpty()) {
                                    result.success(kqua);
                                } else {
                                    result.error("UNAVAILABLE", "Calculated not available.", null);
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

    private JSONObject deviceInfo(String type) {
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

    private JSONObject toastMessage(String type) {
        JSONObject json = new JSONObject();
        String msg = "Anh Phú";
        if (type.equals("msg")) {
            try {
                json.put("result", msg);
            } catch (JSONException e) {
                e.printStackTrace();
            }
            return json;
        }

        return null;
    }


    private String getAndroidVersion() {
        String androidVersion = "Unknown";
        if (VERSION.SDK_INT >= VERSION_CODES.LOLLIPOP) {
            androidVersion = Build.VERSION.RELEASE;
        } else {
            androidVersion = "Loi...";
        }

        return androidVersion;
    }

    public static String giaiPTBac2(float a, float b, float c) {
        float delta = (b*b)-(4*a*c);
        float sqrt = (float) (Math.sqrt(delta));
        String result;

        if (delta > 0) {
            float x1 = (-b + sqrt) / (2*a);
            float x2 = (-b - sqrt) / (2*a);
            result = "Pt 2 nghiệm là: " + x1 + " và " + x2;
        } else if (delta == 0) {
            float x1 = -b / (2 * a);
            result = "Pt có nghiệm kép: " + "x1 = x2 = " + x1;
        } else {
            result = "Phương trình vô nghiệm";
        }
        return result;
    }
}
