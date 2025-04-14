import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quotes_app/models/quote_model.dart';

class QuoteDetailScreen extends StatefulWidget {
  final QuoteModel quote;

  const QuoteDetailScreen({Key? key, required this.quote}) : super(key: key);

  @override
  State<QuoteDetailScreen> createState() => _QuoteDetailScreenState();
}

class _QuoteDetailScreenState extends State<QuoteDetailScreen> {
  List<String> backgrounds = [
    'assets/bg1.png',
    'assets/bg2.png',
    'assets/bg3.png',
    'assets/bg4.png',
  ];

  List<TextStyle Function()> fontStyles = [
    () => GoogleFonts.roboto(fontSize: 20, color: Colors.white),
    () => GoogleFonts.poppins(fontSize: 20, color: Colors.white),
    () => GoogleFonts.dancingScript(fontSize: 24, color: Colors.white),
    () => GoogleFonts.pacifico(fontSize: 22, color: Colors.white),
  ];

  late String selectedBg;
  late TextStyle selectedStyle;

  @override
  void initState() {
    super.initState();
    _setRandomStyle();
  }

  void _setRandomStyle() {
    final random = Random();
    selectedBg = backgrounds[random.nextInt(backgrounds.length)];
    selectedStyle = fontStyles[random.nextInt(fontStyles.length)]();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Quote Details"), actions: [
        
      ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(selectedBg),
                  fit: BoxFit.cover,
                ),
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    '"${widget.quote.quote}"\n\n- ${widget.quote.author}',
                    textAlign: TextAlign.center,
                    style: selectedStyle,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
