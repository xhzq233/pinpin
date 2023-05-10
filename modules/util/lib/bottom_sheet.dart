import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

/// Template code for the bottom sheet
/// The bottom sheet for the modal style pinpin
/// 写自己的widget即可
Future<dynamic> showPinPinBottomSheet(
    {required BuildContext context,
    required WidgetBuilder builder,
    bool? enableDrag,
    }) async {
  return await showCustomModalBottomSheet<dynamic>(
      context: context,
      expand: false,
      enableDrag: enableDrag ?? true,
      animationCurve: Curves.easeInOut,
      backgroundColor: const Color.fromRGBO(0x0A, 0x11, 0x1A, 0.7),
      builder: builder,
      containerWidget: (context, animation, child) => Material(
            color: Colors.white,
            clipBehavior: Clip.antiAlias,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
            child: Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: child,
            ),
          ));
}

class ModalInsideModal extends StatelessWidget {
  const ModalInsideModal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SizedBox(
      height: 460,
      child: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 12),
            Flexible(
              flex: 1,
              fit: FlexFit.loose,
              child: Material(
                child: SafeArea(
                  bottom: false,
                  child: ListView(
                      reverse: false,
                      shrinkWrap: true,
                      controller: ModalScrollController.of(context),
                      physics: const ClampingScrollPhysics(),
                      children: List.generate(
                        100,
                        (index) => ListTile(
                            title: Text("Modal $index"),
                            onTap: () => showPinPinBottomSheet(
                                  context: context,
                                  builder: (context) =>
                                      const ModalInsideModal(),
                                )),
                      ).toList()),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}

Future<dynamic> showCommentPageBottomSheet({
  required BuildContext context,
  required WidgetBuilder builder,
}) async {
  return await showCustomModalBottomSheet<dynamic>(
    context: context,
    expand: false,
    animationCurve: Curves.easeInOut,
    backgroundColor: const Color.fromRGBO(0x0A, 0x11, 0x1A, 0.7),
    builder: builder,
    containerWidget: (context, animation, child) => Material(
      color: Colors.white,
      clipBehavior: Clip.antiAlias,
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(24),
        topRight: Radius.circular(24),
      ),
      child: Container(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: child,
      ),
    ),
  );
}
