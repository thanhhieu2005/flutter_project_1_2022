import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project_1/configs/color_config.dart';
import 'package:flutter_project_1/models/address/district_model.dart';
import 'package:flutter_project_1/models/address/province_model.dart';
import 'package:flutter_project_1/models/posts/post.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_project_1/views/create_post/widgets/add_image_widget.dart';
import 'package:flutter_project_1/views/create_post/widgets/container_dropdown.dart';
import 'package:flutter_project_1/views/create_post/widgets/image_item.dart';
import 'package:flutter_project_1/views/create_post/widgets/input_field_custom.dart';
import 'package:flutter_project_1/views/create_post/widgets/input_title.dart';
import 'package:flutter_project_1/widgets/button/rounded_main_button.dart';
import 'package:flutter_project_1/widgets/title_appbar_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../configs/text_config.dart';
import '../../models/address/wards_model.dart';
import '../../view_models/create_post_provider.dart';
import '../../widgets/button/custom_back_button.dart';

class CreatePostScreen extends StatefulWidget {
  static const String nameRoute = '/create_post_screen';

  const CreatePostScreen({Key? key}) : super(key: key);

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBackgroundColor,
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            expandedHeight: 90.h,
            automaticallyImplyLeading: false,
            elevation: 0,
            floating: true,
            backgroundColor: AppColors.kBackgroundColor,
            flexibleSpace: FlexibleSpaceBar(
              background: SafeArea(
                child: Padding(
                  padding: EdgeInsets.only(right: 12.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: CustomBackButton(
                          height: 40.w,
                          width: 40.w,
                          backgroundColor: AppColors.kColor1,
                          iconColor: AppColors.kColor0,
                          onTapBack: () {
                            Navigator.pop(context);
                          },
                          isCircleRounded: false,
                        ),
                      ),
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
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20.w,
                vertical: 20.h,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InputTitleWidget(
                    title: AppLocalizations.of(context).destionationName,
                    isRequired: true,
                  ),
                  Consumer<CreatePostProvider>(
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
                  Consumer<CreatePostProvider>(
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
                  Consumer<CreatePostProvider>(
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
                  Consumer<CreatePostProvider>(
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
                  Consumer<CreatePostProvider>(
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
                    child: Consumer<CreatePostProvider>(
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
                  Consumer<CreatePostProvider>(
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
                  Consumer<CreatePostProvider>(
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
                      Consumer<CreatePostProvider>(
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
                  Consumer<CreatePostProvider>(
                      builder: (context, createPostProvider, child) {
                    return Center(
                      child: RoundedMainButton(
                        text: 'Submit',
                        height: 56.h,
                        width: 240.w,
                        onTap: () {
                          createPostProvider.submitPost();
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
