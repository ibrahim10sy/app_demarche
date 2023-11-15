import 'package:demarche_app/controller/home_controller.dart';
import 'package:demarche_app/model/Actualite.dart';
import 'package:demarche_app/service/actualiteService.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';


class HomeBinding extends Bindings {

  void dependencies(){
    Get.lazyPut< HomeController>(() => HomeController());
  }
}