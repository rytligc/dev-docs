# LINQ (Language-Integrated Query)

Instead of looping through a long array to find specific attributes, we can use LINQ.

Beginning of file should include the `using System.Linq;` and often in conjuction with `using System.Collections.Generic;`

The general syntax is as follows

```c#
var <variableName> = from <iterator> in <listObject>
    where <something>
    select <something>
```

The idea is basically to shorten the amount of code needed to format, filter or similar to list or arrays.

For example, suppose we need to find all names in a list which are longer than 6 characters and return them in uppercase.

There may be an obvious approach of looping the list and formatting with conditionals to return a new formatted list but this will take up more space than the LINQ way of doing it. Below is an example

```c#

// Object initialization list - uses curly braces
List<string> names = new List<string>{"Tom","Jerry","Roadrunner","M. Mouse", "Goofy"};

// Approach using foreach loop, without LINQ

// Basic construction - uses ( ) with no values
List<string> longLoudNames = new List<string>();

foreach(string name in names)
{
    if (name.Length > 6)
    {
        string formattedNames = name.ToUpper();
        longLoudNames.Add(formattedNames)
    }
}

// With LINQ

var longLoudNames2 = from n in names
    where n.Length > 6
    select n.ToUpper();
```

It is also possible to use methods on LINQ collections, like `.Where`, as shown below

```c#
var shortNames = names.Where( n => n.Length < 4);
```
