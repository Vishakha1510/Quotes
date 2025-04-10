import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:quotes_app/helpers/database_helper.dart';
import 'package:quotes_app/models/quote_model.dart';

Future<void> loadQuotesFromJson() async {
  List<QuoteModel> existingQuotes = await DbHelper.dbHelper.fetchAllQuotes();
  if (existingQuotes.isNotEmpty) return;

  String jsonString = await rootBundle.loadString('assets/data.json');
  List<dynamic> jsonList = jsonDecode(jsonString);

  List<QuoteModel> quotes =
      jsonList
          .map(
            (e) => QuoteModel(
              quote: e['quote'],
              author: e['author'],
              category: e['category'],
            ),
          )
          .toList();

  for (var quote in quotes) {
    await DbHelper.dbHelper.insertQuote(quote);
  }

  print("Quotes loaded from JSON into SQLite");
}
