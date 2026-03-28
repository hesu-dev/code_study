import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nomade_finalproject/authentication/sign_up_page.dart';
import 'package:nomade_finalproject/authentication/view_models/login_view_model.dart';
import 'package:nomade_finalproject/constants/btn.dart';
import 'package:nomade_finalproject/constants/text.dart';
import 'package:nomade_finalproject/post/home.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _pwCtrl = TextEditingController();
  bool _obscure = true;

  @override
  void dispose() {
    _emailCtrl.dispose();
    _pwCtrl.dispose();
    super.dispose();
  }

  String? _emailValidator(String? val) {
    if (val == null || val.trim().isEmpty) return '이메일을 입력하세요.';
    final emailRegex = RegExp(r'^[\w\-.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(val.trim())) return '유효한 이메일을 입력하세요.';
    return null;
  }

  String? _pwValidator(String? val) {
    if (val == null || val.isEmpty) return '비밀번호를 입력하세요.';
    if (val.length < 6) return '비밀번호는 최소 6자 이상이어야 합니다.';
    return null;
  }

  void _onLogin() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      ref
          .read(loginProvider.notifier)
          .login(formData["email"]!, formData["password"]!, context);
      // ScaffoldMessenger.of(
      //   context,
      // ).showSnackBar(SnackBar(content: Text('로그인 시도: ${_emailCtrl.text}')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Btn.backgroundBeige,
      body: SafeArea(
        child: Column(
          children: [
            // 로고 및 상단 여백
            const SizedBox(height: 24),
            Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Text('🔥', style: TextStyle(fontSize: 20)),
                  SizedBox(width: 6),
                  Text(
                    'MOOD',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  SizedBox(width: 6),
                  Text('🔥', style: TextStyle(fontSize: 20)),
                ],
              ),
            ),
            const SizedBox(height: 36),

            // 폼 영역
            Expanded(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const Text(
                        'Welcome!',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 18),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 36),
                        child: Column(
                          children: [
                            TextFormField(
                              controller: _emailCtrl,
                              decoration:
                                  InputDecorationText.buildInputDecoration(
                                    'Email',
                                  ),
                              validator: _emailValidator,
                              keyboardType: TextInputType.emailAddress,
                            ),
                            const SizedBox(height: 12),
                            TextFormField(
                              controller: _pwCtrl,
                              decoration:
                                  InputDecorationText.buildInputDecoration(
                                    'Password',
                                  ).copyWith(
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        _obscure
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                      ),
                                      onPressed: () =>
                                          setState(() => _obscure = !_obscure),
                                    ),
                                  ),
                              obscureText: _obscure,
                              validator: _pwValidator,
                            ),
                            const SizedBox(height: 18),
                            // Enter 버튼 (핑크)
                            Btn.pinkButtonWidget(
                              text: 'Enter',
                              onTap: _onLogin,
                              horizontalPadding: 32,
                              verticalPadding: 12,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 120),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 36),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: Btn.pinkButtonWidget(
                                text: 'Create an account →',
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (_) => const SignUpPage(),
                                    ),
                                  );
                                },
                                horizontalPadding: 26,
                                verticalPadding: 12,
                              ),
                            ),
                            const SizedBox(height: 18),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
