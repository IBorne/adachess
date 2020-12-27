CC=gnatmake
SRC=src/main.adb src/chess.adb
LIB=

all:
	${CC} ${LIB} ${SRC}
