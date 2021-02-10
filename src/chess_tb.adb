with Ada.Assertions; use Ada.Assertions;
with Ada.Text_IO; use Ada.Text_IO;

with Chess; use Chess;

package body Chess_tb is
    procedure test_get_piece_at is
        Unused_Bool : Boolean;
    begin
        Unused_Bool := Read_Fen("rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1", 56);

        for X in Range_Inner_Board loop
            if get_piece_at((X, 2)) /= (Pawn, White) then Put_Line("Chess_tb (test_get_piece_at) : White pawn incorrect"); end if;
        end loop;

        if get_piece_at((1, 1)) /= (Rook, White) then Put_Line("Chess_tb (test_get_piece_at) : White rook incorrect"); end if;
        if get_piece_at((2, 1)) /= (Knight, White) then Put_Line("Chess_tb (test_get_piece_at) : White knight incorrect"); end if;
        if get_piece_at((3, 1)) /= (Bishop, White) then Put_Line("Chess_tb (test_get_piece_at) : White bishop incorrect"); end if;
        if get_piece_at((4, 1)) /= (Queen, White) then Put_Line("Chess_tb (test_get_piece_at) : White queen incorrect"); end if;
        if get_piece_at((5, 1)) /= (King, White) then Put_Line("Chess_tb (test_get_piece_at) : White king incorrect"); end if;
        if get_piece_at((6, 1)) /= (Bishop, White) then Put_Line("Chess_tb (test_get_piece_at) : White bishop incorrect"); end if;
        if get_piece_at((7, 1)) /= (Knight, White) then Put_Line("Chess_tb (test_get_piece_at) : White knight incorrect"); end if;
        if get_piece_at((8, 1)) /= (Rook, White) then Put_Line("Chess_tb (test_get_piece_at) : White rook incorrect"); end if;
        Put_Line("Chess_tb - test_get_piece_at (White pieces) : finished");

        for X in Range_Inner_Board loop
            if get_piece_at((X, 7)) /= (Pawn, Black) then Put_Line("Chess_tb (test_get_piece_at) : Black pawn incorrect"); end if;
        end loop;

        if get_piece_at((1, 8)) /= (Rook, Black) then Put_Line("Chess_tb (test_get_piece_at) : Black rook incorrect"); end if;
        if get_piece_at((2, 8)) /= (Knight, Black) then Put_Line("Chess_tb (test_get_piece_at) : Black knight incorrect"); end if;
        if get_piece_at((3, 8)) /= (Bishop, Black) then Put_Line("Chess_tb (test_get_piece_at) : Black bishop incorrect"); end if;
        if get_piece_at((4, 8)) /= (Queen, Black) then Put_Line("Chess_tb (test_get_piece_at) : Black king incorrect"); end if;
        if get_piece_at((5, 8)) /= (King, Black) then Put_Line("Chess_tb (test_get_piece_at) : Black queen incorrect"); end if;
        if get_piece_at((6, 8)) /= (Bishop, Black) then Put_Line("Chess_tb (test_get_piece_at) : Black bishop incorrect"); end if;
        if get_piece_at((7, 8)) /= (Knight, Black) then Put_Line("Chess_tb (test_get_piece_at) : Black knight incorrect"); end if;
        if get_piece_at((8, 8)) /= (Rook, Black) then Put_Line("Chess_tb (test_get_piece_at) : Black rook incorrect"); end if;
        Put_Line("Chess_tb - test_get_piece_at (Black pieces) : finished");
    end test_get_piece_at;

    procedure test_read_fen is
    begin
        if (Read_Fen("rnbqkbnr/pppppppp/8/8/8/8/PPPPPP/RNBQKBNR w KQkq - 0 1", 54)) then Put_Line("Chess_tb (test_read_fen) : 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPP/RNBQKBNR w KQkq - 0 1' should be incorrect"); end if;
        if (Read_Fen("rnbqkbnr/pppppppp/8/6/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1", 56)) then Put_Line("Chess_tb (test_read_fen) : 'rnbqkbnr/pppppppp/8/6/8/8/PPPPPP/RNBQKBNR w KQkq - 0 1' should be incorrect"); end if;
        if (Read_Fen("rnbqkbvr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1", 56)) then Put_Line("Chess_tb (test_read_fen) : 'rnbqkbvr/pppppppp/8/8/8/8/PPPPPP/RNBQKBNR w KQkq - 0 1' should be incorrect"); end if;
        if (Read_Fen("rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR m KQkq - 0 1", 56)) then Put_Line("Chess_tb (test_read_fen) : 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPP/RNBQKBNR m KQkq - 0 1' should be incorrect"); end if;
        if (Read_Fen("rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KPkq - 0 1", 56)) then Put_Line("Chess_tb (test_read_fen) : 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPP/RNBQKBNR w KPkq - 0 1' should be incorrect"); end if;
        if (Read_Fen("rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq a9 0 1", 56)) then Put_Line("Chess_tb (test_read_fen) : 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPP/RNBQKBNR w KQkq a9 0 1' should be incorrect"); end if;
        if (Read_Fen("rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq y5 0 1", 56)) then Put_Line("Chess_tb (test_read_fen) : 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPP/RNBQKBNR w KQkq y5 0 1' should be incorrect"); end if;
        if (Read_Fen("rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq a3 a5 1", 56)) then Put_Line("Chess_tb (test_read_fen) : 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPP/RNBQKBNR w KQkq a9 0 1' should be incorrect"); end if;
        if (Read_Fen("rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 h1", 56)) then Put_Line("Chess_tb (test_read_fen) : 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPP/RNBQKBNR w KQkq a9 0 1' should be incorrect"); end if;
        Put_Line("Chess_tb - test_read_fen : finished");
    end test_read_fen;

    procedure test_chess_tb is
    begin
        test_get_piece_at;
        test_read_fen;
    end test_chess_tb;
end Chess_tb;