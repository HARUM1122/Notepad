import 'package:flutter/material.dart';
import '../providers/notes_provider.dart';
import '../providers/settings_provider.dart';
import 'package:provider/provider.dart';
import '../widgets/tiles/tiles.dart';
import 'edit_notes_screen.dart';
import '../widgets/dialog/dialog.dart' show ErrorDialog, showDialogBox;
class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});
  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  @override
  Widget build(BuildContext context) {
    Provider.of<NotesProvider>(context,listen:false).getNotes();
    return Padding(
      padding:const EdgeInsets.all(10),
      child:Consumer2<NotesProvider,SettingsProvider>(
        builder: (context,notesProv,settingsProv,child){
          if(notesProv.isLoading)return const Center(child:CircularProgressIndicator(color:Color.fromRGBO(111, 111, 198, 1)));
          if(notesProv.data.isEmpty){
            final int? category = notesProv.currentCategory;
            return Center(
              child:Text(
                const [0,1].contains(category)?'No notes':'Trash is empty',
                style:Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontSize:18
                )
              )
            );
          }
          if(settingsProv.currentView=="ListView"){
            return ListView.builder(
              physics:const BouncingScrollPhysics(),
              itemCount: notesProv.data.length,
              itemBuilder: (context,index){
                return CustomListTile(
                  onLongPress: (){
                    if(!notesProv.startSelecting){
                      notesProv.selectedNotes.add(index);
                      notesProv.search=false;
                      notesProv.toggleBool(varName: "select",notify: true);
                    }
                  },
                  selected: notesProv.selectedNotes.contains(index),
                  pressed:(){
                    if(notesProv.startSelecting){
                      if(!notesProv.selectDeselect(index)){
                        showDialogBox(context,const ErrorDialog(
                          message:"Cannot select more than 100 notes",
                        ));
                      }
                    }
                    else{
                      Navigator.push(context,MaterialPageRoute(builder: (context)=>EditNotesScreen(note:notesProv.data[index])));
                    }
                  },
                  title:notesProv.data[index].title,
                  note:notesProv.data[index].desc
                );
              }
            );
          }
          else{
            return GridView.builder(
              physics:const BouncingScrollPhysics(),
              gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 2
              ),
              itemCount: notesProv.data.length,
              itemBuilder: (context,index){
                return CustomGridTile(
                  onLongPress: (){
                    if(!notesProv.startSelecting){
                      notesProv.selectedNotes.add(index);
                      notesProv.search=false;
                      notesProv.toggleBool(varName: "select",notify: true);
                    }
                  },
                  selected: notesProv.selectedNotes.contains(index),
                  pressed:(){
                    if(notesProv.startSelecting){
                      if(!notesProv.selectDeselect(index)){
                        showDialogBox(context,const ErrorDialog(
                          message:"Cannot select more than 100 notes",
                        ));
                      }
                    }
                    else{
                      Navigator.push(context,MaterialPageRoute(builder: (context)=>EditNotesScreen(note:notesProv.data[index])));
                    }
                  },
                  title:notesProv.data[index].title,
                  note:notesProv.data[index].desc
                );
              }
            );
          }
        }
      )
    );
  }
}