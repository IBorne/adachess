package body Chess is
    -- TODO: check for any missing element
    function is_valid_move(x_start : in Integer; y_start : in Integer; x_end : in Integer; y_end : in Integer; p : in Player; prev : in String) return Boolean is
        function get_player(c : in Cell) return Player is
--            with Pre => Cell'Pos(c) in white_range or Cell'Pos(c) in black_range;
        begin
            return (if Cell'Pos(c) in white_range then White else Black);
        end get_player;

        function valid_piece_move(x_start : in Integer; y_start : in Integer; x_end : in Integer; y_end : in Integer; p : in Player; prev : in String) return Boolean is
--            with Pre => get_piece_at(x_start, y_start, p) /= Empty
--                    and get_piece_at(x_start, y_start, p) /= Forbidden;

            function is_valid_pawn(delta_x : in Integer; delta_y : in Integer; x_start : in Integer; y_start : in Integer; x_end : in Integer; y_end : in Integer; p : in Player; prev : in String) return Boolean is
                function is_pawn(c : in Cell) return Boolean is
                begin
                    return c = Rook_black or c = Rook_white;
                end is_pawn;

                L : constant Character := Character'Val(x_end + Character'Pos('A'));
            begin
                -- Normal move : straight 1
                if delta_y = 1 and delta_x = 0 and get_piece_at(x_end, y_end, p) = Empty then
                    return True;
                end if;

                -- Start move : straight 2
                if delta_y = 2 and delta_x = 0 and y_start = 2 and get_piece_at(x_end, y_end, p) = Empty then
                    return True;
                end if;

                if delta_y = 1 and abs delta_x = 1 then
                    -- Capture piece : en passant
                    if get_piece_at(x_end, y_end, p) = Empty then
                        return y_start = 5
                            and is_pawn(get_piece_at(x_end, 5, p))
                            and prev = L & '2' & ' ' & L & '4';
                    -- Capture piece : diagonal 1
                    else
                        return True;
                    end if;
                end if;

                return False;
            end is_valid_pawn;

            function is_valid_rook(delta_x : in Integer; delta_y : in Integer; x_start : in Integer; y_start : in Integer; p : in Player) return Boolean is
            begin
                -- Check if the way is clear
                if delta_x /= 0 and delta_y /= 0 then
                    return False;
                end if;

                -- FIXME: check if loop is actually valid
                for y in y_start .. y_start + delta_y loop
                    for x in x_start .. x_start + delta_x loop
                        if get_piece_at(x, y, p) /= Empty then
                            return False;
                        end if;
                    end loop;
                end loop;

                return True;
            end is_valid_rook;

            function is_valid_knight(delta_x : in Integer; delta_y : in Integer) return Boolean is
            begin
                return (abs delta_x = 1 and abs delta_y = 3)
                    or (abs delta_x = 3 and abs delta_y = 1);
            end is_valid_knight;

            function is_valid_bishop(delta_x : in Integer; delta_y : in Integer; x_start : in Integer; y_start : in Integer; p : in Player) return Boolean is
                dir_x : constant Integer := delta_x / abs delta_x;
                dir_y : constant Integer := delta_y / abs delta_y;
            begin
                if abs delta_x /= abs delta_y then
                    return False;
                end if;

                -- Check if the way is clear
                for i in 1 .. (abs delta_x) - 1 loop
                    if get_piece_at(x_start + i * dir_x, y_start + i * dir_y, p) /= Empty then
                        return False;
                    end if;
                end loop;

                return True;
            end is_valid_bishop;

            function is_valid_queen(delta_x : in Integer; delta_y : in Integer; x_start : in Integer; y_start : in Integer; p : in Player) return Boolean is
            begin
                return is_valid_rook(delta_x, delta_y, x_start, y_start, p)
                    or is_valid_bishop(delta_x, delta_y, x_start, y_start, p);
            end is_valid_queen;

            function is_valid_king(delta_x : in Integer; delta_y : in Integer) return Boolean is
            begin
                return abs delta_x = 1 or abs delta_y = 1;
            end is_valid_king;

            delta_x : constant Integer := (x_end - x_start);
            delta_y : constant Integer := (y_end - y_start);
        begin
            case get_piece_at(x_start, y_start, p) is
                when Pawn_white     | Pawn_black    => return is_valid_pawn(delta_x, delta_y, x_start, y_start, x_end, y_end, p, prev);
                when Rook_white     | Rook_black    => return is_valid_rook(delta_x, delta_y, x_start, y_start, p);
                when Knight_white   | Knight_black  => return is_valid_knight(delta_x, delta_y);
                when Bishop_white   | Bishop_black  => return is_valid_bishop(delta_x, delta_y, x_start, y_start, p);
                when Queen_white    | Queen_black   => return is_valid_queen(delta_x, delta_y, x_start, y_start, p);
                when King_white     | King_black    => return is_valid_king(delta_x, delta_y);
                when Empty          | Forbidden     => return False;
            end case;
        end valid_piece_move;
    begin
--        Put_Line("x_start :" & Integer'Image(x_start) & ".");
        -- Out of Bounds check
        if get_piece_at(x_end, y_end, p) = forbidden then
            return False;
        end if;

        -- Check if start piece is valid
        if get_player(get_piece_at(x_end, y_end, p)) /= p then
            return False;
        end if;

        -- Check if end piece is ennemy (yes, you can't kill your allies)
        if get_player(get_piece_at(x_end, y_end, p)) = p then
            return False;
        end if;

        return valid_piece_move(x_start, y_start, x_end, y_end, p, prev);
    end is_valid_move;

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

    function get_piece_at(x : in Integer; y : in Integer; p : in Player) return Cell is
    begin
        return (if p = White then Chess.game_board(x, y) else Chess.game_board(x, 9 - y));
    end get_piece_at;

    procedure move_piece(x_start : in Integer; y_start : in Integer; x_end : in Integer; y_end : in Integer; p : in Player) is
    begin
        -- get board piece, move it the new coord
        if p = White then
            Chess.game_board(x_end, y_end) := Chess.game_board(x_start, y_start);
            Chess.game_board(x_start, y_start) := Empty;
        else
            Chess.game_board(x_end, 9 - y_end) := Chess.game_board(x_start, 9 - y_start);
            Chess.game_board(x_start, 9 - y_start) := Empty;
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
        for letter in 3 .. 10 loop
            for number in 3 .. 10 loop
                print_cell(Chess.game_board(letter, number));
            end loop;
            Put_Line("");
        end loop;
    end print_gameboard;
end Chess;
