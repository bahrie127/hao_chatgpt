import 'dart:core';
import 'dart:ui';

class Constants {
  static const String gpt3ModelDavinci003 = 'text-davinci-003';
  static const String gpt3ModelCurie001 = 'text-curie-001';
  static const String gpt3ModelBabbage001 = 'text-babbage-001';
  static const String gpt3ModelAda001 = 'text-ada-001';
  static const List<String> gpt3Models = [
    gpt3ModelDavinci003,
    gpt3ModelCurie001,
    gpt3ModelBabbage001,
    gpt3ModelAda001
  ];

  static const String codexModelDavinci002 = 'code-davinci-002';
  static const String codexModelCushman001 = 'code-cushman-001';
  static const List<String> codexModels = [
    codexModelDavinci002,
    codexModelCushman001,
  ];

  static const Locale enLocale = Locale('en', '');
  static const Locale zhLocale = Locale('zh', '');

  static const String aboutChatGPTUrl = 'https://openai.com/blog/chatgpt/';
  static const String aboutGPT3ModelsUrl =
      'https://beta.openai.com/docs/models/gpt-3';
  static const String aboutCodexModelsUrl =
      'https://beta.openai.com/docs/models/codex';
  static const String apiCompletionsUrl =
      'https://beta.openai.com/docs/api-reference/completions/create';
  static const String haoChatGitHubUrl =
      'https://github.com/conghaonet/hao_chatgpt';

  static const String blankUrl = 'about:blank';
}
