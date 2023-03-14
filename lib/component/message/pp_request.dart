import 'package:flutter/material.dart';
import 'package:pinpin/app/theme/app_theme.dart';
import 'package:pinpin/component/stateful_button/hold_active_button.dart';
import 'package:util/clipper.dart';

class PPRequest extends StatelessWidget {
  const PPRequest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 300),
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 15),
          child: DecoratedBox(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 13.5, vertical: 16),
              child: Column(mainAxisSize: MainAxisSize.max, children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Text("申请加入ing...", style: AppTheme.headline4,),
                    Container(
                        width: 68,
                        height: 32,
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        child: HoldActiveButton(
                          builder: (_) => ClipPath(
                            clipper: const CapsuleClipper(),
                            child: DecoratedBox(
                              decoration: const BoxDecoration(color: Colors.blue),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                                child: Text("确认", style: AppTheme.headline6.copyWith(color: Colors.white),),
                              ),
                            ),
                          ),
                          onPressed: () => {}
                        )),

                  ],
                )
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
