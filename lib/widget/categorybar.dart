import 'package:flutter/material.dart';

class CategoryBarItem extends StatelessWidget {
  final String title;
  final void Function()? onTap;
  final int currentIndex;
  final int index;

  const CategoryBarItem({
    super.key,
    required this.title,
    required this.onTap,
    required this.currentIndex,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.zero,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: currentIndex == index ? Colors.blue : Colors.white,
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(50),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: currentIndex == index ? Colors.white : Colors.black
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}