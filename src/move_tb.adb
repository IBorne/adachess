with Ada.Assertions; use Ada.Assertions;
with Ada.Text_IO; use Ada.Text_IO;

with Chess; use Chess;
with Move; use Move;

package body Move_tb is
    procedure test_is_valid_pawn is
    begin
        if Read_Fen("R7/6K1/BRPr4/5P2/4pPP1/4k3/1p1p3N/Q6q w - - 0 1", 47) = False then Put_Line("Move_tb (test_is_valid_pawn) - 'R7/6K1/BRPr4/5P2/4pPP1/4k3/1p1p3N/Q6q w - - 0 1' should be a valid FEN"); end if;
        if is_valid_move(((3, 6), (3, 6)), White) then Put_Line("Move_tb (test_is_valid_pawn) - b6c6 should be invalid"); end if;

        if Read_Fen("8/2r2p2/5P2/P4Q2/P1k1n1PB/K1P5/p6P/1R1n4 w - - 0 1", 50) = False then Put_Line("Move_tb (test_is_valid_pawn) - '8/2r2p2/5P2/P4Q2/P1k1n1PB/K1P5/p6P/1R1n4 w - - 0 1' should be a valid FEN"); end if;
        if is_valid_move(((1, 5), (1, 7)), White) then Put_Line("Move_tb (test_is_valid_pawn) - a5a7 should be invalid"); end if;
        if is_valid_move(((1, 5), (2, 6)), White) then Put_Line("Move_tb (test_is_valid_pawn) - a5b6 should be invalid"); end if;
        if is_valid_move(((6, 6), (6, 7)), White) then Put_Line("Move_tb (test_is_valid_pawn) - f6f7 should be invalid"); end if;

        Put_Line("Move_tb - test_is_valid_pawn : finished");
    end test_is_valid_pawn;

    procedure test_is_valid_rook is
    begin
        if Read_Fen("R7/6K1/BRPr4/5P2/4pPP1/4k3/1p1p3N/Q6q w - - 0 1", 47) = False then Put_Line("Move_tb (test_is_valid_rook) - 'R7/6K1/BRPr4/5P2/4pPP1/4k3/1p1p3N/Q6q w - - 0 1' should be a valid FEN"); end if;
        if is_valid_move(((2, 6), (3, 6)), White) then Put_Line("Move_tb (test_is_valid_rook) - b6c6 should be invalid"); end if;
        if is_valid_move(((2, 6), (4, 6)), White) then Put_Line("Move_tb (test_is_valid_rook) - b6d6 should be invalid"); end if;
        if is_valid_move(((2, 6), (5, 6)), White) then Put_Line("Move_tb (test_is_valid_rook) - b6e6 should be invalid"); end if;
        if is_valid_move(((2, 6), (6, 6)), White) then Put_Line("Move_tb (test_is_valid_rook) - b6f6 should be invalid"); end if;
        if is_valid_move(((2, 6), (2, 1)), White) then Put_Line("Move_tb (test_is_valid_rook) - b6b1 should be invalid"); end if;
        if is_valid_move(((2, 6), (1, 7)), White) then Put_Line("Move_tb (test_is_valid_rook) - b6a7 should be invalid"); end if;

        Put_Line("Move_tb - test_is_valid_rook : finished");
    end test_is_valid_rook;

    procedure test_is_valid_knight is
    begin
        if Read_Fen("4B3/1b2q3/p2pP1P1/4p1P1/1n1P4/1K4p1/8/3rB1k1 w - - 0 1", 54) = False then Put_Line("Move_tb (test_is_valid_knight) - '4B3/1b2q3/p2pP1P1/4p1P1/1n1P4/1K4p1/8/3rB1k1 w - - 0 1' should be a valid FEN"); end if;
        if is_valid_move(((2, 4), (2, 5)), White) then Put_Line("Move_tb (test_is_valid_knight) - b4b5 should be invalid"); end if;
        if is_valid_move(((2, 4), (2, 6)), White) then Put_Line("Move_tb (test_is_valid_knight) - b4b6 should be invalid"); end if;
        if is_valid_move(((2, 4), (1, 4)), White) then Put_Line("Move_tb (test_is_valid_knight) - b4a4 should be invalid"); end if;
        if is_valid_move(((2, 4), (1, 5)), White) then Put_Line("Move_tb (test_is_valid_knight) - b4a5 should be invalid"); end if;
        if is_valid_move(((2, 4), (0, 6)), White) then Put_Line("Move_tb (test_is_valid_knight) - b4?6 should be invalid"); end if;
        if is_valid_move(((2, 4), (1, 6)), White) then Put_Line("Move_tb (test_is_valid_knight) - b4a6 should be invalid"); end if;

        Put_Line("Move_tb - test_is_valid_knight : finished");
    end test_is_valid_knight;

    procedure test_is_valid_bishop is
    begin
        if Read_Fen("R7/6K1/BRPr4/5P2/4pPP1/4k3/1p1p3N/Q6q w - - 0 1", 47) = False then Put_Line("Move_tb (test_is_valid_bishop) - 'R7/6K1/BRPr4/5P2/4pPP1/4k3/1p1p3N/Q6q w - - 0 1' should be a valid FEN"); end if;
        if is_valid_move(((1, 6), (1, 4)), White) then Put_Line("Move_tb (test_is_valid_bishop) - a6a4 should be invalid"); end if;
        if is_valid_move(((1, 6), (2, 4)), White) then Put_Line("Move_tb (test_is_valid_bishop) - a6b4 should be invalid"); end if;

        Put_Line("Move_tb - test_is_valid_bishop : finished");
    end test_is_valid_bishop;

    procedure test_is_valid_queen is
    begin
        if Read_Fen("R7/6K1/BRPr4/5P2/4pPP1/4k3/1p1p3N/Q6q w - - 0 1", 47) = False then Put_Line("Move_tb (test_is_valid_queen) - 'R7/6K1/BRPr4/5P2/4pPP1/4k3/1p1p3N/Q6q w - - 0 1' should be a valid FEN"); end if;
        if is_valid_move(((1, 1), (3, 3)), White) then Put_Line("Move_tb (test_is_valid_queen) - a1c3 should be invalid"); end if;
        if is_valid_move(((1, 1), (5, 5)), White) then Put_Line("Move_tb (test_is_valid_queen) - a1e5 should be invalid"); end if;
        if is_valid_move(((1, 1), (4, 5)), White) then Put_Line("Move_tb (test_is_valid_queen) - a1d5 should be invalid"); end if;

        Put_Line("Move_tb - test_is_valid_queen : finished");
    end test_is_valid_queen;

    procedure test_is_valid_king is
    begin
        if Read_Fen("R7/6K1/BRPr4/5P2/4pPP1/4k3/1p1p3N/Q6q w - - 0 1", 47) = False then Put_Line("Move_tb (test_is_valid_king) - 'R7/6K1/BRPr4/5P2/4pPP1/4k3/1p1p3N/Q6q w - - 0 1' should be a valid FEN"); end if;
        if is_valid_move(((7, 7), (6, 6)), White) then Put_Line("Move_tb (test_is_valid_king) - g7f6 should be invalid"); end if;
        if is_valid_move(((7, 7), (7, 6)), White) then Put_Line("Move_tb (test_is_valid_king) - g7g6 should be invalid"); end if;
        if is_valid_move(((7, 7), (8, 6)), White) then Put_Line("Move_tb (test_is_valid_king) - g7h6 should be invalid"); end if;

        if Read_Fen("8/2r2p2/5P2/P4Q2/P1k1n1PB/K1P5/p6P/1R1n4 w - - 0 1", 50) = False then Put_Line("Move_tb (test_is_valid_king) - '8/2r2p2/5P2/P4Q2/P1k1n1PB/K1P5/p6P/1R1n4 w - - 0 1' should be a valid FEN"); end if;
        if is_valid_move(((1, 3), (0, 3)), White) then Put_Line("Move_tb (test_is_valid_king) - a3?3 should be invalid"); end if;
        if is_valid_move(((1, 3), (2, 3)), White) then Put_Line("Move_tb (test_is_valid_king) - a3b3 should be invalid"); end if;
        if is_valid_move(((1, 3), (2, 2)), White) then Put_Line("Move_tb (test_is_valid_king) - a3b2 should be invalid"); end if;

        Put_Line("Move_tb - test_is_valid_king : finished");
    end test_is_valid_king;

	procedure test_move_tb is
	begin
		test_is_valid_pawn;
		test_is_valid_rook;
		test_is_valid_knight;
		test_is_valid_bishop;
		test_is_valid_queen;
		test_is_valid_king;
	end test_move_tb;
end Move_tb;