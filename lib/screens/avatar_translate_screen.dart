import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:lottie/lottie.dart';

class AvatarTranslateScreen extends StatefulWidget {
  const AvatarTranslateScreen({super.key});

  @override
  State<AvatarTranslateScreen> createState() => _AvatarTranslateScreenState();
}

class _AvatarTranslateScreenState extends State<AvatarTranslateScreen> {
  final TextEditingController _textController = TextEditingController();
  late stt.SpeechToText _speech;
  bool _isListening = false;
  String _translatedWord = '';
  String _selectedLanguage = 'ASL';

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
  }

  void _startListening() async {
    bool available = await _speech.initialize();
    if (available) {
      setState(() => _isListening = true);
      _speech.listen(
        onResult: (result) {
          setState(() {
            _textController.text = result.recognizedWords;
          });
        },
      );
    }
  }

  void _stopListening() {
    _speech.stop();
    setState(() => _isListening = false);
  }

  void _translateText() {
    setState(() {
      _translatedWord = _textController.text.trim().toLowerCase();
    });
  }

  Widget _getLottieForWord(String word) {
    // NOTE: Map this with real Lottie files in assets
    switch (word) {
      case 'hello':
        return Lottie.asset('assets/lottie/hello.json');
      case 'thanks':
        return Lottie.asset('assets/lottie/thanks.json');
      case 'i love you':
        return Lottie.asset('assets/lottie/i_love_you.json');
      default:
        return Lottie.asset('assets/lottie/default_idle.json');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("3D Avatar Translator"),
        backgroundColor: Colors.deepPurple,
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Avatar Area
            Expanded(
              child: Center(
                child: Container(
                  width: double.infinity,
                  margin: const EdgeInsets.all(16),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      )
                    ],
                  ),
                  child: _getLottieForWord(_translatedWord),
                ),
              ),
            ),

            // Text Input
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: _textController,
                decoration: InputDecoration(
                  hintText: 'Type something...',
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: _translateText,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 12),

            // Language Selector
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: DropdownButtonFormField<String>(
                value: _selectedLanguage,
                items: ['ASL', 'BSL', 'ISL'].map((lang) {
                  return DropdownMenuItem(
                    value: lang,
                    child: Text(lang),
                  );
                }).toList(),
                onChanged: (val) {
                  setState(() => _selectedLanguage = val!);
                },
                decoration: const InputDecoration(
                  labelText: 'Select Language',
                  border: OutlineInputBorder(),
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),

      // Floating Mic Button
      floatingActionButton: FloatingActionButton(
        backgroundColor: _isListening ? Colors.red : Colors.deepPurple,
        onPressed: _isListening ? _stopListening : _startListening,
        child: Icon(_isListening ? Icons.stop : Icons.mic),
      ),
    );
  }
}
