# Interfaces in C#

Interfaces are groups of definitions for related functionalities that a (non-abstract) class or struct must implement.

All interfaces are typed as follows, starting by convention with a capital `I`

```C#
interface ISomeInterface 
{

}
```

An interface defines what a class must have. As an example designing cars that abides to the highway patrol's requirements.

The highway patrol tells us: “Every automobile on the road must have these properties and methods accessible to us:”

* speed
* license plate number
* number of wheels
* ability to honk

```C#
// IAutomobile.cs (the interface)
using System;

namespace LearnInterfaces
{
  interface IAutomobile
  {
    string LicensePlate { get; } // License plate requirement
    double Speed { get; } // Speed requirement
    int Wheels { get; } // number of wheels requirement
    void Honk(); // ability to honk requirement
  }
}


// Sedan.cs (the Sedan Class) 
using System;

namespace LearnInterfaces
{
  class Sedan : IAutomobile
  {
    public string LicensePlate { get; }
    public double Speed { get; } 
    public int Wheels { get; }
    
    public void Honk() {
      Console.WriteLine("HONK HONK!");
    }
  }
}
```

In the interface, the methods and public variables are only declared, not initialized with any values. See the "honk" method. It's only declared like `void Honk();` and does not contain a body. The body is defined in the Sedan Class as the Class of the Sedan defines the kind of sound the honk should sound like.

