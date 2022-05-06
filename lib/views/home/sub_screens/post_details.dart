import 'package:flutter/material.dart';
import 'package:flutter_project_1/configs/color_config.dart';
import 'package:flutter_project_1/views/home/sub_screens/widgets/address_des_widget.dart';
import 'package:flutter_project_1/views/home/sub_screens/widgets/comment_widget.dart';
import 'package:flutter_project_1/views/home/sub_screens/widgets/description_post_widget.dart';
import 'package:flutter_project_1/views/home/sub_screens/widgets/evaluate_widget.dart';
import 'package:flutter_project_1/views/home/sub_screens/widgets/first_infro_post.dart';
import 'package:flutter_project_1/views/home/sub_screens/widgets/sharer_post_widget.dart';
import 'package:flutter_project_1/widgets/custom_back_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PostDetail extends StatefulWidget {
  static const String nameRoute = '/post_detail';
  static Route route() {
    return MaterialPageRoute(
      builder: (_) => const PostDetail(),
      settings: const RouteSettings(name: nameRoute),
    );
  }

  const PostDetail({Key? key}) : super(key: key);

  @override
  State<PostDetail> createState() => _PostDetailState();
}

class _PostDetailState extends State<PostDetail> {
  final List<String> urlImages = [
    'https://picsum.photos/250?image=9',
    'https://picsum.photos/250?image=5',
    'https://picsum.photos/250?image=4'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBackgroundColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 210.h,
            automaticallyImplyLeading: false,
            elevation: 0,
            floating: true,
            leadingWidth: 48.w,
            leading: CustomBackButton(
              currentWidgetContext: context,
              backgroundColor: const Color.fromARGB(99, 179, 189, 184),
              iconColor: AppColors.kColor1,
            ),
            backgroundColor: AppColors.kBackgroundColor,
            pinned: true,
            // ignore: prefer_const_constructors
            flexibleSpace: FlexibleSpaceBar(
              background: SafeArea(
                child: FirstInfoPost(
                  urlImages: urlImages,
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                const AddressDestinationWidget(
                  address: 'Quang Ninh, Viet Nam',
                  locationDiscovery: 'Ha Long Bay',
                ),
                SizedBox(
                  height: 16.h,
                ),
                const DescriptionPostWidget(
                  content:
                      'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA',
                ),
                SizedBox(
                  height: 16.h,
                ),
                const Divider(
                  height: 1,
                  thickness: 1,
                  indent: 10,
                  endIndent: 10,
                  color: Color.fromARGB(255, 216, 214, 214),
                ),
                CommentWidget(
                  countComment: '205',
                  onClick: () {},
                ),
                SizedBox(
                  height: 8.h,
                ),
                const EvaluateWidget(),
                SizedBox(
                  height: 16.h,
                ),
                SharerPostWidget(
                  onClick: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
