import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_project_1/configs/color_config.dart';
import 'package:flutter_project_1/configs/date_cofig.dart';
import 'package:flutter_project_1/models/others/argument_model.dart';
import 'package:flutter_project_1/models/posts/destination_post.dart';
import 'package:flutter_project_1/view_models/post/post_moderation_provider.dart';
import 'package:flutter_project_1/views/account/sub_screens/moderation/post_destination_moderation.dart';
import 'package:flutter_project_1/views/account/widgets/item_post_moderation_widget.dart';
import 'package:flutter_project_1/views/account/widgets/light_blue_button.dart';
import 'package:flutter_project_1/views/home/sub_screens/widgets/post_images_widget.dart';
import 'package:flutter_project_1/widgets/button/custom_back_button.dart';
import 'package:flutter_project_1/widgets/des_post_moderation_widget.dart';
import 'package:flutter_project_1/widgets/dialog/open_dialog.dart';
import 'package:flutter_project_1/widgets/info_des_post_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PostModerationDetailScreen extends StatelessWidget {
  static const String nameRoute = '/post_moderation_detail_screen';
  static Route route(RouteSettings settings) {
    PostModerationArgument args = settings.arguments as PostModerationArgument;
    return MaterialPageRoute(
      settings: settings,
      builder: (_) => ChangeNotifierProvider<PostModerationProvider>.value(
        value: args.provider,
        child: const PostModerationDetailScreen(),
      ),
    );
  }

  const PostModerationDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PostModerationArgument postModerationArgument =
        ModalRoute.of(context)!.settings.arguments as PostModerationArgument;
    final postModeration = postModerationArgument.post;
    final infoPoster = postModerationArgument.sharer;
    return Scaffold(
      body: SizedBox(
        height: 1.sh,
        width: 1.sw,
        child: Stack(
          children: [
            Positioned(
              child: Container(
                width: double.maxFinite,
                height: 300.h,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(postModeration.images.first),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            Positioned(
              child: Padding(
                padding: EdgeInsets.only(
                  top: 72.h,
                  left: 8.w,
                  right: 8.w,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomBackButton(
                      onTapBack: () {
                        Navigator.pop(context);
                      },
                      backgroundColor: AppColors.kColor1.withOpacity(0.55),
                      iconColor: AppColors.kColor1,
                      isCircleRounded: true,
                      height: 40.w,
                      width: 40.w,
                    )
                  ],
                ),
              ),
            ),
            Positioned.fill(
              top: 250.h,
              child: Container(
                width: 1.sw,
                decoration: const BoxDecoration(
                  color: AppColors.kBackgroundColor,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Padding(
                    padding: EdgeInsets.only(top: 8.h, bottom: 20.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        InfoDestinationWidget(
                          post: postModeration,
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        ItemPostModerationWidget(
                          content: DateConfig.fortmattedDateTime(
                              postModeration.dateTime),
                          hasAvatar: false,
                          title: AppLocalizations.of(context).timeSend,
                          icon: "assets/icons/ic_personal.svg",
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        ItemPostModerationWidget(
                          content: infoPoster.userName!,
                          hasAvatar: true,
                          avatar: infoPoster.avatarUrl,
                          title: AppLocalizations.of(context).sharer,
                          icon: "assets/icons/ic_personal.svg",
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        DesPostModerationWidget(
                          content: postModeration.description
                              .replaceAll("   ", '\n'),
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        PostImagesWidget(urlImages: postModeration.images),
                        SizedBox(
                          height: 20.h,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Consumer<PostModerationProvider>(builder:
                                  (context, postModerationProvider, child) {
                                return LightBlueButton(
                                  text: AppLocalizations.of(context).decline,
                                  textColor: AppColors.kColor3,
                                  onTap: () {
                                    OpenDialog().confirmDialog(
                                      context: context,
                                      assetsNamePng:
                                          "assets/images/decline.png",
                                      content: AppLocalizations.of(context)
                                          .contentConfirmDecline,
                                      title: AppLocalizations.of(context)
                                          .titleConfirmDecline,
                                      onTapConfirm: () {
                                        postModerationProvider.postModeration(
                                          postModeration.destinationPostId,
                                          PostStatus.decline,
                                          () {
                                            Navigator.popUntil(
                                                context,
                                                (route) =>
                                                    route.settings.name ==
                                                    PostModerationScreen
                                                        .nameRoute);
                                          },
                                        );
                                      },
                                      confirmColorButton: AppColors.kLightGreen,
                                    );
                                  },
                                );
                              }),
                              Consumer<PostModerationProvider>(builder:
                                  (context, postModerationProvider, child) {
                                return LightBlueButton(
                                  text: AppLocalizations.of(context).approve,
                                  textColor: AppColors.kLightGreen,
                                  onTap: () {
                                    OpenDialog().confirmDialog(
                                      context: context,
                                      assetsNamePng:
                                          "assets/images/approve.png",
                                      content: AppLocalizations.of(context)
                                          .contentConfirmApprove,
                                      title: AppLocalizations.of(context)
                                          .titleConfirmApprove,
                                      onTapConfirm: () {
                                        postModerationProvider.postModeration(
                                          postModeration.destinationPostId,
                                          PostStatus.approve,
                                          () {
                                            Navigator.popUntil(
                                                context,
                                                (route) =>
                                                    route.settings.name ==
                                                    PostModerationScreen
                                                        .nameRoute);
                                          },
                                        );
                                      },
                                      confirmColorButton: AppColors.kLightGreen,
                                    );
                                  },
                                );
                              }),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
