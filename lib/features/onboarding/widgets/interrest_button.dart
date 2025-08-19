import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class InterrestButton extends StatefulWidget {
  const InterrestButton({Key? key, required this.interest}) : super(key: key);

  final String interest;

  @override
  State<InterrestButton> createState() => _InterrestButtonState();
}

class _InterrestButtonState extends State<InterrestButton> {
  bool _isSelected = false;

  void _onTap() {
    setState(() {
      _isSelected = !_isSelected;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        decoration: BoxDecoration(
          color: _isSelected ? Colors.blue : Colors.white,
          borderRadius: BorderRadius.circular(Sizes.size32),
          boxShadow: [BoxShadow(color: Colors.grey, spreadRadius: 1)],
        ),
        padding: EdgeInsets.symmetric(
          vertical: Sizes.size14,
          horizontal: Sizes.size28,
        ),
        child: Text(
          widget.interest,
          style: TextStyle(color: _isSelected ? Colors.white : Colors.grey),
        ),
      ),
    );
  }
}
