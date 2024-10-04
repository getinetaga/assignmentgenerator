// TODO Implement this library.
void main() {
  querySelector('#changeTextButton')?.onClick.listen((event) {
    querySelector('#header')?.text = 'Text changed!';
  });
}