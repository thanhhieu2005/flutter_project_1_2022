import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_project_1/constants/global_constants.dart';
import 'package:flutter_project_1/models/address/district_model.dart';
import 'package:flutter_project_1/models/address/province_model.dart';
import 'package:flutter_project_1/models/address/wards_model.dart';
import 'package:flutter_project_1/models/posts/post.dart';
import 'package:flutter_project_1/services/data_provider.dart';
import 'package:flutter_project_1/services/post_repository.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class CreatePostProvider extends ChangeNotifier {
  bool isLoad = true;

  List<Province> _listProvince = [];
  List<District> _listDistrict = [];
  List<Wards> _listWards = [];

  Province? _selectedProvince;
  District? _selectedDistrict;
  Wards? _selectedWards;

  final List<File> _listImages = [];

  PostType _postType = PostType.beach;

  bool _checkTerms = false;

  TextEditingController namePostController = TextEditingController();
  TextEditingController roadController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  CreatePostProvider() {
    getProvinceApi();
  }

  /* Province API */

  Future getProvinceApi() async {
    _listProvince = await DataProvider.getProvinceApi();
    notifyListeners();
  }

  List<Province> get listProvince {
    return _listProvince;
  }

  Province? getProvince() {
    return _selectedProvince;
  }

  void setSelectedProvince(value) async {
    _selectedProvince = value;
    _selectedDistrict = null;
    await getDistrictApi();
    notifyListeners();
  }

  /* District API */

  Future getDistrictApi() async {
    _listDistrict = await DataProvider.getDistrictApi(_selectedProvince!.code);
  }

  List<District> get listDistrict {
    return _listDistrict;
  }

  District? getDistrict() {
    return _selectedDistrict;
  }

  void setSelectedDistrict(value) async {
    _selectedDistrict = value;
    _selectedWards = null;
    await getWardsApi();
    notifyListeners();
  }

  /* Wards API */

  Future getWardsApi() async {
    _listWards =
        await DataProvider.getWardsApi(_selectedDistrict!.codeDistrict);
  }

  List<Wards> get listWards {
    return _listWards;
  }

  Wards? getWards() {
    return _selectedWards;
  }

  void setSelectedWards(value) {
    _selectedWards = value;
    notifyListeners();
  }

  /* Get Post Type */
  void setPostType(value) {
    _postType = value;
    notifyListeners();
  }

  PostType? getPostType() {
    return _postType;
  }

  void setCheckTerms(value) {
    _checkTerms = value;
    notifyListeners();
  }

  bool getCheckTerms() {
    return _checkTerms;
  }

  // get list image
  List<File> get listImage {
    return _listImages;
  }

  Future deleteImage(int index) async {
    _listImages.removeAt(index);
    notifyListeners();
  }

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;

      _listImages.add(File(image.path));
      notifyListeners();
    } on PlatformException catch (e) {
      // ignore: avoid_print
      print('$e');
    }
  }

  void submitPost() async {
    if (namePostController.text != "" ||
        descriptionController.text != "" ||
        _listProvince.isNotEmpty ||
        _listDistrict.isNotEmpty ||
        _listWards.isNotEmpty ||
        _listImages.isNotEmpty ||
        _checkTerms == true) {
      return;
    } else {
      final images = await PostRepo()
          .uploadListFileImage(_listImages, namePostController.text);

      var postId = const Uuid().v1();
      var newPost = Post(
        postId: postId,
        description: descriptionController.text,
        province: _selectedProvince!.nameProvince,
        district: _selectedDistrict!.nameDistrict,
        wards: _selectedWards!.nameWards,
        road: roadController.text,
        postName: namePostController.text,
        images: images,
        rating: 0.toDouble(),
        sharer: localCurrentUser.uid,
        status: PostStatus.pending,
        type: _postType,
      );

      await PostRepo().submitPost(newPost, postId);
      notifyListeners();
    }
  }
}
