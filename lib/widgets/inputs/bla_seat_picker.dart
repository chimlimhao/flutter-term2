import 'package:flutter/material.dart';

import '../../theme/theme.dart';

class BlaSeatPicker extends StatefulWidget {
  final int initialSeats;
  final int maxSeats;

  const BlaSeatPicker({
    super.key,
    this.initialSeats = 1,
    this.maxSeats = 8,
  });

  @override
  State<BlaSeatPicker> createState() => _BlaSeatPickerState();
}

class _BlaSeatPickerState extends State<BlaSeatPicker> {
  late int selectedSeats;

  @override
  void initState() {
    super.initState();
    selectedSeats = widget.initialSeats;
  }

  void decrementSeats() {
    if (selectedSeats > 1) {
      setState(() {
        selectedSeats--;
      });
    }
  }

  void incrementSeats() {
    if (selectedSeats < widget.maxSeats) {
      setState(() {
        selectedSeats++;
      });
    }
  }

  void onBackPressed() {
    Navigator.of(context).pop();
  }

  void onConfirmPressed() {
    Navigator.of(context).pop(selectedSeats);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black),
          onPressed: onBackPressed,
        ),
        // title: Text(
        //   'Number of seats to book',
        //   style: TextStyle(
        //     color: BlaColors.neutralDark,
        //     fontSize: 18,
        //     fontWeight: FontWeight.bold,
        //   ),
        // ),
      ),
      body: Column(
        children: [
          Text("Number of seats to book",
              style: TextStyle(
                  fontSize: 32,
                  color: BlaColors.neutralDark,
                  fontWeight: FontWeight.bold)),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Minus button
                    GestureDetector(
                      onTap: decrementSeats,
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: selectedSeats > 1
                                ? BlaColors.primary
                                : BlaColors.greyLight,
                            width: 2,
                          ),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.remove,
                            color: selectedSeats > 1
                                ? BlaColors.primary
                                : BlaColors.greyLight,
                            size: 24,
                          ),
                        ),
                      ),
                    ),

                    // Number display
                    Container(
                      width: 175,
                      margin: const EdgeInsets.symmetric(horizontal: 40),
                      child: Text(
                        selectedSeats.toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: BlaColors.neutralDark,
                          fontSize: 60,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    // Plus button
                    GestureDetector(
                      onTap: incrementSeats,
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: selectedSeats < widget.maxSeats
                                ? BlaColors.primary
                                : BlaColors.greyLight,
                            width: 2,
                          ),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.add,
                            color: selectedSeats < widget.maxSeats
                                ? BlaColors.primary
                                : BlaColors.greyLight,
                            size: 24,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Confirm button
          Padding(
            padding: const EdgeInsets.all(32.0),
            child: Align(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(
                onPressed: onConfirmPressed,
                backgroundColor: BlaColors.primary,
                child: const Icon(Icons.arrow_forward),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
