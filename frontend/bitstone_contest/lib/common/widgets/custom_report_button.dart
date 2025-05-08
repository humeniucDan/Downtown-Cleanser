import 'package:bitstone_contest/common/widgets/take_photo_button.dart';
import 'package:bitstone_contest/common/widgets/upload_from_files.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ReportButton extends StatefulWidget {
  const ReportButton({super.key});

  @override
  State<ReportButton> createState() => _ReportButtonState();
}

class _ReportButtonState extends State<ReportButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        AnimatedSwitcher(
          duration: 300.ms,
          switchInCurve: Curves.easeOut,
          switchOutCurve: Curves.easeIn,
          child:
              _isPressed
                  ? Padding(
                    key: const ValueKey("buttons"),
                    padding: const EdgeInsets.only(bottom: 60),
                    child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: TakePhotoButton(),
                            ),
                            UploadFromFiles(),
                          ],
                        )
                        .animate()
                        .fadeIn(duration: 300.ms)
                        .slideY(begin: 0.5, end: 0.0, duration: 300.ms),
                  )
                  : const SizedBox.shrink(key: ValueKey("empty")),
        ),
        SizedBox(
          width: double.infinity,
          height: 50,
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(6)),
                ),
              ),
              onPressed: () {
                setState(() => _isPressed = !_isPressed);
              },
              icon: Icon(
                _isPressed ? Icons.close : Icons.report_problem_outlined,
                color: Colors.white,
                size: 24,
              ),
              label:
                  _isPressed
                      ? const Text("")
                      : const Text(
                        'Report a problem',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
            ),
          ),
        ),
      ],
    );
  }
}
