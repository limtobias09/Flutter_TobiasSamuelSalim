import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:open_file/open_file.dart';




void main(List<String> args) {
  runApp(const MyApp());
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Advance User Input',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}



class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime _dueDate= DateTime.now();
  final currentDate= DateTime.now();
  Color _currentColor=Colors.orange;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Interactive Widgets'),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            buildDatePicker(context),
            
            buildColorPicker(context),
            const SizedBox(
              height: 20,
            ),

            buildFilePicker(context),

          ],
        ),
      ),
    );
  }



  Widget buildDatePicker(BuildContext context){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('Date'),
          TextButton(
            onPressed: () async{
             final selectDate= await showDatePicker(
              context: context, 
              initialDate: currentDate, 
              firstDate: DateTime(1990), 
              lastDate: DateTime(currentDate.year+5),
              ); 

              setState(() {
                if(selectDate!= null){
                  _dueDate=selectDate;
                }
              });

            }, 
            child: const Text('Select'),
          ),
        ],
        ),
      Text(
        DateFormat('dd-MM-yyyy').format(_dueDate),
        ),
      ],
    );
  }



  Widget buildColorPicker(BuildContext context){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text('Color'),
      const SizedBox(height: 10,),
      Container(height: 100, width: double.infinity,
      color: _currentColor,
      ),
      const SizedBox(height: 10,),
      Center(
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(_currentColor),
            ),
        onPressed: (){
          showDialog(
            context: context, 
            builder: (context){
              return AlertDialog(
                title: const Text('Pick Your Color'),
                content:ColorPicker( //Ada Widget ColorPicker, BlockPicker, dan SlidePicker
                  pickerColor: _currentColor, 
                  onColorChanged: (color){
                    setState(() {
                       _currentColor=color;
                    });
                   
                  },
                  ),
                actions: [
                  TextButton(
                    onPressed: (){
                      Navigator.pop(context);
                    }, 
                    child: const Text('Save'),
                  ),
                ],
              );
            },
            );
        },
        child: const Text('Pick Color'),
        ),
      ),
    ],
    );
  }


  Widget buildFilePicker(BuildContext context){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      const Text('Pick Files'),
      const SizedBox(
        height: 10,
        ),
      Center(
        child: ElevatedButton(
          onPressed: (){
            _pickFile();
          }, 
          child: const Text('Pick and Open Files'),
          ),
      ),
      ],
    );
  }

  void _pickFile() async{
    final result=await FilePicker.platform.pickFiles();
    if (result==null)return;
   
   final file=result.files.first;

   _openFile(file);
  }
  
  
  
  void _openFile(PlatformFile file){
   OpenFile.open(file.path);
  
  }

}

