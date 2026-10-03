typedef CompressionResult = dynamic; // for now

abstract interface class CompressionStrategy {
  CompressionResult compress(
    dynamic item,
  ); // item can be distinguished using runtime type check
  // in the receiving strategies
}

class Bzip2Strategy implements CompressionStrategy {
  CompressionResult compress(dynamic data) {
    print("Bzip2 compression strategy");
  }
}

class TarStrategy implements CompressionStrategy {
  CompressionResult compress(dynamic data) {
    print("Tar compression strategy");
  }
}

class Compressor {
  CompressionStrategy _strategy;

  new(this._strategy);

  CompressionResult compress(dynamic data) {
    return _strategy.compress(data);
  }

  void setStrategy(CompressionStrategy strategy) {
    _strategy = strategy;
  }
}

void main() {
  Compressor compressor = Compressor(TarStrategy());
  compressor.compress(2323233334);
  compressor.setStrategy(Bzip2Strategy());
  compressor.compress("hello");
}
