class Shoppinglist  {
   int id;
  final String nom;
  final DateTime? dateretrait;
  final DateTime? createdTime;

  Shoppinglist({this.dateretrait, required this.id, this.createdTime, required this.nom});

  List<Shoppinglist> shoppinglist = [];

  Shoppinglist copy({
    int? id,
    String? nom,
    DateTime? dateretrait,
    DateTime? createdTime,
  }) =>
      Shoppinglist(
        id: id ?? this.id,
        nom: nom ?? this.nom,
        dateretrait: dateretrait ?? this.dateretrait,
        createdTime: createdTime ?? this.createdTime,
      );

  Map<String, Object?> toJson() => {
        //ArticleFields.id: id,
        ShoppingListFields.nom: nom,
        ShoppingListFields.dateretrait: dateretrait?.toIso8601String(),
        ShoppingListFields.createdTime: createdTime?.toIso8601String(),
      };

  factory Shoppinglist.fromJson(Map<String, Object?> json) => Shoppinglist(
        id: json[ShoppingListFields.id] as int,
        nom: json[ShoppingListFields.nom] as String,
        dateretrait: DateTime.tryParse(json[ShoppingListFields.dateretrait] as String? ?? ''),
        createdTime: DateTime.tryParse(json[ShoppingListFields.createdTime] as String? ?? ''),
      );
}

class ShoppingListFields {
  static const String tableName = 'shoppinglist';
  static const String idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
  static const String textType = 'TEXT NOT NULL';
  static const String intType = 'INTEGER NOT NULL';
  static const String id = '_id';
  static const String nom = 'nom';
  static const String dateretrait = 'date_retrait';
  static const String createdTime = 'created_time';

  static const List<String> values = [
    id,
    nom,
    dateretrait,
    createdTime
  ];
}