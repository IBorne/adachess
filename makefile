CC=gnatmake
SRC=src/chess.adb src/move.adb
LIB=

BIN = main test game_test gui #perft

all: ${BIN}

main: ${SRC} src/main.adb
	${CC} ${LIB} $^

test: ${SRC} src/chess_tb.adb src/move_tb.adb src/test.adb
	${CC} ${LIB} $^ 

#perft: ${SRC} src/perft.adb src/perft_func.adb
#	${CC} ${LIB} $^

game_test: ${SRC} src/test_game.adb
	${CC} ${LIB} $^

gui: ${SRC} src/gui.adb
	${CC} ${LIB} $^

clean:
	${RM} *.ali *.o ${BIN}
