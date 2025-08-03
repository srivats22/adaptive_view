import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:platform_identifier/platform_identifier.dart';
import '../helper/AdaptiveViewScope.dart';
import 'one_pane.dart';
import 'two_pane.dart';

class AdaptiveView extends StatelessWidget {
  final Widget Function(BuildContext context, void Function(int index) onItemTap) listBuilder;
  final Widget Function(BuildContext context, int? selectedIndex) detailBuilder;
  final double breakpoint;
  final bool animateTransitions;
  final bool showAppBar;

  const AdaptiveView({
    super.key,
    required this.listBuilder,
    required this.detailBuilder,
    this.breakpoint = 600.0,
    this.animateTransitions = true,
    this.showAppBar = true,
  });

  @override
  Widget build(BuildContext context) {
    return AdaptiveViewScope(
      child: Builder(
        builder: (context) {
          final isDesktop = PlatformIdentifier.isDesktop
          || PlatformIdentifier.isDesktopBrowser;

          if (isDesktop) {
            return TwoPaneLayout(
              listBuilder: listBuilder,
              detailBuilder: detailBuilder,
              animateTransitions: animateTransitions,
            );
          } else {
            return OnePaneLayout(
              listBuilder: listBuilder,
              detailBuilder: detailBuilder,
              animateTransitions: animateTransitions,
              showAppBar: showAppBar,
            );
          }
        },
      ),
    );
  }
}