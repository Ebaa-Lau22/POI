import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class BlogDetailPage extends StatefulWidget {
  const BlogDetailPage({Key? key}) : super(key: key);

  @override
  State<BlogDetailPage> createState() => _BlogDetailPageState();
}

class _BlogDetailPageState extends State<BlogDetailPage> {
  double baseFontSize = 18;
  double currentScale = 1.0;
  double previousScale = 1.0;

  double get fontSize => (baseFontSize * currentScale).clamp(16, 30);

  void _onScaleStart(ScaleStartDetails details) {
    previousScale = currentScale;
  }

  void _onScaleUpdate(ScaleUpdateDetails details) {
    setState(() {
      currentScale = (previousScale * details.scale).clamp(0.7, 2.0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Article Details', style: TextStyle(fontSize: 14.sp)),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
        child: GestureDetector(
          onScaleStart: _onScaleStart,
          onScaleUpdate: _onScaleUpdate,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Flutter Released',
                style: TextStyle(
                  fontSize: fontSize.sp + 8,
                  fontWeight: FontWeight.w900,
                  color: Colors.deepPurple.shade700,
                ),
              ),
              SizedBox(height: 2.h),
              Row(
                children: [
                  Icon(
                    Icons.person,
                    color: Colors.deepPurple.shade300,
                    size: 13.sp,
                  ),
                  SizedBox(width: 2.w),
                  Text(
                    'Publisher: Tech News',
                    style: TextStyle(
                      fontSize: (fontSize.sp - 5).clamp(10, double.infinity),
                      fontWeight: FontWeight.w600,
                      color: Colors.deepPurple.shade700,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 2.h),
              Divider(color: Colors.deepPurple.shade200, thickness: 1.5),
              SizedBox(height: 1.h),
              Text(
                'Flutter 3.0 brings lots of new features and improvements that make app development faster and easier. '
                'In this update, you will find enhanced performance, better tooling, and new widgets to explore. '
                'The community support continues to grow, making Flutter a top choice for cross-platform development.\nThe community support continues to grow, making Flutter a top choice for cross-platform developmentThe community support continues to grow, making Flutter a top choice for cross-platform development',
                style: TextStyle(
                  fontSize: fontSize.sp,
                  height: 1.6,
                  color: Colors.grey.shade900,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
