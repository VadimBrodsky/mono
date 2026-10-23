# Installing Clojure
Clojure requires Java. Clojure officially supports Java LTS releases  (currently Java 8, 11, and 17), but also tries to ensure interim  versions work as well. You can use any Java distribution, whether it’s a commercial release from Oracle or an open source version based on  OpenJDK (like Temurin). The Clojure tools require only that the `java` command is on the `PATH` or that the `JAVA_HOME` environment variable is set.
  
## Linux
```shell
  sudo apt search openjdk
  sudo apt install openjdk-17-jdk
  ```
  
## OSX
 ```shell
  brew install openjdk
  ```
	 
## asdf
- [ A Java plugin for asdf-vm. ](https://github.com/halcyon/asdf-java)
 ```shell
asdf plugin-add java https://github.com/halcyon/asdf-java.git
  ```
- [ Clojure plugin for the asdf version manager ](https://github.com/asdf-community/asdf-clojure)
```shell
asdf plugin add clojure https://github.com/asdf-community/asdf-clojure.git
```
- [Leiningen plugin for asdf version manager](https://github.com/miorimmax/asdf-lein)
```shell
asdf plugin-add lein https://github.com/miorimmax/asdf-lein.git
```
  
## Editor setup
- [A filetype, syntax and indent plugin for Clojure](https://github.com/vim-scripts/VimClojure)