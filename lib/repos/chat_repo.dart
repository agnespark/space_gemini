import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:space_gemini/models/chat_message_model.dart';
import 'package:space_gemini/utils/constants.dart';

class ChatRepo {
  static chatTextGenerationRepo(List<ChatMessageModel> previousMessage) {
    try {
      Dio dio = Dio();

      final response = dio.post(
          'https://generativelanguage.googleapis.com/v1beta/models/gemini-1.0-pro:generateContent?key=$apiKey',
          data: {
            "contents": previousMessage.map((e) => e.toMap()).toList(),
            "generationConfig": {
              "temperature": 0.9,
              "topK": 1,
              "topP": 1,
              "maxOutputTokens": 2048,
              "stopSequences": []
            },
            "safetySettings": [
              {
                "category": "HARM_CATEGORY_HARASSMENT",
                "threshold": "BLOCK_MEDIUM_AND_ABOVE"
              },
              {
                "category": "HARM_CATEGORY_HATE_SPEECH",
                "threshold": "BLOCK_MEDIUM_AND_ABOVE"
              },
              {
                "category": "HARM_CATEGORY_SEXUALLY_EXPLICIT",
                "threshold": "BLOCK_MEDIUM_AND_ABOVE"
              },
              {
                "category": "HARM_CATEGORY_DANGEROUS_CONTENT",
                "threshold": "BLOCK_MEDIUM_AND_ABOVE"
              }
            ]
          });
      log(response.toString());
    } catch (e) {
      log(e.toString());
    }
  }
}
