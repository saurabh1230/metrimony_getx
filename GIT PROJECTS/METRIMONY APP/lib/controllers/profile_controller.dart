import 'package:bureau_couple/data/repository/repo/matches_repo.dart';
import 'package:bureau_couple/data/repository/repo/profile_repo.dart';

import 'package:bureau_couple/src/models/basic_info_model.dart';
import 'package:bureau_couple/src/models/career_info_model.dart';
import 'package:bureau_couple/src/models/education_info_model.dart';
import 'package:bureau_couple/src/models/images_model.dart';
import 'package:bureau_couple/src/models/other_person_details_models.dart';
// import 'package:bureau_couple/src/models/other_person_details_models.dart';
import 'package:bureau_couple/src/models/preference_model.dart';
import 'package:bureau_couple/src/models/profie_model.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:get/get.dart';

// import '../../../models/attributes_model.dart';


class ProfileController extends GetxController implements GetxService {
  final ProfileRepo profileRepo;

  ProfileController({required this.profileRepo});


  bool _isLoading = false;
  bool get isLoading => _isLoading;

  int _offset = 1;
  int get offset => _offset;
  List<String> _pageList = [];
  int? _pageSize;
  int? get pageSize => _pageSize;


  List<PhotosModel>? _galleryImages;
  List<PhotosModel>? get galleryImages => _galleryImages;

  // int? _matchesIndex = 0;
  // int? get matches => _matchesIndex;

  void setOffset(int offset) {
    _offset= offset;
  }

  void showBottomLoader () {
    _isLoading = true;
    update();
  }

  Future<void> getGalleryImagesList() async {
    _isLoading = true;
    update();
    try {
      Response response = await profileRepo.getGalleryImages();
      Map<String, dynamic> responseData = response.body; // Assuming response.body is a Map
      if (responseData['status'] == true) {
        List<dynamic> data = responseData['data'];
        List<PhotosModel> newDataList = data.map((json) => PhotosModel.fromJson(json)).toList();
        _galleryImages = newDataList;

        _isLoading = false;
        update();
      } else {
        _isLoading = false;
        update();
      }
    } catch (e) {
      print('Error fetching list: $e');
      _isLoading = false;
      update();
    }
  }


  BasicInfoModel? _basicInfo;
  BasicInfoModel? get basicInfo => _basicInfo;


  Future<BasicInfoModel?> getBasicInfoApi() async {
    _isLoading = true;
    _basicInfo = null;
    update();
    try {
      Response response = await profileRepo.getProfileDetails();
      if (response.statusCode == 200) {
        var responseData = response.body['data']['user']['basic_info'];

        if (responseData != null) {
          _basicInfo = BasicInfoModel.fromJson(responseData);
        } else {
          print("Error: Basic info data is null");
          _isLoading = false;
          update();
        }
      } else {
        print("Error: API call failed with status code ${response.statusCode}");
        _isLoading = false;
        update();
      }
    } catch (e) {
      print("Exception: $e");
      _isLoading = false;
      update();
    }
    _isLoading = false;
    update();
    return _basicInfo;
  }

  List<CareerInfoModel>? _careerInfo;
  List<CareerInfoModel>? get careerInfo => _careerInfo;


  Future<void> getCareerInfo() async {
    _isLoading = true;
    _careerInfo = []; // Reset career info list
    update();

    try {
      Response response = await profileRepo.getProfileDetails();

      if (response.statusCode == 200) {
        List<dynamic> responseData = response.body['data']['user']['career_info'];
        List<CareerInfoModel> newDataList = responseData.map((json) => CareerInfoModel.fromJson(json)).toList();

        _careerInfo = newDataList;
        _isLoading = false;
        update();
      } else {
        // Handle API error
        print("Error: API call failed with status code ${response.statusCode}");
        _isLoading = false;
        update();
      }
    } catch (e) {
      print('Error fetching list: $e');
      _isLoading = false;
      update();
    }
  }


  List<EducationInfoModel>? _educationInfo;
  List<EducationInfoModel>? get educationInfo => _educationInfo;


