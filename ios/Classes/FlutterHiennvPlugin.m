#import "FlutterHiennvPlugin.h"
#if __has_include(<flutter_hiennv/flutter_hiennv-Swift.h>)
#import <flutter_hiennv/flutter_hiennv-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "flutter_hiennv-Swift.h"
#endif

@implementation FlutterHiennvPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterHiennvPlugin registerWithRegistrar:registrar];
}
@end
