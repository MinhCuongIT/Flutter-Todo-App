import 'package:flutter/material.dart';
import 'package:todo_app/src/models/QuickNote.dart';
import 'package:todo_app/src/UI/widgets/SmallButton.dart';
import 'package:todo_app/src/resources/repository.dart';

class QuickNoteWidget extends StatefulWidget {
  final QuickNote quickNoteInfo;
  final String uid;
  QuickNoteWidget(
    this.uid,
    this.quickNoteInfo
  );
  @override
  _QuickNoteWidgetState createState() => _QuickNoteWidgetState();
}


class _QuickNoteWidgetState extends State<QuickNoteWidget> {
  TextEditingController _quickNoteTitleController = new TextEditingController();
  final _repository = Repository(); 
  
  @override
  void initState() {
    super.initState();
   
  }

  @override
  void dispose() {
    
    _quickNoteTitleController.dispose();
    super.dispose();
  }

 
  void _showModalToEditTitle(){
    _quickNoteTitleController = TextEditingController(text: widget.quickNoteInfo.title);
    showDialog(
      context: context,
      builder: (context){
        return Dialog(
          backgroundColor: Colors.red,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40)
          ),
          child: Container(
           height: 200,
           
            padding: EdgeInsets.symmetric(horizontal: 30),
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: Container(                      
                        child: TextField(
                          controller: _quickNoteTitleController, 
                          style: TextStyle(
                            fontSize: 18.0,
                            color:  Color(0xff878CAC),
                            fontFamily: "Poppins"
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 20),
                    SmallButton(
                      color: Colors.blue,
                      icon: Icon(
                        Icons.check,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        _repository.setQuickNoteTitle(
                          uid: widget.uid,
                          quickNoteId: widget.quickNoteInfo.quickNoteId,
                          newTitle:_quickNoteTitleController.text
                        );
                        Navigator.of(context).pop();
                        
                      },
                    )
                  ],
                )
              ],
            ),
          ),
        );
      }
    );
  }
  @override
  Widget build(BuildContext context) {
     
    
    return InkWell(
      onLongPress: (){
        _showModalToEditTitle();
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              
              children: <Widget>[
                Container(
                  width: 18,
                  height: 18,
                  child: Checkbox(
                    value: widget.quickNoteInfo.isDone,
                    activeColor: Color(0x80878CAC),
                    checkColor: Colors.white,
                    onChanged: (bool isChecked) {
                      setState(() {
                        this.widget.quickNoteInfo.isDone = isChecked;
                      });
                     _repository.setQuickNoteIsDone(
                       uid: widget.uid,
                       quickNoteId: widget.quickNoteInfo.quickNoteId,
                       isDone: isChecked
                     );
                    },
                  ),
                ),
                SizedBox(width: 30.0),
                Container(
                  
                  width: MediaQuery.of(context).size.width * 0.65,
                 
                  child: Text(
                    widget.quickNoteInfo.title,
                    style: TextStyle(
                        fontSize: 18.0,
                        
                        decoration: widget.quickNoteInfo.isDone
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                        color: widget.quickNoteInfo.isDone
                            ? Color(0x4D878CAC)
                            : Color(0xff878CAC),
                        fontFamily: "Poppins"),
                  ),
                ),
              ],
            ),
            widget.quickNoteInfo.isDone
                ? Container(
                    child: InkWell(
                      borderRadius: BorderRadius.circular(30.0),
                      onTap: () {
                        _repository.deleteQuickNote(
                          uid: widget.uid,
                          quickNoteId: widget.quickNoteInfo.quickNoteId
                        );
                      },
                      child: Icon(
                        Icons.clear,
                        color: Theme.of(context).accentColor,
                        size: 20,
                      ),
                    ),
                  )
                : Container(
                    height: 7.0,
                    width: 7.0,
                    decoration: BoxDecoration(
                        color: widget.quickNoteInfo.priority.color,
                        borderRadius: BorderRadius.circular(10.0)),
                  )
          ],
        ),
      ),
    );
  }
}
