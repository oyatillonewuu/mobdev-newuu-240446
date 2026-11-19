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

# Q/A

```
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
```
