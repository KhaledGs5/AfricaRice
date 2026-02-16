import 'package:flutter/material.dart';

class DisclaimerDialog extends StatefulWidget {
  final VoidCallback onAccept;
  final bool canDismiss;

  const DisclaimerDialog({
    super.key,
    required this.onAccept,
    this.canDismiss = true,
  });

  @override
  State<DisclaimerDialog> createState() => _DisclaimerDialogState();
}

class _DisclaimerDialogState extends State<DisclaimerDialog> {
  bool _hasScrolledToBottom = false;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.offset >= _scrollController.position.maxScrollExtent - 10) {
      if (!_hasScrolledToBottom) {
        setState(() {
          _hasScrolledToBottom = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: widget.canDismiss,
      child: AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.warning_amber_rounded, color: Colors.orange),
            SizedBox(width: 8),
            Expanded(child: Text('Important Disclaimer')),
          ],
        ),
        content: SizedBox(
          width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: SingleChildScrollView(
                  controller: _scrollController,
                  child: const Text(
                    'AFRICA RICE QUALITY ASSESSMENT APP\n\n'
                    'DISCLAIMER AND LIMITATION OF LIABILITY\n\n'
                    'This application is intended for indicative, field-level quality assessment of rice grains only. '
                    'The results provided by this tool are based on image analysis using machine learning models and are meant to support rapid buy/reject or price-adjustment decisions.\n\n'
                    'IMPORTANT LIMITATIONS:\n\n'
                    '1. This tool does NOT replace professional laboratory analysis.\n\n'
                    '2. This tool does NOT provide food safety certification.\n\n'
                    '3. Results are indicative and may vary based on image quality, lighting conditions, background, and other environmental factors.\n\n'
                    '4. The application should be used as a supplementary decision-support tool only.\n\n'
                    '5. Users are responsible for ensuring appropriate calibration and validation of results in their specific use case.\n\n'
                    '6. Neither UNIDO nor AfricaRice shall be liable for any decisions made based on the results provided by this application.\n\n'
                    'INTELLECTUAL PROPERTY:\n\n'
                    'The intellectual property for this solution is co-owned by the United Nations Industrial Development Organization (UNIDO) and the Africa Rice Center (AfricaRice).\n\n'
                    'By using this application, you acknowledge that you have read, understood, and agree to this disclaimer.',
                    style: TextStyle(fontSize: 14, height: 1.5),
                  ),
                ),
              ),
              if (!_hasScrolledToBottom)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.arrow_downward, size: 16, color: Colors.grey[600]),
                      const SizedBox(width: 4),
                      Text(
                        'Please scroll to read the full disclaimer',
                        style: TextStyle(fontSize: 12, color: Colors.grey[600], fontStyle: FontStyle.italic),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        actions: [
          if (widget.canDismiss)
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancel'),
            ),
          ElevatedButton(
            onPressed: _hasScrolledToBottom
                ? () {
                    Navigator.of(context).pop(true);
                    widget.onAccept();
                  }
                : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
            ),
            child: const Text('I Accept'),
          ),
        ],
      ),
    );
  }
}

// Helper function to show the disclaimer
Future<bool> showDisclaimerDialog(BuildContext context, {bool canDismiss = true, VoidCallback? onAccept}) async {
  final result = await showDialog<bool>(
    context: context,
    barrierDismissible: canDismiss,
    builder: (context) => DisclaimerDialog(
      onAccept: onAccept ?? () {},
      canDismiss: canDismiss,
    ),
  );
  return result ?? false;
}
