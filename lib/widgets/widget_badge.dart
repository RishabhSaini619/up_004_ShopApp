import 'package:flutter/material.dart';

class BadgeWidget extends StatelessWidget {
  const BadgeWidget({
    Key key,
    @required this.badgeChild,
    @required this.badgeValue,
    this.badgeColor,
  }) : super(key: key);

  final Widget badgeChild;
  final String badgeValue;
  final Color badgeColor;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        badgeChild,
        Positioned(
          right: 13,
          top: 12,
          child: Container(
            padding: const EdgeInsets.all(2.0),
            // color: Theme.of(context).accentColor,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: badgeColor != null ? badgeColor : Theme.of(context).colorScheme.secondary.withOpacity(0.6),
            ),
            constraints: const BoxConstraints(
              minWidth: 20,
              minHeight: 20,
            ),
            child: Text(
              badgeValue,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleSmall
            ),
          ),
        )
      ],
    );
  }
}
