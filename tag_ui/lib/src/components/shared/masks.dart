// ignore_for_file: unnecessary_string_escapes

import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class TagMasks {
  // ignore: unnecessary_new
  static final maskDate = new MaskTextInputFormatter(
    mask: '##\/##\/####',
    filter: {"#": RegExp(r'[0-9]')},
  );

  static final maskTime = MaskTextInputFormatter(
    mask: '2#:5#',
    filter: {
      "#": RegExp(r'[0-9]'),
      "5": RegExp(r'[0-5]'),
      "2": RegExp(r'[0-2]'),
    },
  );

  static final maskCPF = MaskTextInputFormatter(
    mask: '###.###.###-##',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.eager,
  );

  static final maskCEP = MaskTextInputFormatter(
    mask: '#####-###',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.eager,
  );
}
