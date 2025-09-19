import 'package:flutter/material.dart';
import '../repository/book_service_api.dart';
import '../model/book.dart';

class BookSearchView extends StatefulWidget {
  const BookSearchView({super.key});

  @override
  State<BookSearchView> createState() => _BookSearchViewState();
}

class _BookSearchViewState extends State<BookSearchView> {
  final TextEditingController _controller = TextEditingController();
  final BookServiceApi _service = BookServiceApi();

  List<Book> _results = [];
  bool _loading = false;
  String? _error;

  void _searchBooks() async {
    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      final books = await _service.searchBooks(_controller.text);
      setState(() {
        _results = books;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
      });
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Buscar Libros")),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: "Escribe un título o autor",
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: _searchBooks,
                ),
              ],
            ),
            const SizedBox(height: 10),
            if (_loading) const CircularProgressIndicator(),
            if (_error != null) Text("Error: $_error"),
            if (!_loading && _results.isNotEmpty)
              Expanded(
                child: ListView.builder(
                  itemCount: _results.length,
                  itemBuilder: (context, index) {
                    final book = _results[index];
                    return ListTile(
                      title: Text(book.title),
                      subtitle: Text("Descargas: ${book.downloadCount}"),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
