import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class WorkoutBuilerPage extends StatefulWidget {
  const WorkoutBuilerPage({super.key});

  @override
  State<WorkoutBuilerPage> createState() => _WorkoutBuilerPageState();
}

class _WorkoutBuilerPageState extends State<WorkoutBuilerPage> {
  final CollectionReference _workouts =
      FirebaseFirestore.instance.collection('workouts');

  final _exerciseNameController = TextEditingController();
  final _exerciseSetsController = TextEditingController();
  final _exerciseRepsController = TextEditingController();

  @override
  void dispose() {
    _exerciseNameController.dispose();
    _exerciseSetsController.dispose();
    _exerciseRepsController.dispose();
    super.dispose();
  }

  // Create
  Future<void> _create([DocumentSnapshot? documentSnapshot]) async {
    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _exerciseNameController,
                  decoration: const InputDecoration(labelText: 'Exercise Name'),
                ),
                TextField(
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  controller: _exerciseSetsController,
                  decoration: const InputDecoration(
                    labelText: 'Sets',
                  ),
                ),
                TextField(
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  controller: _exerciseRepsController,
                  decoration: const InputDecoration(
                    labelText: 'Reps',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  child: const Text('Create'),
                  onPressed: () async {
                    final String exerciseName = _exerciseNameController.text;
                    final double? sets =
                        double.tryParse(_exerciseSetsController.text);
                    final double? reps =
                        double.tryParse(_exerciseRepsController.text);
                    if (sets != null) {
                      await _workouts.add({
                        "exerciseName": exerciseName,
                        "sets": sets,
                        "reps": reps
                      });

                      _exerciseNameController.text = '';
                      _exerciseSetsController.text = '';
                      _exerciseRepsController.text = '';
                      Navigator.of(context).pop();
                    }
                  },
                )
              ],
            ),
          );
        });
  }

  //Update
  Future<void> _update([DocumentSnapshot? documentSnapshot]) async {
    if (documentSnapshot != null) {
      _exerciseNameController.text = documentSnapshot['exerciseName'];
      _exerciseSetsController.text = documentSnapshot['sets'].toString();
      _exerciseRepsController.text = documentSnapshot['reps'].toString();
    }

    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _exerciseNameController,
                  decoration: const InputDecoration(labelText: 'Exercise Name'),
                ),
                TextField(
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  controller: _exerciseSetsController,
                  decoration: const InputDecoration(
                    labelText: 'Sets',
                  ),
                ),
                TextField(
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  controller: _exerciseRepsController,
                  decoration: const InputDecoration(
                    labelText: 'Reps',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  child: const Text('Update'),
                  onPressed: () async {
                    final String exerciseName = _exerciseNameController.text;
                    final double? sets =
                        double.tryParse(_exerciseSetsController.text);
                    final double? reps =
                        double.tryParse(_exerciseRepsController.text);
                    if (sets != null) {
                      await _workouts.doc(documentSnapshot!.id).update({
                        "exerciseName": exerciseName,
                        "sets": sets,
                        "reps": reps
                      });
                      _exerciseNameController.text = '';
                      _exerciseSetsController.text = '';
                      _exerciseRepsController.text = '';
                      Navigator.of(context).pop();
                    }
                  },
                )
              ],
            ),
          );
        });
  }

  //delete
  Future<void> _delete(String productId) async {
    await _workouts.doc(productId).delete();

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('You have successfully deleted an exercise')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[300],
        body: StreamBuilder(
          stream: _workouts.snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
            if (streamSnapshot.hasData) {
              return ListView.builder(
                itemCount: streamSnapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final DocumentSnapshot documentSnapshot =
                      streamSnapshot.data!.docs[index];
                  return Card(
                      margin: EdgeInsets.all(10),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                            title: Text(documentSnapshot['exerciseName']),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Sets: ' +
                                    documentSnapshot['sets'].toString()),
                                Text('Reps: ' +
                                    documentSnapshot['reps'].toString()),
                              ],
                            ),
                            trailing: SizedBox(
                              width: 100,
                              child: Row(children: [
                                IconButton(
                                  icon: Icon(Icons.edit),
                                  onPressed: () => _update(documentSnapshot),
                                ),
                                IconButton(
                                    icon: const Icon(Icons.delete),
                                    onPressed: () =>
                                        _delete(documentSnapshot.id)),
                              ]),
                            )),
                      ));
                },
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blueGrey,
          onPressed: () => _create(),
          child: const Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat);
  }
}

// class WorkoutBuilerPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         height: double.infinity,
//         width: double.infinity,
//         padding: const EdgeInsets.all(20),
//         child: Text('2')
//         // Column(
//         //   crossAxisAlignment: CrossAxisAlignment.center,
//         //   mainAxisAlignment: MainAxisAlignment.center,
//         //   children: <Widget>[
//         //     _userUid(),
//         //     _signOutButton(),
//         //   ],
//         // ),
//         );
//   }
// }
