import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_project_1/constants/global_constants.dart';
import 'package:flutter_project_1/models/address/district_model.dart';
import 'package:flutter_project_1/models/address/province_model.dart';
import 'package:flutter_project_1/models/address/wards_model.dart';
import 'package:flutter_project_1/models/posts/destination_post.dart';
import 'package:flutter_project_1/services/data_provider.dart';
import 'package:flutter_project_1/services/destination_post_repository.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class CreateDestinationPostProvider extends ChangeNotifier {
  bool _isLoad = false;

  List<Province> _listProvince = [];
  List<District> _listDistrict = [];
  List<Wards> _listWards = [];

  Province? _selectedProvince;
  District? _selectedDistrict;
  Wards? _selectedWards;

  List<File> _listImages = [];

  PostType _postType = PostType.beach;

  bool _checkTerms = false;

  TextEditingController namePostController = TextEditingController();
  TextEditingController roadController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  CreateDestinationPostProvider() {
    getProvinceApi();
  }

  bool get isLoad => _isLoad;

  set isLoad(value) {
    _isLoad = value;
    notifyListeners();
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

  void resetInputData() {
    namePostController = TextEditingController();
    roadController = TextEditingController();
    descriptionController = TextEditingController();
    _selectedProvince = null;
    _selectedDistrict = null;
    _selectedWards = null;
    _postType = PostType.beach;
    _listImages = [];
    _checkTerms = false;
  }

  void submitPost(Function onSuccess, Function onFail) async {
    if (namePostController.text == "" ||
        descriptionController.text == "" ||
        _selectedDistrict?.nameDistrict == "" ||
        _selectedProvince?.nameProvince == "" ||
        _selectedWards?.nameWards == "" ||
        _listImages.isEmpty ||
        _checkTerms == false) {
      onFail();
    } else {
      isLoad = true;
      final images = await DestinationPostRepo()
          .uploadListFileImage(_listImages, namePostController.text);

      var postId = const Uuid().v1();
      var newPost = DestinationPost(
        destinationPostId: postId,
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
        countRating: 0,
        dateTime: DateTime.now(),
      );

      await DestinationPostRepo().submitPost(newPost, postId);
      isLoad = true;

      resetInputData();

      onSuccess();
    }
  }
}
