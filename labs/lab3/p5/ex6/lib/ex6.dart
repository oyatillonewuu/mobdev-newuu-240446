/// A library implementing a simple thread pool.
library;

import "dart:collection";

/// Handle for a thread (descriptor/dummy type).
typedef ThreadHandle = int; // Dummy type

/// Task function type with [R] type for return value and [T] type for data.
typedef TaskFunc<R, T> = R Function(T data);

/// Queue type for aggregating finished tasks.
typedef ResultQueue = Queue<dynamic>;

/// # Task class.
///
/// Generic over [R] and [T]. [R] for return value
/// of task functions and [T] for data of task functions.
class Task<R, T> {
  final int taskId;
  final T data;
  final TaskFunc<R, T> taskFunc;
  R? result;

  new({required this.taskId, required this.taskFunc, required this.data});

  /// Calls the task function with the stored data.
  void execute() {
    result = taskFunc(data);
  }
}

/// # ThreadPool class.
///
/// Provides facilities for (if this implementation was real):
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
class ThreadPool {
  // Stores workers.
  final List<Worker> _workers = [];

  // A queue of finished tasks which contain their results too.
  final Queue<Task> _finishedTasksQueue = Queue();

  // Tracks monotonic id for tasks. Used to generate task id.
  int _monotonicTaskId = 0;

  // Tracks id of the last worker to which task was assigned.
  // Algorithm: Round-robin.
  int _lastTaskedWorkerId = 0;

  /// Creates a pool with [numWorkers].
  new({int numWorkers = 2}) {
    for (int i in Iterable.generate(numWorkers)) {
      var wk = Worker(th: i);
      _workers.add(wk);
    }
  }

  /// Creates new task with given [taskFunc] and [data]
  /// and chooses a worker to delete task execution.
  void execute<R, T>({required TaskFunc<R, T> taskFunc, required T data}) {
    int receivingWorkerId = _getNextWorkerIdAndUpdateTracker();

    Task task = Task<R, T>(
      taskId: _getNewTaskIdAndUpdateTracker(),
      data: data,
      taskFunc: taskFunc,
    );

    // Dispatches to a worker which runs in some thread.
    _workers[receivingWorkerId].execute(
      task: task,
      finishedTasksQueue: _finishedTasksQueue,
    );
  }

  /// Throws [UnsupportedError] if [workers].length ends up being 0.
  int _getNextWorkerIdAndUpdateTracker() {
    _lastTaskedWorkerId = (_lastTaskedWorkerId + 1) % _workers.length;
    return _lastTaskedWorkerId;
  }

  /// Returns new task id and updates the id tracker.
  int _getNewTaskIdAndUpdateTracker() {
    return _monotonicTaskId++;
  }

  /// Pops one task from queue and returns it for consumption.
  /// Returns null if queue is empty.
  Task? consumeFinishedTask() {
    if (_finishedTasksQueue.isEmpty) {
      return null;
    }
    Task task = _finishedTasksQueue.removeFirst();
    return task;
  }
}

/// # Worker class.
///
/// Stores a thread handle and provides function
/// to execute a task.
class Worker {
  final ThreadHandle th;

  new({required this.th});

  /// Executes task in a worker thread (in real implementation) and
  /// adds result to queue when available.
  void execute({required Task task, required Queue<Task> finishedTasksQueue}) {
    task.execute();
    finishedTasksQueue.add(task);
  }
}
