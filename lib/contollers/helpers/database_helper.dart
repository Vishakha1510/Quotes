import 'package:path/path.dart';
import 'package:quotes_app/models/quote_model.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  DbHelper._();

  static final DbHelper dbHelper = DbHelper._();

  Database? db;

  Future<void> initDB() async {
    String directoryPath = await getDatabasesPath();

    String dbName = "quotes.db";

    String dbPath = join(directoryPath, dbName);

    db = await openDatabase(
      dbPath,
      version: 1,
      onCreate: (database, val) async {
        String query =
            "CREATE TABLE IF NOT EXISTS quotes(id INTEGER PRIMARY KEY AUTOINCREMENT, quote TEXT NOT NULL, author TEXT, category TEXT, isFavorite INTEGER DEFAULT 0);";
        await database.execute(query);
        print("=====================================");
        print("Table Created Successfully...");
        print("=====================================");
      },
    );
  }

  Future<int> insertQuote(QuoteModel quote) async {
    await initDB();
    return await db!.insert('quotes', quote.toMap());
  }

  Future<List<QuoteModel>> fetchAllQuotes() async {
    await initDB();
    List<Map<String, dynamic>> quoteList = await db!.query('quotes');

    return quoteList.map((e) => QuoteModel.fromJson(e)).toList();
  }

  Future<int> toggleFavorite(int id, int newValue) async {
    await initDB();
    return await db!.update(
      'quotes',
      {'isFavorite': newValue},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteQuote({required int id}) async {
    await initDB();
    String query = "DELETE FROM quotes WHERE id=?;";

    List args = [id];

    int res = await db!.rawDelete(query, args);

    return res;
  }

  Future<List<QuoteModel>> fetchFavorites() async {
    await initDB();
    List<Map<String, dynamic>> favorites = await db!.query(
      'quotes',
      where: 'isFavorite = ?',
      whereArgs: [1],
    );
    return favorites.map((e) => QuoteModel.fromJson(e)).toList();
  }

  Future<List<QuoteModel>> searchQuotes({required String category}) async {
    await initDB();
    String query = "SELECT * FROM quotes WHERE category LIKE ?";
    List<Map<String, dynamic>> searchedQuotes = await db!.rawQuery(query, [
      '%$category%',
    ]);
    return searchedQuotes.map((e) => QuoteModel.fromJson(e)).toList();
  }
}
