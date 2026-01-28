import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../app_model.dart';
import '../../app_progress_indicator.dart';
import '../../settings_model.dart';
import '../../utilities/color_definitions.dart';

class SettingsDetail extends StatefulWidget {
  const SettingsDetail({super.key});

  @override
  State<SettingsDetail> createState() => _SettingsDetailState();
}

class _SettingsDetailState extends State<SettingsDetail> {
  StreamSubscription<String>? exceptionStreamSubscription;

  @override
  didChangeDependencies() {
    super.didChangeDependencies();

    exceptionStreamSubscription = context.read<AppModel>().exceptionStreamController.stream.listen((message) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(message), duration: const Duration(seconds: 10)));
    });
  }

  @override
  void dispose() async {
    super.dispose();
    if (exceptionStreamSubscription != null) {
      await exceptionStreamSubscription!.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    final settingsModel = context.read<SettingsModel>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        flexibleSpace: const AppProgressIndicator(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DropdownButton<Color>(
                  value: settingsModel.themeDataColorSchemeSeed,
                  onChanged: (value) => setState(() => settingsModel.setThemeDataColorSchemeSeed(value)),
                  items: ColorDefinitions.primaries
                      .map<DropdownMenuItem<Color>>((x) => DropdownMenuItem<Color>(
                          value: x.color,
                          child: Row(
                            children: [
                              CircleAvatar(backgroundColor: x.color),
                              const SizedBox(
                                width: 8,
                              ),
                              Text(x.name),
                            ],
                          )))
                      .toList()),
              RadioListTile(
                  title: const Text('Light'),
                  value: Brightness.light,
                  groupValue: settingsModel.themeDataBrightness,
                  onChanged: (value) => setState(() => settingsModel.setThemeDataBrightness(value))),
              RadioListTile(
                  title: const Text('Dark'),
                  value: Brightness.dark,
                  groupValue: settingsModel.themeDataBrightness,
                  onChanged: (value) => setState(() => settingsModel.setThemeDataBrightness(value))),
              // Container(color: Theme.of(context).colorScheme.primary, child: const Text('primary The color displayed most frequently across your app’s screens and components.')),
              // Container(color: Theme.of(context).colorScheme.onPrimary, child: const Text("onPrimary A color that's clearly legible when drawn on [primary].")),
              // Container(color: Theme.of(context).colorScheme.primaryContainer, child: const Text('primaryContainer A color used for elements needing less emphasis than [primary].')),
              // Container(color: Theme.of(context).colorScheme.onPrimaryContainer, child: const Text("onPrimaryContainer A color that's clearly legible when drawn on [primaryContainer].")),
              // Container(color: Theme.of(context).colorScheme.primaryFixed, child: const Text("primaryFixed A substitute for [primaryContainer] that's the same color for the dark and light themes.")),
              // Container(color: Theme.of(context).colorScheme.primaryFixedDim, child: const Text("primaryFixedDim A color used for elements needing more emphasis than [primaryFixed].")),
              // Container(color: Theme.of(context).colorScheme.onPrimaryFixed, child: const Text("onPrimaryFixed A color that is used for text and icons that exist on top of elements having [primaryFixed] color.")),
              // Container(color: Theme.of(context).colorScheme.onPrimaryFixedVariant, child: const Text("onPrimaryFixedVariant A color that provides a lower-emphasis option for text and icons than [onPrimaryFixed].")),
              // Container(color: Theme.of(context).colorScheme.secondary, child: const Text("secondary An accent color used for less prominent components in the UI, such as filter chips, while expanding the opportunity for color expression.")),
              // Container(color: Theme.of(context).colorScheme.onSecondary, child: const Text("onSecondary A color that's clearly legible when drawn on [secondary].")),
              // Container(color: Theme.of(context).colorScheme.secondaryContainer, child: const Text("secondaryContainer A color used for elements needing less emphasis than [secondary].")),
              // Container(color: Theme.of(context).colorScheme.onSecondaryContainer, child: const Text("onSecondaryContainer A color that's clearly legible when drawn on [secondaryContainer].")),
              // Container(color: Theme.of(context).colorScheme.secondaryFixed, child: const Text("secondaryFixed A substitute for [secondaryContainer] that's the same color for the dark and light themes.")),
              // Container(color: Theme.of(context).colorScheme.secondaryFixedDim, child: const Text("secondaryFixedDim A color used for elements needing more emphasis than [secondaryFixed].")),
              // Container(color: Theme.of(context).colorScheme.onSecondaryFixed, child: const Text("onSecondaryFixed A color that is used for text and icons that exist on top of elements having [secondaryFixed] color.")),
              // Container(color: Theme.of(context).colorScheme.onSecondaryFixedVariant, child: const Text("onSecondaryFixedVariant A color that provides a lower-emphasis option for text and icons than [onSecondaryFixed].")),
              // Container(color: Theme.of(context).colorScheme.tertiary, child: const Text("tertiary A color used as a contrasting accent that can balance [primary] and [secondary] colors or bring heightened attention to an element, such as an input field.")),
              // Container(color: Theme.of(context).colorScheme.onTertiary, child: const Text("onTertiary A color that's clearly legible when drawn on [tertiary].")),
              // Container(color: Theme.of(context).colorScheme.tertiaryContainer, child: const Text("tertiaryContainer A color used for elements needing less emphasis than [tertiary].")),
              // Container(color: Theme.of(context).colorScheme.onTertiaryContainer, child: const Text("onTertiaryContainer A color that's clearly legible when drawn on [tertiaryContainer].")),
              //Container(color: Theme.of(context).colorScheme., child: const Text("")),
              //Container(color: Theme.of(context).colorScheme., child: const Text("")),
              //Container(color: Theme.of(context).colorScheme., child: const Text("")),




  //final Color? _tertiaryFixed;
  /// A substitute for [tertiaryContainer] that's the same color for dark
  /// and light themes.
  //Color get tertiaryFixed => _tertiaryFixed ?? tertiary;

  //final Color? _tertiaryFixedDim;
  /// A color used for elements needing more emphasis than [tertiaryFixed].
  //Color get tertiaryFixedDim => _tertiaryFixedDim ?? tertiary;

  //final Color? _onTertiaryFixed;
  /// A color that is used for text and icons that exist on top of elements having
  /// [tertiaryFixed] color.
  //Color get onTertiaryFixed => _onTertiaryFixed ?? onTertiary;

  //final Color? _onTertiaryFixedVariant;
  /// A color that provides a lower-emphasis option for text and icons than
  /// [onTertiaryFixed].
  //Color get onTertiaryFixedVariant => _onTertiaryFixedVariant ?? onTertiary;

  /// The color to use for input validation errors, e.g. for
  /// [InputDecoration.errorText].
  //final Color error;

  /// A color that's clearly legible when drawn on [error].
  ///
  /// To ensure that an app is accessible, a contrast ratio between
  /// [error] and [onError] of at least 4.5:1 is recommended. See
  /// <https://www.w3.org/TR/UNDERSTANDING-WCAG20/visual-audio-contrast-contrast.html>.
  //final Color onError;

  //final Color? _errorContainer;
  /// A color used for error elements needing less emphasis than [error].
  //Color get errorContainer => _errorContainer ?? error;

  //final Color? _onErrorContainer;
  /// A color that's clearly legible when drawn on [errorContainer].
  ///
  /// To ensure that an app is accessible, a contrast ratio between
  /// [errorContainer] and [onErrorContainer] of at least 4.5:1 is
  /// recommended. See
  /// <https://www.w3.org/TR/UNDERSTANDING-WCAG20/visual-audio-contrast-contrast.html>.
  //Color get onErrorContainer => _onErrorContainer ?? onError;

  /// The background color for widgets like [Scaffold].
  //final Color surface;

  /// A color that's clearly legible when drawn on [surface].
  ///
  /// To ensure that an app is accessible, a contrast ratio between
  /// [surface] and [onSurface] of at least 4.5:1 is recommended. See
  /// <https://www.w3.org/TR/UNDERSTANDING-WCAG20/visual-audio-contrast-contrast.html>.
  //final Color onSurface;


  //final Color? _surfaceDim;
  /// A color that's always darkest in the dark or light theme.
  //Color get surfaceDim => _surfaceDim ?? surface;

  //final Color? _surfaceBright;
  /// A color that's always the lightest in the dark or light theme.
  //Color get surfaceBright => _surfaceBright ?? surface;

  //final Color? _surfaceContainerLowest;
  /// A surface container color with the lightest tone and the least emphasis
  /// relative to the surface.
  //Color get surfaceContainerLowest => _surfaceContainerLowest ?? surface;

  //final Color? _surfaceContainerLow;
  /// A surface container color with a lighter tone that creates less emphasis
  /// than [surfaceContainer] but more emphasis than [surfaceContainerLowest].
  //Color get surfaceContainerLow => _surfaceContainerLow ?? surface;

  //final Color? _surfaceContainer;
  /// A recommended color role for a distinct area within the surface.
  ///
  /// Surface container color roles are independent of elevation. They replace the old
  /// opacity-based model which applied a tinted overlay on top of
  /// surfaces based on their elevation.
  ///
  /// Surface container colors include [surfaceContainerLowest], [surfaceContainerLow],
  /// [surfaceContainer], [surfaceContainerHigh] and [surfaceContainerHighest].
  //Color get surfaceContainer => _surfaceContainer ?? surface;

  //final Color? _surfaceContainerHigh;
  /// A surface container color with a darker tone. It is used to create more
  /// emphasis than [surfaceContainer] but less emphasis than [surfaceContainerHighest].
  //Color get surfaceContainerHigh => _surfaceContainerHigh ?? surface;

  //final Color? _surfaceContainerHighest;
  /// A surface container color with the darkest tone. It is used to create the
  /// most emphasis against the surface.
  //Color get surfaceContainerHighest => _surfaceContainerHighest ?? surface;

  //final Color? _onSurfaceVariant;
  /// A color that's clearly legible when drawn on [surfaceVariant].
  ///
  /// To ensure that an app is accessible, a contrast ratio between
  /// [surfaceVariant] and [onSurfaceVariant] of at least 4.5:1 is
  /// recommended. See
  /// <https://www.w3.org/TR/UNDERSTANDING-WCAG20/visual-audio-contrast-contrast.html>.
  //Color get onSurfaceVariant => _onSurfaceVariant ?? onSurface;

  //final Color? _outline;
  /// A utility color that creates boundaries and emphasis to improve usability.
  //Color get outline => _outline ?? onBackground;

  //final Color? _outlineVariant;
  /// A utility color that creates boundaries for decorative elements when a
  /// 3:1 contrast isn’t required, such as for dividers or decorative elements.
  //Color get outlineVariant => _outlineVariant ?? onBackground;

  //final Color? _shadow;
  /// A color use to paint the drop shadows of elevated components.
  //Color get shadow => _shadow ?? const Color(0xff000000);

  //final Color? _scrim;
  /// A color use to paint the scrim around of modal components.
  //Color get scrim => _scrim ?? const Color(0xff000000);

  //final Color? _inverseSurface;
  /// A surface color used for displaying the reverse of what’s seen in the
  /// surrounding UI, for example in a SnackBar to bring attention to
  /// an alert.
  //Color get inverseSurface => _inverseSurface ?? onSurface;

  //final Color? _onInverseSurface;
  /// A color that's clearly legible when drawn on [inverseSurface].
  ///
  /// To ensure that an app is accessible, a contrast ratio between
  /// [inverseSurface] and [onInverseSurface] of at least 4.5:1 is
  /// recommended. See
  /// <https://www.w3.org/TR/UNDERSTANDING-WCAG20/visual-audio-contrast-contrast.html>.
  //Color get onInverseSurface => _onInverseSurface ?? surface;

  //final Color? _inversePrimary;
  /// An accent color used for displaying a highlight color on [inverseSurface]
  /// backgrounds, like button text in a SnackBar.
  //Color get inversePrimary => _inversePrimary ?? onPrimary;

  //final Color? _surfaceTint;
  /// A color used as an overlay on a surface color to indicate a component's
  /// elevation.
  //Color get surfaceTint => _surfaceTint ?? primary;




            ],
          ),
        ),
      ),
    );
  }
}
