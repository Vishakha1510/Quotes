import 'package:flutter/material.dart';
import 'package:quotes_app/contollers/helpers/database_helper.dart';
import 'package:quotes_app/models/quote_model.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Favorite Quotes"), centerTitle: true),
      body: FutureBuilder<List<QuoteModel>>(
        future: DbHelper.dbHelper.fetchFavorites(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Something went wrong"));
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            List<QuoteModel> favQuotes = snapshot.data!;
            return ListView.builder(
              itemCount: favQuotes.length,
              itemBuilder: (context, index) {
                QuoteModel quote = favQuotes[index];
                return Card(
                  margin: EdgeInsets.all(8),
                  child: ListTile(
                    title: Text(
                      '"${quote.quote}"',
                      style: TextStyle(fontSize: 16),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 4),
                        Text("- ${quote.author}"),
                        Text("Category: ${quote.category}"),
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(child: Text("No favorites found"));
          }
        },
      ),
    );
  }
}
