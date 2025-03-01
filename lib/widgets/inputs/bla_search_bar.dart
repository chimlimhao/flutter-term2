import 'package:app/theme/theme.dart';
import 'package:flutter/material.dart';

class BlaSearchBar extends StatefulWidget {
  final String initQuery;
  final void Function(String query) onChanged;
  final void Function() onBackPressed;

  const BlaSearchBar({
    super.key,
    this.initQuery = '',
    required this.onChanged,
    required this.onBackPressed,
  });

  @override
  State<StatefulWidget> createState() => _BlaSearchBarState();
}

class _BlaSearchBarState extends State<BlaSearchBar> {
  final TextEditingController controller = TextEditingController();
  final FocusNode focusNode = FocusNode();

  @override
  void initState() {
    controller.text = widget.initQuery;
    super.initState();
  }

  void onChanged(String text) {
    setState(() {
      widget.onChanged(text);
    });
  }

  void onClear() {
    controller.clear();
    onChanged('');
    focusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: BlaColors.backgroundAccent,
        borderRadius: BorderRadius.circular(BlaSpacings.radius),
      ),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: BlaSpacings.s),
            child: IconButton(
              onPressed: widget.onBackPressed,
              icon: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: BlaColors.iconNormal,
              ),
            ),
          ),
          Expanded(
            child: TextField(
              controller: controller,
              focusNode: focusNode,
              onChanged: onChanged,
              style: TextStyle(color: BlaColors.textNormal),
              decoration: InputDecoration(
                hintText: 'Station Road or The Bridge Cafe',
                border: InputBorder.none,
                filled: false,
              ),
            ),
          ),
          if (controller.text.isNotEmpty)
            IconButton(
              onPressed: onClear,
              icon: Icon(Icons.close_rounded, color: BlaColors.iconNormal),
            ),
        ],
      ),
    );
  }
}
