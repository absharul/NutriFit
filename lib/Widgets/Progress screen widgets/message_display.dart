import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

class MessageDisplay extends StatelessWidget {
  final String message;
  final Color messageColor;

  const MessageDisplay({
    Key? key,
    required this.message,
    required this.messageColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      message,
      style: GoogleFonts.inter(
        fontSize: 18,
        color: messageColor,
      ),
    );
  }
}