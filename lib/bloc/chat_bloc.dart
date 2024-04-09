import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:space_gemini/models/chat_message_model.dart';
import 'package:space_gemini/repos/chat_repo.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc() : super(ChatInitial()) {
    // 이벤트 처리기
    on<ChatGenerateNewTextMessageEvent>(chatGenerateNewTextMessageEvent);
  }
  List<ChatMessageModel> messages = [];

  Future<void> chatGenerateNewTextMessageEvent(
      ChatGenerateNewTextMessageEvent event, Emitter<ChatState> emit) async {
    messages.add(ChatMessageModel(
        role: "user", parts: [ChatPartModel(text: event.inputMessage)]));
    emit(ChatSuccessState(messages: messages));
    await ChatRepo.chatTextGenerationRepo(messages);
  }
}
