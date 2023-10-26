import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_project_1/configs/color_config.dart';
import 'package:flutter_project_1/models/address/district_model.dart';
import 'package:flutter_project_1/models/address/province_model.dart';
import 'package:flutter_project_1/models/posts/destination_post.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_project_1/views/create_destination_post/widgets/add_image_widget.dart';
import 'package:flutter_project_1/views/create_destination_post/widgets/container_dropdown.dart';
import 'package:flutter_project_1/views/create_destination_post/widgets/image_item.dart';
import 'package:flutter_project_1/views/create_destination_post/widgets/input_field_custom.dart';
import 'package:flutter_project_1/views/create_destination_post/widgets/input_title.dart';
import 'package:flutter_project_1/widgets/button/rounded_main_button.dart';
import 'package:flutter_project_1/widgets/dialog/open_dialog.dart';
import 'package:flutter_project_1/widgets/title_appbar_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import '../../configs/text_config.dart';
import '../../models/address/wards_model.dart';
import '../../view_models/post/create_des_post_provider.dart';
import '../../widgets/button/custom_back_button.dart';

class CreateDestinationPostScreen extends StatefulWidget {
  static const String nameRoute = '/create_destination_post_screen';

  const CreateDestinationPostScreen({Key? key}) : super(key: key);

  @override
  State<CreateDestinationPostScreen> createState() =>
      _CreateDestinationPostScreenState();
}

