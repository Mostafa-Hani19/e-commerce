import 'package:ecommerce/core/constants/app_strings.dart';
import 'package:ecommerce/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class ColorSizeSelector extends StatefulWidget {
  final Function(String color)? onColorChanged;
  final Function(String size)? onSizeChanged;

  const ColorSizeSelector({super.key, this.onColorChanged, this.onSizeChanged});

  @override
  State<ColorSizeSelector> createState() => _ColorSizeSelectorState();
}

class _ColorSizeSelectorState extends State<ColorSizeSelector> {
  int _selectedColorIndex = 0;
  int _selectedSizeIndex = 1;

  final List<String> _colorNames = ['Black', 'Grey', 'Blue'];
  final List<Color> _colors = [
    const Color(0xff1A1A1A), // Dark
    const Color(0xff455A64), // Grey Blue
    const Color(0xff90CAF9), // Light Blue
  ];

  final List<String> _sizes = ['S', 'M', 'L', 'XL'];

  @override
  void initState() {
    super.initState();
    // Notify initial values
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onColorChanged?.call(_colorNames[_selectedColorIndex]);
      widget.onSizeChanged?.call(_sizes[_selectedSizeIndex]);
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Colors
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppStrings.color,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).textTheme.titleMedium?.color,
                ),
              ),
              const SizedBox(height: 12),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(
                    _colors.length,
                    (index) => GestureDetector(
                      onTap: () {
                        setState(() => _selectedColorIndex = index);
                        widget.onColorChanged?.call(_colorNames[index]);
                      },
                      child: Container(
                        margin: const EdgeInsets.only(right: 12),
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: _selectedColorIndex == index
                              ? Border.all(color: _colors[index], width: 2)
                              : null,
                        ),
                        child: Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _colors[index],
                          ),
                          child: _selectedColorIndex == index
                              ? const Icon(
                                  Icons.check,
                                  color: AppTheme.whiteColor,
                                  size: 16,
                                )
                              : null,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        // Sizes
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppStrings.size,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).textTheme.titleMedium?.color,
                ),
              ),
              const SizedBox(height: 12),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(
                    _sizes.length,
                    (index) => GestureDetector(
                      onTap: () {
                        setState(() => _selectedSizeIndex = index);
                        widget.onSizeChanged?.call(_sizes[index]);
                      },
                      child: Container(
                        margin: const EdgeInsets.only(right: 12),
                        width: 35,
                        height: 35,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _selectedSizeIndex == index
                              ? (isDark ? Colors.white24 : Colors.grey[200])
                              : Colors.transparent,
                        ),
                        child: Center(
                          child: Text(
                            _sizes[index],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: _selectedSizeIndex == index
                                  ? (isDark
                                        ? AppTheme.whiteColor
                                        : AppTheme.blackColor)
                                  : (isDark
                                        ? Colors.grey[400]
                                        : Colors.grey[400]),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
