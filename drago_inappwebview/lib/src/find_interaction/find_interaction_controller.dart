import 'package:flutter/foundation.dart';
import 'package:drago_inappwebview_platform_interface/drago_inappwebview_platform_interface.dart';

///{@macro drago_inappwebview_platform_interface.PlatformFindInteractionController}
///
///{@macro drago_inappwebview_platform_interface.PlatformFindInteractionController.supported_platforms}
class FindInteractionController {
  ///{@macro drago_inappwebview_platform_interface.PlatformFindInteractionController}
  ///
  ///{@macro drago_inappwebview_platform_interface.PlatformFindInteractionController.supported_platforms}
  FindInteractionController({
    void Function(
      PlatformFindInteractionController controller,
      int activeMatchOrdinal,
      int numberOfMatches,
      bool isDoneCounting,
    )?
    onFindResultReceived,
  }) : this.fromPlatformCreationParams(
         params: PlatformFindInteractionControllerCreationParams(
           onFindResultReceived: onFindResultReceived,
         ),
       );

  /// Constructs a [FindInteractionController].
  ///
  /// See [FindInteractionController.fromPlatformCreationParams] for setting parameters for
  /// a specific platform.
  FindInteractionController.fromPlatformCreationParams({
    required PlatformFindInteractionControllerCreationParams params,
  }) : this.fromPlatform(platform: PlatformFindInteractionController(params));

  /// Constructs a [FindInteractionController] from a specific platform implementation.
  FindInteractionController.fromPlatform({required this.platform});

  /// Implementation of [PlatformFindInteractionController] for the current platform.
  final PlatformFindInteractionController platform;

  ///{@macro drago_inappwebview_platform_interface.PlatformFindInteractionController.onFindResultReceived}
  ///
  ///{@macro drago_inappwebview_platform_interface.PlatformFindInteractionController.onFindResultReceived.supported_platforms}
  void Function(
    PlatformFindInteractionController controller,
    int activeMatchOrdinal,
    int numberOfMatches,
    bool isDoneCounting,
  )?
  get onFindResultReceived => platform.onFindResultReceived;

  ///{@macro drago_inappwebview_platform_interface.PlatformFindInteractionController.findAll}
  ///
  ///{@macro drago_inappwebview_platform_interface.PlatformFindInteractionController.findAll.supported_platforms}
  Future<void> findAll({String? find}) => platform.findAll(find: find);

  ///{@macro drago_inappwebview_platform_interface.PlatformFindInteractionController.findNext}
  ///
  ///{@macro drago_inappwebview_platform_interface.PlatformFindInteractionController.findNext.supported_platforms}
  Future<void> findNext({bool forward = true}) =>
      platform.findNext(forward: forward);

  ///{@macro drago_inappwebview_platform_interface.PlatformFindInteractionController.clearMatches}
  ///
  ///{@macro drago_inappwebview_platform_interface.PlatformFindInteractionController.clearMatches.supported_platforms}
  Future<void> clearMatches() => platform.clearMatches();

  ///{@macro drago_inappwebview_platform_interface.PlatformFindInteractionController.setSearchText}
  ///
  ///{@macro drago_inappwebview_platform_interface.PlatformFindInteractionController.setSearchText.supported_platforms}
  Future<void> setSearchText(String? searchText) =>
      platform.setSearchText(searchText);

  ///{@macro drago_inappwebview_platform_interface.PlatformFindInteractionController.getSearchText}
  ///
  ///{@macro drago_inappwebview_platform_interface.PlatformFindInteractionController.getSearchText.supported_platforms}
  Future<String?> getSearchText() => platform.getSearchText();

  ///{@macro drago_inappwebview_platform_interface.PlatformFindInteractionController.isFindNavigatorVisible}
  ///
  ///{@macro drago_inappwebview_platform_interface.PlatformFindInteractionController.isFindNavigatorVisible.supported_platforms}
  Future<bool?> isFindNavigatorVisible() => platform.isFindNavigatorVisible();

  ///{@macro drago_inappwebview_platform_interface.PlatformFindInteractionController.updateResultCount}
  ///
  ///{@macro drago_inappwebview_platform_interface.PlatformFindInteractionController.updateResultCount.supported_platforms}
  Future<void> updateResultCount() => platform.updateResultCount();

  ///{@macro drago_inappwebview_platform_interface.PlatformFindInteractionController.presentFindNavigator}
  ///
  ///{@macro drago_inappwebview_platform_interface.PlatformFindInteractionController.presentFindNavigator.supported_platforms}
  Future<void> presentFindNavigator() => platform.presentFindNavigator();

  ///{@macro drago_inappwebview_platform_interface.PlatformFindInteractionController.dismissFindNavigator}
  ///
  ///{@macro drago_inappwebview_platform_interface.PlatformFindInteractionController.dismissFindNavigator.supported_platforms}
  Future<void> dismissFindNavigator() => platform.dismissFindNavigator();

  ///{@macro drago_inappwebview_platform_interface.PlatformFindInteractionController.getActiveFindSession}
  ///
  ///{@macro drago_inappwebview_platform_interface.PlatformFindInteractionController.getActiveFindSession.supported_platforms}
  Future<FindSession?> getActiveFindSession() =>
      platform.getActiveFindSession();

  ///{@macro drago_inappwebview_platform_interface.PlatformFindInteractionController.dispose}
  ///
  ///{@macro drago_inappwebview_platform_interface.PlatformFindInteractionController.dispose.supported_platforms}
  void dispose({bool isKeepAlive = false}) => platform.dispose();

  ///{@macro drago_inappwebview_platform_interface.PlatformFindInteractionControllerCreationParams.isClassSupported}
  static bool isClassSupported({TargetPlatform? platform}) =>
      PlatformFindInteractionController.static().isClassSupported(
        platform: platform,
      );

  ///{@macro drago_inappwebview_platform_interface.PlatformFindInteractionController.isPropertySupported}
  static bool isPropertySupported(
    PlatformFindInteractionControllerCreationParamsProperty property, {
    TargetPlatform? platform,
  }) => PlatformFindInteractionController.static().isPropertySupported(
    property,
    platform: platform,
  );

  ///{@macro drago_inappwebview_platform_interface.PlatformFindInteractionController.isMethodSupported}
  static bool isMethodSupported(
    PlatformFindInteractionControllerMethod method, {
    TargetPlatform? platform,
  }) => PlatformFindInteractionController.static().isMethodSupported(
    method,
    platform: platform,
  );
}
