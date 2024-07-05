import 'package:flutter/material.dart';

class SidebarButton extends StatelessWidget {
  const SidebarButton(
      {super.key,
      required this.isSelected,
      required this.icon,
      required this.label,
      required this.onPressed,
      required this.isAnimationEnd});
  final bool isSelected;
  final IconData icon;
  final String? label;
  final VoidCallback onPressed;
  final bool isAnimationEnd;

  final Duration duration = const Duration(milliseconds: 1000);

  @override
  Widget build(BuildContext context) {
    return Material(
      color:
          isSelected ? const Color.fromRGBO(26, 31, 85, 1) : Colors.transparent,
      borderRadius: BorderRadius.circular(10),
      elevation: 10,
      child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(10),
          child: Container(
              alignment: Alignment.center,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10)),
              padding: const EdgeInsets.all(5),
              // padding:  EdgeInsets.all(expanded ? 5 : 0),
              child: Row(
                mainAxisAlignment: isAnimationEnd
                    ? MainAxisAlignment.start
                    : MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                        color: isSelected
                            ? Colors.blue
                            : const Color.fromRGBO(26, 31, 85, 1),
                        borderRadius: BorderRadius.circular(10)),
                    child: Icon(
                      icon,
                      size: 20,
                      color: isSelected ? Colors.white : Colors.blue,
                    ),
                  ),
                  isAnimationEnd
                      ? const SizedBox(
                          width: 15,
                        )
                      : const Spacer(),
                  AnimatedOpacity(
                      opacity: isAnimationEnd ? 1 : 0,
                      duration: duration,
                      child: isAnimationEnd
                          ? Text(label ?? "Button")
                          : Container()),
                ],
              ))),
    );
  }
}
