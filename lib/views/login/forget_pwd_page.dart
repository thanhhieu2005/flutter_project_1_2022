import 'package:email_auth/email_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project_1/configs/color_config.dart';
import 'package:flutter_project_1/constants/global_constants.dart';
import 'package:flutter_project_1/services/auth_service.dart';
import 'package:flutter_project_1/view_models/login/login_provider.dart';
import 'package:flutter_project_1/view_models/login/sign_up_provider.dart';
import 'package:flutter_project_1/views/login/login_page.dart';
import 'package:flutter_project_1/views/navigation_bar_view/navigation_bar_view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import '../../configs/auth_config.dart';
import '../../configs/text_config.dart';
import '../../widgets/dialog/custom_dialog.dart';
import '../../widgets/button/rounded_linear_button.dart';
import '../../widgets/text_field/rounded_input_field.dart';
import '../../widgets/text_field/rounded_password_field.dart';

class ForgetPwdPage extends StatefulWidget {
  const ForgetPwdPage({Key? key}) : super(key: key);
  static const String nameRoute = '/forgetPwd';
  static Route route() {
    return MaterialPageRoute(
      builder: (_) => const ForgetPwdPage(),
      settings: const RouteSettings(name: nameRoute),
    );
  }

  @override
  State<ForgetPwdPage> createState() => _ForgetPwdPageState();
}

class _ForgetPwdPageState extends State<ForgetPwdPage> {
  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(context);
    Size size = MediaQuery.of(context).size;
    return ModalProgressHUD(
      progressIndicator: SpinKitThreeBounce(
        color: AppColors.kPrimaryColor,
        size: 32.h,
      ),
      inAsyncCall: loginProvider.isLoading,
      child: Scaffold(
        body: SingleChildScrollView(
          child: SafeArea(
            child: Column(
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
                        Navigator.pushNamedAndRemoveUntil(
                            context, LoginPage.nameRoute, (route) => false);
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
                                AppLocalizations.of(context).backToSignIn,
                                style: TextConfigs.kText16White,
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
                    Positioned.fill(child: Consumer<LoginProvider>(
                      builder: (context, provider, child) {
                        return Container(
                          margin: EdgeInsets.only(top: size.height * 0.12),
                          child: provider.isEnterEmail
                              ? Column(
                                  children: [
                                    Text(
                                      "One More Step",
                                      style: TextConfigs.kText22WhiteBold
                                          .copyWith(
                                              fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    Text(
                                      "Let's Verify Your Email",
                                      style: TextConfigs.kText22White,
                                    )
                                  ],
                                )
                              : Column(
                                  children: [
                                    Text(
                                      "First Step",
                                      style: TextConfigs.kText22WhiteBold
                                          .copyWith(
                                              fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    Text(
                                      "Please Enter Your Email",
                                      style: TextConfigs.kText22White,
                                    )
                                  ],
                                ),
                        );
                      },
                    ))
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: Container(
                          margin: EdgeInsets.symmetric(vertical: 25.h),
                          child: Consumer<LoginProvider>(
                            builder: (context, provider, child) {
                              return !provider.isChangePwd
                                  ? provider.isEnterEmail
                                      ? Pinput(
                                          controller: loginProvider
                                              .forgetPwdPinController,
                                          defaultPinTheme: defaultPinTheme,
                                          focusedPinTheme: focusPinTheme,
                                          showCursor: false,
                                          length: 6,
                                          onCompleted: (value) {},
                                        )
                                      : Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 30.w),
                                          child: RoundedInputField(
                                            hasHint: true,
                                            fillColor:
                                                AppColors.kLightBlueBackGround,
                                            controller: loginProvider
                                                .forgetEmailController,
                                            inputName:
                                                AppLocalizations.of(context)
                                                    .email,
                                            icon: Icons.person,
                                          ),
                                        )
                                  : Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 30.w),
                                      child: RoundedPasswordField(
                                        controller: provider.newPwdController,
                                        isConfirmPwd: true,
                                        pwdToConfirm:
                                            provider.newPwdController.text,
                                      ),
                                    );
                            },
                          )),
                    ),
                    Consumer<LoginProvider>(
                      builder: (context, provider, child) {
                        return provider.isChangePwd
                            ? Text(
                                AppLocalizations.of(context).pleaseEnterPwd,
                                style: TextConfigs.kText14Black,
                                textAlign: TextAlign.center,
                              )
                            : provider.isEnterEmail
                                ? Text(
                                    AppLocalizations.of(context)
                                        .pleaseEnter6DigitCode,
                                    style: TextConfigs.kText14Black,
                                    textAlign: TextAlign.center,
                                  )
                                : Text(
                                    AppLocalizations.of(context)
                                        .pleaseEnterEmail,
                                    style: TextConfigs.kText14Black,
                                    textAlign: TextAlign.center,
                                  );
                      },
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
                      child: Consumer<LoginProvider>(
                        builder: (context, provider, child) {
                          return RoundedLinearButton(
                            press: () async {
                              if (!provider.isEnterEmail &&
                                  !provider.isChangePwd) {
                                provider.sendOtp(
                                    provider.forgetEmailController.text);
                              } else if (!provider.isChangePwd) {
                                bool result = await provider.verifyOtp(
                                    provider.forgetEmailController.text,
                                    provider.forgetPwdPinController.text);
                                if (result) {
                                  provider.isChangePwd = true;
                                }
                              } else if (provider.isChangePwd) {
                                await provider.changePwd(
                                    provider.newPwdController.text,
                                    provider.forgetEmailController.text);
                              }
                            },
                            isAllCap: false,
                            text: provider.isChangePwd
                                ? AppLocalizations.of(context).changePwd
                                : provider.isEnterEmail
                                    ? AppLocalizations.of(context).verify
                                    : AppLocalizations.of(context).sendEmail,
                            textColor: Colors.white,
                            startColor: AppColors.kPrimaryColor,
                            endColor: AppColors.kPrimaryColor,
                          );
                        },
                      )),
                ),
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
