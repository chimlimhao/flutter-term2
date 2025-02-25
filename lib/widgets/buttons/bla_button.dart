import 'package:flutter/material.dart';
import '../../theme/button_type.dart';
import '../../theme/theme.dart';

class BlaButton extends StatelessWidget {
  final String label;
  final IconData? icon;
  final BlaButtonType type;
  final VoidCallback? onPressed;
  final bool isEnabled;

  const BlaButton({
    super.key,
    required this.label,
    this.icon,
    this.type = BlaButtonType.primary,
    this.onPressed,
    this.isEnabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 48,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(BlaSpacings.radius),
        color: _getBackgroundColor(),
        border: type == BlaButtonType.secondary
            ? Border.all(color: BlaColors.primary)
            : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isEnabled ? onPressed : null,
          borderRadius: BorderRadius.circular(BlaSpacings.radius),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (icon != null) ...[
                  Icon(
                    icon,
                    color: _getTextColor(),
                    size: 20,
                  ),
                  const SizedBox(width: BlaSpacings.s),
                ],
                Text(
                  label,
                  style: BlaTextStyles.button.copyWith(
                    color: _getTextColor(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color _getBackgroundColor() {
    if (!isEnabled) return BlaColors.disabled;
    return type == BlaButtonType.primary
        ? BlaColors.primary
        : Colors.transparent;
  }

  Color _getTextColor() {
    if (!isEnabled) return BlaColors.textLight;
    return type == BlaButtonType.primary ? Colors.white : BlaColors.primary;
  }
}
