import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:space_gemini/models/chat_message_model.dart';
import 'package:space_gemini/repos/chat_repo.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc() : super(ChatSuccessState(messages: [])) {
    // 이벤트 처리기
    on<ChatGenerateNewTextMessageEvent>(chatGenerateNewTextMessageEvent);
  }
  List<ChatMessageModel> messages = [];
  bool generating = false;

  Future<void> chatGenerateNewTextMessageEvent(
      ChatGenerateNewTextMessageEvent event, Emitter<ChatState> emit) async {
    messages.add(ChatMessageModel(
        role: "user", parts: [ChatPartModel(text: event.inputMessage)]));
    emit(ChatSuccessState(messages: messages));
    generating = true;
    String generatedText = await ChatRepo.chatTextGenerationRepo(messages);
    if (generatedText.isNotEmpty) {
      messages.add(ChatMessageModel(
          role: 'model', parts: [ChatPartModel(text: generatedText)]));
      emit(ChatSuccessState(messages: messages));
    }
    generating = false;
  }
}
