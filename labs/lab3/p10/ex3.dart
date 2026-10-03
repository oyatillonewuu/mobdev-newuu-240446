abstract class Device {
  void printInfo() {
    print("Device info");
  }
}

class STM32 extends Device {
  void printInfo() {
    print("STM32 -- chip to for embedded programming");
  }
}

abstract class Animal {
  void makeSound() {
    print("I don't know my sound yet");
  }
}

class Dog extends Animal {
  void makeSound() {
    print("woof");
  }
}

void callSoundOfAnimal(Animal animal) {
  animal.makeSound();
}

void main() {
  callSpecificFuncByTypeCheck(Dog());
  callSpecificFuncByTypeCheck(STM32());
  tryForceCastToDog(Dog());
  try {
    tryForceCastToDog(STM32());
  } catch (TypeError) {
    print("Casting failed");
  }
}

void callSpecificFuncByTypeCheck(dynamic object) {
  if (object is Animal) {
    object.makeSound();
  } else if (object is Device) {
    object.printInfo();
  } else {
    print("Unrecognized type");
  }
}

void tryForceCastToDog(dynamic object) {
  Dog dog = object as Dog;
  dog.makeSound();
}
