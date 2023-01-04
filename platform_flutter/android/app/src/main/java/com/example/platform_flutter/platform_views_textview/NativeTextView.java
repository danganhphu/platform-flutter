package com.example.platform_flutter.platform_views_textview;

import android.annotation.SuppressLint;
import android.content.Context;
import android.graphics.Color;
import android.view.View;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import java.util.Map;

import io.flutter.plugin.platform.PlatformView;

public class NativeTextView implements PlatformView {
    @NonNull
    private final TextView textView;

    @SuppressLint("SetTextI18n")
    public NativeTextView(@NonNull Context context, int id, @Nullable Map<String, Object> creationParams) {
        textView = new TextView(context);
        textView.setTextSize(20);
        textView.setBackgroundColor(Color.rgb(255, 255, 255));
        textView.setText("Native Android view (id: " + id + ")");
    }

    @Nullable
    @Override
    public View getView() {
        return textView;
    }

    @Override
    public void dispose() {

    }
}
