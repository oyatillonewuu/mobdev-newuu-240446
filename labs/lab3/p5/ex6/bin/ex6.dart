import 'package:ex6/ex6.dart' as ex6;

int multByTwo(int a) {
  return 2 * a;
}

void main() {
  final ex6.ThreadPool thp = ex6.ThreadPool(numWorkers: 4); // creates 4 workers

  thp.execute(taskFunc: multByTwo, data: 2);
  var finishedTask = thp.consumeFinishedTask();
  print("Task Id: ${finishedTask!.taskId}");
  print("Task data: ${finishedTask.data}");
  print("Task result: ${finishedTask.result}");
}
