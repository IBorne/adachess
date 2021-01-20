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

    function is_valid_pawn(dx : In Integer; dy : In Integer; Move : In Move_Type; p : In Player_Type) return Boolean is
		dy_rel : constant Integer := (if p = White then dy else -dy);
		y0_rel : constant Range_Inner_Board := (if p = White then Move.Start.Y else 9 - Move.Start.Y);
		y01 : constant Range_Inner_Board := Range_Inner_Board(if p = White then Integer(Move.Start.Y) + 1 else Integer(Move.Start.Y) - 1);
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
				-- FIXME: verify if En_Passant_Target is Invalid if there is no En_Passant
                return En_Passant_Target = Move.Target;
            -- Capture piece : diagonal 1
            else
                return True;
            end if;
        end if;

        return False;
    end is_valid_pawn;

    function is_valid_rook(Move : In Move_Type) return Boolean is
        dx : constant Integer := Integer(Move.Target.X) - Integer(Move.Start.X);
        dy : constant Integer := Integer(Move.Target.Y) - Integer(Move.Start.Y);
        X_Increment : constant Integer := (if dx = 0 then 0 elsif Move.Start.X < Move.Target.X then 1 else -1);
        Y_Increment : constant Integer := (if dy = 0 then 0 elsif Move.Start.Y < Move.Target.Y then 1 else -1);
        Start : Coordinate := Move.Start;
    begin
        -- Check if the way is clear
        if dx /= 0 and dy /= 0 then
            return False;
        end if;
        while Start /= (Move.Target.X - X_Increment, Move.Target.Y - Y_Increment) loop
			Start := (Start.X + X_Increment, Start.Y + Y_Increment);
            if Get_Piece_At(Start).Piece /= Empty then
                return False;
            end if;
        end loop;

        return True;
    end is_valid_rook;

    function is_valid_knight(dx : In Integer; dy : In Integer) return Boolean is
    begin
        return (abs dx = 1 and abs dy = 2)
            or (abs dx = 2 and abs dy = 1);
    end is_valid_knight;

    function is_valid_bishop(dx : In Integer; dy : In Integer; Start : In Coordinate) return Boolean is
        dir_x : Integer :=  (if dx < 0 then -1 else 1);
        dir_y : Integer := (if dy < 0 then -1 else 1);
    begin
        if abs dx /= abs dy then
            return False;
        end if;

        -- Check if the way is clear
        for i In Integer range 1 .. (abs dx) - 1 loop
            if Get_Piece_At((Start.X + i * dir_x, Start.Y + i * dir_y)).Piece /= Empty then
                return False;
            end if;
        end loop;

        return True;
    end is_valid_bishop;

    function is_valid_queen(dx : In Integer; dy : In Integer; Move : In Move_Type) return Boolean is
    begin
        return is_valid_rook(Move)
            or is_valid_bishop(dx, dy, Move.Start);
    end is_valid_queen;

    function is_valid_king(dx : In Integer; dy : In Integer) return Boolean is
    begin
        return abs dx = 1 or abs dy = 1;
    end is_valid_kIng;

    function valid_piece_move(Move : In Move_Type; p : In Player_Type) return Boolean is
        dx : constant Integer := Integer(Move.Target.X) - Integer(Move.Start.X);
        dy : constant Integer := Integer(Move.Target.Y) - Integer(Move.Start.Y);
    begin
        case Get_Piece_At(Move.Start).Piece is
            when Pawn    => return is_valid_pawn(dx, dy, Move, p);
            when Rook    => return is_valid_rook(Move);
            when Knight  => return is_valid_knight(dx, dy);
            when Bishop  => return is_valid_bishop(dx, dy, Move.Start);
            when Queen   => return is_valid_queen(dx, dy, Move);
            when KIng    => return is_valid_king(dx, dy);
            when Empty  | Forbidden => return False;
        end case;
    end valid_piece_move;

    function is_valid_move(Move : In Move_Type; p : In Player_Type) return Boolean is
    begin
        -- Out of Bounds check
        if Get_Piece_At(Move.Target).Piece = Forbidden then
            return False;
        end if;

        -- Check if start piece is valid
        if Get_Piece_At(Move.Start).Player /= p then
            return False;
        end if;

        -- Check if end piece is ennemy (yes, you can't kill your allies)
        if Get_Piece_At(Move.Target).Player = p then
            return False;
        end if;

        return valid_piece_move(Move, p);
    end is_valid_move;
end Move;
