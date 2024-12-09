import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:shoppinglist_manager/model/article.dart';
import 'package:shoppinglist_manager/model/shoppinglist.dart';

class GestionCourseDatabaseManager {
  static final GestionCourseDatabaseManager instance = GestionCourseDatabaseManager._internal();

  static Database? _database;

  GestionCourseDatabaseManager._internal();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'gestion_course.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDatabase,
    );
  }

  Future<void> _createDatabase(Database db, _) async {
    await db.execute('''
        CREATE TABLE ${ArticleFields.tableName} (
          ${ArticleFields.id} ${ArticleFields.idType},
          ${ArticleFields.idshoppinglist} ${ArticleFields.intType},
          ${ArticleFields.quantite} ${ArticleFields.intType},
          ${ArticleFields.familleproduit} ${ArticleFields.textType},
          ${ArticleFields.nom} ${ArticleFields.textType},
          ${ArticleFields.createdTime} ${ArticleFields.textType},
          ${ArticleFields.status} ${ArticleFields.intType},
          FOREIGN KEY(${ArticleFields.idshoppinglist}) REFERENCES ${ShoppingListFields.tableName}(${ShoppingListFields.id})
        )
      ''');

      await db.execute('''
        CREATE TABLE ${ShoppingListFields.tableName} (
          ${ShoppingListFields.id} ${ShoppingListFields.idType},
          ${ShoppingListFields.nom} ${ShoppingListFields.textType},
          ${ShoppingListFields.dateretrait} ${ShoppingListFields.textType},
          ${ShoppingListFields.createdTime} ${ShoppingListFields.textType}
        )
      ''');
  }

  Future<Article> createArticle(Article article) async {
    final db = await instance.database;
    final id = await db.insert(ArticleFields.tableName, article.toJson());
    return article.copy(id: id);
  }

  Future<Shoppinglist> createShoppingList(Shoppinglist shoppinglist) async {
    final db = await instance.database;
    final id = await db.insert(ShoppingListFields.tableName, shoppinglist.toJson());
    return shoppinglist.copy(id: id);
  }

  Future<Article> readArticle(int id) async {
    final db = await instance.database;
    final maps = await db.query(
      ArticleFields.tableName,
      columns: ArticleFields.values,
      where: '${ArticleFields.id} = ?',
      whereArgs: [id],
    );
    

    if (maps.isNotEmpty) {
      return Article.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<Shoppinglist> readShoppingList(int id) async {
    final db = await instance.database;
    final maps = await db.query(
      ShoppingListFields.tableName,
      columns: ShoppingListFields.values,
      where: '${ShoppingListFields.id} = ?',
      whereArgs: [id],
    );
    
    if (maps.isNotEmpty) {
      return Shoppinglist.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<Article>> readAllArticle(int idshoppinglist) async {
    final db = await instance.database;
    const orderBy = '${ArticleFields.createdTime}, ${ArticleFields.status} DESC';
  
    final result = await db.query(ArticleFields.tableName, 
                                  orderBy: orderBy,
                                  where: '${ArticleFields.idshoppinglist} = ?',
                                  whereArgs: [idshoppinglist],);
    return result.map((json) => Article.fromJson(json)).toList();
  }

  Future<List<Shoppinglist>> readAllShoppingList() async {
    final db = await instance.database;
    const orderBy = '${ShoppingListFields.createdTime} DESC';
    final result = await db.query(ShoppingListFields.tableName, orderBy: orderBy);
    return result.map((json) => Shoppinglist.fromJson(json)).toList();
  }

  Future<int> updateArticle(Article article) async {
    final db = await instance.database;
    return db.update(
      ArticleFields.tableName,
      article.toJson(),
      where: '${ArticleFields.id} = ?',
      whereArgs: [article.id],
    );
  }

  Future<int> updateShoppingList(Shoppinglist shoppinglist) async {
    final db = await instance.database;
    return db.update(
      ShoppingListFields.tableName,
      shoppinglist.toJson(),
      where: '${ShoppingListFields.id} = ?',
      whereArgs: [shoppinglist.id],
    );
  }

  Future<int> updateStatus(int id, bool status) async {
    final db = await instance.database;
    return db.update(
        ArticleFields.tableName,
        {
          'status': status ? 1 : 0,
        },
        where: '${ArticleFields.id} = ?',
        whereArgs: [id]);
  
    /*return db.update(
      ArticleFields.tableName,
      article.toJson(),
      where: '${ArticleFields.id} = ?',
      whereArgs: [article.id],
    );*/
  }

  Future<int> deleteArticle(int? id) async {
    final db = await instance.database;
    return await db.delete(
      ArticleFields.tableName,
      where: '${ArticleFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteShoppingList(int? id) async {
    final db = await instance.database;
    await db.delete(
      ArticleFields.tableName,
      where: '$ArticleFields.idshoppinglist} = ?',
      whereArgs: [id],
    );
    return await db.delete(
      ShoppingListFields.tableName,
      where: '${ShoppingListFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}