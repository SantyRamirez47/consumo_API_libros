import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'repository/bookServiceApi.dart';
import 'bloc/book_Bloc.dart';
import 'ui/vista_libros.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gutendex Flutter',
      home: BlocProvider(
        create: (context) => BookBloc(BookServiceApi()),
        child: const BookListView(),
      ),
    );
  }
}
