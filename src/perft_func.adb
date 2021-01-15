with Chess; use Chess;
with Move; use Move;

package body Perft_func is
	function play(b : in Board; x0 : in Integer; x1 : in Integer; y0 : in Integer; y1 : in Integer;
				  depth : in Integer; p : in Player) return Integer is
		b_copy : Board := b;
		prev : constant String := Character'Val(x0 + Character'Pos('A'))
					   			& Character'Val(y0 + Character'Pos('0'))
					   			& Character'Val(x1 + Character'Pos('A'))
					   			& Character'Val(y1 + Character'Pos('0'));
	begin
		if depth = 1 then
			return 1;
		end if;

		-- move piece
		b_copy(2 + x1, 2 + y1) := b_copy(2 + x0, 2 + y0);
		b_copy(2 + x0, 2 + y0) := Empty;

		return perft_all(b_copy, (if p = White then Black else White), depth - 1, prev);
	end play;

	function perft_pawn(b : in Board; x : in Integer; y : in Integer; depth : in Integer; p : in Player; prev : in String) return Integer is
		y1 : Integer := (if p = White then y + 1 else y - 1);
		n : Integer := 0;
	begin
		if is_valid_pawn(1, -1, x, y, x - 1, y1, p, prev) then
			n := n + play(b, x, x - 1, y, y1, depth, p);
		end if;

		if is_valid_pawn(1,  0, x, y, x    , y1, p, prev) then
			n := n + play(b, x, x    , y, y1, depth, p);
		end if;

		if is_valid_pawn(1,  1, x, y, x + 1, y1, p, prev) then
			n := n + play(b, x, x + 1, y, y1, depth, p);
		end if;

		return n;
	end perft_pawn;

	function perft_all(b : in Board; p : in Player; depth : in Integer; prev : in String) return Integer is
		n : Integer := 0;
	begin
		for y in 1..8 loop
			for x in 1..8 loop
				if get_player(b(2 + x, 2 + y)) = p then
					case b(2 + x, 2 + y) is
						when Pawn_white | Pawn_black	=> n := n + perft_pawn(b, x, y, depth, p, prev);
						-- FIXME
						when others						=> n := n + 1;
					end case;
				end if;
			end loop;
		end loop;

		return n;
	end perft_all;
end Perft_func;