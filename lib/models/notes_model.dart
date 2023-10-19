class Note{
  int? id;
  String title;
  String desc;
  int category;
  String dateModified;
  final String dateCreated;
  Note({required this.title,required this.desc,required this.category,required this.dateModified,required this.dateCreated});
  Note.fromMap(Map<String,dynamic> map):
    id = map['id'],
    title = map['title'],
    desc = map['desc'],
    category = map['category'],
    dateModified = map['date_modified'],
    dateCreated = map['date_created'];
  Map<String,Object?> toMap(){
    return {
      'id':id,
      'title':title,
      'desc':desc,
      'category':category,
      'date_modified':dateModified,
      'date_created':dateCreated,
    };
  }

}


void main(){
}