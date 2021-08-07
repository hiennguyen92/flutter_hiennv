
```
    // You have generated a new plugin project without
    // specifying the `--platforms` flag. A plugin project supports no platforms is generated.
    // To add platforms, run `flutter create -t plugin --platforms <platforms> .` under the same
    // directory. You can also find a detailed instruction on how to add platforms in the `pubspec.yaml` at https://flutter.dev/docs/development/packages-and-plugins/developing-packages#plugin-platforms.
    
    import 'dart:async';
    
    import 'package:flutter/services.dart';
    
    class FlutterHiennv {
      static const MethodChannel _channel =
          const MethodChannel('flutter_hiennv');
    
      static Future<String?> get platformVersion async {
        final String? version = await _channel.invokeMethod('getPlatformVersion');
        return version;
      }
    }
```

```

    import 'dart:async';
    // In order to *not* need this ignore, consider extracting the "web" version
    // of your plugin as a separate package, instead of inlining it in the same
    // package as the core of your plugin.
    // ignore: avoid_web_libraries_in_flutter
    import 'dart:html' as html show window;
    
    import 'package:flutter/services.dart';
    import 'package:flutter_web_plugins/flutter_web_plugins.dart';
    
    /// A web implementation of the FlutterHiennv plugin.
    class FlutterHiennvWeb {
      static void registerWith(Registrar registrar) {
        final MethodChannel channel = MethodChannel(
          'flutter_hiennv',
          const StandardMethodCodec(),
          registrar,
        );
    
        final pluginInstance = FlutterHiennvWeb();
        channel.setMethodCallHandler(pluginInstance.handleMethodCall);
      }
    
      /// Handles method calls over the MethodChannel of this plugin.
      /// Note: Check the "federated" architecture for a new way of doing this:
      /// https://flutter.dev/go/federated-plugins
      Future<dynamic> handleMethodCall(MethodCall call) async {
        switch (call.method) {
          case 'getPlatformVersion':
            return getPlatformVersion();
          default:
            throw PlatformException(
              code: 'Unimplemented',
              details: 'flutter_hiennv for web doesn\'t implement \'${call.method}\'',
            );
        }
      }
    
      /// Returns a [String] containing the version of the platform.
      Future<String> getPlatformVersion() {
        final version = html.window.navigator.userAgent;
        return Future.value(version);
      }
    }


```