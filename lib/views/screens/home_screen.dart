import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quotes_app/contollers/json_controller.dart';
import 'package:quotes_app/helpers/database_helper.dart';
import 'package:quotes_app/models/quote_model.dart';
import 'package:quotes_app/views/screens/detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<List<QuoteModel>>? allQuotes;
  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    await loadQuotesFromJson();
    setState(() {
      allQuotes = DbHelper.dbHelper.fetchAllQuotes();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("All Quotes"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Get.toNamed('/fav');
            },
            icon: Icon(Icons.favorite),
          ),
          IconButton(
            onPressed: () {
              (Get.isDarkMode == false)
                  ? Get.changeTheme(ThemeData.dark())
                  : Get.changeTheme(ThemeData.light());
            },
            icon: Icon(Icons.light_mode_outlined),
          ),
        ],
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: OutlinedButton.icon(
                onPressed: () {},
                label: Text("Add Quote"),
                icon: Icon(Icons.add),
              ),
            ),
            Expanded(
              flex: 15,
              child: FutureBuilder(
                future: allQuotes,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text("Something went wrong"));
                  } else if (snapshot.hasData) {
                    List<QuoteModel> quotes = snapshot.data!;
                    return ListView.builder(
                      itemCount: quotes.length,
                      itemBuilder: (context, index) {
                        return Card(
                          margin: EdgeInsets.all(8),
                          child: ListTile(
                            onTap: () {
                              Get.to(
                                () => QuoteDetailScreen(quote: quotes[index]),
                              );
                            },

                            title: Text(quotes[index].quote),
                            subtitle: Text("- ${quotes[index].author}"),
                            trailing: Text(quotes[index].category),
                          ),
                        );
                      },
                    );
                  } else {
                    return Center(child: Text("No quotes found"));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
