class Name{
  String UserName;


  Name({required this.UserName});







  factory Name.fromFirestore(snapshot, options){

    final data = snapshot.data();
    return Name(

      UserName: data?['UserName']
    );
  }
}