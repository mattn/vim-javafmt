# vim-javafmt

    :JavaFmt

vim plugin for java code format. similar to `:GoFmt`.

you need to put `google-java-format-0.1-SNAPSHOT.jar` into `~/.vim/lib`.

## How to build google-java-format-0.1-SNAPSHOT.jar

    $ git clone https://github.com/google/google-java-format.git
    $ cd google-java-format/
    $ mvn clean package --projects core

If failed to build, let's skip tests.

    $ mvn package --projects core -DskipTests

You will get `core/target/google-java-format-0.1-SNAPSHOT.jar`
