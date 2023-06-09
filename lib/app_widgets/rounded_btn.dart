import 'package:expense_proj/ui_helper.dart';
import 'package:flutter/material.dart';

class Rounded_Btn extends StatelessWidget {
  String title;
  double mWidth;
  double mHeight;
  VoidCallback onPress;
  Color? mColor;

  IconData? mIcon;
  bool isLoading;

  Rounded_Btn({
    required this.title,
    required this.onPress,
    this.mWidth = double.infinity,
    this.mHeight = 50,
    this.mColor,
    this.mIcon,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    var ThemeMode = Theme.of(context).brightness == Brightness.light;
    return SizedBox(
      height: mHeight,
      width: mWidth,
      child: ElevatedButton(
        onPressed: onPress,
        child: mIcon != null
            ? isLoading
                ? Row(
                    children: [
                      CircularProgressIndicator(),
                      Icon(mIcon),
                      mWidthSpacer(),
                      Text(
                        title,
                        style: mTextStyle16(
                            mColor: ThemeMode ? Colors.white : Colors.black,
                            mFWeight: FontWeight.bold),
                      )
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(mIcon),
                      mWidthSpacer(),
                      Text(
                        title,
                        style: mTextStyle16(
                            mColor: ThemeMode ? Colors.white : Colors.black,
                            mFWeight: FontWeight.bold),
                      )
                    ],
                  )
            : isLoading
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      mWidthSpacer(),
                      Text(
                        title,
                        style: mTextStyle16(
                            mColor: ThemeMode ? Colors.white : Colors.black,
                            mFWeight: FontWeight.bold),
                      )
                    ],
                  )
                : Text(
                    title,
                    style: mTextStyle16(
                        mColor: ThemeMode ? Colors.white : Colors.black,
                        mFWeight: FontWeight.bold),
                  ),
        style: ElevatedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          backgroundColor:
              mColor ?? (ThemeMode ? AppColor.AppDarkbgColor : Colors.white),
        ),
      ),
    );
  }
}
