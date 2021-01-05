with Ada.Text_IO; use Ada.Text_IO;
with Chess; use Chess;

procedure main is
    Str     : String (1 .. 80);
    Last    : Natural;

    x_start : Integer;
    y_start : Integer;
    x_end   : Integer;
    y_end   : Integer;

    -- previous move
    prev    : String(1 .. 5) := "     ";

    side    : Player := White;

    function check_input return Boolean is
    begin
        Ada.Text_IO.Get_Line (Str, Last);
        Put_Line ("." & Str(1 .. Last) & ".");
        Put_Line("length:" & Integer'Image(Str(1 .. Last)'Length));
        if Str(1 .. Last)'Length /= 5 then
            return False;
        end if;
        x_start := Character'Pos(Str(1)) - Character'Pos('A') + 3;
        y_start := Integer'Value(Str(2 .. 2)) + 2;
        x_end := Character'Pos(Str(4)) - Character'Pos('A') + 3;
        y_end := Integer'Value(Str(5 .. 5)) + 2;
        return True;
    end check_input;
begin
    init_gameboard;
    print_gameboard;
    Put_Line("Welcome to Adachess");

    while(True) loop -- is_game_end()
        Put_Line((if side = White then "White" else "Black") & " to move:");

        -- TODO: take care of castling

        if check_input = False then
            Put_Line("Wrong input. Usage:E2 E4");
        elsif not is_valid_move(x_start, y_start, x_end, y_end, side, prev) then
            Put_Line("Input a valid move");
        else
            -- TODO: take care of cases where king is check
            -- TODO: transform a pawn into queen if pawn at last row

            move_piece(x_start, y_start, x_end, y_end, side);
            print_gameboard;

            prev := Str(1 .. 5);
            side := (if side = White then Black else White);
        end if;
      end loop;
end main;
