import 'package:flutter/material.dart';
import '../helper/AdaptiveViewScope.dart';

class OnePaneLayout extends StatefulWidget {
  final Widget Function(BuildContext context, void Function(int index) onItemTap) listBuilder;
  final Widget Function(BuildContext context, int? selectedIndex) detailBuilder;
  final bool animateTransitions;
  final bool showAppBar;

  const OnePaneLayout({
    super.key,
    required this.listBuilder,
    required this.detailBuilder,
    this.animateTransitions = true,
    this.showAppBar = true,
  });

  @override
  State<OnePaneLayout> createState() => _OnePaneLayoutState();
}

class _OnePaneLayoutState extends State<OnePaneLayout> {
  @override
  Widget build(BuildContext context) {
    return widget.listBuilder(context, (index) {
      _navigateToDetail(context, index);
    });
  }

  void _navigateToDetail(BuildContext context, int index) {
    final selectedNotifier = AdaptiveViewScope.of(context);
    selectedNotifier.value = index;

    if (widget.animateTransitions) {
      Navigator.of(context).push(
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            return _DetailPage(
              detailBuilder: widget.detailBuilder,
              selectedIndex: index,
            );
          },
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0);
            const end = Offset.zero;
            const curve = Curves.ease;

            var tween = Tween(begin: begin, end: end).chain(
              CurveTween(curve: curve),
            );

            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
        ),
      );
    } else {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => _DetailPage(
            detailBuilder: widget.detailBuilder,
            selectedIndex: index,
            showAppBar: widget.showAppBar,
          ),
        ),
      );
    }
  }
}

class _DetailPage extends StatelessWidget {
  final Widget Function(BuildContext context, int? selectedIndex) detailBuilder;
  final int selectedIndex;
  final bool showAppBar;

  const _DetailPage({
    required this.detailBuilder,
    required this.selectedIndex,
    this.showAppBar = false,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: showAppBar ? AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ) : null,
      body: detailBuilder(context, selectedIndex),
    );
  }
}