import 'package:flutter/material.dart';

class CoinDropOverlay extends StatefulWidget {
  final List<int> coins;

  const CoinDropOverlay({super.key, required this.coins});

  @override
  State<CoinDropOverlay> createState() => _CoinDropOverlayState();
}

class _CoinDropOverlayState extends State<CoinDropOverlay>
    with TickerProviderStateMixin {
  final List<AnimationController> _controllers = [];
  final List<Animation<Offset>> _animations = [];

  @override
  void initState() {
    super.initState();

    for (int i = 0; i < widget.coins.length; i++) {
      final controller = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 700),
      );

      final animation = Tween<Offset>(
        begin: const Offset(0, -1.5),
        end: const Offset(0, 0),
      ).animate(
        CurvedAnimation(parent: controller, curve: Curves.easeOutCubic),
      );

      _controllers.add(controller);
      _animations.add(animation);

      // 순차적 애니메이션 시작
      Future.delayed(Duration(milliseconds: i * 100), () {
        if (mounted) controller.forward();
      });
    }

    // 자동 닫힘 (전체 애니메이션 이후)
    Future.delayed(
      Duration(milliseconds: 700 + widget.coins.length * 100 + 500),
      () {
        if (mounted) Navigator.of(context).pop();
      },
    );
  }

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    super.dispose();
  }

  Widget _buildCoin(int unit, int index) {
    final imagePath = 'assets/images/$unit.png';
    return SlideTransition(
      position: _animations[index],
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: Image.asset(
          imagePath,
          width: 60,
          height: 60,
          errorBuilder: (context, error, stackTrace) => Container(
            width: 60,
            height: 60,
            color: Colors.grey[400],
            child: Center(child: Text('$unit원')),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: Wrap(
          alignment: WrapAlignment.center,
          children: List.generate(
            widget.coins.length,
            (i) => _buildCoin(widget.coins[i], i),
          ),
        ),
      ),
    );
  }
}
