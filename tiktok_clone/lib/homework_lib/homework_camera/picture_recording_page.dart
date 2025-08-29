// ignore_for_file: avoid_print

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class PictureRecordingPage extends StatefulWidget {
  const PictureRecordingPage({super.key});

  @override
  State<PictureRecordingPage> createState() => _PictureRecordingPageState();
}

class _PictureRecordingPageState extends State<PictureRecordingPage>
    with TickerProviderStateMixin {
  bool _hasPermission = false;
  bool _isSelfieMode = false;

  late final AnimationController _buttonAnimationController =
      AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 200),
      );

  late final Animation<double> _buttonAnimation = Tween(
    begin: 1.0,
    end: 1.3,
  ).animate(_buttonAnimationController);

  late final AnimationController _progressAnimationController =
      AnimationController(
        vsync: this,
        duration: const Duration(seconds: 10),
        lowerBound: 0.0,
        upperBound: 1.0,
      );

  FlashMode? _flashMode;
  CameraController? _cameraController;

  @override
  void initState() {
    super.initState();
    initPermissions();

    _progressAnimationController.addListener(() {
      setState(() {});
    });
    _progressAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _stopRecording();
      }
    });
  }

  Future<void> initPermissions() async {
    print("카메라와 마이크 권한 요청 중...");
    final cameraPermission = await Permission.camera.request();
    final micPermission = await Permission.microphone.request();

    print("카메라 권한 상태: $cameraPermission");
    print("마이크 권한 상태: $micPermission");

    final cameraDenied =
        cameraPermission.isDenied || cameraPermission.isPermanentlyDenied;
    final micDenied =
        micPermission.isDenied || micPermission.isPermanentlyDenied;

    if (!cameraDenied && !micDenied) {
      print("권한이 허용되었습니다!");
      _hasPermission = true;
      await initCamera();
    } else {
      print("권한이 거부되었습니다.");
    }
  }

  Future<void> initCamera() async {
    print("카메라 초기화 시작...");
    final cameras = await availableCameras();
    print("사용 가능한 카메라 수: ${cameras.length}");
    if (cameras.isEmpty) return;

    await _cameraController?.dispose();

    try {
      final selectedCamera = _isSelfieMode && cameras.length > 1
          ? cameras[1]
          : cameras[0];
      print("선택된 카메라: ${selectedCamera.name}");

      _cameraController = CameraController(
        selectedCamera,
        ResolutionPreset.high,
      );

      print("CameraController.initialize() 호출 중...");
      await _cameraController!.initialize();
      print("카메라 초기화 완료!");

      _flashMode = _cameraController!.value.flashMode;
      setState(() {});
    } catch (e) {
      print("카메라 초기화 오류 발생: $e");
    }
  }

  Future<void> _toggleSelfieMode() async {
    _isSelfieMode = !_isSelfieMode;
    await initCamera();
  }

  Future<void> _setFlashMode(FlashMode newFlashMode) async {
    if (_cameraController == null) return;
    await _cameraController!.setFlashMode(newFlashMode);
    _flashMode = newFlashMode;
    setState(() {});
  }

  void _startRecording(TapDownDetails _) {
    _buttonAnimationController.forward();
    _progressAnimationController.forward();
  }

  void _stopRecording() {
    _buttonAnimationController.reverse();
    _progressAnimationController.reset();
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    _buttonAnimationController.dispose();
    _progressAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("권한 허용 여부: $_hasPermission");
    print("CameraController 상태: $_cameraController");
    print("CameraController 초기화 여부: ${_cameraController?.value.isInitialized}");

    if (!_hasPermission ||
        _cameraController == null ||
        !_cameraController!.value.isInitialized) {
      return const Scaffold(
        backgroundColor: Colors.black,
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Stack(
          alignment: Alignment.center,
          children: [
            CameraPreview(_cameraController!),
            Positioned(
              top: Sizes.size20,
              right: Sizes.size20,
              child: Column(
                children: [
                  IconButton(
                    color: Colors.white,
                    onPressed: _toggleSelfieMode,
                    icon: const Icon(Icons.cameraswitch),
                  ),
                  Gaps.v10,
                  IconButton(
                    color: _flashMode == FlashMode.off
                        ? Colors.amber.shade200
                        : Colors.white,
                    onPressed: () => _setFlashMode(FlashMode.off),
                    icon: const Icon(Icons.flash_off_rounded),
                  ),
                  Gaps.v10,
                  IconButton(
                    color: _flashMode == FlashMode.always
                        ? Colors.amber.shade200
                        : Colors.white,
                    onPressed: () => _setFlashMode(FlashMode.always),
                    icon: const Icon(Icons.flash_on_rounded),
                  ),
                  Gaps.v10,
                  IconButton(
                    color: _flashMode == FlashMode.auto
                        ? Colors.amber.shade200
                        : Colors.white,
                    onPressed: () => _setFlashMode(FlashMode.auto),
                    icon: const Icon(Icons.flash_auto_rounded),
                  ),
                  Gaps.v10,
                  IconButton(
                    color: _flashMode == FlashMode.torch
                        ? Colors.amber.shade200
                        : Colors.white,
                    onPressed: () => _setFlashMode(FlashMode.torch),
                    icon: const Icon(Icons.flashlight_on_rounded),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: Sizes.size40,
              child: GestureDetector(
                onTapDown: _startRecording,
                onTapUp: (details) => _stopRecording(),
                child: ScaleTransition(
                  scale: _buttonAnimation,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: Sizes.size80 + Sizes.size14,
                        height: Sizes.size80 + Sizes.size14,
                        child: CircularProgressIndicator(
                          color: Colors.red.shade400,
                          strokeWidth: Sizes.size6,
                          value: _progressAnimationController.value,
                        ),
                      ),
                      Container(
                        width: Sizes.size80,
                        height: Sizes.size80,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.red.shade400,
                        ),
                      ),
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
