package com.yzj.tools;
// import java.net.InetAddress;
// import java.net.NetworkInterface;
// import java.net.SocketException;
// import java.util.Enumeration;
// import java.util.ArrayList;

// import com.quick_x.samples.luajavabridge.R;

// import org.cocos2dx.lib.Cocos2dxActivity;
// import org.cocos2dx.lib.Cocos2dxLuaJavaBridge;

// import android.app.AlertDialog;
// import android.content.Context;
// import android.content.DialogInterface;
// import android.content.Intent;
// import android.content.pm.ApplicationInfo;
// import android.content.pm.ActivityInfo;
// import android.net.ConnectivityManager;
// import android.net.NetworkInfo;
// import android.net.wifi.WifiInfo;
// import android.net.wifi.WifiManager;
// import android.os.Bundle;
// import android.provider.Settings;
// import android.text.format.Formatter;
// import android.util.Log;
// import android.view.WindowManager;
// import android.widget.Toast;
import android.util.Log;


public class NativeProxy {

    public static void printLog(final String msg) {
        Log.e("yzj","yzj = " + msg);
    }

    // private static Cocos2dxActivity mContext;

    // public static void setContext(Cocos2dxActivity context) {
    //     mContext = context;
    // }

    // public static void showAlertDialog(final String title,
    //     final String message, final int luaCallbackFunction) {
    //     s_instance.runOnUiThread(new Runnable() {
    //         @Override
    //         public void run() {
    //             AlertDialog alertDialog = new AlertDialog.Builder(s_instance).create();
    //             alertDialog.setTitle(title);
    //             alertDialog.setMessage(message);
    //             alertDialog.setButton("OK", new DialogInterface.OnClickListener() {
    //                 @Override
    //                 public void onClick(DialogInterface dialog, int which) {
    //                     s_instance.runOnGLThread(new Runnable() {
    //                         @Override
    //                         public void run() {
    //                             Cocos2dxLuaJavaBridge.callLuaFunctionWithString(luaCallbackFunction, "CLICKED");
    //                             Cocos2dxLuaJavaBridge.releaseLuaFunction(luaCallbackFunction);
    //                         }
    //                     });
    //                 }
    //             });
    //             alertDialog.setIcon(R.drawable.icon);
    //             alertDialog.show();
    //         }
    //     });
    // }

}