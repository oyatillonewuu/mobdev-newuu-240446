# Part 1

```
1. In product.json , find one field that is a number, one that is
   a list of strings, one that is a nested object and one that is a list of
   objects.

   Number field: `price`
   List of strings: `tags`
   Nested object: `dimensions`
   List of objects: `reviews`

2. Change the address to /products/0 . What status code and body come back?
   Status code: 404
   Body:
        {"message":"Product with id '0' not found"}
```

# Part 2

```
1. What exactly happens if you write json['price'] as double and
   the server sends 10 ? Is the error found at compile time or at runtime?

   Causes casting error (because the value would have been converted to int
   which is not a subtype of 'double').

   Error happens at run time.

   Here's what I got when tested with code:

    print((json["id"] as double));
      type 'int' is not a subtype of type 'double' in type cast
```

# Part 4

```
1. Add ?delay=3000 to the list request (DummyJSON waits 3 s before answering).
   Leave the screen during the wait: what would happen without the isClosed check?

   To observe the behavior, I had to add a home screen that pushes the products
   screen.

   MaterialApp -> HomeScreen -> ProductsApp (create cubit) -> Products (receives cubit)
   On stack pop, bloc library closes the cubit.

   So, when there is `isClosed` check, the following is observed:

      Restarted application in 171ms.
      Change { currentState: Instance of 'ProductsLoading', nextState: Instance of 'ProductsLoading' }
      ProductsCubit closed

  If remove `isClosed` guard, the following is observed upon api request completion
  after products page has been popped:

      Performing hot restart...
      Restarted application in 174ms.
      Change { currentState: Instance of 'ProductsLoading', nextState: Instance of 'ProductsLoading' }
      ProductsCubit closed
      [ERROR:flutter/runtime/dart_vm_initializer.cc(40)] Unhandled Exception: Bad state: Cannot emit new states after calling close
      #0      BlocBase.emit (package:bloc/src/bloc_base.dart:100:9)
      #1      ProductsCubit.load (package:api_catalog/cubit/products_cubit.dart:37:7)
      <asynchronous suspension>

  This shows that error is thrown if we use bloc after it has been closed.

2. Why does the test use isA<…>() instead of ProductsLoaded([...]) ? What would
   you add to the state class to compare by value?

    "Note: when using [blocTest] with state classes which don’t override == and hashCode you can provide an Iterable of matchers instead of explicit state instances."

    .... inline doc says.

    This means the default comparator isn't expected to give what we expect from 
    comparison.

    For direct instance comparison to work, we should override `==` operator at least
    to use our custom logic.
    
```
