import 'package:flutter/material.dart';
import 'package:nomade_finalproject/constants/btn.dart';
import 'package:nomade_finalproject/constants/text.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
      // TODO: 실제 로그인 로직 (API 호출 등)을 여기에 연결
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('로그인 시도: ${_emailCtrl.text}')));
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

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _pwCtrl = TextEditingController();
  final _pwConfirmCtrl = TextEditingController();
  bool _obscure = true;
  bool _obscureConfirm = true;

  @override
  void dispose() {
    _emailCtrl.dispose();
    _pwCtrl.dispose();
    _pwConfirmCtrl.dispose();
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

  String? _pwConfirmValidator(String? val) {
    if (val == null || val.isEmpty) return '비밀번호 확인을 입력하세요.';
    if (val != _pwCtrl.text) return '비밀번호가 일치하지 않습니다.';
    return null;
  }

  void _onCreateAccount() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('계정 생성: ${_emailCtrl.text}')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Btn.backgroundBeige,
      body: SafeArea(
        child: Column(
          children: [
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

            Expanded(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const Text(
                        'Join!',
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
                            const SizedBox(height: 12),
                            TextFormField(
                              controller: _pwConfirmCtrl,
                              decoration:
                                  InputDecorationText.buildInputDecoration(
                                    'Confirm Password',
                                  ).copyWith(
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        _obscureConfirm
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                      ),
                                      onPressed: () => setState(
                                        () =>
                                            _obscureConfirm = !_obscureConfirm,
                                      ),
                                    ),
                                  ),
                              obscureText: _obscureConfirm,
                              validator: _pwConfirmValidator,
                            ),
                            const SizedBox(height: 18),
                            Btn.pinkButtonWidget(
                              text: 'Create Account',
                              onTap: _onCreateAccount,
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
                                text: 'Log in →',
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                                horizontalPadding: 26,
                                verticalPadding: 12,
                              ),
                            ),
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