class _CreateDestinationPostScreenState
    extends State<CreateDestinationPostScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBackgroundColor,
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            expandedHeight: 120.h,
            automaticallyImplyLeading: false,
            elevation: 0,
            floating: true,
            backgroundColor: AppColors.kBackgroundColor,
            flexibleSpace: FlexibleSpaceBar(
              background: SafeArea(
                child: Padding(
                  padding: EdgeInsets.only(right: 12.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // Align(
                      //   alignment: Alignment.centerLeft,
                      //   child: CustomBackButton(
                      //     height: 40.w,
                      //     width: 40.w,
                      //     backgroundColor: AppColors.kColor1,
                      //     iconColor: AppColors.kColor0,
                      //     onTapBack: () {
                      //       Navigator.pop(context);
                      //     },
                      //     isCircleRounded: false,
                      //   ),
                      // ),
                      TitleAppBarWidget(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        aboveText: AppLocalizations.of(context).create,
                        underText: AppLocalizations.of(context).newDiscover,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20.w,
              vertical: 20.h,
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InputTitleWidget(
                    title: AppLocalizations.of(context).destionationName,
                    isRequired: true,
                  ),
                  Consumer<CreateDestinationPostProvider>(
                      builder: (context, createPostProvider, child) {
                    return InputFieldCreatePost(
                      keyboardType: TextInputType.text,
                      maxLines: 1,
                      isRequired: true,
                      controller: createPostProvider.namePostController,
                    );
                  }),
                  SizedBox(height: 16.h),
                  InputTitleWidget(
                    isRequired: true,
                    title: AppLocalizations.of(context).province,
                  ),
                  Consumer<CreateDestinationPostProvider>(
                      builder: (context, provider, child) {
                    return ContainerDropdown(
                      dropDownWidget: DropdownButtonHideUnderline(
                        child: DropdownButton<Province>(
                            items: provider.listProvince.map((Province item) {
                              return DropdownMenuItem<Province>(
                                child: Text(
                                  item.nameProvince,
                                  style: TextConfigs.kText16Black,
                                ),
                                value: item,
                              );
                            }).toList(),
                            value: provider.getProvince(),
                            onChanged: (Province? value) {
                              setState(() {
                                provider.setSelectedProvince(value);
                              });
                            }),
                      ),
                    );
                  }),
                  SizedBox(height: 16.h),
                  InputTitleWidget(
                    isRequired: true,
                    title: AppLocalizations.of(context).district,
                  ),
                  Consumer<CreateDestinationPostProvider>(
                      builder: (context, provider, child) {
                    return ContainerDropdown(
                      dropDownWidget: DropdownButtonHideUnderline(
                        child: DropdownButton<District>(
                            items: provider.listDistrict.map((District item) {
                              return DropdownMenuItem<District>(
                                child: Text(
                                  item.nameDistrict,
                                  style: TextConfigs.kText16Black,
                                ),
                                value: item,
                              );
                            }).toList(),
                            value: provider.getDistrict(),
                            onChanged: (District? value) {
                              setState(() {
                                provider.setSelectedDistrict(value);
                              });
                            }),
                      ),
                    );
                  }),
                  SizedBox(height: 16.h),
                  InputTitleWidget(
                    isRequired: true,
                    title: AppLocalizations.of(context).wards,
                  ),
                  Consumer<CreateDestinationPostProvider>(
                      builder: (context, provider, child) {
                    return ContainerDropdown(
                      dropDownWidget: DropdownButtonHideUnderline(
                        child: DropdownButton<Wards>(
                            items: provider.listWards.map((Wards item) {
                              return DropdownMenuItem<Wards>(
                                child: Text(
                                  item.nameWards,
                                  style: TextConfigs.kText16Black,
                                ),
                                value: item,
                              );
                            }).toList(),
                            value: provider.getWards(),
                            onChanged: (Wards? value) {
                              setState(() {
                                provider.setSelectedWards(value);
                              });
                            }),
                      ),
                    );
                  }),
                  SizedBox(height: 16.h),
                  InputTitleWidget(
                    isRequired: false,
                    title: AppLocalizations.of(context).road,
                  ),
                  Consumer<CreateDestinationPostProvider>(
                      builder: (context, createPostProvider, child) {
                    return InputFieldCreatePost(
                      keyboardType: TextInputType.text,
                      maxLines: 1,
                      isRequired: false,
                      controller: createPostProvider.roadController,
                    );
                  }),
                  SizedBox(height: 16.h),
                  InputTitleWidget(
                    isRequired: true,
                    title: AppLocalizations.of(context).images,
                  ),
                  SizedBox(
                    height: 120.h,
                    child: Consumer<CreateDestinationPostProvider>(
                        builder: (context, createPostProvider, child) {
                      return ListView.separated(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int index) {
                            if (createPostProvider.listImage.length == index) {
                              return AddImageWidget(
                                onTap: () {
                                  createPostProvider.pickImage();
                                },
                              );
                            } else {
                              return ImageItemWidget(
                                image: createPostProvider.listImage[index],
                                onTap: () {
                                  createPostProvider.deleteImage(index);
                                },
                              );
                            }
                          },
                          separatorBuilder: (context, index) => SizedBox(
                                width: 21.w,
                              ),
                          itemCount: createPostProvider.listImage.length + 1);
                    }),
                  ),
                  SizedBox(height: 8.h),
                  const NoticeImageText(),
                  SizedBox(
                    height: 16.h,
                  ),
                  InputTitleWidget(
                    isRequired: true,
                    title: AppLocalizations.of(context).description,
                  ),
                  Consumer<CreateDestinationPostProvider>(
                      builder: (context, createPostProvider, child) {
                    return InputFieldCreatePost(
                      keyboardType: TextInputType.multiline,
                      maxLines: 10,
                      isRequired: true,
                      controller: createPostProvider.descriptionController,
                    );
                  }),
                  SizedBox(
                    height: 16.h,
                  ),
                  InputTitleWidget(
                    isRequired: true,
                    title: AppLocalizations.of(context).typeDestination,
                  ),
                  Consumer<CreateDestinationPostProvider>(
                      builder: (context, provider, child) {
                    return ContainerDropdown(
                      dropDownWidget: DropdownButtonHideUnderline(
                        child: DropdownButton<PostType>(
                            items: SettingPostType.listType,
                            value: provider.getPostType(),
                            onChanged: (PostType? value) {
                              setState(() {
                                provider.setPostType(value);
                              });
                            }),
                      ),
                    );
                  }),
                  SizedBox(
                    height: 8.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Consumer<CreateDestinationPostProvider>(
                          builder: (context, provider, child) {
                        return Checkbox(
                            activeColor: AppColors.kPrimaryColor,
                            checkColor: AppColors.kColor1,
                            value: provider.getCheckTerms(),
                            onChanged: (bool? value) {
                              setState(() {
                                provider.setCheckTerms(value);
                              });
                            });
                      }),
                      SizedBox(
                        height: 8.w,
                      ),
                      Flexible(
                        child: Text(
                          AppLocalizations.of(context).termsApp,
                          style: TextConfigs.kText14Black,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 24.h),
                  Consumer<CreateDestinationPostProvider>(
                      builder: (context, createPostProvider, child) {
                    return Center(
                      child: RoundedMainButton(
                        text: 'Submit',
                        height: 56.h,
                        width: 240.w,
                        onTap: () {
                          EasyLoading.show(
                              status: "Loading",
                              indicator: SpinKitThreeBounce(
                                color: AppColors.kPrimaryColor,
                                size: 32.h,
                              ),
                              dismissOnTap: false,
                              maskType: EasyLoadingMaskType.custom);
                          createPostProvider.submitPost(() async {
                            await EasyLoading.dismiss();
                            OpenDialog().onSuccess(
                                context: context,
                                assetsNamePng: "assets/images/check.png",
                                content: AppLocalizations.of(context)
                                    .contentCreatePostSuccess,
                                title: AppLocalizations.of(context)
                                    .titleCreatePostSuccess,
                                mainColor: AppColors.kLightGreen);
                          }, () async {
                            await EasyLoading.dismiss();
                            OpenDialog().onFail(
                                context: context,
                                assetsNamePng: "assets/images/error.png",
                                content: AppLocalizations.of(context)
                                    .contentCreatePostFail,
                                title: AppLocalizations.of(context)
                                    .titleCreatePostFail,
                                mainColor: AppColors.kLightRed);
                          });
                        }
                        // ignore: avoid_returning_null_for_void
                        ,
                      ),
                    );
                  })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
