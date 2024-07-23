import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laundri/models/promo_model.dart';
import 'package:laundri/models/shop_model.dart';

final homeCategoryProvider = StateProvider.autoDispose(
  (ref) => 'All',
);

final homePromoStatusProvider = StateProvider.autoDispose(
  (ref) => '',
);

final homeShopRecomendationStatusProvider = StateProvider.autoDispose(
  (ref) => '',
);

setHomeCategory(WidgetRef ref, String newCategory) {
  ref.read(homeCategoryProvider.notifier).state = newCategory;
}

setHomePromoStatus(WidgetRef ref, String newStatus) {
  ref.read(homePromoStatusProvider.notifier).state = newStatus;
}

setHomeShopRecomendationStatus(WidgetRef ref, String newStatus) {
  ref.read(homeShopRecomendationStatusProvider.notifier).state = newStatus;
}

final homePromoListProvider =
    StateNotifierProvider.autoDispose<HomePromoList, List<PromoModel>>(
        (ref) => HomePromoList([]));

class HomePromoList extends StateNotifier<List<PromoModel>> {
  HomePromoList(super.state);

  initial(List<PromoModel> newData) {
    state = newData;
  }
}

final homeRecomendationProvider =
    StateNotifierProvider.autoDispose<HomeRecomendationList, List<ShopModel>>(
  (ref) => HomeRecomendationList([]),
);

class HomeRecomendationList extends StateNotifier<List<ShopModel>> {
  HomeRecomendationList(super.state);

  initial(List<ShopModel> newData) {
    state = newData;
  }
}
