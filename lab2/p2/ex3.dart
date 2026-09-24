void main() {
  const d1 = DateTime.now();
  final d2 = DateTime.now();

  // Program does not compiler.
  // Reason:
  //  const requires a value that is constant both
  //  in compile and run time. Datetime.now is variable
  //  on each point of time. So, can't be assigned to const
  //  variable.
  //
  //  On the other hand, final is deferred to runtime. It also
  //  prevents re-assigning value, but initialization happens
  //  in run time.
}
