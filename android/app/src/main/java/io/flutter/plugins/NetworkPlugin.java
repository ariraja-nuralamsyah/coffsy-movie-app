package main.java.io.flutter.plugins;

import android.content.Context;
import android.net.ConnectivityManager;
import android.net.Network;
import android.net.NetworkCapabilities;
import android.net.NetworkRequest;
import android.net.wifi.WifiConfiguration;
import android.net.wifi.WifiManager;
import android.os.Build;
import android.provider.Settings;

import androidx.annotation.NonNull;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.PluginRegistry;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import android.content.Intent;
import android.widget.Toast;

import android.util.Log;

public class NetworkPlugin implements FlutterPlugin, MethodCallHandler {
    private Context context;
    private MethodChannel channel;
    private ConnectivityManager.NetworkCallback networkCallback;
    private WifiManager wifiManager;
    private ConnectivityManager connectivityManager;

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding binding) {
        context = binding.getApplicationContext();
        wifiManager = (WifiManager) context.getSystemService(Context.WIFI_SERVICE);
        connectivityManager = (ConnectivityManager) context.getSystemService(Context.CONNECTIVITY_SERVICE);
        channel = new MethodChannel(binding.getBinaryMessenger(), "network_channel");
        channel.setMethodCallHandler(this);
        Log.d("1", "Masuk 1");
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
        switch (call.method) {
            case "switchToMobileData":
                Log.d("2", "Masuk method call");
                switchToMobileData(result);
                break;
            default:
                Log.d("5", "Tidak masuk");
                result.notImplemented();
        }
    }

    private void switchToMobileData(Result result) {
        if (Build.VERSION.SDK_INT < Build.VERSION_CODES.Q) {
            Log.d("3", "Masuk Switch to mobile data");
            disableWifi();
        } else {
            Log.d("4", "Versi Android tidak compatible");
            // For Android versions prior to 10, open the network settings to allow the user to switch to mobile data
            Intent intent = new Intent(Settings.ACTION_SETTINGS);
            intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
            context.startActivity(intent);
            result.success(null);
        }
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
        context = null;
        channel.setMethodCallHandler(null);
        channel = null;
    }

    private void disableWifi() {
        if (wifiManager != null && wifiManager.isWifiEnabled()) {
            wifiManager.setWifiEnabled(false);
            Log.d("3", "Disable Wifi");
            Toast.makeText(context, "Wifi Disabled", Toast.LENGTH_SHORT).show();
        }
    }
}
