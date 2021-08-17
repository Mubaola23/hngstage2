import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final formKey = GlobalKey<FormState>();
  List<String> _textItems = [];

  void _addTextItem(String text) {
//    if (text.length > 0) {}
    setState(() => _textItems.add(text));
    Navigator.pop(context);
  }

  void addTextModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => addTextItem(),
    );
  }

  Widget _buildTextList() {
    return ListView.builder(
      itemCount: _textItems.length,
      itemBuilder: (context, index) {
//        if (index < _textItems.length) {
//          return _buildTextItemTile(_textItems[index], index);
//        }
        return _buildTextItemTile(_textItems[index], index);
      },
    );
  }

  void _removeTextItem(int index) {
    setState(() => _textItems.removeAt(index));
  }

  void _confirmRemoveTextItem(int index) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
                'Are you sure you want to delete "${_textItems[index]}" ?'),
            actions: [
              TextButton(
                child: Text('Cancle'),
                onPressed: () => Navigator.of(context).pop(),
              ),
              TextButton(
                  child: Text('Yes'),
                  onPressed: () {
                    _removeTextItem(index);
                    Navigator.of(context).pop();
                  }),
            ],
          );
        });
  }

  Widget _buildTextItemTile(String todoText, int index) {
    return Container(
      margin: EdgeInsets.all(16),
      color: Colors.white,
      padding: EdgeInsets.all(20),
      child: ListTile(
        title: Text(todoText),
        trailing: GestureDetector(
            onTap: () => _confirmRemoveTextItem(index),
            child: Icon(
              Icons.delete,
              color: Colors.red,
            )),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      floatingActionButton: FloatingActionButton(
        onPressed: addTextModal,
        backgroundColor: Colors.blueAccent,
        child: Icon(
          Icons.add,
          size: 30,
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/download.png",
                    width: MediaQuery.of(context).size.width / 6,
                  ),
                  SizedBox(
                    width: 3,
                  ),
                  Text(
                    "HNG8\nInternship",
                    style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: MediaQuery.of(context).size.width / 20),
                  )
                ],
              ),
            ),
            Expanded(
              child: Container(
                child: ListView.builder(
                    itemCount: 1,
                    itemBuilder: (context, index) {
                      return Container(
                        constraints: BoxConstraints(
                            maxHeight:
                                MediaQuery.of(context).size.height / 1.5),
                        child: _buildTextList(),
                      );
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget addTextItem() {
    final newTextController = TextEditingController();
    return Container(
      padding: EdgeInsets.all(16),
      constraints:
          BoxConstraints(maxHeight: MediaQuery.of(context).size.height / 2),
      child: Column(
        children: [
          TextField(
            autofocus: true,
            controller: newTextController,
            decoration: InputDecoration(
              hintText: 'Enter your name',
            ),
          ),
          GestureDetector(
            onTap: () => newTextController.text.isEmpty
                ? Navigator.pop(context)
                : _addTextItem(newTextController.text),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(top: 40),
                    color: Colors.blueAccent,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text(
                          'Done',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
