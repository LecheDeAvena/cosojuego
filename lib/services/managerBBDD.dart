import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:incremental_game/services/account.dart';

class DatabaseManager {
  final CollectionReference profileList =
      FirebaseFirestore.instance.collection('Datos');

  Future<void> createUserData(String name, int score, String uid) async {
    return await profileList.doc(uid).set({'name': name, 'score': score});
  }

  Future updateUserList(
      String name,
      int score,
      int clcks,
      int loop,
      int mUp1,
      int mUp2,
      int mUp3,
      int mUp4,
      int rScore,
      int tClclks,
      int tScore,
      int up1,
      int up2,
      int up3,
      int up4,
      String uid) async {
    return await profileList.doc(uid).update({
      'name': name,
      'score': score,
      'clicks': clcks,
      'loops': loop,
      'maxUpgrade1': mUp1,
      'maxUpgrade2': mUp2,
      'maxUpgrade3': mUp3,
      'maxUpgrade4': mUp4,
      'recordScore': rScore,
      'totalClicks': tClclks,
      'totalScore': tScore,
      'upgrade1': up1,
      'upgrade2': up2,
      'upgrade3': up3,
      'upgrade4': up4
    });
  }

  Future<Map<String, dynamic>> getUserInfo(String uid) async {
    Map<String, dynamic> itemsList = <String, dynamic>{'name': 'nadie'};
    try {
      await profileList.doc(FirebaseAuth.instance.currentUser!.uid).get().then(
        (DocumentSnapshot doc) {
          if (doc.exists) {
            final datos = doc.data() as Map<String, dynamic>;
            //itemsList = data;
            itemsList.clear();
            itemsList.addEntries(datos.entries);

            return itemsList;
          }
        },
        onError: (e) => print("Error getting document: $e"),
      );
    } catch (e) {
      print('ERROR PILLANDO LOS DATO');
    }
    //await profileList.doc(uid).get().then((querySnapshot) {
    /*await profileList.doc(Account.getuserID()).get().then((querySnapshot) {
        querySnapshot.get('name');
        print('a: ' + querySnapshot.get('name'));
      });*/

    return itemsList;
  }
}
