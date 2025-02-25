import 'package:flutter/material.dart';
import '../../theme/button_type.dart';
import '../../widgets/buttons/bla_button.dart';

class ButtonTestScreen extends StatelessWidget {
  const ButtonTestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Button Test')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            BlaButton(
              label: 'Primary Button',
              type: BlaButtonType.primary,
              onPressed: () => print('Primary pressed'),
            ),
            const SizedBox(height: 16),
            BlaButton(
              label: 'Secondary Button',
              type: BlaButtonType.secondary,
              onPressed: () => print('Secondary pressed'),
            ),
            const SizedBox(height: 16),
            BlaButton(
              label: 'Primary with Icon',
              icon: Icons.star,
              type: BlaButtonType.primary,
              onPressed: () => print('Primary with icon pressed'),
            ),
            const SizedBox(height: 16),
            BlaButton(
              label: 'Secondary with Icon',
              icon: Icons.favorite,
              type: BlaButtonType.secondary,
              onPressed: () => print('Secondary with icon pressed'),
            ),
            const SizedBox(height: 16),
            const BlaButton(
              label: 'Disabled Button',
              isEnabled: false,
            ),
          ],
        ),
      ),
    );
  }
}
