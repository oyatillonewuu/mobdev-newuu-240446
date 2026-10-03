typedef SuccessCode = int;
typedef Error = String;

enum ProcessingResult<T> {
  success<SuccessCode>(0),
  fail<Error>("Invalid data. Processing failed.");

  final T data;

  const ProcessingResult(this.data);
}

void main() {
  ProcessingResult p = ProcessingResult.success;
  print(p.data);
}
