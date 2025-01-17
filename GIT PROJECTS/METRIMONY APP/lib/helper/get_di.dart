import 'package:bureau_couple/controllers/matches_controller.dart';
import 'package:bureau_couple/controllers/profile_controller.dart';
import 'package:bureau_couple/data/repository/repo/matches_repo.dart';
import 'package:bureau_couple/data/repository/repo/profile_repo.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../controllers/auth_controller.dart';
import '../data/repository/api/api_client.dart';
import '../data/repository/repo/auth_repo.dart';
import '../utils/app_constants.dart';


Future<void>   init() async {
  /// Repository


  final sharedPreferences = await SharedPreferences.getInstance();
  Get.lazyPut(() => sharedPreferences);
  Get.lazyPut(() => ApiClient(appBaseUrl: AppConstants.baseUrl, sharedPreferences: Get.find()));

  // Repository
  
  Get.lazyPut(() => AuthRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() => MatchesRepo(apiClient: Get.find(),));
  Get.lazyPut(() => ProfileRepo(apiClient: Get.find(),));

  /// Controller

  Get.lazyPut(() => sharedPreferences);
  Get.lazyPut(() => AuthController(authRepo:  Get.find(),sharedPreferences: Get.find()));
  Get.lazyPut(() => MatchesController(matchesRepo: Get.find(),));
  Get.lazyPut(() => ProfileController(profileRepo: Get.find(), ));

}
