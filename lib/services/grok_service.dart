import 'dart:convert';
import '

package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class GrokService {
  static final String _apiKey = dotenv.env['GROK_API_KEY']!;
  static const String _url = 'https://api.x.ai/v1/chat/completions';

  static Future<String> ask(String message) async {
    try {
      final response = await http.post(
        Uri.parse(_url),
        headers: {
          'Authorization': 'Bearer $_apiKey',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "model": "grok-4",
          "messages": [
            {
              "role": "system",
              "content": "Eres CAMI, la IA buena onda y rebelde de CommuniApp. Hablas español relajado, con slang mexicano si el usuario lo usa, y eres útil y divertida."
            },
            {"role": "user", "content": message}
          ],
          "temperature": 0.8,
          "max_tokens": 800
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['choices'][0]['message']['content'];
      } else {
        return "CAMI está ocupada, intenta en un rato 😅";
      }
    } catch (e) {
      return "Sin conexión o error, revisa tu internet";
    }
  }
}
