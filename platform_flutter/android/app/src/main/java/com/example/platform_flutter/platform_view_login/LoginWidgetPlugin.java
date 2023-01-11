package com.example.platform_flutter.platform_view_login;

import androidx.annotation.NonNull;

import io.flutter.embedding.engine.plugins.FlutterPlugin;

public class LoginWidgetPlugin implements FlutterPlugin {
    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding binding) {
        binding
                .getPlatformViewRegistry()
                .registerViewFactory("<login-widget-plugin>", new LoginViewWidgetFactory());
    }


    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {

    }
}
