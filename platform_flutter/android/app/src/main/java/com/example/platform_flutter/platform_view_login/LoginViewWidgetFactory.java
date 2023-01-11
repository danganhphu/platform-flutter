package com.example.platform_flutter.platform_view_login;

import android.content.Context;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import java.util.Map;
import io.flutter.plugin.common.StandardMessageCodec;
import io.flutter.plugin.platform.PlatformView;
import io.flutter.plugin.platform.PlatformViewFactory;

public class LoginViewWidgetFactory extends PlatformViewFactory {
    public LoginViewWidgetFactory() {
        super(StandardMessageCodec.INSTANCE);
    }

    @NonNull
    @SuppressWarnings("unchecked")
    @Override
    public PlatformView create(Context context, int viewId, @Nullable Object args) {
        final Map<String, Object> creationParams = (Map<String, Object>) args;
        return new LoginViewWidget(context, viewId, creationParams);
    }
}
