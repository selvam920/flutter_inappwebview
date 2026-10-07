import 'package:flutter/foundation.dart';
import 'package:drago_inappwebview_platform_interface/drago_inappwebview_platform_interface.dart';

///{@macro drago_inappwebview_platform_interface.PlatformPrintJobController}
///
///{@macro drago_inappwebview_platform_interface.PlatformPrintJobController.supported_platforms}
class PrintJobController {
  ///{@macro drago_inappwebview_platform_interface.PlatformPrintJobController}
  ///
  ///{@macro drago_inappwebview_platform_interface.PlatformPrintJobController.supported_platforms}
  PrintJobController({required String id})
    : this.fromPlatformCreationParams(
        params: PlatformPrintJobControllerCreationParams(id: id),
      );

  /// Constructs a [PrintJobController].
  ///
  /// See [PrintJobController.fromPlatformCreationParams] for setting parameters for
  /// a specific platform.
  PrintJobController.fromPlatformCreationParams({
    required PlatformPrintJobControllerCreationParams params,
  }) : this.fromPlatform(platform: PlatformPrintJobController(params));

  /// Constructs a [PrintJobController] from a specific platform implementation.
  PrintJobController.fromPlatform({required this.platform});

  /// Implementation of [PlatformPrintJobController] for the current platform.
  final PlatformPrintJobController platform;

  ///{@macro drago_inappwebview_platform_interface.PlatformPrintJobController.id}
  ///
  ///{@macro drago_inappwebview_platform_interface.PlatformPrintJobController.id.supported_platforms}
  String get id => platform.id;

  ///{@macro drago_inappwebview_platform_interface.PlatformPrintJobController.onComplete}
  ///
  ///{@macro drago_inappwebview_platform_interface.PlatformPrintJobController.onComplete.supported_platforms}
  PrintJobCompletionHandler? get onComplete => platform.onComplete;

  void set onComplete(PrintJobCompletionHandler? handler) {
    platform.onComplete = handler;
  }

  ///{@macro drago_inappwebview_platform_interface.PlatformPrintJobController.cancel}
  ///
  ///{@macro drago_inappwebview_platform_interface.PlatformPrintJobController.cancel.supported_platforms}
  Future<void> cancel() => platform.cancel();

  ///{@macro drago_inappwebview_platform_interface.PlatformPrintJobController.restart}
  ///
  ///{@macro drago_inappwebview_platform_interface.PlatformPrintJobController.restart.supported_platforms}
  Future<void> restart() => platform.restart();

  ///{@macro drago_inappwebview_platform_interface.PlatformPrintJobController.dismiss}
  ///
  ///{@macro drago_inappwebview_platform_interface.PlatformPrintJobController.dismiss.supported_platforms}
  Future<void> dismiss({bool animated = true}) =>
      platform.dismiss(animated: animated);

  ///{@macro drago_inappwebview_platform_interface.PlatformPrintJobController.getInfo}
  ///
  ///{@macro drago_inappwebview_platform_interface.PlatformPrintJobController.getInfo.supported_platforms}
  Future<PrintJobInfo?> getInfo() => platform.getInfo();

  ///{@macro drago_inappwebview_platform_interface.PlatformPrintJobController.dispose}
  ///
  ///{@macro drago_inappwebview_platform_interface.PlatformPrintJobController.dispose.supported_platforms}
  void dispose() => platform.dispose();

  ///{@macro drago_inappwebview_platform_interface.PlatformPrintJobControllerCreationParams.isClassSupported}
  static bool isClassSupported({TargetPlatform? platform}) =>
      PlatformPrintJobController.static().isClassSupported(platform: platform);

  ///{@macro drago_inappwebview_platform_interface.PlatformPrintJobController.isPropertySupported}
  static bool isPropertySupported(
    dynamic property, {
    TargetPlatform? platform,
  }) => PlatformPrintJobController.static().isPropertySupported(
    property,
    platform: platform,
  );

  ///{@macro drago_inappwebview_platform_interface.PlatformPrintJobController.isMethodSupported}
  static bool isMethodSupported(
    PlatformPrintJobControllerMethod method, {
    TargetPlatform? platform,
  }) => PlatformPrintJobController.static().isMethodSupported(
    method,
    platform: platform,
  );
}
