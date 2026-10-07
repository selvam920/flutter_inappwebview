import 'dart:ui';

import 'package:flutter/services.dart';
import 'package:drago_inappwebview_platform_interface/drago_inappwebview_platform_interface.dart';

///{@macro drago_inappwebview_platform_interface.PlatformPullToRefreshController}
///
///{@macro drago_inappwebview_platform_interface.PlatformPullToRefreshController.supported_platforms}
class PullToRefreshController {
  ///{@macro drago_inappwebview_platform_interface.PlatformPullToRefreshController}
  ///
  ///{@macro drago_inappwebview_platform_interface.PlatformPullToRefreshController.supported_platforms}
  PullToRefreshController({
    void Function()? onRefresh,
    @Deprecated("Use settings instead") PullToRefreshOptions? options,
    PullToRefreshSettings? settings,
  }) : this.fromPlatformCreationParams(
         params: PlatformPullToRefreshControllerCreationParams(
           onRefresh: onRefresh,
           options: options,
           settings: settings,
         ),
       );

  /// Constructs a [PullToRefreshController].
  ///
  /// See [PullToRefreshController.fromPlatformCreationParams] for setting parameters for
  /// a specific platform.
  PullToRefreshController.fromPlatformCreationParams({
    required PlatformPullToRefreshControllerCreationParams params,
  }) : this.fromPlatform(platform: PlatformPullToRefreshController(params));

  /// Constructs a [PullToRefreshController] from a specific platform implementation.
  PullToRefreshController.fromPlatform({required this.platform});

  /// Implementation of [PlatformPullToRefreshController] for the current platform.
  final PlatformPullToRefreshController platform;

  ///{@macro drago_inappwebview_platform_interface.PlatformPullToRefreshController.options}
  ///
  ///{@macro drago_inappwebview_platform_interface.PlatformPullToRefreshController.options.supported_platforms}
  @Deprecated("Use settings instead")
  PullToRefreshOptions get options => platform.options;

  ///{@macro drago_inappwebview_platform_interface.PlatformPullToRefreshController.settings}
  ///
  ///{@macro drago_inappwebview_platform_interface.PlatformPullToRefreshController.settings.supported_platforms}
  PullToRefreshSettings get settings => platform.settings;

  ///{@macro drago_inappwebview_platform_interface.PlatformPullToRefreshController.onRefresh}
  ///
  ///{@macro drago_inappwebview_platform_interface.PlatformPullToRefreshController.onRefresh.supported_platforms}
  void Function()? get onRefresh => platform.onRefresh;

  ///{@macro drago_inappwebview_platform_interface.PlatformPullToRefreshController.setEnabled}
  ///
  ///{@macro drago_inappwebview_platform_interface.PlatformPullToRefreshController.setEnabled.supported_platforms}
  Future<void> setEnabled(bool enabled) => platform.setEnabled(enabled);

  ///{@macro drago_inappwebview_platform_interface.PlatformPullToRefreshController.isEnabled}
  ///
  ///{@macro drago_inappwebview_platform_interface.PlatformPullToRefreshController.isEnabled.supported_platforms}
  Future<bool> isEnabled() => platform.isEnabled();

  ///{@macro drago_inappwebview_platform_interface.PlatformPullToRefreshController.beginRefreshing}
  ///
  ///{@macro drago_inappwebview_platform_interface.PlatformPullToRefreshController.beginRefreshing.supported_platforms}
  Future<void> beginRefreshing() => platform.beginRefreshing();

  ///{@macro drago_inappwebview_platform_interface.PlatformPullToRefreshController.endRefreshing}
  ///
  ///{@macro drago_inappwebview_platform_interface.PlatformPullToRefreshController.endRefreshing.supported_platforms}
  Future<void> endRefreshing() => platform.endRefreshing();

  ///{@macro drago_inappwebview_platform_interface.PlatformPullToRefreshController.isRefreshing}
  ///
  ///{@macro drago_inappwebview_platform_interface.PlatformPullToRefreshController.isRefreshing.supported_platforms}
  Future<bool> isRefreshing() => platform.isRefreshing();

  ///{@macro drago_inappwebview_platform_interface.PlatformPullToRefreshController.setColor}
  ///
  ///{@macro drago_inappwebview_platform_interface.PlatformPullToRefreshController.setColor.supported_platforms}
  Future<void> setColor(Color color) => platform.setColor(color);

