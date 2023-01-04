package com.example.platform_flutter.platform_views_textview;

import android.content.Context;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;


import java.util.Map;

import io.flutter.plugin.common.StandardMessageCodec;
import io.flutter.plugin.platform.PlatformView;
import io.flutter.plugin.platform.PlatformViewFactory;

public class NativeTextViewFactory extends PlatformViewFactory {

    public NativeTextViewFactory() {
        super(StandardMessageCodec.INSTANCE);
    }


    @NonNull
    @SuppressWarnings("unchecked")
    @Override
    public PlatformView create(@NonNull Context context, int id, @Nullable Object args) {
        final Map<String, Object> creationParams = (Map<String, Object>) args;
        return new NativeTextView(context, id, creationParams);
    }
}
