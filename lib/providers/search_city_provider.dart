import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laundri/models/shop_model.dart';

final searchByCityStatusProvider = StateProvider.autoDispose((ref) => '');

setSearchByCityStatus(WidgetRef ref, String newStatus) {
  ref.read(searchByCityStatusProvider.notifier).state = newStatus;
}

final searchByCityListProvider =
    StateNotifierProvider.autoDispose<SearchByCity, List<ShopModel>>(
  (ref) => SearchByCity([]),
);

class SearchByCity extends StateNotifier<List<ShopModel>> {
  SearchByCity(super.state);

  setData(newList) {
    state = newList;
  }
}
