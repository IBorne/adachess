with Ada.Assertions; use Ada.Assertions;
with Ada.Text_IO; use Ada.Text_IO;

with Chess; use Chess;

package body Chess_tb is
    procedure test_get_piece_at is
    begin
		init_gameboard;

		for x in 1 .. 8 loop
			Assert(get_piece_at(x, 2, White) = Pawn_white, "Chess_tb (test_get_piece_at) : White pawn incorrect");
		end loop;

		Assert(get_piece_at(1, 1, White) = Rook_white, "Chess_tb (test_get_piece_at) : White rook incorrect");
        Assert(get_piece_at(2, 1, White) = Knight_white, "Chess_tb (test_get_piece_at) : White knight incorrect");
        Assert(get_piece_at(3, 1, White) = Bishop_white, "Chess_tb (test_get_piece_at) : White bishop incorrect");
        Assert(get_piece_at(4, 1, White) = Queen_white, "Chess_tb (test_get_piece_at) : White queen incorrect");
        Assert(get_piece_at(5, 1, White) = King_white, "Chess_tb (test_get_piece_at) : White king incorrect");
        Assert(get_piece_at(6, 1, White) = Bishop_white, "Chess_tb (test_get_piece_at) : White bishop incorrect");
        Assert(get_piece_at(7, 1, White) = Knight_white, "Chess_tb (test_get_piece_at) : White knight incorrect");
        Assert(get_piece_at(8, 1, White) = Rook_white, "Chess_tb (test_get_piece_at) : White rook incorrect");
		Put_Line("Chess_tb - test_get_piece_at (White pieces) : Success");

		for x in 1 .. 8 loop
			Assert(get_piece_at(x, 2, Black) = Pawn_black, "Chess_tb (test_get_piece_at) : Black pawn incorrect");
		end loop;

		Assert(get_piece_at(1, 1, Black) = Rook_black, "Chess_tb (test_get_piece_at) : Black rook incorrect");
        Assert(get_piece_at(2, 1, Black) = Knight_black, "Chess_tb (test_get_piece_at) : Black knight incorrect");
        Assert(get_piece_at(3, 1, Black) = Bishop_black, "Chess_tb (test_get_piece_at) : Black bishop incorrect");
        Assert(get_piece_at(4, 1, Black) = Queen_black, "Chess_tb (test_get_piece_at) : Black queen incorrect");
        Assert(get_piece_at(5, 1, Black) = King_black, "Chess_tb (test_get_piece_at) : Black king incorrect");
        Assert(get_piece_at(6, 1, Black) = Bishop_black, "Chess_tb (test_get_piece_at) : Black bishop incorrect");
        Assert(get_piece_at(7, 1, Black) = Knight_black, "Chess_tb (test_get_piece_at) : Black knight incorrect");
        Assert(get_piece_at(8, 1, Black) = Rook_black, "Chess_tb (test_get_piece_at) : Black rook incorrect");
		Put_Line("Chess_tb - test_get_piece_at (Black pieces) : Success");
    end test_get_piece_at;

    procedure test_move_piece is
    begin
		init_gameboard;
		move_piece(1, 2, 1, 4, White);
		Assert(get_piece_at(1, 4, White) = Pawn_white, "Chess_tb (test_move_piece) : Start move for White pawn incorrect");
		move_piece(1, 4, 1, 5, White);
		Assert(get_piece_at(1, 5, White) = Pawn_white, "Chess_tb (test_move_piece) : Normal move for White pawn incorrect");
		Put_Line("Chess_tb - test_move_piece (White pieces) : Success");

		init_gameboard;
		move_piece(1, 2, 1, 4, Black);
		Assert(get_piece_at(1, 4, Black) = Pawn_black, "Chess_tb (test_move_piece) : Start move for Black pawn incorrect");
		move_piece(1, 4, 1, 5, Black);
		Assert(get_piece_at(1, 5, Black) = Pawn_black, "Chess_tb (test_move_piece) : Normal move for Black pawn incorrect");
		Put_Line("Chess_tb - test_move_piece (Black pieces) : Success");
    end test_move_piece;

	procedure test_chess_tb is
	begin
		test_get_piece_at;
		test_move_piece;
	end test_chess_tb;
end Chess_tb;