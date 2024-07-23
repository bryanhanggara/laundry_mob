import 'package:d_button/d_button.dart';
import 'package:d_info/d_info.dart';
import 'package:d_input/d_input.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laundri/auth/register_page.dart';
import 'package:laundri/config/app_assets.dart';
import 'package:laundri/config/app_color.dart';
import 'package:laundri/config/app_constants.dart';
import 'package:laundri/config/app_failure.dart';
import 'package:laundri/config/app_response.dart';
import 'package:laundri/config/app_session.dart';
import 'package:laundri/config/navigation.dart';
import 'package:laundri/data/user_datasource.dart';
import 'package:laundri/page/dashboard_page.dart';
import 'package:laundri/providers/login_provider.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final edtEmail = TextEditingController();
  final edtPassword = TextEditingController();
  final formKey = GlobalKey<FormState>();

  execute() {
    bool validInput = formKey.currentState!.validate();
    if (!validInput) return;
    setLoginStatus(ref, 'loading');

    UserDataSource.login(
      edtEmail.text,
      edtPassword.text,
    ).then((value) {
      String newStatus = '';
      value.fold((failure) {
        switch (failure.runtimeType) {
          case ServerFailure:
            newStatus = 'Server Sedang Error';
            DInfo.toastError(newStatus);
            break;
          case NotFoundFailure:
            newStatus = 'Tidak Dapat Ditemukan';
            DInfo.toastError(newStatus);
            break;
          case ForbiddenFailure:
            newStatus = 'Akses Dibatasi';
            DInfo.toastError(newStatus);
            break;
          case BadRequestFailure:
            newStatus = 'Permintaan Gagal';
            DInfo.toastError(newStatus);
            break;
          case InvalidInputFailure:
            newStatus = 'Terdapat Kesalahan Input';
            AppResponse.invalidInput(context, failure.message ?? '{}');
            DInfo.toastError(newStatus);
            break;
          case UnauthorizedFailure:
            newStatus = 'Tidak Terauntentikasi';
            DInfo.toastError(newStatus);
            break;
          default:
            newStatus = 'Kesalahan Error';
            DInfo.toastError(newStatus);
            newStatus = failure.message ?? '-';
            break;
        }
        setLoginStatus(ref, newStatus);
      }, (result) {
        DInfo.toastSuccess('Berhasil Registrasi');
        AppSession.setUser(result['data']);
        AppSession.setBearerToken(result['token']);
        setLoginStatus(ref, 'Sukses');
        Nav.replace(context, const Dashboard());
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            AppAssets.bgAuth,
            fit: BoxFit.cover,
          ),
          Container(
            height: MediaQuery.of(context).size.height / 2,
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
                Colors.transparent,
                Colors.black45,
              ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 60, 30, 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Column(
                    children: [
                      const Text(
                        AppConstants.appName,
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: AppColor.primary,
                        ),
                      ),
                      Container(
                        height: 5,
                        width: 40,
                        decoration: BoxDecoration(
                          color: AppColor.primary.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ],
                  ),
                ),
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      IntrinsicHeight(
                        child: Row(
                          children: [
                            AspectRatio(
                              aspectRatio: 1,
                              child: Material(
                                color: Colors.white70,
                                borderRadius: BorderRadius.circular(10),
                                child: const Icon(
                                  Icons.email,
                                  color: AppColor.primary,
                                ),
                              ),
                            ),
                            // ignore: deprecated_member_use
                            DView.spaceWidth(10),
                            Expanded(
                              child: DInput(
                                  controller: edtEmail,
                                  fillColor: Colors.white70,
                                  hint: 'Email',
                                  radius: BorderRadius.circular(10),
                                  validator: (input) =>
                                      input == '' ? "Jangan Kosong" : null),
                            ),
                          ],
                        ),
                      ),
                      // ignore: deprecated_member_use
                      DView.spaceHeight(10),
                      IntrinsicHeight(
                        child: Row(
                          children: [
                            AspectRatio(
                              aspectRatio: 1,
                              child: Material(
                                color: Colors.white70,
                                borderRadius: BorderRadius.circular(10),
                                child: const Icon(
                                  Icons.key,
                                  color: AppColor.primary,
                                ),
                              ),
                            ),
                            // ignore: deprecated_member_use
                            DView.spaceWidth(10),
                            Expanded(
                              child: DInputPassword(
                                  controller: edtPassword,
                                  fillColor: Colors.white70,
                                  hint: 'Password',
                                  radius: BorderRadius.circular(10),
                                  validator: (input) =>
                                      input == '' ? "Jangan Kosong" : null),
                            ),
                          ],
                        ),
                      ),
                      // ignore: deprecated_member_use
                      DView.spaceHeight(10),
                      IntrinsicHeight(
                        child: Row(
                          children: [
                            AspectRatio(
                              aspectRatio: 1,
                              child: Material(
                                color: Colors.white70,
                                borderRadius: BorderRadius.circular(10),
                                child: DButtonFlat(
                                  onClick: () {
                                    Nav.push(context, const RegisterPage());
                                  },
                                  padding: const EdgeInsets.all(0),
                                  radius: 10,
                                  mainColor: Colors.white70,
                                  child: const Text(
                                    'REG',
                                    style: TextStyle(
                                        color: AppColor.primary,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                            // ignore: deprecated_member_use
                            DView.spaceWidth(10),
                            Expanded(
                               child: Consumer(builder: (_, wiRef, __) {
                                String status =
                                    wiRef.watch(loginStatusProvider);
                                if (status == 'loading') {
                                  return DView.loadingCircle();
                                }
                                  return ElevatedButton(
                                    onPressed: () => execute(),
                                    style: const ButtonStyle(
                                      backgroundColor: MaterialStatePropertyAll(
                                          AppColor.primary),
                                      alignment: Alignment.centerLeft,
                                    ),
                                    child: const Text('Login'),
                                  );
                                }
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
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
