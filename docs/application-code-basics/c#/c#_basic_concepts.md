# Basic concepts

This file contains the basics of C# that needs to be remembered and heavily repeated

## Data types

|Type|Description|Size (Bytes)|.Net type|Range|
|-|-|-|-|-|
|int|Whole Numbers|4|System.Int32|+/-2,147,483,648
|long|Whole numbers (bigger range than int)|8|System.Int64|+/-9,223,372,036,854,775,808
|float|floating-point numbers|4|System.Single|+/-3.4x10^38
|double|Double precision floating numbers|8|System.Double|+/-1.7x10^38
|decimal|Monetary values (extreme precision such as needed for money)|16|System.Decimal|28 significat figures
|char|Single character e.g `'g'`|2|System.Char|N/A
|bool|Boolean|1|System.Boolean|True or False
|DateTime|Moments in time|8|System.DateTime|0:0:00 on 01/01/0001 to 23:59:59 on 12/31/9999
|string|Sequence of characters e.g. `"Hello"`|System.String|N/A

## Declaring and initializing variables

Like other languages variables can be declared and initialized in on single line. The basic structure is as follows

```C#
// DataType (e.g. string.)
<data_type> <variable_name>;


<data_type> <variable_name>=value;

// Access Specifiers 
//Public, Private, Protected, Internal, Protected internal
<access_specifier><data_type> <variable_name>=value;
```

**Declaring** a variable is done by stating it's data type and name without a value.

**Initialization** is done by calling the variable and setting a value, ***WITHOUT*** declaring the data type

```C#
// Declaration
string thisIsAString;
int thisIsAnInt;
bool thisIsABool;

// Initialization
thisIsAString = "Hello World!";
thisIsAnInt = 8;
thisIsABool = true;
```

## Access Specifiers

### Public Access Specifier

It allows a class to expose its member variables and member functions to other functions and objects.

### Private Access Specifier

Private access specifier allows a class to hide its member variables and member functions from other functions and objects. Only functions of the same class can access its private members.

### Protected Access Specifier

Protected access specifier allows a child class to access the member variables and member functions of its base class.

### Internal Access Specifier

Internal access specifier allows a class to expose its member variables and member functions to other functions and objects in the current assembly.

### Protected Internal Access Specifier

The protected internal access specifier allows a class to hide its member variables and member functions from other class objects and functions, except a child class within the same application.
