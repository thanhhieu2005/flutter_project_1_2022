import 'package:flutter/material.dart';
import 'package:flutter_project_1/configs/color_config.dart';
import 'package:flutter_project_1/models/address/district_model.dart';
import 'package:flutter_project_1/models/address/province_model.dart';
import 'package:flutter_project_1/models/posts/post.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flutter_project_1/views/create_post/widgets/container_dropdown.dart';
import 'package:flutter_project_1/views/create_post/widgets/input_field_custom.dart';
import 'package:flutter_project_1/views/create_post/widgets/input_title.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../configs/text_config.dart';
import '../../models/address/wards_model.dart';
import '../../view_models/create_post_provider.dart';
import '../../widgets/custom_back_button.dart';

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
                          currentWidgetContext: context,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                            child: Text(
                              AppLocalizations.of(context).create,
                              style: TextConfigs.kTextHeader1,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              AppLocalizations.of(context).newDiscover,
                              style: TextConfigs.kTextHeader1,
                            ),
                          ),
                        ],
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
                  const InputFieldCreatePost(
                    keyboardType: TextInputType.text,
                    maxLines: 1,
                    isRequired: true,
                  ),
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
                  const InputFieldCreatePost(
                    keyboardType: TextInputType.text,
                    maxLines: 1,
                    isRequired: false,
                  ),
                  SizedBox(height: 16.h),
                  InputTitleWidget(
                    isRequired: true,
                    title: AppLocalizations.of(context).images,
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  InputTitleWidget(
                    isRequired: true,
                    title: AppLocalizations.of(context).description,
                  ),
                  const InputFieldCreatePost(
                    keyboardType: TextInputType.multiline,
                    maxLines: 10,
                    isRequired: true,
                  ),
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
                    height: 32.h,
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
