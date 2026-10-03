class DummyParent {
  void dummyMethod() {
    print("just something from parent");
  }
}

class DummyChild extends DummyParent {
  /// The method deprecating `dummyMethod`.
  void dummyMethodModern() {
    print("Modern version of dummy method");
  }

  /// Overrides `dummyMethod` of `DummyParent`.
  /// Currently deprecated.
  @deprecated
  @override
  void dummyMethod() {
    print("just something from child");
  }
}

void main() {
  var x = DummyChild();
  x.dummyMethod();
  x.dummyMethodModern();
}
