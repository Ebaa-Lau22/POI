import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:poi/core/components/buttons.dart';
import 'package:poi/core/constants/constants.dart';
import 'package:poi/core/localization/l10n/context_localiztion.dart';
import 'package:poi/core/theme/app_colors.dart';
import 'package:sizer/sizer.dart';

class FilterDialog extends StatelessWidget {
  final ThemedColors themedColor;
  final String title;
  final List<String> allTopics;
  final List<String> selectedTopics;
  final void Function(String topic) toggleTopicFunction;
  final void Function() appFilterFunction;
  const FilterDialog({
    super.key,
    required this.themedColor,
    required this.title,
    required this.allTopics,
    required this.selectedTopics,
    required this.toggleTopicFunction,
    required this.appFilterFunction,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(widgetBorderRadius)),
      child: SizedBox(
        width: 50.w,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              height: 40.h,
              width: double.infinity,
              decoration: BoxDecoration(borderRadius: BorderRadiusDirectional.circular(widgetBorderRadius), color: themedColor.red),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 40),
                child: Column(children: [Text(title, style: TextStyle(color: AppColors.white, fontSize: 18, fontWeight: FontWeight.bold))]),
              ),
            ),
            Container(
              height: 40.h - 40,
              width: double.infinity,
              decoration: BoxDecoration(borderRadius: BorderRadiusDirectional.circular(widgetBorderRadius), color: themedColor.primary),
              child: Padding(
                padding: EdgeInsets.only(top: 2.h, bottom: 2.h, left: 2.8.w, right: 2.8.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: Wrap(
                        alignment: WrapAlignment.center,
                        runAlignment: WrapAlignment.center,
                        spacing: 1.4.w,
                        runSpacing: 1.h,
                        children:
                            allTopics.map((topic) {
                              final isSelected = selectedTopics.contains(topic);
                              return GestureDetector(
                                onTap: () => toggleTopicFunction(topic),
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                                  decoration: BoxDecoration(
                                    color: isSelected ? themedColor.red.withValues(alpha: 0.4) : themedColor.blue.withValues(alpha: 0.4),
                                    borderRadius: BorderRadius.circular(widgetBorderRadius),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      if (!isSelected) Icon(Icons.add, size: 14, color: themedColor.blue, weight: 50),
                                      if (!isSelected) SizedBox(width: 1.w),
                                      Text(topic, style: TextStyle(fontSize: 10, fontWeight: FontWeight.w400, color: themedColor.secondary)),
                                      if (isSelected) SizedBox(width: 1.w),
                                      if (isSelected) Icon(Icons.close, size: 14, color: themedColor.red, weight: 50),
                                    ],
                                  ),
                                ),
                              );
                            }).toList(),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: ClipRRect(
                        borderRadius: const BorderRadiusDirectional.all(Radius.circular(widgetBorderRadius)),
                        child: myButton(
                          onPressed: () {
                            appFilterFunction();
                            Navigator.pop(context);
                          },
                          text: context.loc.apply,
                          textColor: AppColors.white,
                          borderRadius: widgetBorderRadius,
                          backgroundColor: themedColor.red,
                          hasBorder: false,
                          width: double.infinity,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

    );
  }
}
