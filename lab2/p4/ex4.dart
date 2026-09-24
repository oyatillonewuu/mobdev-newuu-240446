List<int> apply(List<int> nums, int Function(int) transform) {
  List<int> output = [];

  for (var n in nums) {
    output.add(transform(n));
  }

  return output;
}

void main() {
  List<int> nums = [1, 2, 3, 4];
  List<int> squares = apply(nums, (x) => x * x);

  print("Nums:    ${nums.join(',')}.");
  print("Squares: ${squares.join(',')}.");
}
