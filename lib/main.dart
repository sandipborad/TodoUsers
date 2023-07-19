import 'package:doshaheen/model/user.dart';
import 'package:doshaheen/providers/UserToDoProvider.dart';
import 'package:doshaheen/utils/appstring.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserToDoProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Doshaheen',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const MyHomePage(title: 'Doshaheen Practical Task(Sandip)'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: FutureBuilder(
        future: context.read<UserToDoProvider>().getUsers(),
        builder: (BuildContext context,
            AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: SizedBox(
                height: 70.0,
                width: 70.0,
                child: CircularProgressIndicator(
                  color: Colors.blue,
                ),
              ),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              return listUsers();
            } else if (snapshot.hasError) {
              return const Text(
                AppString.NO_USERS_FOUND,
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.15,
                  color: Colors.white,
                ),
              );
            } else {
              return const Text(
                AppString.NO_USERS_FOUND,
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.15,
                  color: Colors.white,
                ),
              );
            }
          }
          return Container();
        },
      ),
    );
  }

  Consumer listUsers() {
    return Consumer<UserToDoProvider>(
      builder: (context, data, child) {
        return data.userIdMap.isNotEmpty
            ? SingleChildScrollView(
          child: Column(
              children: data.userIdMap.entries.map((entry) {
                return Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 5.0,),
                      Text('Userid : ${entry.value['userId'].toString()}',),
                      const SizedBox(height: 2,),
                      Text('Pending : ${entry.value['pending'].toString()}',),
                      const SizedBox(height: 2,),
                      Text('Completed : ${entry.value['completed'].toString()}',),
                      const SizedBox(height: 5.0,),
                      const Divider(height: 1,color: Colors.black,),
                    ],
                  ),
                );
              }).toList()),
        ) : userNotFound();
      },
    );
  }
  Widget userNotFound() {
    return Stack(children: [
      ListView(),
      Center(
        child: Text(
          'User Not found',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.white,
            fontSize: 25.0,
            letterSpacing: 0.3,
          ),
        ),
      ),
    ]);
  }
}
