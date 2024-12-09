import 'package:flutter/material.dart';
import 'package:shoppinglist_manager/utils/constant.dart';
import 'package:shoppinglist_manager/database/gestioncoursedatabasemanager.dart';
import 'package:shoppinglist_manager/screens/listarticlescreen.dart';
import 'package:shoppinglist_manager/model/shoppinglist.dart';

class Shoppinglistscreen extends StatefulWidget {
  const Shoppinglistscreen({super.key});

  @override
  State<Shoppinglistscreen> createState() => _ShoppinglistscreenState();
}

class _ShoppinglistscreenState extends State<Shoppinglistscreen> {
  // TextEditingController is used to control the text field.
  final TextEditingController _nomcontroller = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  final TextEditingController _dateretraitcontroller = TextEditingController();

  GestionCourseDatabaseManager gestionCourseDatabaseManager = GestionCourseDatabaseManager.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Gestion de course partagé')),
        body: FutureBuilder(
            //helper.getTasks() returns a Future<List<Map<String, dynamic>>>.
            future: gestionCourseDatabaseManager.readAllShoppingList(),//.getTasks(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                //snapshot.data is the list of tasks that we get from the database.
                return ListView.builder(
                    itemCount: snapshot.data?.length ?? 0,
                    itemBuilder: (context, index) {
                      return ListTile(
                          /*leading:  
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
                              }), */
                          title: Text(snapshot.data![index].nom),
                          subtitle: Text('Date de retrait souhaitée : ${formatDate(snapshot.data?[index].dateretrait)}'),
                          trailing: IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () async {
                                //deleteTask method takes the id of the task to be deleted.
                                await gestionCourseDatabaseManager.deleteShoppingList(snapshot.data![index].id);
                                //setState is used to update the UI.
                                setState(() {});
                              }),
                              onTap: () =>
                              Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => ListArticleScreen(idshoppinglist: snapshot.data![index].id,),
                                              )));
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
                            controller: _dateretraitcontroller,
                            decoration: const InputDecoration(
                              hintText: 'Entrez la date de retrait',
                            ),
                            onTap: () => _selectDate(context),
                            )]),  
                                                    
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
                                await gestionCourseDatabaseManager.createShoppingList(Shoppinglist(nom : _nomcontroller.text, dateretrait: _selectedDate, createdTime: DateTime.now(), id: 0));
                                  //Article(status: false, nom: _nomcontroller.text, quantite: int.parse(_quantitecontroller.text),familleProduit: FamilleProduit.animal.nom, createdTime: DateTime.now(), id: 0));
                                //clear is used to clear the text field.
                                _nomcontroller.clear();
                                //_quantitecontroller.clear();
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

  Future _selectDate(BuildContext context) async => showDatePicker(
      context: context,
      locale : const Locale("fr", "FR"),
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2050),
      helpText: 'Sélectionner la date',
      cancelText: 'Annuler',
      confirmText: 'Valider',
      fieldHintText: 'Day/Month/Year',
      fieldLabelText: 'Date',
      errorInvalidText: 'SVP saisissez une date valide',
      errorFormatText: 'Format incorrect',
    ).then((DateTime? selected) {
      if (selected != null && selected != _selectedDate) {
        setState(() => _selectedDate = selected);
        _dateretraitcontroller.text = formatDate(_selectedDate);
      }
    }
  );
}
