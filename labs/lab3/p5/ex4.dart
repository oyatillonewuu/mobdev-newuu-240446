// Again, NO LLM.
// Inspired by Rust Book exercise on thread pools.

import "dart:collection";

/// A library implementing a simple thread pool.

/// Custom type declarations
typedef ThreadHandle = int; // Dummy type
typedef TaskFunc<R, T> = R Function(T data);
typedef ResultQueue = Queue<dynamic>;

class Task<R, T> {
  final int taskId;
  final T data;
  final TaskFunc<R, T> taskFunc;
  R? result;

  new({required this.taskId, required this.taskFunc, required this.data});
  void execute() {
    this.result = this.taskFunc(this.data);
  }
}

/// # ThreadPool class.
///
/// Provides facilities for:
///   - **initializing** a pool
///   - **executing** tasks & **queuing** finished tasks for consumption
///   - **cleaning up** of workers
///
/// ## Example usage
///
/// ```dart
/// final ThreadPool thp = ThreadPool(numWorkers: 4); // creates 4 workers
///
/// thp.execute(taskFunc: multByTwo, data: 2);
/// var finishedTask = thp.consumeFinishedTask();
/// print("Task Id: ${finishedTask.taskId}");
/// print("Task data: ${finishedTask.data}");
/// print("Task result: ${finishedTask.result}");

/// ```
///
class ThreadPool {
  final List<Worker> workers = [];

  /// Stores queue of finished tasks which contain their results too.
  Queue<Task> _finishedTasksQueue = new Queue();

  /// Tracks monotonic id for tasks. Used to generate task id.
  int _monotonicTaskId = 0;

  /// Tracks id of the last worker to which task was assigned.
  /// Round-robin algorithm.
  int _lastTaskedWorkerId = 0;

  new({int numWorkers = 2}) {
    for (int i in Iterable.generate(numWorkers)) {
      var wk = Worker(th: i);
      workers.add(wk);
    }
  }

  void execute<R, T>({required TaskFunc<R, T> taskFunc, required T data}) {
    int receivingWorkerId = _getNextWorkerIdAndUpdateTracker();

    Task task = Task<R, T>(
      taskId: _getNewTaskIdAndUpdateTracker(),
      data: data,
      taskFunc: taskFunc,
    );

    // Dispatches to a worker which runs in some thread.
    this.workers[receivingWorkerId].execute(
      task: task,
      finishedTasksQueue: this._finishedTasksQueue,
    );
  }

  int _getNextWorkerIdAndUpdateTracker() {
    this._lastTaskedWorkerId =
        (this._lastTaskedWorkerId + 1) % this.workers.length;
    return this._lastTaskedWorkerId;
  }

  /// Returns new task id and updates the id tracker.
  int _getNewTaskIdAndUpdateTracker() {
    return this._monotonicTaskId++;
  }

  dynamic consumeFinishedTask() {
    if (this._finishedTasksQueue.isEmpty) {
      return null;
    }
    dynamic task = _finishedTasksQueue.removeFirst();
    return task;
  }
}

class Worker {
  final ThreadHandle th;

  new({required this.th});

  /// Executes task in a worker thread and
  /// adds result to queue when available.
  void execute({required Task task, required Queue<Task> finishedTasksQueue}) {
    task.execute();
    finishedTasksQueue.add(task);
  }
}

int multByTwo(int a) {
  return 2 * a;
}

void main() {
  final ThreadPool thp = ThreadPool(numWorkers: 4); // creates 4 workers

  thp.execute(taskFunc: multByTwo, data: 2);
  var finishedTask = thp.consumeFinishedTask();
  print("Task Id: ${finishedTask.taskId}");
  print("Task data: ${finishedTask.data}");
  print("Task result: ${finishedTask.result}");
}
