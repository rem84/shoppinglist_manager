import 'package:flutter/material.dart';
import 'package:shoppinglist_manager/model/article.dart';
import 'package:shoppinglist_manager/database/gestioncoursedatabasemanager.dart';
import 'package:shoppinglist_manager/utils/constant.dart';

class ListArticleScreen extends StatefulWidget {
  final int idshoppinglist;
  
  const ListArticleScreen({super.key, required this.idshoppinglist});

  @override
  State<ListArticleScreen> createState() => _ListArticleScreenState();
}

class _ListArticleScreenState extends State<ListArticleScreen> {
  // TextEditingController is used to control the text field.
  final TextEditingController _nomcontroller = TextEditingController();
  final TextEditingController _quantitecontroller = TextEditingController();

  //helper is the instance of the SqfliteHelper class.
  //SqfliteHelper helper = SqfliteHelper();
  //SqfliteHelper helper = SqfliteHelper();
  GestionCourseDatabaseManager gestionCourseDatabaseManager = GestionCourseDatabaseManager.instance;
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Liste des articles')),
        body: FutureBuilder(
            //helper.getTasks() returns a Future<List<Map<String, dynamic>>>.
            future: gestionCourseDatabaseManager.readAllArticle(widget.idshoppinglist),//.getTasks(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                //snapshot.data is the list of tasks that we get from the database.
                return ListView.builder(
                    itemCount: snapshot.data?.length ?? 0,
                    itemBuilder: (context, index) {
                      return ListTile(
                          leading:  
                          Checkbox(
                              //We use 1 for true and 0 for false.
                              value: snapshot.data![index].status,
                              onChanged: (value) async {
                                //updateTask method takes the id of the task and the status to be updated.
                                await gestionCourseDatabaseManager.updateStatus(snapshot.data![index].id, value! //update(snapshot.data![index]
                                  //Article(id: snapshot.data![index].id, status : snapshot.data?[index].status, nom: snapshot.data![index].nom, quantite: snapshot.data![index].quantite,familleProduit: FamilleProduit.animal.nom)
                                  );
                                    //snapshot.data?[index]['id'], value!);
                                //setState is used to update the UI.
                                setState(() {});
                              }),
                          title: Text(snapshot.data![index].nom),
                          subtitle: Text(snapshot.data![index].quantite.toString()),
                          trailing: IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () async {
                                //deleteTask method takes the id of the task to be deleted.
                                await gestionCourseDatabaseManager.deleteArticle(snapshot.data![index].id);
                                //setState is used to update the UI.
                                setState(() {});
                              }));
                    });
              }
              return const Center(child: CircularProgressIndicator());
            }),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              //showDialog is used to show a dialog box, it takes a context and a builder.
              showDialog(
                  context: context,
                  builder: (context) {
                    //AlertDialog is a dialog box with a title, content, and actions.
                    return AlertDialog(
                        title: const Text('Ajouter un article'),
                        content: Column(
                          children: [
                        TextField(
                            //autofocus is used to focus the text field when the dialog box is shown.
                            autofocus: true,
                            //controller is used to control the text field.
                            controller: _nomcontroller,
                            decoration: const InputDecoration(
                              hintText: 'Entrez le nom',
                            )),
                            TextField(
                            //autofocus is used to focus the text field when the dialog box is shown.
                            autofocus: true,
                            //controller is used to control the text field.
                            controller: _quantitecontroller,
                            decoration: const InputDecoration(
                              hintText: 'Entrez la quantite',
                            ))]),                            
                        actions: [
                          TextButton(
                              onPressed: () {
                                //Navigator.pop is used to close the dialog box.
                                Navigator.pop(context);
                              },
                              child: const Text('Annuler')),
                          TextButton(
                              onPressed: () async {
                                //insertTask method takes the title of the task and the status.
                                await gestionCourseDatabaseManager.createArticle(Article(status: false, nom: _nomcontroller.text, quantite: int.parse(_quantitecontroller.text),familleProduit: FamilleProduit.animal.nom, createdTime: DateTime.now(), id: 0, idshoppinglist: widget.idshoppinglist));
                                //clear is used to clear the text field.
                                _nomcontroller.clear();
                                _quantitecontroller.clear();
                                //here we are checking if the widget is mounted before popping the dialog box.
                                //because we are using context in async functions.
                                if (context.mounted) {
                                  Navigator.pop(context);
                                }
                                //setState is used to update the UI.
                                setState(() {});
                              },
                              child: const Text('Ajouter'))
                        ]);
                  });
            },
            child: const Icon(Icons.add)));
  }
}
