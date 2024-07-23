import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laundri/config/app_color.dart';
import 'package:laundri/config/app_failure.dart';
import 'package:laundri/data/shop_datasource.dart';
import 'package:laundri/models/shop_model.dart';
import 'package:laundri/providers/search_city_provider.dart';

class SearchCityPage extends ConsumerStatefulWidget {
  const SearchCityPage({super.key, required this.query});
  final String query;

  @override
  ConsumerState<SearchCityPage> createState() => _SearchCityPageState();
}

class _SearchCityPageState extends ConsumerState<SearchCityPage> {
  final edtSearch = TextEditingController();

  execute() {
    ShopDataSource.searchByCity(edtSearch.text).then((value) {
      setSearchByCityStatus(ref, 'loading');
          value.fold((failure) {
            switch (failure.runtimeType) {
              case ServerFailure:
                setSearchByCityStatus(ref, 'Server Eror');
                break;
              case NotFoundFailure:
                setSearchByCityStatus(ref, 'Tidak Ditemukan');
                break;
              case ForbiddenFailure:
                setSearchByCityStatus(ref, 'Akses dibatasi');
                break;
              case BadRequestFailure:
                setSearchByCityStatus(ref, 'Requesy Eror');
                break;
              case UnauthorizedFailure:
                setSearchByCityStatus(ref, 'unauthorize');
                break;
              default:
                setSearchByCityStatus(ref, 'request error');
                break;
            }
          }, (result) {
            setSearchByCityStatus(ref, 'Sukses');
            List data = result['data'];
            List<ShopModel> list =
                data.map((e) => ShopModel.fromJson(e)).toList();
            ref.read(searchByCityListProvider.notifier).setData(list);
          });
        });
  }

  @override
  void initState() {
    if(widget.query != ''){
      edtSearch.text = widget.query;
      execute();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          height: 40,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                const Text(
                  'Kota ',
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 16,
                    height: 1,
                  ),
                ),
                Expanded(
                  child: TextField(
                    controller: edtSearch,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      isDense: true,
                    ),
                    style: const TextStyle(
                      height: 1,
                    ),
                    onSubmitted: (value) => execute(),
                  ),
                ),
              ],
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => execute(),
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: Consumer(
        builder: (_, wiRef, __) {
          String status = wiRef.watch(searchByCityStatusProvider);
          List<ShopModel> list = wiRef.watch(searchByCityListProvider);
          if (status == '') {
            return DView.nothing();
          }

          if (status == 'loading') return DView.loadingCircle();

          if (status == 'Sukses') {
            return ListView.builder(
              itemCount: list.length,
              itemBuilder: (context, index) {
                ShopModel shop = list[index];
                return ListTile(
                  onTap: () {},
                  leading: CircleAvatar(
                    backgroundColor: AppColor.primary,
                    foregroundColor: Colors.white,
                    child: Text(
                      '${index+1}'
                    ),
                  ),
                  title: Text(shop.name),
                  subtitle: Text(shop.city),
                  trailing: const Icon(Icons.navigate_next),
                );
              },
            );
          }
          return DView.error();
        },
      ),
    );
  }
}
