import 'package:flutter/material.dart';

class MySliverAppbar extends StatelessWidget {

  final Widget? child;
  final Widget? title;
  final IconButton? icon;
  final double? height;
  final Color? color;

  const MySliverAppbar({super.key,
    this.child,
    this.title,
    this.icon,
    this.height,
    this.color
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: height,
      actions:icon!= null ? [
        icon!,
      ] : null,
      backgroundColor: color ?? Theme.of(context).colorScheme.surface,
      floating: false,
      title: title,
      flexibleSpace: FlexibleSpaceBar(
        background: child,
      ),
    );
  }
}