import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:drago_inappwebview_platform_interface/drago_inappwebview_platform_interface.dart';

///{@macro drago_inappwebview_platform_interface.PlatformContainerController}
///
///{@macro drago_inappwebview_platform_interface.PlatformContainerController.supported_platforms}
class ContainerController {
  ///{@macro drago_inappwebview_platform_interface.PlatformContainerController}
  ContainerController()
    : this.fromPlatformCreationParams(
        const PlatformContainerControllerCreationParams(),
      );

  /// Constructs a [ContainerController] from creation params for a specific
  /// platform.
  ContainerController.fromPlatformCreationParams(
    PlatformContainerControllerCreationParams params,
  ) : this.fromPlatform(PlatformContainerController(params));

  /// Constructs a [ContainerController] from a specific platform
  /// implementation.
  ContainerController.fromPlatform(this.platform);

  /// Implementation of [PlatformContainerController] for the current platform.
  final PlatformContainerController platform;

  static ContainerController? _instance;

  ///Gets the [ContainerController] shared instance.
  static ContainerController instance() {
    return _instance ??= ContainerController();
  }

  ///{@macro drago_inappwebview_platform_interface.PlatformContainerController.getAllContainerNames}
  ///
  ///{@macro drago_inappwebview_platform_interface.PlatformContainerController.getAllContainerNames.supported_platforms}
  Future<List<String>> getAllContainerNames() =>
      platform.getAllContainerNames();

  ///{@macro drago_inappwebview_platform_interface.PlatformContainerController.hasProfile}
  ///
  ///{@macro drago_inappwebview_platform_interface.PlatformContainerController.hasProfile.supported_platforms}
  Future<bool> hasContainer(String containerId) =>
      platform.hasContainer(containerId);

  ///{@macro drago_inappwebview_platform_interface.PlatformContainerController.deleteProfile}
  ///
  ///{@macro drago_inappwebview_platform_interface.PlatformContainerController.deleteProfile.supported_platforms}
  Future<bool> deleteContainer(String containerId) =>
      platform.deleteContainer(containerId);

  ///{@macro drago_inappwebview_platform_interface.PlatformContainerController.clearContainerData}
  ///
  ///{@macro drago_inappwebview_platform_interface.PlatformContainerController.clearContainerData.supported_platforms}
  Future<bool> clearContainerData(String containerId) =>
      platform.clearContainerData(containerId);

  ///{@macro drago_inappwebview_platform_interface.PlatformContainerControllerCreationParams.isClassSupported}
  static bool isClassSupported({TargetPlatform? platform}) =>
      PlatformContainerController.static().isClassSupported(platform: platform);

  ///{@macro drago_inappwebview_platform_interface.PlatformContainerController.isMethodSupported}
  static bool isMethodSupported(
    PlatformContainerControllerMethod method, {
    TargetPlatform? platform,
  }) => PlatformContainerController.static().isMethodSupported(
    method,
    platform: platform,
  );
}
