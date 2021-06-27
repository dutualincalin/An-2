run: build
	java -cp bin game.Main

build:
	find -name "*.java" > sources
	rm -rf bin
	mkdir bin
	javac @sources -d bin

clean:
	rm -rf bin
	rm -rf sources
