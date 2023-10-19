import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/notes_model.dart';
import '../widgets/action_button.dart';
import '../providers/notes_provider.dart';
import '../widgets/dialog/dialog.dart';
class EditNotesScreen extends StatefulWidget {
  final Note? note;
  const EditNotesScreen({this.note, super.key});

  @override
  State<EditNotesScreen> createState() => _EditNotesScreenState();
}

class _EditNotesScreenState extends State<EditNotesScreen> {
  bool _saved = false;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final NotesProvider notesProvider = Provider.of<NotesProvider>(context,listen:false);
    final bool inTrash = widget.note!=null && widget.note!.category==2;
    notesProvider.search=false;
    if(widget.note!=null){
      _titleController.text = widget.note!.title;
      _descController.text = widget.note!.desc;
      notesProvider.isFavorite = widget.note!.category==1;
    }
    else{
      notesProvider.changeCategory(0);
      notesProvider.isFavorite=false;
    }
    return Scaffold(
      appBar:AppBar(
        leading:TextButton(
          style:const ButtonStyle(
            overlayColor: MaterialStatePropertyAll<Color>(Colors.transparent)
          ),
        onPressed: (){
          if(inTrash) {
            Navigator.pop(context);
            return;
          }
          final int category = notesProvider.isFavorite?1:0;
          final String title = _titleController.text;
          final String description = _descController.text;
          if(widget.note!=null){
            if(widget.note!.title!=title||widget.note!.desc!=description||widget.note!.category!=category){
              showDialogBox(context,QuestionDialog(title:"Are you sure?",message: "Quit without saving?", pressed:(){
                Navigator.pop(context);
                Navigator.pop(context);
              }));
            }
            else{
              Navigator.pop(context);
            }
          }
          else if(title.isNotEmpty || description.isNotEmpty){
            showDialogBox(context,QuestionDialog(title:"Are you sure?",message: "Quit without saving?", pressed:(){
              Navigator.pop(context);
              Navigator.pop(context);
            }));
          }
          else {
            Navigator.pop(context);
          }
        },
        child:Icon(
          Icons.keyboard_arrow_left,
          color: Theme.of(context).textTheme.titleLarge!.color,
          size:32
          )
        ),
        actions: [
          ActionButton(
            visible:inTrash,
            pressed: (){
              widget.note!.category=0;
              notesProvider.update(widget.note!.id!,widget.note!);
              Navigator.pop(context);
            },
            icon:Icons.recycling_outlined,
            size:30,
            color:Theme.of(context).textTheme.titleLarge!.color!
          ),
          ActionButton(
            visible:widget.note!=null,
            pressed: (){
              if(inTrash){
                showDialogBox(context,QuestionDialog(title:"Are you sure?",message: "Permanenty delete the note?", pressed:(){
                  notesProvider.delete(widget.note!.id!);
                  Navigator.pop(context);
                  Navigator.pop(context);
                }));
              }
              else{
                showDialogBox(context,QuestionDialog(title:"Are you sure?",message: "Move to trash?", pressed:(){
                  widget.note!.category=2;
                  notesProvider.update(widget.note!.id!,widget.note!);
                  Navigator.pop(context);
                  Navigator.pop(context);
                }));
              }
            },
            icon:Icons.delete_outlined,
            size:30,
            color:Theme.of(context).textTheme.titleLarge!.color!
          ),
          Consumer<NotesProvider>(
            builder:(context,notesProv,_)=>ActionButton(
              visible: !inTrash,
              pressed: notesProvider.toggleBool,
              icon:notesProv.isFavorite?Icons.favorite:Icons.favorite_outline,
              color:notesProv.isFavorite?const Color.fromRGBO(111, 111, 198, 1):Theme.of(context).textTheme.titleLarge!.color!,
              size:26
            )
          )
      
        ],
      ),
      body:SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child:Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller:_titleController,
                minLines: 1,
                keyboardType:TextInputType.multiline,
                maxLines:null,
                style:Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontSize:20
                ),
                decoration:InputDecoration(
                  contentPadding: EdgeInsets.zero,
                  hintText:"Title",
                  hintStyle:Theme.of(context).textTheme.labelSmall!.copyWith(
                    fontSize:20,
                    fontWeight: FontWeight.w600
                  ),
                  border:const OutlineInputBorder(
                    borderSide: BorderSide.none,
                  )
                )
              ),
              TextField(
                controller:_descController,
                minLines: 1,
                keyboardType:TextInputType.multiline,
                maxLines:null,
                style:Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontSize:18,
                  fontWeight: FontWeight.w400
                ),
                decoration:InputDecoration(
                  contentPadding: EdgeInsets.zero,
                  hintText:"Note",
                  hintStyle:Theme.of(context).textTheme.labelSmall!.copyWith(
                    fontSize:18,
                    fontWeight: FontWeight.w400
                  ),
                  border:const OutlineInputBorder(
                    borderSide: BorderSide.none,
                  )
                )
              ),
              const SizedBox(height:20),
              Divider(
                color:Theme.of(context).textTheme.titleLarge!.color
              ),
              const SizedBox(height:20),
              Text(
                "Updated: ${widget.note?.dateModified.split('.')[0]??DateTime.now().toString().split('.')[0]}",
                style:Theme.of(context).textTheme.labelSmall!.copyWith(
                  fontWeight: FontWeight.w400,
                  fontSize:12
                )
              ),
              const SizedBox(height:6),
              Text(
                "Created: ${widget.note?.dateCreated.split('.')[0]??DateTime.now().toString().split('.')[0]}",
                style:Theme.of(context).textTheme.labelSmall!.copyWith(
                  fontWeight: FontWeight.w400,
                  fontSize:12
                )
              )
            ],
          ),
        )
      ),
      floatingActionButton: Visibility(
        visible: !inTrash,
        child: FloatingActionButton(
          onPressed: (){
            if(!_saved){
              _saved=true;
              final String title = _titleController.text.trim();
              final String description = _descController.text.trim();
              final int category = notesProvider.isFavorite?1:0;
              if(widget.note==null){
                if(title.isEmpty&&description.isEmpty){
                  Navigator.pop(context);
                }
                else if(title.isEmpty||description.isEmpty){
                  showDialogBox(context,const ErrorDialog(
                    message:"Fields cannot be empty",
                  ));
                  _saved=false;
                  return;
                }
                else{
                  notesProvider.isLoading=true;
                  notesProvider.insert(
                    Note(
                      title:title,
                      desc:description,
                      category: category,
                      dateModified:DateTime.now().toString(),
                      dateCreated:DateTime.now().toString()
                    )
                  ).whenComplete(() => Navigator.pop(context)); 
                }
              }
              else if(widget.note!.title!=title||widget.note!.desc!=description||widget.note!.category!=category){
                if(title.isEmpty&&description.isEmpty){
                  notesProvider.delete(widget.note!.id!).whenComplete(() => Navigator.pop(context));
                }
                else if(title.isEmpty||description.isEmpty){
                  showDialogBox(context,const ErrorDialog(
                    message:"Fields cannot be empty",
                  ));
                  _saved=false;
                  return;
                }
                else{
                  notesProvider.isLoading=true;
                  widget.note!.title=title;
                  widget.note!.desc=description;
                  widget.note!.category=category;
                  widget.note!.dateModified=DateTime.now().toString();
                  notesProvider.update(widget.note!.id!,widget.note!).whenComplete(() => Navigator.pop(context));
                } 
              }
              else {
                Navigator.pop(context);
              }
              _titleController.text="";
              _descController.text="";
            }
          },
          backgroundColor:const Color.fromRGBO(111, 111, 198, 1),
          child:const Icon(
            Icons.check,
            size:30
          )
        ),
      ),
    );
  }
}