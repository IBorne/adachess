package body Chess is

  procedure move_piece(x_start : in X; y_start : in Y; x_end : in X; y_end : in Y) is
  begin
    --get board piece, move it the new coord
    game_board(x_end, y_end) := game_board(x_start, y_start);
    game_board(x_start, y_start) := empty;
  end
end Chess;
