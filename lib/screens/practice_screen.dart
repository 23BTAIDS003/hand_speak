import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class PracticeScreen extends StatefulWidget {
  const PracticeScreen({super.key});

  @override
  State<PracticeScreen> createState() => _PracticeScreenState();
}

class _PracticeScreenState extends State<PracticeScreen> {
  late CameraController _cameraController;
  bool _isInitialized = false;
  String _recognizedSign = 'None';
  String _feedbackMessage = '';
  bool _isCorrect = false;
  Timer? _detectionTimer;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    try {
      final cameras = await availableCameras();
      final frontCam = cameras.firstWhere(
            (cam) => cam.lensDirection == CameraLensDirection.front,
        orElse: () => cameras.first,
      );

      _cameraController = CameraController(
        frontCam,
        ResolutionPreset.medium,
        enableAudio: false,
      );

      await _cameraController.initialize();

      if (!mounted) return;

      setState(() {
        _isInitialized = true;
      });

      // Start mock gesture recognition loop
      _startMockGestureDetection();
    } catch (e) {
      print("Error initializing camera: $e");
    }
  }

  void _startMockGestureDetection() {
    const mockSigns = ['A', 'B', 'C'];
    _detectionTimer = Timer.periodic(const Duration(seconds: 4), (_) {
      final detected = mockSigns[Random().nextInt(mockSigns.length)];
      final correct = Random().nextBool();

      setState(() {
        _recognizedSign = detected;
        _isCorrect = correct;
        _feedbackMessage = correct
            ? '✅ You signed: $detected (Correct!)'
            : '❌ You signed: $detected (Try Again)';
      });
    });
  }

  @override
  void dispose() {
    _detectionTimer?.cancel();
    _cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Practice Signs'),
        backgroundColor: Colors.deepPurple,
      ),
      body: SafeArea(
        child: !_isInitialized
            ? const Center(child: CircularProgressIndicator())
            : Column(
          children: [
            Expanded(
              child: CameraPreview(_cameraController),
            ),
            const SizedBox(height: 16),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                "Camera initialized. You can now practice signs!",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20),
            _buildFeedbackCard(),
          ],
        ),
      ),
    );
  }

  Widget _buildFeedbackCard() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _isCorrect ? Colors.green[100] : Colors.red[100],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: _isCorrect ? Colors.green : Colors.red,
          width: 2,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            _isCorrect ? Icons.check_circle : Icons.cancel,
            color: _isCorrect ? Colors.green : Colors.red,
            size: 30,
          ),
          const SizedBox(width: 12),
          Text(
            _feedbackMessage,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
