import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:poi/core/constants/appImgaeAsset.dart';

class NoDataImageContainer extends StatelessWidget {
  final double width;
  final double height;
  final double borderRadius;

  const NoDataImageContainer({
    super.key,
    this.width = 100,
    this.height = 100,
    this.borderRadius = 12,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 3)),
        ],
      ),
      child: SvgPicture.asset(AppImageAsset.NoDataImage, fit: BoxFit.contain),
    );
  }
}
