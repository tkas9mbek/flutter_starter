import 'package:flutter/material.dart';
import 'package:starter_uikit/example/widgets/example_tile.dart';
import 'package:starter_uikit/widgets/app_bar/title_app_bar.dart';

/// **INTERNAL USE ONLY**: This screen is for UIKit testing and demonstration.
@visibleForTesting
class TestingUikitMenuScreen extends StatelessWidget {
  const TestingUikitMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TitleAppBar(
        title: 'UIKit Components',
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ExampleTile(
              title: '1. App Bars',
              subtitle: 'Title and base app bars',
              icon: Icons.web_asset,
              onTap: () {
                // TODO: Navigate to app bar screen
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('App Bar examples coming soon')),
                );
              },
            ),
            const SizedBox(height: 8),
            ExampleTile(
              title: '2. Buttons',
              subtitle: 'Elevated and outlined buttons with loading states',
              icon: Icons.smart_button,
              onTap: () {
                // TODO: Navigate to button screen
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Button examples coming soon')),
                );
              },
            ),
            const SizedBox(height: 8),
            ExampleTile(
              title: '3. Form Fields',
              subtitle: 'Text fields, dropdowns, date pickers',
              icon: Icons.edit_note,
              onTap: () {
                // TODO: Navigate to form screen
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Form examples coming soon')),
                );
              },
            ),
            const SizedBox(height: 8),
            ExampleTile(
              title: '4. Status Widgets',
              subtitle: 'Loading, empty, and failure states',
              icon: Icons.error_outline,
              onTap: () {
                // TODO: Navigate to status screen
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Status examples coming soon')),
                );
              },
            ),
            const Divider(height: 48),
            const Text(
              'About UIKit',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'This UIKit package contains reusable widgets and components:\n\n'
              '• Custom app bars and navigation\n'
              '• Styled buttons with loading states\n'
              '• Form fields with validation\n'
              '• Status widgets for different states\n'
              '• Notification snackbars\n'
              '• Theme system support\n\n'
              'Use these examples as a reference for building production features.',
            ),
          ],
        ),
      ),
    );
  }
}
