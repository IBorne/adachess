with Ada.Command_Line; use Ada.Command_Line;
with Ada.Text_IO; use Ada.Text_IO;

with Chess; use Chess;
with Move; use Move;

procedure Test_Game is
	function Parse_Move(Str : String) return Move_Type is
		Move : Move_Type;
	begin
		if Str'Length = 4 then
			return ((0, 0), (0, 0));
		end if;

		Move.Start.X := Character'Pos(Str(Str'First + 0)) - 96;
        Move.Start.Y := Character'Pos(Str(Str'First + 1)) - 48;
        Move.Target.X := Character'Pos(Str(Str'First + 2)) - 96;
        Move.Target.Y := Character'Pos(Str(Str'First + 3)) - 48;

		return Move;
	exception
		when others => return ((0, 0), (0, 0));
	end Parse_Move;

    File : File_Type;
	Line : Integer;
begin
	if Argument_Count < 1 then
		Put_Line("Usage: ./test_game <path/to/file>");
		return;
	end if;

	for I in 1 .. Argument_Count loop
	    Read_Fen("rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1", 56);

		Line := 1;
		declare
		begin
			Open(File,
				Mode => In_File,
				Name => Argument(I));

			while not End_Of_File(File) loop
				declare
					Move_Str : String := Get_Line(File); 
					Move : Move_Type := Parse_Move(Move_Str);
				begin
					if Move_Str /= "" and Move.Start /= Move.Target then
						if is_valid_move(Move, Player) then
							move_piece(Move);
							if End_Turn then
								Put_Line((if Player = White then "White" else "Black") & " won.");
								Print;
								Put_Line("");
								exit;
							end if;

							Line := Line + 1;
						else
							Put_Line("Failed to move at line " & Integer'Image(Line)
								& " of file " & Argument(I) & ": " & Move_Str);
							Print;
							Put_Line("");

							exit;
						end if;
					end if;
				end;
			end loop;

			Close(File);
		exception
			when Name_Error =>
				Put_Line("Couldn't find file " & Argument(I));
				Put_Line("");
		end;
	end loop;
end Test_Game;