import 'package:flutter/material.dart';
import 'package:poi/core/components/default_text_button.dart';
import 'package:poi/core/constants/constants.dart';
import 'package:poi/core/localization/l10n/context_localiztion.dart';
import 'package:poi/core/theme/app_colors.dart';
import 'package:sizer/sizer.dart';

class NewMotionDialog extends StatelessWidget {
  final ThemedColors themedColor;
  final String title;
  final TextEditingController titleController;
  final List<String> allTopics;
  final List<String> selectedTopics;
  final void Function(String topic) toggleTopicFunction;
  const NewMotionDialog({
    super.key,
    required this.themedColor,
    required this.title,
    required this.titleController,
    required this.allTopics,
    required this.selectedTopics,
    required this.toggleTopicFunction,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(widgetBorderRadius)),
      child: SizedBox(
        width: 65.w,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              height: 50.h,
              width: double.infinity,
              decoration: BoxDecoration(borderRadius: BorderRadiusDirectional.circular(widgetBorderRadius), color: themedColor.blue),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 40),
                child: Column(children: [Text(title, style: TextStyle(color: AppColors.white, fontSize: 18, fontWeight: FontWeight.bold))]),
              ),
            ),
            Container(
              height: 50.h - 40,
              width: double.infinity,
              decoration: BoxDecoration(borderRadius: BorderRadiusDirectional.circular(widgetBorderRadius), color: themedColor.primary),
              child: Padding(
                padding: EdgeInsets.only(top: 2.h, bottom: 2.h, left: 2.8.w, right: 2.8.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // Motion title
                    defaultTextFormField(
                      context,
                      controller: titleController,
                      hintText: context.loc.motion,
                      textColor: themedColor.secondary,
                      keyboardType: TextInputType.text,
                      mainColor: themedColor.secondary,
                      maxLength: 200,
                      maxLines: 10,
                      radiusBorder: widgetBorderRadius
                    ),
                    SizedBox(height: 3.h),
                    // Topics selection
                    Text(
                        "${context.loc.select_topics}:",
                        style: TextStyle(
                            color: themedColor.secondary,
                            fontSize: 12,
                            fontWeight: FontWeight.w400
                        ),
                      textAlign: TextAlign.start,
                      maxLines: 2,
                    ),
                    SizedBox(height: 1.5.h),
                    Row(
                      children: [
                        SizedBox(width: 5.w,),
                        Expanded(child: Container(height: 0.5, color: themedColor.secondary.withValues(alpha: 0.7),)),
                      ],
                    ),
                    Expanded(
                      child: ListView.separated(
                        shrinkWrap: false,
                        itemBuilder: (context, index){
                          final topic = allTopics[index];
                          final isSelected = selectedTopics.contains(topic);
                          return CheckboxListTile(
                            activeColor: themedColor.red,
                            title: Text(topic, style: TextStyle(color: themedColor.secondary)),
                            value: isSelected,
                            onChanged: (val) {
                              if (val == true) {
                                toggleTopicFunction(topic);
                              } else {
                                toggleTopicFunction(topic);
                              }
                            },
                          );
                        },
                        separatorBuilder: (context, state) => Row(
                          children: [
                            SizedBox(width: 5.w,),
                            Expanded(child: Container(height: 0.5, color: themedColor.secondary.withValues(alpha: 0.7),)),
                          ],
                        ),
                        itemCount: allTopics.length,
                      ),
                    ),
                    SizedBox(height: 1.5.h),
                    Row(
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(widgetBorderRadius),
                            child: ElevatedButton(
                              onPressed: () {
                               //TODO
                              },
                              style: ElevatedButton.styleFrom(backgroundColor: themedColor.blue),
                              child: Text(context.loc.submit, style: TextStyle(color: AppColors.lighterColor, fontWeight: FontWeight.bold)),
                            ),
                          ),
                        ),
                      ],
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
