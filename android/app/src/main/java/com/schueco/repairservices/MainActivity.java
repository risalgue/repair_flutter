package com.schueco.repairservices;

import android.os.Bundle;
import com.crashlytics.android.ndk.CrashlyticsNdk;
import io.flutter.app.FlutterActivity;
import io.flutter.plugins.GeneratedPluginRegistrant;
import com.crashlytics.android.Crashlytics;
import io.fabric.sdk.android.Fabric;

public class MainActivity extends FlutterActivity {
  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    Fabric.with(this, new Crashlytics(), new CrashlyticsNdk());
    GeneratedPluginRegistrant.registerWith(this);
  }
}
