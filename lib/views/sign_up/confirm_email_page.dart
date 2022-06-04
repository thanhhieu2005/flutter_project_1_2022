import 'package:flutter/material.dart';
import 'package:flutter_project_1/configs/color_config.dart';
import 'package:flutter_project_1/constants/global_constants.dart';
import 'package:flutter_project_1/services/auth_service.dart';
import 'package:flutter_project_1/view_models/login/sign_up_provider.dart';
import 'package:flutter_project_1/views/navigation_bar_view/navigation_bar_view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import '../../configs/text_config.dart';
import '../../widgets/custom_dialog.dart';
import '../../widgets/rounded_linear_button.dart';

class ConfirmEmailPage extends StatefulWidget {
  const ConfirmEmailPage({Key? key, this.isCreateAccount = false})
      : super(key: key);
  static const String nameRoute = '/confirmEmail';
  final bool isCreateAccount;
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
    final signUpProvider = Provider.of<SignUpProvider>(context);
    final isCreateAccount = ModalRoute.of(context)!.settings.arguments as bool;
    Size size = MediaQuery.of(context).size;
    return ModalProgressHUD(
      inAsyncCall: signUpProvider.isLoading,
      child: Scaffold(
        body: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Stack(
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
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 25.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Pinput(
                              controller: signUpProvider.pinCodeController,
                              defaultPinTheme: defaultPinTheme,
                              focusedPinTheme: focusPinTheme,
                              showCursor: false,
                              length: 6,
                              onCompleted: (value) {},
                            )
                          ],
                        ),
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
                  ],
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 15.w),
                      child: Consumer<AuthService>(
                        builder: (context, provider, child) {
                          return RoundedLinearButton(
                            press: () async {
                              var isVerified = await provider.verifyOtp(
                                  localCurrentUser.email,
                                  signUpProvider.pinCodeController.text);
                              if (isVerified) {
                                if (isCreateAccount) {
                                  signUpProvider.createAccountWithEmail();
                                }
                                await signUpProvider.updateVerifyEmailStatus(
                                    localCurrentUser.uid);
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    NavigationBarView.route(),
                                    (route) => false);
                                signUpProvider.clearPinCodeController();
                              } else {
                                signUpProvider.isLoading = false;
                                showDialog(
                                  context: context,
                                  builder: (context) => const CustomDialog(
                                    title: "Invalid Code",
                                    description: "Please try again!",
                                    image: 'cancel.png',
                                    hasDescription: true,
                                  ),
                                );
                              }
                            },
                            isAllCap: false,
                            text: "Verify",
                            textColor: Colors.white,
                            startColor: AppColors.kPrimaryColor,
                            endColor: AppColors.kPrimaryColor,
                          );
                        },
                      )),
                )
              ],
            ),
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

final defaultPinTheme = PinTheme(
  width: 50.w,
  height: 50.h,
  textStyle: const TextStyle(
      fontSize: 20, color: AppColors.kDarkBlue1, fontWeight: FontWeight.w600),
  decoration: BoxDecoration(
    color: AppColors.kBackgroundColor,
    border: Border.all(color: Colors.grey),
    borderRadius: BorderRadius.circular(10),
  ),
);

final focusPinTheme = PinTheme(
  width: 50.w,
  height: 50.h,
  textStyle: const TextStyle(
      fontSize: 20, color: AppColors.kDarkBlue1, fontWeight: FontWeight.w600),
  decoration: BoxDecoration(
    color: AppColors.kBackgroundColor,
    border: Border.all(color: AppColors.kDarkBlue1),
    borderRadius: BorderRadius.circular(10),
  ),
);
