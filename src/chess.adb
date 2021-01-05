package body Chess is
    procedure init_gameboard is
    begin
        for number in 1 .. 12 loop
            for letter in 1 .. 12 loop
                Chess.game_board(letter, number) := Forbidden;
            end loop;
        end loop;

        for number in 5 .. 8 loop
            for letter in 3 .. 10 loop
                Chess.game_board(letter,number) := Empty;
            end loop;
        end loop;

        for letter in 3 .. 10 loop
            Chess.game_board(letter, 4) := Pawn_white;
        end loop;

        for letter in 3 .. 10 loop
            Chess.game_board(letter, 9) := Pawn_black;
        end loop;

        Chess.game_board(3,3) := Rook_white;
        Chess.game_board(4,3) := Knight_white;
        Chess.game_board(5,3) := Bishop_white;
        Chess.game_board(6,3) := Queen_white;
        Chess.game_board(7,3) := King_white;
        Chess.game_board(8,3) := Bishop_white;
        Chess.game_board(9,3) := Knight_white;
        Chess.game_board(10,3) := Rook_white;

        Chess.game_board(3,10) := Rook_black;
        Chess.game_board(4,10) := Knight_black;
        Chess.game_board(5,10) := Bishop_black;
        Chess.game_board(6,10) := Queen_black;
        Chess.game_board(7,10) := King_black;
        Chess.game_board(8,10) := Bishop_black;
        Chess.game_board(9,10) := Knight_black;
        Chess.game_board(10,10) := Rook_black;
    end init_gameboard;

    function get_piece_at(x : in Integer; y : in Integer) return Cell is
    begin
        return (if p = White then Chess.game_board(x + 2, y + 2) else Chess.game_board(x + 2, 11 - y));
    end get_piece_at;

    procedure move_piece(x_start : in Integer; y_start : in Integer; x_end : in Integer; y_end : in Integer) is
    begin
        -- get board piece, move it the new coord
        if p = White then
            Chess.game_board(x_end + 2, y_end + 2) := Chess.game_board(x_start + 2, y_start + 2);
            Chess.game_board(x_start + 2, y_start + 2) := Empty;
        else
            Chess.game_board(x_end + 2, 11 - y_end) := Chess.game_board(2 + x_start, 11 - y_start);
            Chess.game_board(x_start + 2, 11 - y_start) := Empty;
        end if;
    end;

    procedure print_gameboard is
        procedure print_cell(c : Cell) is
        begin
            case c is
                when Empty        => Put(".");
                when Forbidden    => Put("X");
                when Pawn_white   => Put("P");
                when Rook_white   => Put("R");
                when Knight_white => Put("N");
                when Bishop_white => Put("B");
                when Queen_white  => Put("Q");
                when King_white   => Put("K");
                when Pawn_black   => Put("p");
                when Rook_black   => Put("r");
                when Knight_black => Put("n");
                when Bishop_black => Put("b");
                when Queen_black  => Put("q");
                when King_black   => Put("k");
            end case;
        end print_cell;
    begin
        if side = Black then
            for number in 3 .. 10 loop
                for letter in 3 .. 10 loop
                    print_cell(Chess.game_board(letter, number));
                end loop;
                Put_Line("");
            end loop;
        else
            for number in reverse 3 .. 10 loop
                for letter in reverse 3 .. 10 loop
                    print_cell(Chess.game_board(letter, number));
                end loop;
                Put_Line("");
            end loop;
        end if;
    end print_gameboard;
end Chess;
