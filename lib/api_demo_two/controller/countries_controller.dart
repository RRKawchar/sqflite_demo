import 'package:get/get.dart';
import 'package:sqlite_demo/api_demo_two/countries_api_service/countries_api_service.dart';
import 'package:sqlite_demo/api_demo_two/models/countries_model.dart';


class CountryController extends GetxController {
  final countries = <CountriesModel>[].obs;
  final isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    loadCountries();
  }

  Future<void> loadCountries() async {
    try {
      isLoading(true);
      final loadedCountries = await CountriesApiService.getCountries();
      countries.value = loadedCountries;
    } catch (e) {
      print(e.toString());
    } finally {
      isLoading(false);
    }
  }
}
