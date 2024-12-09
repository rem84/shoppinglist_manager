class Article  {
  int id;
  final String nom;
  final int? quantite;
  final String? familleProduit;
  final DateTime? createdTime;
  final bool? status;
  int idshoppinglist;

  Article({required this.id, required this.idshoppinglist, this.createdTime, required this.nom, this.quantite, this.familleProduit, this.status});

  List<Article> articles = [];

  Article copy({
    int? id,
    String? nom,
    int? quantite,
    String? familleProduit,
    DateTime? createdTime,
    bool? status,
    int? idshoppinglist,
  }) =>
      Article(
        id: id ?? this.id,
        nom: nom ?? this.nom,
        quantite: quantite ?? this.quantite,
        familleProduit: familleProduit ?? this.familleProduit,
        createdTime: createdTime ?? this.createdTime,
        status: status ?? this.status,
        idshoppinglist: idshoppinglist ?? this.idshoppinglist,
      );

  Map<String, Object?> toJson() => {
        //ArticleFields.id: id,
        ArticleFields.nom: nom,
        ArticleFields.quantite: quantite,
        ArticleFields.familleproduit: familleProduit,
        ArticleFields.createdTime: createdTime?.toIso8601String(),
        ArticleFields.status : status == true ? 1 : 0,
        ArticleFields.idshoppinglist : idshoppinglist,
      };

  factory Article.fromJson(Map<String, Object?> json) => Article(
        id: json[ArticleFields.id] as int,
        nom: json[ArticleFields.nom] as String,
        quantite: json[ArticleFields.quantite] as int,
        familleProduit: json[ArticleFields.familleproduit] as String,
        createdTime: DateTime.tryParse(json[ArticleFields.createdTime] as String? ?? ''),
        status: json[ArticleFields.status] == 1 ? true : false,
        idshoppinglist: json[ArticleFields.idshoppinglist] as int,
      );
}

class ArticleFields {
  static const String tableName = 'article';
  static const String idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
  static const String idTypefk = 'INTEGER FOREIGN KEY';
  static const String textType = 'TEXT NOT NULL';
  static const String intType = 'INTEGER NOT NULL';
  static const String id = '_id';
  static const String idshoppinglist = '_idshoppinglist';
  static const String quantite = 'quantite';
  static const String nom = 'nom';
  static const String familleproduit = 'familleproduit';
  static const String createdTime = 'created_time';
  static const String status = 'status';

  static const List<String> values = [
    id,
    quantite,
    nom,
    familleproduit,
    createdTime,
    status,
    idshoppinglist,
  ];
}