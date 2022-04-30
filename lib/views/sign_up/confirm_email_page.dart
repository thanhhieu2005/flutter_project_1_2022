import 'package:flutter/material.dart';
import 'package:flutter_project_1/configs/color_config.dart';
import 'package:flutter_project_1/views/login/login_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../configs/text_config.dart';
import '../../widgets/rounded_linear_button.dart';

class ConfirmEmailPage extends StatefulWidget {
  const ConfirmEmailPage({Key? key}) : super(key: key);
  static const String nameRoute = '/confirmEmail';
  static Route route() {
    return MaterialPageRoute(
      builder: (_) => const ConfirmEmailPage(),
      settings: const RouteSettings(name: nameRoute),
    );
  }

  @override
  State<ConfirmEmailPage> createState() => _ConfirmEmailPageState();
}

class _ConfirmEmailPageState extends State<ConfirmEmailPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                child: Stack(
                  children: [
                    CustomPaint(
                      size: size / 3,
                      painter: ProfileCardPainter(color: Colors.black),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: (size.height / 2) / 2),
                      child: Center(
                        child: CircleAvatar(
                          maxRadius: 55.r,
                          minRadius: 55.r,
                          backgroundColor: AppColors.kBackgroundColor,
                          child: Icon(
                            Icons.mail,
                            size: 65.sp,
                            color: AppColors.kPrimaryColor.withOpacity(0.9),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        margin: EdgeInsets.only(top: 15.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 15.w, right: 15.w),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.kLightBlue2.withOpacity(0.25),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    spreadRadius: 3,
                                    blurRadius: 4,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: ClipOval(
                                child: Material(
                                  color: AppColors.kLightBlue2
                                      .withOpacity(0.1), // Button color
                                  child: InkWell(
                                    splashColor: Colors.grey, // Splash color
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: SizedBox(
                                      width: 42.w,
                                      height: 42.h,
                                      child: SvgPicture.asset(
                                        "assets/icons/ic_back.svg",
                                        fit: BoxFit.scaleDown,
                                        color: AppColors.kBackgroundColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Center(
                              child: Text(
                                AppLocalizations.of(context).backToSignUp,
                                style: TextConfigs.kText16_1,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      right: -35.w,
                      top: 100.h,
                      child: SvgPicture.asset(
                        "assets/icons/img_send_background.svg",
                        color: AppColors.kLightBlue3.withOpacity(0.25),
                        width: 150.w,
                        height: 150.h,
                      ),
                    ),
                    Positioned.fill(
                      child: Container(
                        margin: EdgeInsets.only(top: size.height * 0.12),
                        child: Column(
                          children: [
                            Text(
                              "One Last Step",
                              style: TextConfigs.kText22WhiteBold
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Text(
                              "Let's Verify Your Email",
                              style: TextConfigs.kText22White,
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Column(
                children: [
                  Container(
                    margin:
                        EdgeInsets.symmetric(vertical: 25.h, horizontal: 20.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _textFieldOTP(first: true, context: context),
                        _textFieldOTP(context: context),
                        _textFieldOTP(context: context),
                        _textFieldOTP(context: context),
                        _textFieldOTP(context: context),
                        _textFieldOTP(context: context, last: true),
                      ],
                    ),
                  ),
                  Text(
                    AppLocalizations.of(context).pleaseEnter6DigitCode,
                    style: TextConfigs.kText14Black,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 50.h,
                  ),
                  RoundedLinearButton(
                    press: () {},
                    isAllCap: false,
                    text: "Verify",
                    textColor: Colors.white,
                    startColor: AppColors.kPrimaryColor,
                    endColor: AppColors.kPrimaryColor,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileCardPainter extends CustomPainter {
  //2
  ProfileCardPainter({required this.color});

  //3
  final Color color;

  //4
  @override
  void paint(Canvas canvas, Size size) {
    final shapeBounds = Rect.fromLTWH(0, 0, size.width * 3, size.height - 10.h);
    final paint = Paint()..color = AppColors.kDarkBlue1.withOpacity(0.9);

    final curvedShapeBounds = Rect.fromLTRB(
      shapeBounds.left,
      shapeBounds.top + shapeBounds.height * 0.6,
      shapeBounds.right,
      shapeBounds.bottom,
    );
    canvas.drawRect(shapeBounds, paint);
    _drawCurvedShape(canvas, curvedShapeBounds);
  }

  //5
  @override
  bool shouldRepaint(ProfileCardPainter oldDelegate) {
    return color != oldDelegate.color;
  }

  void _drawCurvedShape(Canvas canvas, Rect bounds) {
    //2
    final handlePoint = Offset(bounds.left + (bounds.width * 0.27), bounds.top);

    final paint = Paint()..color = AppColors.kLightBlue3.withOpacity(0.25);

    //3
    final curvePath = Path()
      ..moveTo(bounds.bottomRight.dx, bounds.bottomRight.dy) //4
      //..arcTo(avatarBounds, -3.14, 3.14, false) //5
      ..lineTo(bounds.bottomLeft.dx, bounds.bottomLeft.dy) //6
      ..lineTo(bounds.topLeft.dx, bounds.topLeft.dy) //7
      ..quadraticBezierTo(handlePoint.dx, handlePoint.dy,
          bounds.bottomRight.dx * 0.35, bounds.bottomRight.dy) //8
      ..close(); //9

    //10
    canvas.drawPath(curvePath, paint);
  }
}

Widget _textFieldOTP(
    {bool first = false, bool last = false, required BuildContext context}) {
  return SizedBox(
    height: 80.h,
    child: AspectRatio(
      aspectRatio: 0.7,
      child: Center(
        child: TextField(
          autofocus: true,
          onChanged: (value) {
            if (value.length == 1 && last == false) {
              FocusScope.of(context).nextFocus();
            }
            if (value.isEmpty && first == false) {
              FocusScope.of(context).previousFocus();
            }
          },
          showCursor: false,
          readOnly: false,
          textAlign: TextAlign.center,
          style: TextConfigs.kText16Black
              .copyWith(fontWeight: FontWeight.bold, fontSize: 24.sp),
          keyboardType: TextInputType.number,
          maxLength: 1,
          decoration: InputDecoration(
            counter: const Offstage(),
            enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(width: 2, color: Colors.black12),
                borderRadius: BorderRadius.circular(12)),
            focusedBorder: OutlineInputBorder(
                borderSide:
                    const BorderSide(width: 2, color: AppColors.kPrimaryColor),
                borderRadius: BorderRadius.circular(12)),
          ),
        ),
      ),
    ),
  );
}
