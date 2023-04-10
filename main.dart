import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // debug yazısını kaldırmak için
      title: '18648', // gözüken başlık
      home: TodoList(),
    );
  }
}

class TodoList extends StatefulWidget {
  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  final _todoList = <Todo>[]; // Görev listesi
  final _textController = TextEditingController(); // textfield kontrol
  bool _isDarkMode = false; // başlangıç teması

  void _addTodoItem(String task) {
    setState(() {
      _todoList.add(Todo(task)); // Yeni görev ekle
      _textController.clear(); // TextField'i temizle
    });
  }
                                                                                                          //Arda Koray Kartal 11/Atp-A 18648
  Widget _buildTodoList() {
    return ListView.builder(
      itemCount: _todoList.length,
      itemBuilder: (context, index) {
        final todo = _todoList[index]; // Görevin kendisi
        return Dismissible(
          key: UniqueKey(),
          onDismissed: (direction) {
            setState(() {
              _todoList.removeAt(index); // Görevi listeden kaldır
            });
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Görev silindi")), // Kullanıcıya bildirim göster
            );
          },
          child: CheckboxListTile(
            value: todo.isDone,
            onChanged: (isChecked) {
              setState(() {
                todo.isDone = isChecked!; // Görev tamamlandı mı? 
              });
            },
            title: Text(
              todo.task,
              style: TextStyle(
                decoration: todo.isDone ? TextDecoration.lineThrough : null, // Tamamlanmış görevlerin çizgili görünmesi
              ),
            ),
            controlAffinity: ListTileControlAffinity.leading,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = _isDarkMode ? ThemeData.dark() : ThemeData(primarySwatch: Colors.brown); // uygulama temaları
    return MaterialApp(
      title: 'Arda Koray Kartal', // browserda gözüken başlık
      theme: theme,
      home: Scaffold(
        
        
        appBar: AppBar(
          title: Text('Arda Koray Kartal'), // program içinde gözüken başlık
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: 300,
                child: TextField(
                  controller: _textController,
                  decoration: InputDecoration(
                    hintText: 'Görev giriniz', // TextField'in üzerindeki açıklama
                  ),
                  style: TextStyle(fontSize: 20),
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  child: Text('Ekle'), // Ekle butonu
                  onPressed: () {
                    _addTodoItem(_textController.text); // Yeni görev ekleme fonksiyonunu çağır
                  },
                  style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16),  // buton yükseklik (dikey)
                  textStyle: TextStyle(fontSize: 24),  // buton içi yazı fontu
                  ),
                ),
              ),
              Expanded(
                child: _buildTodoList(),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
        onPressed: () { 
        setState(() {  // State nesnesinin güncellenmesi gerektiğini bildirir.
        _isDarkMode = !_isDarkMode;  // karalnık temayı tersine çevirir
      });
  },
       child: Icon(_isDarkMode ? Icons.wb_sunny : Icons.nightlight_round),  // moda göre simgeyi gösterir
),
      ),
    );
  }
}

class Todo {
  String task;  // Yapılacak işin adını tutar, altına listeler
  bool isDone;  // iş yapıldı mı yapılmadı mı bilgisini hafızada tutar

  Todo(
    this.task, {  // Yapılacak işin adını belirler.
    this.isDone = false,  // İşin tamamlanmış olma durumunu varsayılan olarak false olarak ayarlar.
  });
}
