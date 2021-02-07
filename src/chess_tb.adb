with Ada.Assertions; use Ada.Assertions;
with Ada.Text_IO; use Ada.Text_IO;

with Chess; use Chess;

package body Chess_tb is
    procedure test_get_piece_at is
		Unused_Bool : Boolean;
    begin
	    Unused_Bool := Read_Fen("rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1", 56);

		for X in Range_Inner_Board loop
			Assert(get_piece_at((X, 2)) = (Pawn, White), "Chess_tb (test_get_piece_at) : White pawn incorrect");
		end loop;

		Assert(get_piece_at((1, 1)) = (Rook, White), "Chess_tb (test_get_piece_at) : White rook incorrect");
        Assert(get_piece_at((2, 1)) = (Knight, White), "Chess_tb (test_get_piece_at) : White knight incorrect");
        Assert(get_piece_at((3, 1)) = (Bishop, White), "Chess_tb (test_get_piece_at) : White bishop incorrect");
        Assert(get_piece_at((4, 1)) = (Queen, White), "Chess_tb (test_get_piece_at) : White queen incorrect");
        Assert(get_piece_at((5, 1)) = (King, White), "Chess_tb (test_get_piece_at) : White king incorrect");
        Assert(get_piece_at((6, 1)) = (Bishop, White), "Chess_tb (test_get_piece_at) : White bishop incorrect");
        Assert(get_piece_at((7, 1)) = (Knight, White), "Chess_tb (test_get_piece_at) : White knight incorrect");
        Assert(get_piece_at((8, 1)) = (Rook, White), "Chess_tb (test_get_piece_at) : White rook incorrect");
		Put_Line("Chess_tb - test_get_piece_at (White pieces) : Success");

		for X in Range_Inner_Board loop
			Assert(get_piece_at((X, 2)) = (Pawn, Black), "Chess_tb (test_get_piece_at) : Black pawn incorrect");
		end loop;

		Assert(get_piece_at((1, 1)) = (Rook, Black), "Chess_tb (test_get_piece_at) : Black rook incorrect");
        Assert(get_piece_at((2, 1)) = (Knight, Black), "Chess_tb (test_get_piece_at) : Black knight incorrect");
        Assert(get_piece_at((3, 1)) = (Bishop, Black), "Chess_tb (test_get_piece_at) : Black bishop incorrect");
        Assert(get_piece_at((4, 1)) = (King, Black), "Chess_tb (test_get_piece_at) : Black king incorrect");
        Assert(get_piece_at((5, 1)) = (Queen, Black), "Chess_tb (test_get_piece_at) : Black queen incorrect");
        Assert(get_piece_at((6, 1)) = (Bishop, Black), "Chess_tb (test_get_piece_at) : Black bishop incorrect");
        Assert(get_piece_at((7, 1)) = (Knight, Black), "Chess_tb (test_get_piece_at) : Black knight incorrect");
        Assert(get_piece_at((8, 1)) = (Rook, Black), "Chess_tb (test_get_piece_at) : Black rook incorrect");
		Put_Line("Chess_tb - test_get_piece_at (Black pieces) : Success");
    end test_get_piece_at;

    procedure test_move_piece is
    begin
		move_piece(((1, 2), (1, 4)));
		Assert(Get_Piece_At((1, 4)) = (Pawn, White), "Chess_tb (test_move_piece) : Start move for White pawn incorrect");
		Move_Piece(((1, 4), (1, 5)));
		Assert(get_piece_at((1, 5)) = (Pawn, White), "Chess_tb (test_move_piece) : Normal move for White pawn incorrect");
		Put_Line("Chess_tb - test_move_piece (White pieces) : Success");

		move_piece(((1, 2), (1, 4)));
		Assert(get_piece_at((1, 4)) = (Pawn, Black), "Chess_tb (test_move_piece) : Start move for Black pawn incorrect");
		move_piece(((1, 4), (1, 5)));
		Assert(get_piece_at((1, 5)) = (Pawn, Black), "Chess_tb (test_move_piece) : Normal move for Black pawn incorrect");
		Put_Line("Chess_tb - test_move_piece (Black pieces) : Success");
    end test_move_piece;

	procedure test_chess_tb is
	begin
		test_get_piece_at;
		test_move_piece;
	end test_chess_tb;
end Chess_tb;