package com.example.handspeak

import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.example.handspeak/hand_landmarks"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
                call, result ->
            if (call.method == "getHandLandmarks") {
                // TODO: Replace with real MediaPipe detection logic
                val landmarks: List<Float> = List(63) { (0..100).random() / 100f }
                result.success(landmarks)
            } else {
                result.notImplemented()
            }
        }
    }
}
