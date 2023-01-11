package com.example.platform_flutter.platform_view_login;

import android.annotation.SuppressLint;
import android.content.Context;
import android.graphics.Color;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;
import android.widget.Toast;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import com.example.platform_flutter.R;

import java.util.Map;

import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.platform.PlatformView;

public class LoginViewWidget implements PlatformView {
    @Nullable
    private final View view;
    EditText username;
    EditText password;
    Button loginButton;

    @SuppressLint("InflateParams")
    public LoginViewWidget(@NonNull Context context, int id, @Nullable Map<String, Object> creationParams) {
        view = LayoutInflater.from(context).inflate(R.layout.activity_login, null);
        username = view.findViewById(R.id.username);
        password = view.findViewById(R.id.password);
        loginButton = view.findViewById(R.id.loginButton);
        loginButton.setOnClickListener(view -> {
            if (username.getText().toString().equals("user") && password.getText().toString().equals("1234")) {
                Toast.makeText(context, "Login Successful!", Toast.LENGTH_SHORT).show();
            } else {
                Toast.makeText(context, "Login Failed!", Toast.LENGTH_SHORT).show();
            }
        });
    }
    @Nullable
    @Override
    public View getView() {
        return view;
    }

    @Override
    public void dispose() {
    }
}
