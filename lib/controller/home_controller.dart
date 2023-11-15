import 'package:demarche_app/model/Actualite.dart';
import 'package:demarche_app/service/actualiteService.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class HomeController extends GetxController {
  var box = GetStorage();
  var isLoading = false;
  List<Actualite> carouselData = [];

  @override
  void onInit() {
    fetchCarousel();
    if (box.read('carouselData') != null)
      carouselData.assignAll(box.read('carouselData'));
    super.onInit();
  }

  void fetchCarousel() async {
    try {
      isLoading = true;
      update();

      List<Actualite> _data = await ActualiteService.getActualite();
      if (_data != null) {
        carouselData.assignAll(_data);
        box.write('carouselData', _data);
      }
    } finally {
      isLoading = false;
      update();
      print("Aucun donné trouve");
    }
  }
}
