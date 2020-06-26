import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:copeiros/models/user.dart';

class UserService{

    final CollectionReference userCollection = Firestore.instance.collection('users');

    UserService();

    /// Function to create or update users
    /// Writes to the document referred to by this [user.uid].
    /// If the document does not yet exist, it will be created.
    /// By default merge is false, the existent document will be overwriting.
    /// Returns a `DocumentReference` with the provided path.
    Future updateUserData(User user) async{
      return await userCollection.document(user.uid).setData(user.toMap(), merge: false);
    }

    /// Returns user by [uid]
    Future getUser(String uid) async{
      //Estudar como usar retornos com Future
        userCollection.document(uid).get().then((DocumentSnapshot documentSnapshot) {
           userFromDocument(documentSnapshot);
        });
    }

    /// Returns user by [uid]
    Future getUser2(String uid) async{
      userCollection.document(uid).get().whenComplete(() => null);
    }

    /// getUsersStreams to get modifications on customers
    Stream<List<User>> get usersSnapshots{
      return userCollection.snapshots().map(userListFromSnapshot);
    }

    /// getUserStreams to get modifications of customer by [uid]
    Stream<User> getUserSnapshots(String uid){
      return userCollection.document(uid).snapshots().map(userFromDocument);
    }

    /// Convert [querySnapshot] into [User]
    static List<User> userListFromSnapshot(QuerySnapshot querySnapshot){
      if(querySnapshot == null) return null;
      return querySnapshot.documents.map((doc){
        return userFromDocument(doc);
      }).toList();
    }

    /// Convert [documentSnapshot] into [User]
    static User userFromDocument(DocumentSnapshot documentSnapshot){
      if(documentSnapshot == null) return null;
      return User(
        uid: documentSnapshot.documentID,
        email: documentSnapshot.data[User.EMAIL] ?? '',
        name: documentSnapshot.data[User.NAME] ?? '',
        nickName: documentSnapshot.data[User.NICK_NAME] ?? '',
        sex: documentSnapshot.data[User.SEX] ?? '',
        age: documentSnapshot.data[User.AGE] ?? '',
      );
    }
}