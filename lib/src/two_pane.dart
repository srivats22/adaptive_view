import 'package:flutter/material.dart';
import '../helper/AdaptiveViewScope.dart';

class TwoPaneLayout extends StatefulWidget {
  final Widget Function(BuildContext context, void Function(int index) onItemTap) listBuilder;
  final Widget Function(BuildContext context, int? selectedIndex) detailBuilder;
  final bool animateTransitions;
  final double listPaneFlex;
  final double detailPaneFlex;

  const TwoPaneLayout({
    super.key,
    required this.listBuilder,
    required this.detailBuilder,
    this.animateTransitions = true,
    this.listPaneFlex = 1.0,
    this.detailPaneFlex = 2.0,
  });

  @override
  State<TwoPaneLayout> createState() => _TwoPaneLayoutState();
}

class _TwoPaneLayoutState extends State<TwoPaneLayout> {
  late ValueNotifier<int?> selectedNotifier;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    selectedNotifier = AdaptiveViewScope.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // List pane
        Expanded(
          flex: widget.listPaneFlex.round(),
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                right: BorderSide(
                  color: Theme.of(context).dividerColor,
                  width: 1.0,
                ),
              ),
            ),
            child: widget.listBuilder(context, (index) {
              selectedNotifier.value = index;
            }),
          ),
        ),

        // Detail pane
        Expanded(
          flex: widget.detailPaneFlex.round(),
          child: ValueListenableBuilder<int?>(
            valueListenable: selectedNotifier,
            builder: (context, selectedIndex, child) {
              if (widget.animateTransitions) {
                return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: widget.detailBuilder(context, selectedIndex),
                );
              } else {
                return widget.detailBuilder(context, selectedIndex);
              }
            },
          ),
        ),
      ],
    );
  }
}