with Ada.Text_IO; use Ada.Text_IO;
with Chess; use Chess;
with Move; use Move;

procedure main is
    Str     : String (1 .. 80);
    Last    : Natural;

	Move : Move_Type;

    function check_input return Boolean is
    begin
        Ada.Text_IO.Get_Line (Str, Last);

        if Str(1 .. Last)'Length /= 4 then
            return False;
        end if;

	    Move.Start.X := Character'Pos(Str(1)) - 96;
        Move.Start.Y := Character'Pos(Str(2)) - 48;
        Move.Target.X := Character'Pos(Str(3)) - 96;
        Move.Target.Y := Character'Pos(Str(4)) - 48;

        return True;
    exception
        when others => return False;
    end check_input;
begin
    Read_Fen("rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1", 56);
    Put_Line("Welcome to Adachess");

    while(True) loop -- is_game_end()
        Put_Line((if Player = White then "White" else "Black") & " to move:");
	    Print;

        -- TODO: take care of castling

        if not check_input then
            if Str(1 .. 4) = "quit" then
                Put_Line((if Player = White then "Black" else "White") & " win ! exiting game.");
                exit;
            end if;
            Put_Line("Wrong input, Usage: a2a4.");
        elsif not is_valid_move(Move, Player) then
            Put_Line("Input a valid move.");
        else
            -- TODO: take care of cases where king is check
            -- TODO: transform a pawn into queen if pawn at last row
            move_piece(Move);
			End_Turn;
        end if;
    end loop;
end main;
