with Ada.Text_IO; use Ada.Text_IO;
with Chess; use Chess;
with Perft_func; use Perft_func;

procedure perft is
	function parse_board return Board is
		b : Board;
	begin
		for y in 1..12 loop
			for x in 1..12 loop
				b(x, y) := Forbidden;
			end loop;
		end loop;

		-- FIXME

		return b;
	end parse_board;

	depth : Integer := 0;
	b : Board := parse_board;
begin
	Put_Line("Perft " & Integer'Image(depth) & " : " & Integer'Image(perft_all(b, White, depth, "")));
end perft;