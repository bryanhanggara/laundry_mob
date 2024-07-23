import 'package:d_button/d_button.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laundri/config/app_assets.dart';
import 'package:laundri/config/app_color.dart';
import 'package:laundri/config/app_constants.dart';
import 'package:laundri/config/app_failure.dart';
import 'package:laundri/config/app_format.dart';
import 'package:laundri/config/navigation.dart';
import 'package:laundri/data/promo_datasource.dart';
import 'package:laundri/data/shop_datasource.dart';
import 'package:laundri/models/promo_model.dart';
import 'package:laundri/models/shop_model.dart';
import 'package:laundri/page/search_by_city.dart';
import 'package:laundri/providers/home_provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  static final edtSearch = TextEditingController();
  static final pageControler = PageController();
  getPromo() {
    PromoDataSource.readLimit().then(
      (value) => {
        value.fold(
          (failure) {
            switch (failure.runtimeType) {
              case ServerFailure:
                setHomePromoStatus(ref, 'Server Eror');
                break;
              case NotFoundFailure:
                setHomePromoStatus(ref, 'Tidak Ditemukan');
                break;
              case ForbiddenFailure:
                setHomePromoStatus(ref, 'Akses Dibatasi');
                break;
              case BadRequestFailure:
                setHomePromoStatus(ref, 'Request Time Out');
                break;
              case UnauthorizedFailure:
                setHomePromoStatus(ref, 'Unauthorized');
                break;
              default:
                setHomePromoStatus(ref, 'Server Eror');
                break;
            }
          },
          (result) {
            setHomePromoStatus(ref, 'Sukses');
            List data = result['data'];
            List<PromoModel> promos =
                data.map((e) => PromoModel.fromJson(e)).toList();
            ref.read(homePromoListProvider.notifier).initial(promos);
          },
        ),
      },
    );
  }

  getRecomendation() {
    ShopDataSource.readLimit().then((value) => {
          value.fold((failure) {
            switch (failure.runtimeType) {
              case ServerFailure:
                setHomeShopRecomendationStatus(ref, 'Server Eror');
                break;
              case NotFoundFailure:
                setHomeShopRecomendationStatus(ref, 'Tidak Ditemukan');
                break;
              case ForbiddenFailure:
                setHomeShopRecomendationStatus(ref, 'Akses Dibatasi');
                break;
              case BadRequestFailure:
                setHomeShopRecomendationStatus(ref, 'Request Time Out');
                break;
              case UnauthorizedFailure:
                setHomeShopRecomendationStatus(ref, 'Unauthorized');
                break;
              default:
                setHomeShopRecomendationStatus(ref, 'Server Eror');
                break;
            }
          }, (result) {
            setHomeShopRecomendationStatus(ref, 'sukses');
            List data = result['data'];
            List<ShopModel> shops =
                data.map((e) => ShopModel.fromJson(e)).toList();
            ref.read(homeRecomendationProvider.notifier).initial(shops);
          })
        });
  }

  getSearchCity() {
    Nav.push(
        context,
        SearchCityPage(
          query: edtSearch.text,
        ));
  }

  @override
  void initState() {
    getPromo();
    getRecomendation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        header(),
        categories(),
        // ignore: deprecated_member_use
        DView.spaceHeight(10),
        promo(),
        // ignore: deprecated_member_use
        DView.spaceHeight(10),
        Consumer(
          builder: (_, wiRef, __) {
            List<ShopModel> list = wiRef.watch(homeRecomendationProvider);
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 0, 30, 1),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DView.textTitle(
                        'Rekomendasi',
                        color: Colors.black,
                      ),
                      DView.textAction(
                        () {},
                        color: AppColor.primary,
                      ),
                    ],
                  ),
                ),
                // ignore: deprecated_member_use
                DView.spaceHeight(8),
                // ignore: deprecated_member_use
                if (list.isEmpty) DView.spaceHeight(40),
                if (list.isEmpty)
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.sentiment_dissatisfied,
                        color: Colors.grey,
                      ),
                      // ignore: deprecated_member_use
                      DView.spaceHeight(6),
                      const Text(
                        'Rekomendasi Tidak Ditemukan',
                        style: TextStyle(color: Colors.grey),
                      )
                    ],
                  ),
                if (list.isNotEmpty)
                  SizedBox(
                    height: 250,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: list.length,
                      itemBuilder: (context, index) {
                        ShopModel item = list[index];
                        return GestureDetector(
                          onTap: () {},
                          child: Container(
                            margin: EdgeInsets.fromLTRB(
                              index == 0 ? 30 : 10,
                              0,
                              index == list.length - 1 ? 30 : 10,
                              0,
                            ),
                            width: 200,
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: FadeInImage(
                                    placeholder:
                                        const AssetImage(AppAssets.placeHolder),
                                    image: NetworkImage(
                                      '${AppConstants.baseImageUrl}/shop/${item.image}',
                                    ),
                                    fit: BoxFit.cover,
                                    imageErrorBuilder:
                                        (context, error, stackFit) {
                                      return const Icon(
                                        Icons.error,
                                      );
                                    },
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Container(
                                    height: 100,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      gradient: const LinearGradient(
                                          colors: [
                                            Colors.transparent,
                                            Colors.black,
                                          ],
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 8,
                                  bottom: 8,
                                  right: 8,
                                  child: Column(
                                    children: [
                                      Row(
                                        children:
                                            ["Reguler", "Express"].map((e) {
                                          return Container(
                                            decoration: BoxDecoration(
                                              color: AppColor.primary,
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                            ),
                                            margin:
                                                const EdgeInsets.only(right: 4),
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8, vertical: 4),
                                            child: Text(
                                              e,
                                              style: const TextStyle(
                                                height: 1,
                                                color: Colors.white,
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                      // ignore: deprecated_member_use
                                      DView.spaceHeight(8),
                                      Container(
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        padding: const EdgeInsets.all(8),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              item.name,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                RatingBar.builder(
                                                  initialRating: item.rate,
                                                  itemCount: 5,
                                                  allowHalfRating: true,
                                                  itemPadding:
                                                      const EdgeInsets.all(0),
                                                  unratedColor: Colors.grey,
                                                  itemBuilder:
                                                      (context, index) =>
                                                          const Icon(
                                                    Icons.star,
                                                    color: Colors.orange,
                                                  ),
                                                  itemSize: 12,
                                                  ignoreGestures: true,
                                                  onRatingUpdate: (value) {},
                                                ),
                                                Text(
                                                  '${item.rate}',
                                                  style: const TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 11,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Text(
                                              item.location,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  )
              ],
            );
          },
        ),
      ],
    );
  }

  Consumer promo() {
    return Consumer(
      builder: (_, wiRef, __) {
        List<PromoModel> list = wiRef.watch(homePromoListProvider);
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 0, 30, 1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DView.textTitle(
                    'Promo',
                    color: Colors.black,
                  ),
                  DView.textAction(
                    () {},
                    color: AppColor.primary,
                  ),
                ],
              ),
            ),
            // ignore: deprecated_member_use
            DView.spaceHeight(8),
            // ignore: deprecated_member_use
            if (list.isEmpty) DView.spaceHeight(40),
            if (list.isEmpty)
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.sentiment_dissatisfied,
                    color: Colors.grey,
                  ),
                  // ignore: deprecated_member_use
                  DView.spaceHeight(6),
                  const Text(
                    'Promo Tidak Ditemukan',
                    style: TextStyle(color: Colors.grey),
                  )
                ],
              ),
            if (list.isNotEmpty)
              AspectRatio(
                aspectRatio: 16 / 9,
                child: PageView.builder(
                  controller: pageControler,
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    PromoModel item = list[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: FadeInImage(
                                placeholder:
                                    const AssetImage(AppAssets.placeHolder),
                                image: NetworkImage(
                                  '${AppConstants.baseImageUrl}/promo/${item.image}',
                                ),
                                fit: BoxFit.cover,
                                imageErrorBuilder:
                                    (context, error, stackTrace) {
                                  return const Icon(
                                    Icons.error,
                                  );
                                },
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(
                                          0.5), // Warna bayangan dengan opasitas
                                      spreadRadius: 2, // Penyebaran bayangan
                                      blurRadius: 5, // Jarak blur bayangan
                                      offset: Offset(
                                          2, 4), // Posisi bayangan (x, y)
                                    ),
                                  ],
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 6),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      item.shop.name,
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    // ignore: deprecated_member_use
                                    DView.spaceHeight(4),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          '${AppFormat.shortPrice(item.newPrice)} /Kg',
                                          style: const TextStyle(
                                            color: Colors.green,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        // ignore: deprecated_member_use
                                        DView.spaceWidth(8),
                                        Text(
                                          '${AppFormat.shortPrice(item.oldPrice)} /Kg',
                                          style: const TextStyle(
                                            color: Colors.red,
                                            fontSize: 12,
                                            decoration:
                                                TextDecoration.lineThrough,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
            // ignore: deprecated_member_use
            DView.spaceHeight(5),
            if (list.isNotEmpty)
              SmoothPageIndicator(
                controller: pageControler,
                count: list.length,
                effect: const WormEffect(
                  dotHeight: 4,
                  dotWidth: 12,
                  dotColor: Colors.grey,
                  activeDotColor: AppColor.primary,
                ),
              ),
          ],
        );
      },
    );
  }

  Consumer categories() {
    return Consumer(
      builder: (_, wiRef, __) {
        String categorySelected = wiRef.watch(homeCategoryProvider);
        return SizedBox(
          height: 30,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: AppConstants.homeCategories.length,
            itemBuilder: (context, index) {
              String category = AppConstants.homeCategories[index];
              return Padding(
                padding: EdgeInsets.fromLTRB(
                  index == 0 ? 30 : 8,
                  0,
                  index == AppConstants.homeCategories.length - 1 ? 30 : 8,
                  0,
                ),
                child: InkWell(
                  onTap: () {
                    setHomeCategory(ref, category);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: categorySelected == category
                          ? AppColor.primary
                          : Colors.transparent,
                      border: Border.all(
                        color: categorySelected == category
                            ? AppColor.primary
                            : Colors.grey,
                      ),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      category,
                      style: TextStyle(
                        height: 1,
                        color: categorySelected == category
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Padding header() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Kami Siap',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Text(
            'Mencari Laundri Yang Terbaik',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Colors.grey,
            ),
          ),
          // ignore: deprecated_member_use
          DView.spaceHeight(10),
          Column(
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.location_city,
                    color: AppColor.primary,
                  ),
                  // ignore: deprecated_member_use
                  DView.spaceWidth(10),
                  const Text(
                    'Cari Sesuai Kotamu',
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                      color: AppColor.primary,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              // ignore: deprecated_member_use
              DView.spaceHeight(10),
              IntrinsicHeight(
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColor.secondary,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () => getSearchCity(),
                              icon: const Icon(Icons.search_rounded),
                              color: Colors.white,
                            ),
                            Expanded(
                              child: TextField(
                                controller: edtSearch,
                                decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Cari..',
                                    hintStyle: TextStyle(
                                      color: Colors.white,
                                    )),
                                style: const TextStyle(color: Colors.white),
                                onSubmitted: (value) => getSearchCity(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // ignore: deprecated_member_use
                    DView.spaceWidth(6),
                    DButtonElevation(
                      onClick: () {},
                      mainColor: AppColor.primary,
                      splashColor: AppColor.secondary,
                      width: 50,
                      radius: 10,
                      child: const Icon(
                        Icons.tune,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
