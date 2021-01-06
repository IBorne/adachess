with Ada.Text_IO; use Ada.Text_IO;
with Chess; use Chess;
with Move; use Move;

procedure main is
    last_valid_move : Boolean := True;
    Str     : String (1 .. 80);
    Last    : Natural;

    x_start : Integer;
    y_start : Integer;
    x_end   : Integer;
    y_end   : Integer;

    -- previous move
    prev    : String(1 .. 5) := "     ";

    function check_input return Boolean is
    begin
        Ada.Text_IO.Get_Line (Str, Last);
        if Str(1 .. Last)'Length /= 5 then
            return False;
        end if;
        x_start := Character'Pos(Str(1)) - Character'Pos('A') + 1;
        y_start := Integer'Value(Str(2 .. 2));
        x_end := Character'Pos(Str(4)) - Character'Pos('A') + 1;
        y_end := Integer'Value(Str(5 .. 5));

        return True;
    exception
            when others => return False;
    end check_input;
begin
    init_gameboard;
    Put_Line("Welcome to Adachess");

    while(True) loop -- is_game_end()
        if last_valid_move then
            last_valid_move := True;
	    print_gameboard(side);
                Put_Line("");
        end if;

        Put_Line((if side = White then "White" else "Black") & " to move:");

        -- TODO: take care of castling

        if not check_input then
            if Str(1 .. 4) = "quit" then
                Put_Line((if side = White then "Black" else "White") & " win ! exiting game.");
                exit;
            end if;
            Put("Wrong input, Usage:E2 E4. ");
            last_valid_move := False;
        elsif not is_valid_move(x_start, y_start, x_end, y_end, side, prev) then
            Put("Input a valid move. ");
            last_valid_move := False;
        else
            -- TODO: take care of cases where king is check
            -- TODO: transform a pawn into queen if pawn at last row

            move_piece(x_start, y_start, x_end, y_end, side);

            prev := Str(1 .. 5);
            side := (if side = White then Black else White);
            last_valid_move := True;
        end if;
      end loop;
end main;
