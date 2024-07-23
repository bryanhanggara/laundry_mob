import 'package:d_info/d_info.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:laundri/auth/login_page.dart';
import 'package:laundri/auth/register_page.dart';
import 'package:laundri/config/app_assets.dart';
import 'package:laundri/config/app_color.dart';
import 'package:laundri/config/app_session.dart';
import 'package:laundri/config/navigation.dart';
import 'package:laundri/models/user_model.dart';
import 'package:laundri/page/dashboard_view/about_view.dart';

class AccountView extends StatelessWidget {
  const AccountView({super.key});

  logout(BuildContext context) {
    DInfo.dialogConfirmation(
      context,
      'Logout',
      'Kamu Yakin Akan Logout?',
    ).then((yes) {
      if (yes ?? false) {
        AppSession.removeUser();
        AppSession.removeBearerToken();
        Nav.replace(context, const LoginPage());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: AppSession.getUser(),
      builder: (context, snapshot) {
        if (snapshot.data == null) return DView.loadingCircle();
        UserModel user = snapshot.data!;

        return ListView(
          padding: const EdgeInsets.all(0),
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(30, 60, 30, 30),
              child: Text(
                'Akun Saya',
                style: TextStyle(
                  fontSize: 30,
                  color: AppColor.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 70,
                    child: AspectRatio(
                      aspectRatio: 3 / 4,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          AppAssets.profileDefault,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  // ignore: deprecated_member_use
                  DView.spaceWidth(16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Username',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        // ignore: deprecated_member_use
                        DView.spaceHeight(5),
                        Text(
                          user.username,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                        // ignore: deprecated_member_use
                        DView.spaceHeight(10),
                        const Text(
                          'Email',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        // ignore: deprecated_member_use
                        DView.spaceHeight(5),
                        Text(
                          user.email,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // ignore: deprecated_member_use
            DView.spaceHeight(16),
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 30),
              onTap: () {
                
              },
              dense: true,
              horizontalTitleGap: 0,
              leading: const Icon(
                Icons.image,
              ),
              title: const Text(
                'Ubah Profil',
              ),
              trailing: const Icon(
                Icons.navigate_next,
              ),
            ),
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 30),
              onTap: () {},
              dense: true,
              horizontalTitleGap: 0,
              leading: const Icon(
                Icons.notifications,
              ),
              title: const Text(
                'Notifikasi',
              ),
              trailing: const Icon(
                Icons.navigate_next,
              ),
            ),
          
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 30),
              onTap: () {},
              dense: true,
              horizontalTitleGap: 0,
              leading: const Icon(
                Icons.dark_mode_outlined,
              ),
              title: const Text('Mode Gelap'),
              trailing: Switch(
                activeColor: AppColor.primary,
                value: true,
                onChanged: (value) {},
              ),
            ),
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 30),
              onTap: () {
                Nav.push(context, const AboutPage());
              },
              dense: true,
              horizontalTitleGap: 0,
              title: const Text('Tentang Kami'),
              leading: const Icon(
                Icons.question_mark,
              ),
              trailing: const Icon(
                Icons.navigate_next,
              ),
            ),
             Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: OutlinedButton(
                onPressed: () => logout(context),
                child: const Text(
                  'Logout',
                  style: TextStyle(
                    height: 1,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
