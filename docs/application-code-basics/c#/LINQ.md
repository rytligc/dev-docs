# LINQ (Language-Integrated Query)

## Introduction

Instead of looping through a long array to find specific attributes, we can use LINQ.

Beginning of file should include the `using System.Linq;` and often in conjuction with `using System.Collections.Generic;`

The general syntax is as follows

```c#
var <variableName> = from <iterator> in <listObject>
    where <something>
    select <something>
```

The idea is basically to shorten the amount of code needed to format or filter lists or arrays.

Suppose we need to find all names in a list which are longer than 6 characters and return them in uppercase.

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

It is also possible to use methods on LINQ collections, as shown below

```c#
var shortNames = names.Where( n => n.Length < 4);
```

## Basics and requirements

A basic LINQ query, in query syntax, has three parts:  
The `from` operator declares a variable to iterate through the sequence.  
The `where` operator picks elements from the sequence if they satisfy the given condition. The condition is normally written like the conditional expressions you would find in an if statement.  
The `select` operator determines what is returned for each element in the sequence.

|Keyword |Required
|--      |--
|`from`  |true
|`select`|true
|`where` |false

The following example exclude the `where` keyword

```c#
var heroTitles = from hero in heroes
  select $"HERO: {hero.ToUpper()};
```
  
## Var keyword

Every LINQ query returns either a single value or an object of type `IEnumerable<T>`.  
For `IEnumerable<T>`, operations such as `foreach` (loops) and `Count()` works.  
The `var` keyword is an implicitly typed variable. The C# compiler determine the actual type for us.

```c#
string[] names = { "Tiana", "Dwayne", "Helena" };
var shortNames = names.Where(n => n.Length < 4);
```

In this case shortNames is actually of type `IEnumerable<string>`, but we don’t need to worry ourselves about that as long as we have `var`.

## Example 1 of LINQ with Query and Method syntax

```c#
using System;
using System.Collections.Generic;
using System.Linq;

namespace LearnLinq
{
  class Program
  {
    static void Main()
    {
      List<string> heroes = new List<string> { "D. Va", "Lucio", "Mercy", "Soldier 76", "Pharah", "Reinhardt" };
    
      // LINQ query syntax
      var shortHeroes = from h in heroes
          where h.Length < 8
          select h;

      foreach (var h in shortHeroes)
      {
        // outputs: D. Va, Lucio, Mercy, Pharah
        Console.WriteLine(h);
      }
      
      // LINQ method syntax
      var longHeroes = heroes.Where(n => n.Length > 8);

      // outputs 2
      Console.WriteLine(longHeroes.Count());
    }
  }
}
```

## Example 2 of LINQ with Query and Method syntax

```c#
using System;
using System.Collections.Generic;
using System.Linq;

namespace LearnLinq
{
  class Program
  {
    static void Main()
    {
      string[] heroes = { "D. Va", "Lucio", "Mercy", "Soldier 76", "Pharah", "Reinhardt" };

      // Query syntax
      var queryResult = from x in heroes
                        where x.Contains("a")
                        select $"{x} contains an 'a'";
      
      // Method chain syntax
      var methodResult = heroes
        .Where(x => x.Contains("a"))
        .Select(x => $"{x} contains an 'a'");
     
      // Printing...
      Console.WriteLine("queryResult:");
      foreach (string s in queryResult)
      {
        Console.WriteLine(s);
      }
      
      Console.WriteLine("\nmethodResult:");
      foreach (string s in methodResult)
      {
        Console.WriteLine(s);
      }
    }
  }
}
```
