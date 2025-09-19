import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/book_bloc.dart';
import '../model/book.dart';

class BookListView extends StatelessWidget {
  const BookListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Gutendex Books")),
      body: BlocBuilder<BookBloc, BookState>(
        builder: (context, state) {
          if (state is BookLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is BookLoaded) {
            return ListView.builder(
              itemCount: state.books.length,
              itemBuilder: (context, index) {
                Book book = state.books[index];
                return ListTile(
                  title: Text(book.title),
                  subtitle: Text("Descargas: ${book.downloadCount}"),
                );
              },
            );
          } else if (state is BookError) {
            return Center(child: Text("Error: ${state.message}"));
          }
          return const Center(
            child: Text("Presiona el botón para cargar libros"),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<BookBloc>().add(LoadBooks());
        },
        child: const Icon(Icons.download),
      ),
    );
  }
}
