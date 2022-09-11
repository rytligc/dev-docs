# Welcome to my docs

## Mkdocs

For full documentation of Mkdocs visit [mkdocs.org](https://www.mkdocs.org).

### Commands

* `mkdocs new [dir-name]` - Create a new project.
* `mkdocs serve` - Start the live-reloading docs server.
* `mkdocs build` - Build the documentation site.
* `mkdocs -h` - Print help message and exit.

## Extensions

### Tabs

    ```c

    "=== "C"

        ``` c
        #include <stdio.h>

        int main(void) {
          printf("Hello world!\n");
          return 0;
        }
        ```

    === "C++"

    ``` c++
    #include <iostream>

    int main(void) {
      std::cout << "Hello world!" << std::endl;
      return 0;
    }
    ```

### Result

=== "C"

    ```c
    #include <stdio.h>

    int main(void) {
      printf("Hello world!\n");
      return 0;
    }
    ```

=== "C++"

    ```c++
    #include <iostream>

    int main(void) {
      std::cout << "Hello world!" << std::endl;
      return 0;
    }
    ```

## InlineHilite

Here is some code: `#!py3 import pymdownx; pymdownx.__version__`.
```
`#!py3 import pymdownx; pymdownx.__version__`.
```

The mock shebang will be treated like text here: ` #!js var test = 0; `.


=== "Tab 1"
    Markdown **content**.

    Multiple paragraphs.

=== "Tab 2"
    More Markdown **content**.

    - list item a
    - list item b

===! "Tab A"
    Different tab set.

=== "Tab B"
    ```
    More content.
    ```
