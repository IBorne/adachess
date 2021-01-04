with Ada.Text_IO; use Ada.Text_IO;
with Chess; use Chess;

procedure main is
  Str  : String (1 .. 80);
  Last : Natural;
  x_start : Integer;
  y_start : Integer;
  x_end : Integer;
  y_end : Integer;
begin
  init_gameboard;
  print_gameboard;
  Put_Line("Welcome to Adachess");
  Put_Line("white to move:");

  Main_Loop:
  while(True) loop -- is_game_end()
    Ada.Text_IO.Get_Line (Str, Last);
    x_start := Integer'Value(Str(1 .. 1));
    y_start := Integer'Value(Str(2 .. 2));
    x_end := Integer'Value(Str(4 .. 4));
    y_end := Integer'Value(Str(5 .. 5));

    if not is_valid_move(x_start, y_start, x_end, y_end) then
      Put_Line("Input a valid move");
    else
      move_piece(x_start, y_start, x_end, y_end);
      print_gameboard;
    end if;
  end loop Main_Loop;
end main;
