import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:copeiros/models/user.dart';

class UserController{

    static UserController instance;

    CollectionReference userCollection;

    UserController();

    static UserController newInstance(){
      UserController mService = new UserController();
      mService.userCollection = Firestore.instance.collection('');
      return mService;
    }

    static UserController getInstance(){
      if(instance == null){
        instance = newInstance();
      }
      return instance;
    }

    /// Function to create or update users
    /// Writes to the document referred to by this [user.uid].
    /// If the document does not yet exist, it will be created.
    /// By default merge is false, the existent document will be overwriting.
    /// Returns a `DocumentReference` with the provided path.
    Future updateUserData(User user) async{
      return await userCollection.document(user.uid).setData({
          User.EMAIL : user.email,
          User.NAME : user.name ?? '',
          User.NICK_NAME : user.nickName ?? '',
          User.SEX : user.sex ?? '',
          User.AGE : user.age ?? '',
      }, merge: false);
    }

    /// Returns user by [uid]
    Future getUser(String uid) async{
      return _userFromDocument(await userCollection.document(uid).get());
    }

    /// Returns user by [uid]
    Future getUser2(String uid) async{
      userCollection.document(uid).get().whenComplete(() => null);
    }

    /// getUsersStreams to get modifications on customers
    Stream<List<User>> get usersSnapshots{
      return userCollection.snapshots().map(_userListFromSnapshot);
    }

    /// getUserStreams to get modifications of customer by [uid]
    Stream<User> getUserSnapshots(String uid){
      return userCollection.document(uid).snapshots().map(_userFromDocument);
    }

    /// Convert [querySnapshot] into [User]
    List<User> _userListFromSnapshot(QuerySnapshot querySnapshot){
      return querySnapshot.documents.map((doc){
        return _userFromDocument(doc);
      }).toList();
    }

    /// Convert [documentSnapshot] into [User]
    User _userFromDocument(DocumentSnapshot documentSnapshot){
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