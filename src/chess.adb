package body Chess is

  function is_valid_move(x_start : in Integer; y_start : in Integer; x_end : in Integer; y_end : in Integer) return Boolean is
  begin
    if Chess.game_board(x_end, y_end) = forbidden then
      return False;
    end if;
    return True;
  end is_valid_move;

  procedure init_gameboard is
  begin
    for number in 1 .. 12 loop
      for letter in 1 .. 12 loop
          Chess.game_board(letter, number) := forbidden;
      end loop;
    end loop;

    for number in 5 .. 8 loop
      for letter in 3 .. 10 loop
        Chess.game_board(letter,number) := empty;
      end loop;
    end loop;

    for letter in 3 .. 10 loop
      Chess.game_board(letter, 4) := pawn_white;
    end loop;

    for letter in 3 .. 10 loop
      Chess.game_board(letter, 9) := pawn_black;
    end loop;

    Chess.game_board(3,3) := rook_white;
    Chess.game_board(4,3) := knight_white;
    Chess.game_board(5,3) := bishop_white;
    Chess.game_board(6,3) := queen_white;
    Chess.game_board(7,3) := king_white;
    Chess.game_board(8,3) := bishop_white;
    Chess.game_board(9,3) := knight_white;
    Chess.game_board(10,3) := rook_white;

    Chess.game_board(3,10) := rook_black;
    Chess.game_board(4,10) := knight_black;
    Chess.game_board(5,10) := bishop_black;
    Chess.game_board(6,10) := queen_black;
    Chess.game_board(7,10) := king_black;
    Chess.game_board(8,10) := bishop_black;
    Chess.game_board(9,10) := knight_black;
    Chess.game_board(10,10) := rook_black;

  end init_gameboard;

  procedure move_piece(x_start : in Integer; y_start : in Integer; x_end : in Integer; y_end : in Integer) is
  begin
    --get board piece, move it the new coord
    Chess.game_board(x_end, y_end) := Chess.game_board(x_start, y_start);
    Chess.game_board(x_start, y_start) := empty;
  end;

  procedure print_gameboard is
    procedure print_cell(c : Cell) is
    begin
      case c is
        when empty        => Put(".");
        when forbidden    => Put("X");
        when pawn_white   => Put("P");
        when rook_white   => Put("R");
        when knight_white => Put("N");
        when bishop_white => Put("B");
        when queen_white  => Put("Q");
        when king_white   => Put("K");
        when pawn_black   => Put("p");
        when rook_black   => Put("r");
        when knight_black => Put("n");
        when bishop_black => Put("b");
        when queen_black  => Put("q");
        when king_black   => Put("k");
      end case;
    end print_cell;
  begin
    for letter in 3 .. 10 loop
      for number in 3 .. 10 loop
        print_cell(Chess.game_board(letter, number));
      end loop;
      Put_Line("");
    end loop;
  end print_gameboard;
end Chess;