  Future<void> getEducationInfo() async {
    _isLoading = true;
    _educationInfo = []; // Reset career info list
    update();

    try {
      Response response = await profileRepo.getProfileDetails();

      if (response.statusCode == 200) {
        List<dynamic> responseData = response.body['data']['user']['education_info'];
        List<EducationInfoModel> newDataList = responseData.map((json) => EducationInfoModel.fromJson(json)).toList();

        _educationInfo = newDataList;
        _isLoading = false;
        update();
      } else {
        // Handle API error
        print("Error: API call failed with status code ${response.statusCode}");
        _isLoading = false;
        update();
      }
    } catch (e) {
      print('Error fetching list: $e');
      _isLoading = false;
      update();
    }
  }


  PreferenceModel? _preferenceModel;
  PreferenceModel? get preferenceModel => _preferenceModel;


  Future<BasicInfoModel?> getPreferenceInfoApi() async {
    _isLoading = true;
    _preferenceModel = null;
    update();
    try {
      Response response = await profileRepo.getProfileDetails();
      if (response.statusCode == 200) {
        var responseData = response.body['data']['user']['partner_expectation'];

        if (responseData != null) {
          _preferenceModel = PreferenceModel.fromJson(responseData);
        } else {
          print("Error: Basic info data is null");
          _isLoading = false;
          update();
        }
      } else {
        print("Error: API call failed with status code ${response.statusCode}");
        _isLoading = false;
        update();
      }
    } catch (e) {
      print("Exception: $e");
      _isLoading = false;
      update();
    }
    _isLoading = false;
    update();
    return _basicInfo;
  }

  PhysicalAttr? _physicalAttributes;
  PhysicalAttr? get physicalAttributes => _physicalAttributes;


  Future<PhysicalAttr?> getPhysicalAttributesApi() async {
    _isLoading = true;
    _physicalAttributes = null;
    update();
    try {
      Response response = await profileRepo.getProfileDetails();
      if (response.statusCode == 200) {
        var responseData = response.body['data']['user']['physical_attributes'];

        if (responseData != null) {
          _physicalAttributes = PhysicalAttr.fromJson(responseData);
        } else {
          print("Error: Basic info data is null");
          _isLoading = false;
          update();
        }
      } else {
        print("Error: API call failed with status code ${response.statusCode}");
        _isLoading = false;
        update();
      }
    } catch (e) {
      print("Exception: $e");
      _isLoading = false;
      update();
    }
    _isLoading = false;
    update();
    return _physicalAttributes;
  }



  ProfileModel? _userDetails;
  ProfileModel? get userDetails => _userDetails;

  Future<ProfileModel?> getUserDetailsApi() async {
    _isLoading = true;
    _userDetails = null;
    update();
    Response response = await profileRepo.getProfileDetails();
    var responseData = response.body;
    if(responseData['status'] == true) {
      _userDetails = ProfileModel.fromJson(responseData);
      _isLoading = false;
      update();
    } else {
      print("Api Error ===================== >>");
    }

    _isLoading = false;
    update();
    return _userDetails;
  }

  OtherProfileModel? _otherUserDetails;
  OtherProfileModel? get otherUserDetails => _otherUserDetails;

  Future<OtherProfileModel?> getOtherUserDetailsApi(otherUserId) async {
    _isLoading = true;
    _otherUserDetails = null;
    update();
    Response response = await profileRepo.getOtherUserProfile(otherUserId);
    var responseData = response.body;
    if(responseData['status'] == true) {
      _otherUserDetails = OtherProfileModel.fromJson(responseData);
      _isLoading = false;
      update();
    } else {
      print("Api Error ===================== >>");
    }

    _isLoading = false;
    update();
    return _otherUserDetails;
  }






  final List<String> images = [
    "assets/images/latestnews1.png",
    "assets/images/latestnews1.png",
    "assets/images/latestnews1.png",
    "assets/images/latestnews1.png",
  ];

  int _categoryIndex = 0;
  int get categoryIndex => _categoryIndex;
  void setCategoryIndex(int index) {
    _categoryIndex = index;
    update();
  }
  int _bannerIndex = 0;
  int get bannerIndex => _bannerIndex;
  void setBannerIndex(int index) {
    _bannerIndex = index;
    update();
  }
  final CarouselController _carouselController = CarouselController();
  final List<String> bannerImages = [
    "assets/images/bannerdemo.jpg",
    "assets/images/bannerdemo.jpg",
    "assets/images/bannerdemo.jpg",
  ];

}

