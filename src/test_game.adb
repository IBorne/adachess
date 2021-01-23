with Ada.Command_Line; use Ada.Command_Line;
with Ada.Text_IO; use Ada.Text_IO;

with Chess; use Chess;
with Move; use Move;

procedure Test_Game is
	function Parse_Move(Str : String) return Move_Type is
		Move : Move_Type;
	begin
		if Str'Length /= 4 then
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
					if Move_Str /= "" then
						if     (Move_Str = "O-O" and is_valid_castling(Kingside, Player))
							or (Move_Str = "O-O-O" and is_valid_castling(Queenside, Player))
							or (Move.Start /= Move.Target and is_valid_move(Move, Player)) then
							if Move_Str = "O-O" then
								Move_Castling(Kingside, Player);
							elsif Move_Str = "O-O-O" then
								Move_Castling(Queenside, Player);
							else
								move_piece(Move);
							end if;

							if End_Turn then
								Put_Line((if Player = White then "White" else "Black") & " won.");
								exit;
							end if;
						else
							Put_Line("Invalid input at line" & Integer'Image(Line)
								& " of file " & Argument(I) & ": " & Move_Str);
							exit;
						end if;
					end if;

					Line := Line + 1;
				end;
			end loop;

			Player := White;
			Put_Line("");
			Print;
			Put_Line("");
			Put_Line("");

			Close(File);
		exception
			when Name_Error =>
				Put_Line("Couldn't find file " & Argument(I));
				Put_Line("");
		end;
	end loop;
end Test_Game;