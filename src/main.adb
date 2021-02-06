with Ada.Text_IO; use Ada.Text_IO;
with Chess; use Chess;
with Move; use Move;

with Ada.Command_Line; use Ada.Command_Line;

procedure main is
	Move : Move_Type;

    function Check_Move(Str : String) return Boolean is
    begin
        if Str'Length /= 4 then
            return False;
        end if;

		if     not ('a' <= Str(Str'First + 0) and Str(Str'First + 0) <= 'h')
			or not ('0' <= Str(Str'First + 1) and Str(Str'First + 1) <= '8')
			or not ('a' <= Str(Str'First + 2) and Str(Str'First + 2) <= 'h')
			or not ('0' <= Str(Str'First + 3) and Str(Str'First + 3) <= '8') then
			return False;
		end if;

	    Move.Start.X := Character'Pos(Str(Str'First + 0)) - 96;
        Move.Start.Y := Character'Pos(Str(Str'First + 1)) - 48;
        Move.Target.X := Character'Pos(Str(Str'First + 2)) - 96;
        Move.Target.Y := Character'Pos(Str(Str'First + 3)) - 48;

        return True;
    exception
        when others => return False;
    end Check_Move;

	function Check_Validity(Str : String) return Boolean is
	begin
		if Str = "O-O" then
			if not is_valid_castling(Kingside, Player) then
				Put_Line("Invalid Kingside Castle : " & Str);
				return False;
			end if;

			Move_Castling(Kingside, Player);
		elsif Str = "O-O-O" then
			if not is_valid_castling(Queenside, Player) then
				Put_Line("Invalid Queenside Castle : " & Str);
				return False;
			end if;

			Move_Castling(Queenside, Player);
		elsif Check_Move(Str) then
			if not is_valid_move(Move, Player) then
				Put_Line("Invalid move : " & Str);
				return False;
			end if;

			move_piece(Move);
		else
			Put_Line("Invalid input : " & Str & ". Use help for more info.");
			return False;
		end if;

		return True;
	end Check_Validity;
begin
    Read_Fen("rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1", 56);
    Put_Line("Welcome to Adachess");

	for I in 1 .. Argument_Count loop
		if Argument(I) = "-d" or Argument(I) = "--debug" then
			Set_Debug(True);
		end if;
	end loop;

    while True loop
		Put_Line("");
        Put_Line(get_player_name(Player) & " to move:");
	    Print;
		Put_Line("");

		declare
			Move_Str : String := Get_Line;
		begin
			if Move_Str /= "" then
				if Move_Str = "exit" then
					exit;
				elsif Move_Str = "h" or Move_Str = "help" then
					Put_Line("List of commands :");
					Put_Line("    help: print the list of commands");
					Put_Line("    exit: exit the game");
					Put_Line("    [a-h][1-8][a-h][1-8]: move a piece");
					Put_Line("    O-O: perform a Kingside Castling");
					Put_Line("    O-O-O: perform a Queenside Castling");
				elsif Check_Validity(Move_Str) then
					if End_Turn then
						Put_Line((if Player = Black then "White" else "Black") & " won.");
						exit;
					end if;
				end if;
			end if;
		end;
    end loop;
end main;
