CC=gnatmake
SRC=src/chess.adb src/move.adb
LIB=

all: main test

main: ${SRC} src/main.adb
	${CC} ${LIB} $^

test: ${SRC} src/chess_tb.adb src/move_tb.adb src/test.adb
	${CC} ${LIB} $^ 

clean:
	${RM} *.ali *.o main test
