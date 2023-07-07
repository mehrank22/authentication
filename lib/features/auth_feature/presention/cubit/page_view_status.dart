abstract class PageViewStatus {}

class PageViewInitial extends PageViewStatus {}

class PageViewLoading extends PageViewStatus {}

class PageViewCompleted extends PageViewStatus {
  final String text;

  PageViewCompleted(this.text);
}

class PageViewError extends PageViewStatus {
  final String message;

  PageViewError(this.message);
}
