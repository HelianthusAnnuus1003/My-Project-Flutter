import 'package:get/get.dart';
import 'package:my_project/categories_repository.dart';
import 'package:my_project/products/products_controller.dart';

ProductsController productsController = ProductsController();

class CategoriesController extends GetxController {
  CategoriesRepository categoriesRepository = CategoriesRepository();
  var categories = [].obs;
  var currentIndex = 0.obs;
  var loading = false.obs;

  CategoriesController() {
    loadCategories();
  }

  loadCategories() async {
    loading(true);
    var tcategories = await categoriesRepository.loadCategoriesFromApi();
    categories(tcategories);
    if (categories.isNotEmpty) {
      await productsController
          .loadProductsFromRepo(categories[currentIndex.value]);
    }
    loading(false);
  }

  changeCategories(index) async {
    currentIndex(index);
    await productsController.loadProductsFromRepo(categories[index]);
  }
}