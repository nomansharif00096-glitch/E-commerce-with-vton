import 'package:flutter/material.dart';
import 'package:frontend_side/core/common/widgets/loading_indicator.dart';

class LoadingDialog extends StatelessWidget {
  const LoadingDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        insetPadding: EdgeInsets.zero,
        child: Center(
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(8)),
            height: 120,
            width: MediaQuery.sizeOf(context).width * 0.3,
            child: const AppLoadingIndicator(
              size: 50,
            ),
          ),
        ),
      ),
    );
  }
}
