import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:laundri/config/app_assets.dart';
import 'package:laundri/config/app_color.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(0),
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 60, 30, 30),
            child: Column(
              children: [
                const Text(
                  'Tentang Saya',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColor.primary,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // ignore: deprecated_member_use
                DView.spaceHeight(5),
                Container(
                  height: 5,
                  width: 80,
                  decoration: BoxDecoration(
                    color: AppColor.primary.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                // ignore: deprecated_member_use
                DView.spaceHeight(20),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                      ),
                      borderRadius: BorderRadius.circular(10)),
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 110,
                        child: AspectRatio(
                          aspectRatio: 3 / 4,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              AppAssets.mePic,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      // ignore: deprecated_member_use
                      DView.spaceWidth(10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Nama ',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Text(
                            'Bryan Hanggara',
                          ),
                          // ignore: deprecated_member_use
                          DView.spaceHeight(8),
                          const Text(
                            'Divisi ',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Text(
                            'Mobile Development',
                          ),
                          // ignore: deprecated_member_use
                          DView.spaceHeight(8),
                          const Text(
                            'Final Project ',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Text(
                            'Go Laundri',
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Text(
                    'Framework',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                // ignore: deprecated_member_use
                DView.spaceHeight(20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 60,
                      height: 70,
                      child: AspectRatio(
                        aspectRatio: 1 / 1,
                        child: Image.asset(
                          AppAssets.flutterPic,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    // ignore: deprecated_member_use
                    DView.spaceWidth(30),
                    SizedBox(
                      width: 60,
                      height: 70,
                      child: AspectRatio(
                        aspectRatio: 1 / 1,
                        child: Image.asset(
                          AppAssets.laravelPic,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Text(
                    'Terimakasih',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                // ignore: deprecated_member_use
                DView.spaceHeight(20),
                SizedBox(
                  width: 220,
                  child: AspectRatio(
                    aspectRatio: 4 / 3,
                    child: Image.asset(
                      AppAssets.gdscPic,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