  ///{@macro drago_inappwebview_platform_interface.PlatformPullToRefreshController.setBackgroundColor}
  ///
  ///{@macro drago_inappwebview_platform_interface.PlatformPullToRefreshController.setBackgroundColor.supported_platforms}
  Future<void> setBackgroundColor(Color color) =>
      platform.setBackgroundColor(color);

  ///{@macro drago_inappwebview_platform_interface.PlatformPullToRefreshController.setDistanceToTriggerSync}
  ///
  ///{@macro drago_inappwebview_platform_interface.PlatformPullToRefreshController.setDistanceToTriggerSync.supported_platforms}
  Future<void> setDistanceToTriggerSync(int distanceToTriggerSync) =>
      platform.setDistanceToTriggerSync(distanceToTriggerSync);

  ///{@macro drago_inappwebview_platform_interface.PlatformPullToRefreshController.setSlingshotDistance}
  ///
  ///{@macro drago_inappwebview_platform_interface.PlatformPullToRefreshController.setSlingshotDistance.supported_platforms}
  Future<void> setSlingshotDistance(int slingshotDistance) =>
      platform.setSlingshotDistance(slingshotDistance);

  ///{@macro drago_inappwebview_platform_interface.PlatformPullToRefreshController.getDefaultSlingshotDistance}
  ///
  ///{@macro drago_inappwebview_platform_interface.PlatformPullToRefreshController.getDefaultSlingshotDistance.supported_platforms}
  Future<int> getDefaultSlingshotDistance() =>
      platform.getDefaultSlingshotDistance();

  ///{@macro drago_inappwebview_platform_interface.PlatformPullToRefreshController.setSize}
  ///
  ///{@macro drago_inappwebview_platform_interface.PlatformPullToRefreshController.setSize.supported_platforms}
  @Deprecated("Use setIndicatorSize instead")
  Future<void> setSize(AndroidPullToRefreshSize size) => platform.setSize(size);

  ///{@macro drago_inappwebview_platform_interface.PlatformPullToRefreshController.setIndicatorSize}
  ///
  ///{@macro drago_inappwebview_platform_interface.PlatformPullToRefreshController.setIndicatorSize.supported_platforms}
  Future<void> setIndicatorSize(PullToRefreshSize size) =>
      platform.setIndicatorSize(size);

  ///{@macro drago_inappwebview_platform_interface.PlatformPullToRefreshController.setAttributedTitle}
  ///
  ///{@macro drago_inappwebview_platform_interface.PlatformPullToRefreshController.setAttributedTitle.supported_platforms}
  @Deprecated("Use setStyledTitle instead")
  Future<void> setAttributedTitle(IOSNSAttributedString attributedTitle) =>
      platform.setAttributedTitle(attributedTitle);

  ///{@macro drago_inappwebview_platform_interface.PlatformPullToRefreshController.setStyledTitle}
  ///
  ///{@macro drago_inappwebview_platform_interface.PlatformPullToRefreshController.setStyledTitle.supported_platforms}
  Future<void> setStyledTitle(AttributedString attributedTitle) =>
      platform.setStyledTitle(attributedTitle);

  ///{@macro drago_inappwebview_platform_interface.PlatformPullToRefreshController.dispose}
  ///
  ///{@macro drago_inappwebview_platform_interface.PlatformPullToRefreshController.dispose.supported_platforms}
  void dispose({bool isKeepAlive = false}) =>
      platform.dispose(isKeepAlive: isKeepAlive);

  ///{@macro drago_inappwebview_platform_interface.PlatformPullToRefreshController.isClassSupported}
  static bool isClassSupported({TargetPlatform? platform}) =>
      PlatformPullToRefreshController.static().isClassSupported(
        platform: platform,
      );

  ///{@macro drago_inappwebview_platform_interface.PlatformPullToRefreshController.isPropertySupported}
  static bool isPropertySupported(
    PlatformPullToRefreshControllerCreationParamsProperty property, {
    TargetPlatform? platform,
  }) => PlatformPullToRefreshController.static().isPropertySupported(
    property,
    platform: platform,
  );

  ///{@macro drago_inappwebview_platform_interface.PlatformPullToRefreshController.isMethodSupported}
  static bool isMethodSupported(
    PlatformPullToRefreshControllerMethod method, {
    TargetPlatform? platform,
  }) => PlatformPullToRefreshController.static().isMethodSupported(
    method,
    platform: platform,
  );
}
