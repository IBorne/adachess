with Ada.Command_Line; use Ada.Command_Line;
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Exceptions; use Ada.Exceptions;

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

	function Check_Validity(Str : String; Move : Move_Type) return Boolean is
	begin
		if Str = "O-O" then
			if not is_valid_castling(Kingside, Player) then
				return False;
			end if;

			Move_Castling(Kingside, Player);
		elsif Str = "O-O-O" then
			if not is_valid_castling(Queenside, Player) then
				return False;
			end if;

			Move_Castling(Queenside, Player);
		elsif Move.Start /= Move.Target then
			if not is_valid_move(Move, Player) then
				return False;
			end if;

			move_piece(Move);
		else
			return False;
		end if;

		return True;
	end Check_Validity;

    File : File_Type;
	Line : Integer;
	Unused_Bool : Boolean;
begin
	if Argument_Count < 1 then
		Put_Line("Usage: ./test_game <path/to/file>");
		return;
	end if;

	for I in 1 .. Argument_Count loop
		if Argument(I) = "--debug" or Argument(I) = "-d" then
			Set_Debug(True);
		elsif Argument(I) = "--print" or Argument(I) = "-p" then
		       Set_Print(True);	
		else
			Unused_Bool := Read_Fen("rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1", 56);

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
							Print_Board_Debug;
							if Check_Validity(Move_Str, Move) then
								if End_Turn then
									exit;
								end if;
							else
								Put_Line("Invalid input at line" & Integer'Image(Line)
									& " of file " & Argument(I) & ": " & Move_Str);
								exit;
							end if;
						end if;

						Line := Line + 1;

					exception
						when Err: Constraint_Error =>
							Print_Debug(Exception_Message(Err));
							Reraise_Occurrence(Err);
					end;
				end loop;

				if End_Of_File(File) then
					Put_Line(Get_Player_Name(Get_Enemy(Player)) & " won.");
				end if;

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
		end if;
	end loop;
end Test_Game;
