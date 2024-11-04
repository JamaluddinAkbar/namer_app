import 'package:english_words/english_words.dart'; // paket bahasa inggris
import 'package:flutter/material.dart'; //paket untuk tampilan UI (material UI)
import 'package:provider/provider.dart'; //paket untuk interaksi apikasi

//fungsi utama
void main() {
  runApp(MyApp()); //memanggil fungsi runApp (yang menjalankan seluruh aplikasi di dalam MyApp)
}

//membuat abstrak aplikasi dari statelessWidget (tamplate aplikasi), aplikasinya bernama MyApp
class MyApp extends StatelessWidget {
  const MyApp({super.key}); //menunjukkan bahsa aplikasi ini akan tetap, tidak berubah setelah di-build

  @override //mengganti nilai nilai yang sudah ad di tamplate, dengan nilai nilai yang baru (replace / overwrite)
  Widget build(BuildContext context) {
    //fungsi build adalah fungsi yang membangun UI (mengatur posisi widget, dst)
    //ChangeNotifierProvider mendengarkan/mendeteksi semua interaksi yang terjadi di aplikasi
    return ChangeNotifierProvider(
      create: (context) => MyAppState(), //membuat state bernama MyAppState
      child: MaterialApp( //pada state ini, menggunakan style desain MaterialUI
        title: 'Namer App', //diberi judul Namer App
        theme: ThemeData( //data tema aplikasi, diberi warna deepOrange
          useMaterial3: true, //fungsi MateerialUI yang dipakai versi 3
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        ),
        home: MyHomePage(), //nama halaman "MyHomePage" yang menggunakan state "MyAppState".
      ),
    );
  }
}

//mendefinisikan isi MyAppState
class MyAppState extends ChangeNotifier {
  //state MyAppState diisi dengan 2 kata random yang di gabung. kata random tsb disimpan di variable WordPair
  var current = WordPair.random();
  
  void getNext() {
    current = WordPair.random();
    notifyListeners();
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {           
    var appState = context.watch<MyAppState>();  
    var pair = appState.current;

    return Scaffold(                             
      body: Center(
        child: Column(       
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('A random AWESOME idea:'),        
            BigCard(pair: pair),    
            ElevatedButton(
              onPressed: () {
                appState.getNext();
              },
              child: Text('Next'),
            ),
          ],                                      
        ),
      ),
    );
  }
}

class BigCard extends StatelessWidget {
  const BigCard({
    super.key,
    required this.pair,
  });

  final WordPair pair;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
    );

    return Card(
      color: theme.colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.all(20),

  
        child: Text(
          pair.asLowerCase,
          style: style,
          semanticsLabel: "${pair.first} ${pair.second}",
        ),
      ),
    );
  }
}