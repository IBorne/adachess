CC=gnatmake
SRC=src/chess.adb src/move.adb
LIB=

all: main test #perft

main: ${SRC} src/main.adb
	${CC} ${LIB} $^

test: ${SRC} src/chess_tb.adb src/move_tb.adb src/test.adb
	${CC} ${LIB} $^ 

#perft: ${SRC} src/perft.adb src/perft_func.adb
#	${CC} ${LIB} $^

clean:
	${RM} *.ali *.o main test
