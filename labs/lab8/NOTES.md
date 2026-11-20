
# Model info

```

    Class list

    1. Watch
    2. Nothing
    3. Calculator
    4. Ruler
    5. Flash disk
    6. Watch charger
    
```

[Preview example screenshot](./docs/preview.png)

# Notes

```
   1. Riverpod is used for sharing classifier.

```

# Q/A

```
Task 1
  1. What does the model answer when it sees an object that
     belongs to none of your classes? How does the background
     class change that?

     In my case, it wrongly flagged even me as "Flash disk" instead
     of "nothing" class. I think this is because I didn't
     include my image in the training samples for "nothing" class.
     If thre weren't this class, the model could have shown
     different probabilities across other classes while
     never being confident in any of them or being wrongly
     confident.
     
  2. The export dialog offers Floating point and Quantized.
     What differs between the two files in size, in input type
     and in what your Dart code would have to do?

     Floating point exports a model with weights expressed in
     floating point. Quantized does a compression that
     makes weights expressed in integers thus saving space.

     In quantized version, Dart code would have had "decompress"
     the weights into usable values.

Task 2
  1. What is the difference between listing assets/model/ and 
     listing assets/ ? Which files would each one bundle?

     Flutter docs^[1] says that only files directly located
     in a given directory are loaded.

     So, assets/ option would miss bundling the model files
     because they're locating in the `model` subdirectory.

     The option assets/model/ includes the model files
     because they're located directly in this directory.

     [1] - https://docs.flutter.dev/ui/assets/assets-and-images#specifying-assets
     
  2. Why can image and http run in a plain Dart unit test while 
     tflite_flutter and image_picker cannot?

     For tflite_flutter, it may not be able to be unit-tested
     in plain Dart because it inherently uses FFI (Foreign
     Function Interface) for C for Tensorflow.

     For image_pciker, plain usage in testing would fail
     because image_picker use native OS features which
     won't be available in testing.
```
