import 'package:d_button/d_button.dart';
import 'package:d_info/d_info.dart';
import 'package:d_input/d_input.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laundri/auth/login_page.dart';
import 'package:laundri/config/app_assets.dart';
import 'package:laundri/config/app_color.dart';
import 'package:laundri/config/app_constants.dart';
import 'package:laundri/config/app_failure.dart';
import 'package:laundri/config/app_response.dart';
import 'package:laundri/config/navigation.dart';
import 'package:laundri/data/user_datasource.dart';
import 'package:laundri/providers/register_provider.dart';

class RegisterPage extends ConsumerStatefulWidget {
  const RegisterPage({super.key});

  @override
  ConsumerState<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage> {
  final edtUsername = TextEditingController();
  final edtEmail = TextEditingController();
  final edtPassword = TextEditingController();
  final formKey = GlobalKey<FormState>();

  execute() {
    bool validInput = formKey.currentState!.validate();
    if (!validInput) return;
    setRegisterStatus(ref, 'loading');

    UserDataSource.register(
      edtUsername.text,
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
        setRegisterStatus(ref, newStatus);
      }, (result) {
        DInfo.toastSuccess('Berhasil Registrasi');
        setRegisterStatus(ref, 'Sukses');
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
              gradient: LinearGradient(
                colors: [Colors.transparent, Colors.black45],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),

          //layer 3
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
                          color: AppColor.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        height: 5,
                        width: 50,
                        decoration: BoxDecoration(
                          color: AppColor.primary.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(30),
                        ),
                      )
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
                                  Icons.person,
                                  color: Colors.blue,
                                ),
                              ),
                            ),
                            // ignore: deprecated_member_use
                            DView.spaceWidth(10),
                            Expanded(
                              child: DInput(
                                controller: edtUsername,
                                fillColor: Colors.white70,
                                hint: 'Username',
                                radius: BorderRadius.circular(10),
                                validator: (input) =>
                                input == ''? "Form Belum Terisi" : null,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // ignore: deprecated_member_use
                      DView.spaceHeight(16),
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
                                  color: Colors.blue,
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
                                input == ''? "Form Belum Terisi" : null,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // ignore: deprecated_member_use
                      DView.spaceHeight(16),
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
                                  color: Colors.blue,
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
                                input == ''? "Form Belum Terisi" : null,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // ignore: deprecated_member_use
                      DView.spaceHeight(16),
                      IntrinsicHeight(
                        child: Row(
                          children: [
                            AspectRatio(
                              aspectRatio: 1,
                              child: DButtonFlat(
                                onClick: () {
                                  Nav.push(context, const LoginPage());
                                },
                                padding: const EdgeInsets.all(0),
                                radius: 10,
                                mainColor: Colors.white70,
                                child: const Text(
                                  'LOG',
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            // ignore: deprecated_member_use
                            DView.spaceWidth(10),
                            Expanded(
                              child: Consumer(builder: (_, wiRef, __) {
                                String status =
                                    wiRef.watch(registerStatusProvider);
                                if (status == 'loading') {
                                  return DView.loadingCircle();
                                }
                                return ElevatedButton(
                                  onPressed: () => execute(),
                                  style: const ButtonStyle(
                                    alignment: Alignment.centerLeft,
                                  ),
                                  child: const Text('Registrasi'),
                                );
                              }),
                            )
                          ],
                        ),
                      )
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
