import 'package:flutter_bloc/flutter_bloc.dart';
import '../model/book.dart';
import '../repository/book_service_api.dart';

abstract class BookEvent {}

class LoadBooks extends BookEvent {}

abstract class BookState {}

class BookInitial extends BookState {}

class BookLoading extends BookState {}

class BookLoaded extends BookState {
  final List<Book> books;
  BookLoaded(this.books);
}

class BookError extends BookState {
  final String message;
  BookError(this.message);
}

class BookBloc extends Bloc<BookEvent, BookState> {
  final BookServiceApi bookService;

  BookBloc(this.bookService) : super(BookInitial()) {
    on<LoadBooks>((event, emit) async {
      emit(BookLoading());
      try {
        final books = await bookService.fetchBooks();
        emit(BookLoaded(books));
      } catch (e) {
        emit(BookError(e.toString()));
      }
    });
  }
}
