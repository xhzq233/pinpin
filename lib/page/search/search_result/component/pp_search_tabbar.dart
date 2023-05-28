import 'package:flutter/material.dart';
import 'package:pinpin/app/theme/app_theme.dart';

class PPSearchTabBar extends StatelessWidget {
  final int selectIndex;
  final Function(int) switchTab;

  const PPSearchTabBar({
    Key? key,
    required this.selectIndex,
    required this.switchTab,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 204,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppTheme.gray95,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          _buildTabItem('默认排序', 0),
          _buildTabItem('未排序', 1),
        ],
      ),
    );
  }

  Widget _buildTabItem(String title, int index) {
    final isSelected = selectIndex == index;
    return GestureDetector(
      onTap: () => switchTab(index),
      child: Container(
        width: 98,
        height: 32,
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFFFFFFF) : AppTheme.gray95,
          borderRadius: BorderRadius.circular(16),
        ),
        alignment: Alignment.center,
        padding: const EdgeInsets.only(bottom: 2),
        child: Text(title,
            style: isSelected
                ? AppTheme.headline6.copyWith(color: AppTheme.gray30)
                : AppTheme.headline7.copyWith(color: AppTheme.gray50)),
      ),
    );
  }
}
