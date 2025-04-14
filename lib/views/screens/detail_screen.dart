import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quotes_app/contollers/helpers/database_helper.dart';
import 'package:quotes_app/models/quote_model.dart';

class QuoteDetailScreen extends StatefulWidget {
  final QuoteModel quote;

  const QuoteDetailScreen({super.key, required this.quote});

  @override
  State<QuoteDetailScreen> createState() => _QuoteDetailScreenState();
}

class _QuoteDetailScreenState extends State<QuoteDetailScreen> {
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
              '"${widget.quote.quote}"',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              "- ${widget.quote.author}",
              style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
            ),
            SizedBox(height: 16),
            Text("Category: ${widget.quote.category}"),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton.icon(
                  onPressed: () async {
                    int result = await DbHelper.dbHelper.deleteQuote(
                      id: widget.quote.id!,
                    );

                    if (result > 0) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Quote deleted successfully")),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Failed to delete quote")),
                      );
                    }

                    Get.back(); // Go back after deletion
                  },
                  icon: Icon(Icons.delete),
                  label: Text("Delete"),
                ),

                ElevatedButton.icon(
                  onPressed: () async {
                    int newValue = widget.quote.isFavorite == 1 ? 0 : 1;
                    await DbHelper.dbHelper.toggleFavorite(
                      widget.quote.id!,
                      newValue,
                    );
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
