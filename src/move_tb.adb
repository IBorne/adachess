with Ada.Assertions; use Ada.Assertions;
with Ada.Text_IO; use Ada.Text_IO;

with Chess; use Chess;
with Move; use Move;

package body Move_tb is
    procedure test_get_player is
    begin
		for w in white_range loop
			Assert(get_player(Cell'Val(w)) = White, "Move_tb (test_get_player) : White range incorrect");
		end loop;
		Put_Line("Move_tb - test_get_player (White range) : Success");

		for b in black_range loop
			Assert(get_player(Cell'Val(b)) = Black, "Move_tb (test_get_player) : Black range incorrect");
		end loop;
		Put_Line("Move_tb - test_get_player (Black range) : Success");
    end test_get_player;

    procedure test_is_valid_pawn is
    begin
		Assert(valid_piece_move(1, 2, 1, 3, White, ""), "Move_tb (test_is_valid_pawn) : Normal move (2 -> 3) incorrect");

		Assert(valid_piece_move(1, 2, 1, 4, White, ""), "Move_tb (test_is_valid_pawn) : Start move (2 -> 4) incorrect");
		move_piece(1, 2, 1, 4, White);
		Assert(valid_piece_move(1, 4, 1, 5, White, ""), "Move_tb (test_is_valid_pawn) : Normal move (4 -> 5) incorrect");
    end test_is_valid_pawn;

    procedure test_is_valid_rook is
    begin
		Assert(True);
    end test_is_valid_rook;

    procedure test_is_valid_knight is
    begin
		Assert(True);
    end test_is_valid_knight;

    procedure test_is_valid_bishop is
    begin
		Assert(True);
    end test_is_valid_bishop;

    procedure test_is_valid_queen is
    begin
		Assert(True);
    end test_is_valid_queen;

    procedure test_is_valid_king is
    begin
		Assert(True);
    end test_is_valid_king;

    procedure test_valid_piece_move is
    begin
		Assert(True);
    end test_valid_piece_move;

    procedure test_is_valid_move is
    begin
		Assert(True);
    end test_is_valid_move;

	procedure test_move_tb is
	begin
		test_get_player;
		test_is_valid_pawn;
		test_is_valid_rook;
		test_is_valid_knight;
		test_is_valid_bishop;
		test_is_valid_queen;
		test_is_valid_king;
		test_valid_piece_move;
		test_is_valid_move;
	end test_move_tb;
end Move_tb;