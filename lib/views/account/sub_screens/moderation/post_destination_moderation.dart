import 'package:flutter/material.dart';
import 'package:flutter_project_1/configs/color_config.dart';
import 'package:flutter_project_1/configs/date_cofig.dart';
import 'package:flutter_project_1/configs/text_config.dart';
import 'package:flutter_project_1/models/others/argument_model.dart';
import 'package:flutter_project_1/view_models/post/post_moderation_provider.dart';
import 'package:flutter_project_1/views/account/sub_screens/moderation/post_moderation_detail.dart';
import 'package:flutter_project_1/widgets/general_post_card.dart';
import 'package:flutter_project_1/views/home/widgets/search_widget.dart';
import 'package:flutter_project_1/widgets/button/custom_back_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../home/sub_screens/search_screen.dart';

class PostModerationScreen extends StatefulWidget {
  static const String nameRoute = '/post_moderation_screen';
  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: nameRoute),
      builder: (_) => ChangeNotifierProvider<PostModerationProvider>(
        create: (_) => PostModerationProvider(),
        child: const PostModerationScreen(),
      ),
    );
  }

  const PostModerationScreen({Key? key}) : super(key: key);

  @override
  State<PostModerationScreen> createState() => _PostModerationScreenState();
}

class _PostModerationScreenState extends State<PostModerationScreen> {
  late PostModerationProvider postModrationProvider;
  @override
  void dispose() {
    postModrationProvider.isDispose = true;
    super.dispose();
  }

  @override
  void initState() {
    postModrationProvider =
        Provider.of<PostModerationProvider>(context, listen: false);
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      postModrationProvider.onDataChange();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kLightBlue5,
      body: SafeArea(
        child: NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverAppBar(
              automaticallyImplyLeading: false,
              elevation: 0,
              floating: true,
              backgroundColor: AppColors.kLightBlue5,
              leadingWidth: 48.w,
              leading: SafeArea(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: 12.h,
                    ),
                    child: CustomBackButton(
                      onTapBack: () {
                        Navigator.pop(context);
                      },
                      backgroundColor: AppColors.kColor0,
                      iconColor: AppColors.kColor1,
                      isCircleRounded: true,
                    ),
                  ),
                ),
              ),
              title: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  AppLocalizations.of(context).postModeration,
                  style: TextConfigs.kTextHeader1.copyWith(fontSize: 32.sp),
                ),
              ),
            ),
          ],
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                left: 16.w,
                right: 16.w,
                top: 20.h,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SearchWidget(
                    onChange: (value) {},
                    onTap: () {
                      Navigator.pushNamed(context, SearchScreen.nameRoute,
                          arguments: SearchScreenArgument(true));
                    },
                    readOnly: true,
                    fillColors: AppColors.kColor1,
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Consumer<PostModerationProvider>(
                      builder: (context, postModerationProvider, child) {
                    return ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          final postModeration =
                              postModerationProvider.listPostModeration[index];
                          return GeneralPostCard(
                            firstImage: postModeration.images.first,
                            namePostModeration: postModeration.postName,
                            location: postModeration.district +
                                ", " +
                                postModeration.province,
                            date: DateConfig.fortmattedDateTime(
                                postModeration.dateTime),
                            onTap: () async {
                              await postModerationProvider
                                  .getUserById(postModeration.sharer);
                              Navigator.pushNamed(
                                context,
                                PostModerationDetailScreen.nameRoute,
                                arguments: PostModerationArgument(
                                    postModerationProvider,
                                    postModeration,
                                    postModerationProvider.sharer!),
                              );
                            },
                            isPending: true,
                            // avatarSharer:
                            //     postModerationProvider.sharer.avatarUrl!,
                            // nameSharer: postModerationProvider.sharer.userName!,
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) =>
                            SizedBox(
                              height: 8.h,
                            ),
                        itemCount:
                            postModerationProvider.listPostModeration.length);
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
