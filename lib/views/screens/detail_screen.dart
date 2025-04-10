import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quotes_app/helpers/database_helper.dart';
import 'package:quotes_app/models/quote_model.dart';

class QuoteDetailScreen extends StatelessWidget {
  final QuoteModel quote;

  const QuoteDetailScreen({super.key, required this.quote});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Quote Details")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '"${quote.quote}"',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              "- ${quote.author}",
              style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
            ),
            SizedBox(height: 16),
            Text("Category: ${quote.category}"),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton.icon(
                  onPressed: () async {
                    DbHelper.dbHelper.deleteQuote(quote.id!);

                    Get.back();
                  },
                  icon: Icon(Icons.delete),
                  label: Text("Delete"),
                ),
                ElevatedButton.icon(
                  onPressed: () async {
                    int newValue = quote.isFavorite == 1 ? 0 : 1;
                    await DbHelper.dbHelper.toggleFavorite(quote.id!, newValue);
                    Get.back();
                    Get.snackbar(
                      "SUCCESS",
                      "Added to Favuorites",
                      colorText: Colors.white,
                      backgroundColor: Colors.green,
                      snackPosition: SnackPosition.BOTTOM,
                    );
                  },

                  icon: Icon(Icons.favorite_border),
                  label: Text("Favorite"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
