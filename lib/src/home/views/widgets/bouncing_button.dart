import 'package:flutter/material.dart';

class BouncingButton extends StatefulWidget {
  final VoidCallback onPressed;
  final bool isMarked;

  const BouncingButton({
    required this.onPressed,
    required this.isMarked,
    super.key,
  });

  @override
  State<BouncingButton> createState() => _BouncingButtonState();
}

class _BouncingButtonState extends State<BouncingButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.9).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _controller.forward(),
      onTapUp: (_) {
        _controller.reverse();
        widget.onPressed();
      },
      onTapCancel: () => _controller.reverse(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Transform.scale(
                scale: _scaleAnimation.value,
                child: child,
              );
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              decoration: BoxDecoration(
                color: widget.isMarked ? Colors.grey : Colors.green,
                shape: BoxShape.circle,
              ),
              width: 80,
              height: 80,
              child: const Icon(
                Icons.touch_app,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            widget.isMarked ? 'Unmark' : 'Mark',
          )
        ],
      ),
    );
  }
}
