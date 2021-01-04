package body Chess is
	-- TODO: continue function
	function is_valid_move(x_start : in Integer; y_start : in Integer; x_end : in Integer; y_end : in Integer; p : in Player) return Boolean is
		function get_player(c : in Cell) return Player is
--			with Pre => Cell'Pos(c) in white_range or Cell'Pos(c) in black_range;
		begin
			return (if Cell'Pos(c) in white_range then White else Black);
		end get_player;

		function is_valid_pawn(delta_x : in Integer; delta_y : in Integer; x_start : in Integer; y_start : in Integer) return Boolean is
		begin
			-- FIXME
			return True;
		end is_valid_pawn;

		function is_valid_rook(delta_x : in Integer; delta_y : in Integer) return Boolean is
		begin
			return delta_x = 0 or delta_y = 0;
		end is_valid_rook;

		function is_valid_knight(delta_x : in Integer; delta_y : in Integer) return Boolean is
		begin
			return (abs delta_x = 1 and abs delta_y = 3)
				or (abs delta_x = 3 and abs delta_y = 1);
		end is_valid_knight;

		function is_valid_bishop(delta_x : in Integer; delta_y : in Integer) return Boolean is
		begin
			return abs delta_x = abs delta_y;
		end is_valid_bishop;

		function is_valid_queen(delta_x : in Integer; delta_y : in Integer) return Boolean is
		begin
			return is_valid_knight(delta_x, delta_y)
				or is_valid_bishop(delta_x, delta_y);
		end is_valid_queen;

		function is_valid_king(delta_x : in Integer; delta_y : in Integer) return Boolean is
		begin
			return abs delta_x = 1 or abs delta_y = 1;
		end is_valid_king;

		function valid_piece_move(x_start : in Integer; y_start : in Integer; x_end : in Integer; y_end : in Integer) return Boolean is
--			with Pre => Chess.game_board(x_start, y_start) /= empty
--					and Chess.game_board(x_start, y_start) /= forbidden;

			delta_x : constant Integer := (x_end - x_start);
			delta_y : constant Integer := (y_end - y_start);
		begin
			case Chess.game_board(x_start, y_start) is
				when Pawn_white 					=> return is_valid_pawn(x_start, x_end, delta_x, delta_y);
				-- FIXME: mirror the move
				when Pawn_black 					=> return True;
				when Rook_white 	| Rook_black 	=> return is_valid_rook(delta_x, delta_y);
				when Knight_white 	| Knight_black 	=> return is_valid_knight(delta_x, delta_y);
				when Bishop_white 	| Bishop_black 	=> return is_valid_bishop(delta_x, delta_y);
				when Queen_white 	| Queen_black 	=> return is_valid_queen(delta_x, delta_y);
				when King_white 	| King_black	=> return is_valid_king(delta_x, delta_y);
				when Empty			| Forbidden		=> return False;
			end case;
		end valid_piece_move;
  	begin
--        Put_Line("x_start :" & Integer'Image(x_start) & ".");
		-- Out of Bounds check
    	if Chess.game_board(x_end, y_end) = forbidden then
    		return False;
    	end if;

		-- Check if start piece is valid
		if Chess.game_board(x_start, y_start) = empty
			or Chess.game_board(x_start, y_start) = forbidden
			or get_player(Chess.game_board(x_end, y_end)) /= p then
			return False;
		end if;

		-- Check if end piece is ennemy (yes, you can't kill your allies)
		if get_player(Chess.game_board(x_end, y_end)) = p then
			return False;
		end if;

		return valid_piece_move(x_start, y_start, x_end, y_end);
	end is_valid_move;

	procedure init_gameboard is
	begin
    	for number in 1 .. 12 loop
    		for letter in 1 .. 12 loop
        		Chess.game_board(letter, number) := forbidden;
      		end loop;
    	end loop;

    	for number in 5 .. 8 loop
      		for letter in 3 .. 10 loop
        		Chess.game_board(letter,number) := empty;
      		end loop;
    	end loop;

    	for letter in 3 .. 10 loop
      		Chess.game_board(letter, 4) := pawn_white;
    	end loop;

    	for letter in 3 .. 10 loop
      		Chess.game_board(letter, 9) := pawn_black;
    	end loop;

		Chess.game_board(3,3) := rook_white;
		Chess.game_board(4,3) := knight_white;
		Chess.game_board(5,3) := bishop_white;
		Chess.game_board(6,3) := queen_white;
		Chess.game_board(7,3) := king_white;
		Chess.game_board(8,3) := bishop_white;
		Chess.game_board(9,3) := knight_white;
		Chess.game_board(10,3) := rook_white;

		Chess.game_board(3,10) := rook_black;
		Chess.game_board(4,10) := knight_black;
		Chess.game_board(5,10) := bishop_black;
		Chess.game_board(6,10) := queen_black;
		Chess.game_board(7,10) := king_black;
		Chess.game_board(8,10) := bishop_black;
		Chess.game_board(9,10) := knight_black;
		Chess.game_board(10,10) := rook_black;

  	end init_gameboard;

  	procedure move_piece(x_start : in Integer; y_start : in Integer; x_end : in Integer; y_end : in Integer) is
  	begin
    	--get board piece, move it the new coord
    	Chess.game_board(x_end, y_end) := Chess.game_board(x_start, y_start);
    	Chess.game_board(x_start, y_start) := empty;
 	end;

  	procedure print_gameboard is
    	procedure print_cell(c : Cell) is
    	begin
      		case c is
        		when empty        => Put(".");
        		when forbidden    => Put("X");
        		when pawn_white   => Put("P");
        		when rook_white   => Put("R");
        		when knight_white => Put("N");
				when bishop_white => Put("B");
				when queen_white  => Put("Q");
				when king_white   => Put("K");
				when pawn_black   => Put("p");
				when rook_black   => Put("r");
				when knight_black => Put("n");
				when bishop_black => Put("b");
				when queen_black  => Put("q");
				when king_black   => Put("k");
      		end case;
    	end print_cell;
  	begin
    	for letter in 3 .. 10 loop
      		for number in 3 .. 10 loop
        		print_cell(Chess.game_board(letter, number));
      		end loop;
      		Put_Line("");
    	end loop;
  	end print_gameboard;
end Chess;
