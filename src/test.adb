with Ada.Command_Line; use Ada.Command_Line;

with chess; use chess;
with chess_tb; use chess_tb;
with move_tb; use move_tb;

procedure test is
begin
	for I in 1 .. Argument_Count loop
		if Argument(I) = "--debug" or Argument(I) = "-d" then
			Set_Debug(True);
		end if;
	end loop;

	test_chess_tb;
	test_move_tb;
end test;