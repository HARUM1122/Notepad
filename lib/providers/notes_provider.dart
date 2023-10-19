import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io' show Directory;
import 'dart:async' show Timer;
import '../models/notes_model.dart';
class NotesProvider extends ChangeNotifier{
  final PageController controller = PageController();
  int? currentCategory = 0;
  final Map<int,String> categories = {
    0:"All Notes",
    1:"Favorites",
    2:"Trash",
  };
  bool isLoading = true;
  bool isFavorite = false;
  bool search = false;
  bool startSelecting=false;
  Timer? debounce;
  List<Note> data = [];
  final Set<int> selectedNotes = {};
  Future<Database>? _db;
  Future<Database> get database async{
    if(_db!=null)return _db!;
    return initDataBase();
  }
  Future<Database> initDataBase()async{
    final Directory dir = await getApplicationDocumentsDirectory();
    final String path = join(dir.path,"notes_data.db");
    return await openDatabase(path,version:1,onCreate:(Database db, int version)async{
      await db.execute("CREATE TABLE notes_table (id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, desc TEXT, date_created TEXT, date_modified, category INTEGER)");
    });
  }
  void searchNotes(String searchTerm){
    if(!isLoading){
      isLoading=true;
      notifyListeners();
    }
    if(debounce?.isActive??false)debounce!.cancel();
    debounce = Timer(const Duration(milliseconds: 600),()=>getNotes(searchTerm));
  }
  void changeCategory(int? category){
    if(category==null){
      controller.jumpToPage(1);
    }
    else if(currentCategory==null){
      controller.jumpToPage(0);
    }
    currentCategory = category;
    isLoading=true;
    getNotes();
  }
  void toggleBool({String varName='',bool notify=true}){
    if(varName=="search"){
      search=!search;
    }
    else if(varName == 'select'){
      startSelecting=!startSelecting;
    }
    else{
      isFavorite=!isFavorite;
    }
    if(notify)notifyListeners();
  }
  bool selectDeselect(int index){
    if(selectedNotes.contains(index)){
      if(selectedNotes.length==1){
        startSelecting=false;
      }
      selectedNotes.remove(index);
    }
    else{
      if(selectedNotes.length==100)return false;
      selectedNotes.add(index);
    }
    notifyListeners();
    return true;
  }
  Future<void> insert(Note note)async{
    final Database db = await database;
    await db.insert('notes_table',note.toMap(),conflictAlgorithm: ConflictAlgorithm.replace);
    getNotes();
  }
  Future<void> update(int id, Note note)async{
    final Database db = await database;
    await db.update("notes_table",note.toMap(),where:'id = ?',whereArgs:[id]);
    getNotes();
  }
  Future<void> delete(int id)async{
    final Database db = await database;
    await db.delete('notes_table',where:'id = ?',whereArgs:[id]);
    getNotes();
  }
  Future<void>deleteSelectedNotes()async{
    final Database db = await database;
    for(final int index in selectedNotes){
      if(data[index].category==2){
        await db.delete('notes_table',where:'id = ?',whereArgs:[data[index].id]);
      }
      else{
        data[index].category = 2;
        await db.update('notes_table',data[index].toMap(),where:'id = ?',whereArgs:[data[index].id]);
      }
    }
    startSelecting=false;
    selectedNotes.clear();
    getNotes();
  }
  Future<void> recycleSelectedNotes()async{
    final Database db = await database;
    for(final int index in selectedNotes){
      data[index].category=0;
      await db.update('notes_table',data[index].toMap(),where:'id=?',whereArgs:[data[index].id]);
    }
    startSelecting=false;
    selectedNotes.clear();
    getNotes();
  }
  Future<void> getNotes([String searchTerm=''])async{
    searchTerm = searchTerm.toLowerCase();
    final Database db = await database;
    final List<Map<String,Object?>> noteData = await db.query('notes_table');
    final List<Note> notes = noteData.map((data)=>Note.fromMap(data)).toList();
    if(currentCategory==0){
      data = notes.where((data)=>const[0,1].contains(data.category)&&data.title.toLowerCase().contains(searchTerm)).toList();
    }
    else if(currentCategory==1){
      data = notes.where((data)=>data.category==1&&data.title.toLowerCase().contains(searchTerm)).toList();
    }
    else if(currentCategory==2){
      data = notes.where((data)=>data.category==2&&data.title.toLowerCase().contains(searchTerm)).toList();
    }
    else data=[];
    isLoading = false;
    notifyListeners();
  }
}