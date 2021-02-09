with Ada.Text_IO; use Ada.Text_IO;

with Chess; use Chess;

package body Move is

    function "+" (Left : Range_Board; Right : Integer) return Range_Board is
        Left_Int : Integer := Integer(Left);
    begin
        return Range_Board(Left_Int + Right);
    end "+";

    function "-" (Left : Range_Board; Right : Integer) return Range_Board is
        Left_Int : Integer := Integer(Left);
    begin
        return Range_Board(Left_Int - Right);
    end "-";

    function is_valid_pawn(dx : in Integer; dy : in Integer; Move : in Move_Type; Player : in Player_Type) return Boolean is
        dy_rel : constant Integer := (if Player = White then dy else -dy);
        y0_rel : constant Range_Inner_Board := (if Player = White then Move.Start.Y else 9 - Move.Start.Y);
        y01 : constant Range_Board := Range_Board(if Player = White then Integer(Move.Start.Y) + 1 else Integer(Move.Start.Y) - 1);
    begin
        -- Normal move : straight 1
        if dy_rel = 1 and dx = 0 and Get_Piece_At(Move.Target).Piece = Empty then
            return True;
        end if;

        -- Start move : straight 2
        if dy_rel = 2 and dx = 0 and y0_rel = 2
            and Get_Piece_At(Move.Target).Piece = Empty
            and Get_Piece_At((Move.Target.X, y01)).Piece = Empty then
            return True;
        end if;

        if dy_rel = 1 and abs dx = 1 then
            -- Capture piece : en passant
            if Get_Piece_At(Move.Target).Piece = Empty then
                return En_Passant_Target = Move.Target;
            -- Capture piece : diagonal 1
            else
                return True;
            end if;
        end if;

        Print_Debug("Invalid Pawn");

        return False;
    end is_valid_pawn;

    function is_valid_rook(dx : in Integer; dy : in Integer; Move : in Move_Type) return Boolean is
        Dir_X : constant Integer := (if dx = 0 then 0 elsif Move.Start.X < Move.Target.X then 1 else -1);
        Dir_Y : constant Integer := (if dy = 0 then 0 elsif Move.Start.Y < Move.Target.Y then 1 else -1);

        Pos : Coordinate := (Move.Start.X + Dir_X, Move.Start.Y + Dir_Y);
    begin
        if dx /= 0 and dy /= 0 then
            Print_Debug("Why is your Rook behaving like a Bishop ?");
            return False;
        end if;

        -- Check if the way is clear
        while Pos /= Move.Target loop
            if Get_Piece_At(Pos).Piece /= Empty then
                Print_Debug("The path of your Rook is obstructed");
                return False;
            end if;

            Pos := (Pos.X + Dir_X, Pos.Y + Dir_Y);
        end loop;

        return True;
    end is_valid_rook;

    function is_valid_knight(dx : in Integer; dy : in Integer) return Boolean is
    begin
        return (abs dx = 1 and abs dy = 2)
            or (abs dx = 2 and abs dy = 1);
    end is_valid_knight;

    function is_valid_bishop(dx : in Integer; dy : in Integer; Start : in Coordinate) return Boolean is
        Dir_X : constant Integer := (if dx < 0 then -1 else 1);
        Dir_Y : constant Integer := (if dy < 0 then -1 else 1);

        Dist : constant Integer := (if dx /= 0 then (abs dx) - 1 else (abs dy) - 1);
    begin
        if abs dx /= abs dy then
            Print_Debug("Seems like your Bishop doesn't walk straight");
            return False;
        end if;

        -- Check if the way is clear
        if Dist > 0 then
            for I in Integer range 1 .. Dist loop
                if Get_Piece_At((Start.X + I * Dir_X, Start.Y + I * Dir_Y)).Piece /= Empty then
                    Print_Debug("The path of your Bishop is obstructed");
                    return False;
                end if;
            end loop;
        end if;

        return True;
    end is_valid_bishop;

    function is_valid_queen(dx : in Integer; dy : in Integer; Move : in Move_Type) return Boolean is
        Dir_X : constant Integer := (if dx = 0 then 0 elsif Move.Start.X < Move.Target.X then 1 else -1);
        Dir_Y : constant Integer := (if dy = 0 then 0 elsif Move.Start.Y < Move.Target.Y then 1 else -1);

        Pos : Coordinate := (Move.Start.X + Dir_X, Move.Start.Y + Dir_Y);
    begin
        if abs dx /= abs dy and dx /= 0 and dy /= 0 then
            Print_Debug("Seems like your Queen doesn't walk straight");
            return False;
        end if;

        -- Check if the way is clear
        while Pos /= Move.Target loop
            if Get_Piece_At(Pos).Piece /= Empty then
                Print_Debug("The path of your Queen is obstructed");
                return False;
            end if;

            Pos := (Pos.X + Dir_X, Pos.Y + Dir_Y);
        end loop;

        return True;
    end is_valid_queen;

    function is_valid_king(dx : in Integer; dy : in Integer) return Boolean is
    begin
        return abs dx = 1 or abs dy = 1;
    end is_valid_king;

    function valid_piece_move(Move : in Move_Type; Player : in Player_Type) return Boolean is
        dx : constant Integer := Integer(Move.Target.X) - Integer(Move.Start.X);
        dy : constant Integer := Integer(Move.Target.Y) - Integer(Move.Start.Y);
    begin
        case Get_Piece_At(Move.Start).Piece is
            when Pawn    => return is_valid_pawn(dx, dy, Move, Player);
            when Rook    => return is_valid_rook(dx, dy, Move);
            when Knight  => return is_valid_knight(dx, dy);
            when Bishop  => return is_valid_bishop(dx, dy, Move.Start);
            when Queen   => return is_valid_queen(dx, dy, Move);
            when King    => return is_valid_king(dx, dy);
            when Empty  | Forbidden => return False;
        end case;
    end valid_piece_move;

    function is_valid_move(Move : in Move_Type; Player : in Player_Type) return Boolean is
    begin
        -- Out of Bounds check
        if Get_Piece_At(Move.Target).Piece = Forbidden then
            Print_Debug("Target is out of bounds");
            return False;
        end if;

        -- Check if start piece is valid
        if Get_Piece_At(Move.Start).Player /= Player then
            Print_Debug("Starting piece is not yours");
            return False;
        end if;

        -- Check if end piece not ally (yes, you can't kill your allies)
        if Get_Piece_At(Move.Target).Player = Player then
            Print_Debug("Target piece is an ally");
            return False;
        end if;

        -- Check if piece actually move
        if Move.Start = Move.Target then
            Print_Debug("You can't stay static");
            return False;
        end if;

        if valid_piece_move(Move, Player) = False then
            Print_Debug("Wrong move");
            return False;
        end if;

        declare
            Is_Own_Check : Boolean;
            Board : Board_Save := Save_Board;
        begin
            Simulate_Enter;

            -- Make the move
            Move_Piece(Move);
            -- Check if king is still check
            Is_Own_Check := Is_Check(Player);
            -- Revert the board
            Revert_Board(Board);

            Simulate_Leave;

            if Is_Own_Check then
                Print_Debug("You are in check after your move");
                return False;
            end if;
        end;

        return True;
    end is_valid_move;

    function is_valid_castling(Side : in Side_Type; Player : in Player_Type) return Boolean is
        Castling_K : Boolean := (if Player = White then White_Castling_K else Black_Castling_K);
        Castling_Q : Boolean := (if Player = White then White_Castling_Q else Black_Castling_Q);

        Y : Range_Board := (if Player = White then 1 else 8);

        function check_castling_at(Pos : in Coordinate; Player : in Player_Type) return Boolean is
            Is_Own_Check : Boolean;
            Save : Board_Save := Save_Board;
        begin
            -- No piece can be between the king and the rook
            if Get_Piece_At(Pos) /= (Empty, Unknown) then
                Print_Debug("You cannot castle through pieces");
                return True;
            end if;

            -- You are not allowed to castle through check
            Move_Piece(((5, Pos.Y), Pos));
            Is_Own_Check := Is_Check(Player);
            Revert_Board(Save);

            if Is_Own_Check then
                Print_Debug("You cannot castle through check");
            end if;

            return Is_Own_Check;
        end check_castling_at;
    begin
        Simulate_Enter;

        -- You cannot castle if your king or your rook moved
        if     (Side = Kingside and Castling_K = False)
            or (Side = Queenside and Castling_Q = False) then
            Print_Debug("You can't castle anymore");
            Simulate_Leave;
            return False;
        end if;

        -- You cannot castle out of check
        if Is_Enemy_Check then
            Print_Debug("You cannot castle out of check");
            Simulate_Leave;
            return False;
        end if;

        if Side = Kingside then
            for X in 6..7 loop
                if check_castling_at((Range_Board(X), Y), Player) then
                    Simulate_Leave;
                    return False;
                end if;
            end loop;
        else
            for X in reverse 3..4 loop
                if check_castling_at((Range_Board(X), Y), Player) then
                    Simulate_Leave;
                    return False;
                end if;
            end loop;
        end if;

        Simulate_Leave;
        return True;
    end is_valid_castling;
end Move;
