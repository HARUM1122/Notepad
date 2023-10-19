import 'package:flutter/material.dart';
import '../providers/notes_provider.dart';
import '../screens/edit_notes_screen.dart';
import '../widgets/dialog/dialog.dart';
import 'settings_screen.dart';
import 'notes_screen.dart';
import '../widgets/action_button.dart';
import 'package:provider/provider.dart';
import '../providers/settings_provider.dart';
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}
class _HomeState extends State<Home> {
  final FocusNode _focusNode = FocusNode();
  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final NotesProvider notesProvider = Provider.of<NotesProvider>(context,listen: false);
    final SettingsProvider settingsProvider = Provider.of<SettingsProvider>(context,listen: false);
    return Scaffold(
      appBar: AppBar(
        title:Consumer<NotesProvider>(
          builder: (context,notesProv,_){
            late String title;
            if(notesProv.startSelecting){
              final int length = notesProv.selectedNotes.length;
              title = "Selected $length ${length==1?'note':'notes'}";
            }
            else{
              title = notesProv.currentCategory!=null?
              notesProv.categories[notesProv.currentCategory]!:"Settings";
            }
            return Visibility(
              visible:!notesProv.search,
              child: Text(
                title,
                style:Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontSize:!notesProv.startSelecting?32:20
                )
              ),
            );
          }
        ),
        actions:[
          Consumer<NotesProvider>(
            builder:(context,notesProv,_)=>
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ActionButton(
                  visible:!notesProv.search&&notesProv.currentCategory!=null&&!notesProv.startSelecting,
                  icon:Icons.search_outlined,
                  size:30,
                  pressed:(){
                    notesProv.toggleBool(varName:'search');
                    _focusNode.requestFocus();
                  },
                  color:Theme.of(context).textTheme.titleLarge!.color!
                ),
                ActionButton(
                  visible:notesProv.search,
                  icon:Icons.close_outlined,
                  size:26,
                  pressed:(){
                    notesProv.toggleBool(varName:'search',notify: false);
                    notesProv.getNotes();
                  },
                  color:Theme.of(context).textTheme.titleLarge!.color!
                ),
                ActionButton(
                  visible:notesProv.currentCategory==2&&notesProv.startSelecting,
                  icon:Icons.recycling_outlined,
                  size:26,
                  pressed:(){
                    final int length = notesProv.selectedNotes.length;
                    final String msg = "Recycle $length ${length==1?'note':'notes'}";
                    showDialogBox(context, QuestionDialog(title:"Are you sure?",message:msg,pressed:(){
                      notesProv.recycleSelectedNotes();
                      Navigator.pop(context);
                    }));
                  },
                  color:Theme.of(context).textTheme.titleLarge!.color!
                ),
                ActionButton(
                  visible:notesProv.startSelecting,
                  icon:Icons.delete_outline,
                  size:26,
                  pressed:(){
                    final int length = notesProvider.selectedNotes.length;
                    final String msg = notesProvider.currentCategory==2?"Permanently delete $length ${length==1?'note':'notes'}":"Move $length ${length==1?'note':'notes'} to trash";
                    showDialogBox(context,QuestionDialog(title:"Are you sure?",message: msg, pressed:(){
                      notesProv.deleteSelectedNotes();
                      Navigator.pop(context);
                    }));
                  },
                  color:Theme.of(context).textTheme.titleLarge!.color!
                ),
                Visibility(
                  visible:notesProv.search &&!notesProv.startSelecting,
                  child: Container(
                    padding:const EdgeInsets.only(right:26),
                    width:296,
                    height:40,
                    child: TextField(
                      style:Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontSize:16
                      ),
                      focusNode: _focusNode,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.only(top:4,left:10),
                        hintText:"Search",
                        hintStyle:Theme.of(context).textTheme.labelSmall!.copyWith(
                          fontSize:16,
                          fontWeight: FontWeight.w600
                        ),
                        fillColor: Theme.of(context).cardColor,
                        filled: true,
                        border:const OutlineInputBorder(
                          borderSide: BorderSide.none
                        )
                      ),
                      onChanged: (text)=>notesProv.searchNotes(text),
                    ),
                  ),
                ),
              ],
            ),
          )
        ]
      ),
      body:Padding(
        padding: const EdgeInsets.only(left:6,right:6,top:6,bottom:32),
        child:PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: notesProvider.controller,
          children: [
            const NotesScreen(),
            SettingsScreen(settingsProvider:settingsProvider)
          ],
        )
        ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: ()=>Navigator.push(context,MaterialPageRoute(builder: (context)=>const EditNotesScreen())),
        backgroundColor: const Color.fromRGBO(111, 111, 198, 1),
        child:const Icon(
          Icons.add,
          size:30
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        notchMargin: 8.0,
        shape:const CircularNotchedRectangle(),
        color:Theme.of(context).cardColor,
        child:SizedBox(
          height:50,
          child: Consumer<NotesProvider>(
            builder: (context,notesProv,child)=>
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const SizedBox(width:15),
                BottomNavButton(
                  icon:notesProv.currentCategory==0?Icons.description:Icons.description_outlined,
                  title: "All notes",
                  color:notesProv.currentCategory==0?const Color.fromRGBO(111, 111, 198, 1):Theme.of(context).textTheme.labelSmall!.color!,
                  pressed: (){
                    notesProv.changeCategory(0);
                    notesProv.search=false;
                  },
                ),
                const SizedBox(width:25),
                BottomNavButton(
                  icon:notesProv.currentCategory==1?Icons.favorite:Icons.favorite_outline,
                  title: "Favorites",
                  color:notesProv.currentCategory==1?const Color.fromRGBO(111, 111, 198, 1):Theme.of(context).textTheme.labelSmall!.color!,
                  pressed: (){
                    notesProv.changeCategory(1);
                    notesProv.search=false;
                  },
                ),
                const Spacer(),
                BottomNavButton(
                  icon:notesProv.currentCategory==2?Icons.delete:Icons.delete_outlined,
                  title: "Trash",
                  color:notesProv.currentCategory==2?const Color.fromRGBO(111, 111, 198, 1):Theme.of(context).textTheme.labelSmall!.color!,
                  pressed: (){
                    notesProv.changeCategory(2);
                    notesProv.search=false;
                  },
                ),
                const SizedBox(width:40),
                BottomNavButton(
                  icon:notesProv.currentCategory==null?Icons.settings:Icons.settings_outlined,
                  title: "Settings",
                  color:notesProv.currentCategory==null?const Color.fromRGBO(111, 111, 198, 1):Theme.of(context).textTheme.labelSmall!.color!,
                  pressed: (){
                    notesProv.changeCategory(null);
                    notesProv.search=false;
                  },
                ),
                const SizedBox(width:15),
              ],
            ),
          ),
        )
      ),
    );
  }
}


class BottomNavButton extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color color;
  final Function() pressed;
  const BottomNavButton({
    required this.icon,
    required this.title,
    required this.color,
    required this.pressed,
    super.key
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:pressed,
      child:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color:color,
            size:30
          ),
          Text(
            title,
            style:Theme.of(context).textTheme.labelSmall
          )
        ],
      ),
    );
  }
}