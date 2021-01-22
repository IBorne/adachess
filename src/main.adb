with Ada.Text_IO; use Ada.Text_IO;
with Chess; use Chess;
with Move; use Move;

procedure main is
    Str     : String (1 .. 80);
    Last    : Natural;

	Move : Move_Type;

    function check_input return Boolean is
    begin
        Get_Line(Str, Last);

        -- TODO: take care of castling

        if Str(1 .. Last)'Length /= 4 then
            return False;
        end if;

	    Move.Start.X := Character'Pos(Str(Str'First + 0)) - 96;
        Move.Start.Y := Character'Pos(Str(Str'First + 1)) - 48;
        Move.Target.X := Character'Pos(Str(Str'First + 2)) - 96;
        Move.Target.Y := Character'Pos(Str(Str'First + 3)) - 48;

        return True;
    exception
        when others => return False;
    end check_input;

	function get_player_name(Player : in Player_Type) return String is
	begin
		return (if Player = White then "White" else "Black");
	end get_player_name;
begin
    Read_Fen("rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1", 56);
    Put_Line("Welcome to Adachess");

    while(True) loop -- is_game_end()
		Put_Line("");
        Put_Line(get_player_name(Player) & " to move:");
	    Print;
		Put_Line("");

        if not check_input then
            if Str(1 .. 4) = "quit" then
				Put_Line("");
                Put_Line(get_player_name(Player) & " win ! exiting game.");
                exit;
            end if;
            Put_Line("Invalid input. Usage: a2a4.");
        elsif not is_valid_move(Move, Player) then
            Put_Line("Invalid move : " & Str(1 .. Last));
        else
            move_piece(Move);
			if End_Turn then
				Put_Line(get_player_name(Player) & "'s King checkmate.");
				exit;
			end if;
        end if;
    end loop;
end main;
