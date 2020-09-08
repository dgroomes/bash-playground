# jshell

NOT YET FULLY IMPLEMENTED

Learning and exploring `jshell`--the Java shell that ships with OpenJDK.

---

Can I run a Java application and then attach a jshell session and just poke around the various objects in my Java
process and execute arbitrary Java code? This seems like a good way to learn language features of Java or explore 
methods of a library (e.g. [Jackson](https://github.com/FasterXML/jackson)) or framework (e.g. [Spring](https://github.com/spring-projects/spring-framework)). 

### Learn about jshell

The JDK Enhancement Proposal that introduced `jshell` is the best place to learn the "what" and "why" of jshell: <http://openjdk.java.net/jeps/222>.

To learn the "how", see <https://docs.oracle.com/en/java/javase/14/jshell/introduction-jshell.html#GUID-630F27C8-1195-4989-9F6B-2C51D46F52C8>.

Some highlights from the page include:

> Provide an interactive tool to evaluate declarations, statements, and expressions of the Java programming language, together with an API so that other applications can leverage this functionality.

> Out of scope are graphical interfaces and debugger support. The JShell API is intended to allow JShell functionality in IDEs and other tools, but the jshell tool is not intended to be an IDE.

> Immediate feedback is important when learning a programming language and its APIs. The number one reason schools cite for moving away from Java as a teaching language is that other languages have a "REPL" and have far lower bars to an initial "Hello, world!" program.

> Exploration of coding options is also important for developers prototyping code or investigating a new API. Interactive evaluation is vastly more efficient in this regard than edit/compile/execute and System.out.println.

### Instructions

1. Use Java 14
1. Compile the program with `./build.sh`
1. Run the program with `./run-main.sh` (but this isn't what we really want, we want to use jshell! See the next step)
1. Start a jshell session which loads the library and application source code with `./run-jshell.sh`
  * *This does not work*. Unfortunately I can't figure out the right optionsto jshell to load the application source
    code. The `--class-path` option is problematic. It does not work the same way I am used to using the `-cp` option in
    the `java` command.
