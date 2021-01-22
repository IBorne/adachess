package body Chess is

    function Get_Piece_At(Position : in Coordinate) return Cell_Type is
    begin
        return Chess.Board(Position.X, Position.Y);
    end Get_Piece_At;

	procedure Set_Piece_At(Pos : in Coordinate; Cell : in Cell_Type) is
	begin
		Chess.Board(Pos.X, Pos.Y) := Cell;
	end Set_Piece_At;

    function Is_Player_At(Pos : in Coordinate; Player : in Player_Type) return Boolean is
    begin
        return Get_Piece_At(Pos).Player = Player;
    end Is_Player_At;

    function Is_Cell_At(Pos : in Coordinate; Piece : in Piece_Type) return Boolean is
    begin
        return Get_Piece_At(Pos).Piece = Piece;
    end Is_Cell_At;

    function Is_Empty_Cell(Pos : in Coordinate) return Boolean is
    begin
        return Get_Piece_At(Pos).Piece = Empty;
    end Is_Empty_Cell;

    function Get_Enemy(Player : in Player_Type) return Player_Type is
    begin
        return (if Player = White then Black else White);
    end Get_Enemy;

    -- TODO: factorize (if possible)
    function Is_King_Check(Pos : in Coordinate; Enemy : in Player_Type) return Boolean is
        function Is_Enemy_Queen_Rook(Pos : in Coordinate; Enemy : in Player_Type) return Boolean is
        begin
            return Is_Player_At(Pos, Enemy) and (Is_Cell_At(Pos, Queen) or Is_Cell_At(Pos, Rook));
        end Is_Enemy_Queen_Rook;

        function Is_Enemy_Queen_Bishop(Pos : in Coordinate; Enemy : in Player_Type) return Boolean is
        begin
            return Is_Player_At(Pos, Enemy) and (Is_Cell_At(Pos, Queen) or Is_Cell_At(Pos, Bishop));
        end Is_Enemy_Queen_Bishop;

        Pawn_Y : Range_Board := (if Enemy = White then Pos.Y + 1 else Pos.Y - 1);
    begin
        -- Queen, Rook
        -- Vertical lower part
        if Pos.Y > Range_Inner_Board'First then
            for Y in Range_Inner_Board'First .. Pos.Y - 1 loop
                if Is_Enemy_Queen_Rook((Pos.X, Y), Enemy) then
                    return True;
                end if;

                exit when not Is_Empty_Cell((Pos.X, Y));
            end loop;
        end if;

        -- Vertical upper part
        if Pos.Y < Range_Inner_Board'Last then
            for Y in Pos.Y + 1 .. Range_Inner_Board'Last loop
                if Is_Enemy_Queen_Rook((Pos.X, Y), Enemy) then
                    return True;
                end if;

                exit when not Is_Empty_Cell((Pos.X, Y));
            end loop;
        end if;

        -- Horizontal left part
        if Pos.X > Range_Inner_Board'First then
            for X in Range_Inner_Board'First .. Pos.X - 1 loop
                if Is_Enemy_Queen_Rook((X, Pos.Y), Enemy) then
                    return True;
                end if;

                exit when not Is_Empty_Cell((X, Pos.Y));
            end loop;
        end if;

        -- Vertical upper part
        if Pos.X < Range_Inner_Board'Last then
            for X in Pos.X + 1 .. Range_Inner_Board'Last loop
                if Is_Enemy_Queen_Rook((X, Pos.Y), Enemy) then
                    return True;
                end if;

                exit when not Is_Empty_Cell((X, Pos.Y));
            end loop;
        end if;

        -- TODO: Queen, Bishop
        -- Diagonal upper left
        -- Diagonal upper right
        -- Diagonal lower left
        -- Diagonal lower right

        -- Knight
        if     Get_Piece_At((Pos.X - 1, Pos.Y - 3)) = (Knight, Enemy)
            or Get_Piece_At((Pos.X - 1, Pos.Y + 3)) = (Knight, Enemy)
            or Get_Piece_At((Pos.X + 1, Pos.Y - 3)) = (Knight, Enemy)
            or Get_Piece_At((Pos.X + 1, Pos.Y + 3)) = (Knight, Enemy)
            or Get_Piece_At((Pos.X - 3, Pos.Y - 1)) = (Knight, Enemy)
            or Get_Piece_At((Pos.X - 3, Pos.Y + 1)) = (Knight, Enemy)
            or Get_Piece_At((Pos.X + 3, Pos.Y - 1)) = (Knight, Enemy)
            or Get_Piece_At((Pos.X + 3, Pos.Y + 1)) = (Knight, Enemy) then
            return True;
        end if;

        -- King
        if     Get_Piece_At((Pos.X - 1, Pos.Y - 1)) = (King, Enemy)
            or Get_Piece_At((Pos.X - 1, Pos.Y + 0)) = (King, Enemy)
            or Get_Piece_At((Pos.X + 1, Pos.Y + 1)) = (King, Enemy)
            or Get_Piece_At((Pos.X + 0, Pos.Y - 1)) = (King, Enemy)
            or Get_Piece_At((Pos.X + 0, Pos.Y + 1)) = (King, Enemy)
            or Get_Piece_At((Pos.X + 1, Pos.Y - 1)) = (King, Enemy)
            or Get_Piece_At((Pos.X + 1, Pos.Y + 0)) = (King, Enemy)
            or Get_Piece_At((Pos.X + 1, Pos.Y + 1)) = (King, Enemy) then
            return True;
        end if; 

        -- Pawn
        if     Get_Piece_At((Pos.X - 1, Pawn_Y)) = (Pawn, Enemy)
            or Get_Piece_At((Pos.X + 1, Pawn_Y)) = (Pawn, Enemy) then
            return True;
        end if;

        return False;
    end Is_King_Check;

    function Is_Check(Player : in Player_Type) return Boolean is
    begin
        for Y in Range_Inner_Board loop
            for X in Range_Inner_Board loop
                if Get_Piece_At((X, Y)) = (King, Player) then
                    return Is_King_Check((X, Y), Get_Enemy(Player));
                end if;
            end loop;
        end loop;

        raise Program_Error with "The King is dead. Long live the king !"; 

        return False;
    end Is_Check;

    procedure Place(C : in Character; Position : in out Coordinate) is
        Increment               : Range_Board := 1;
    begin
        case C is
            when '1' .. '9' =>
                Increment := Character'Pos(C) - 48;
                for I in 0 .. Increment loop
                    Chess.Board(Position.X + I, Position.Y) := (Empty, Unknown);
                end loop;
            when 'p' => Chess.Board(Position.X, Position.Y) := (Pawn, Black);
            when 'r' => Chess.Board(Position.X, Position.Y) := (Rook, Black);
            when 'n' => Chess.Board(Position.X, Position.Y) := (Knight, Black);
            when 'b' => Chess.Board(Position.X, Position.Y) := (Bishop, Black);
            when 'q' => Chess.Board(Position.X, Position.Y) := (Queen, Black);
            when 'k' => Chess.Board(Position.X, Position.Y) := (King, Black);
            when 'P' => Chess.Board(Position.X, Position.Y) := (Pawn, White);
            when 'R' => Chess.Board(Position.X, Position.Y) := (Rook, White);
            when 'N' => Chess.Board(Position.X, Position.Y) := (Knight, White);
            when 'B' => Chess.Board(Position.X, Position.Y) := (Bishop, White);
            when 'Q' => Chess.Board(Position.X, Position.Y) := (Queen, White);
            when 'K' => Chess.Board(Position.X, Position.Y) := (King, White);
            when others => Null;
        end case;

        if C = '/' then
            Chess.Board(-1, Position.Y) := (Forbidden, Unknown);
            Chess.Board(0, Position.Y) := (Forbidden, Unknown);
            Chess.Board(9, Position.Y) := (Forbidden, Unknown);
            Chess.Board(10, Position.Y) := (Forbidden, Unknown);

            Position := (1, Position.Y - 1);
        else
            Position.X := Position.X + Increment;
        end if;
    end Place;

    function Collect(Position : in Coordinate) return Character is
        Cell                    : Cell_Type := Chess.Board(Position.X, Position.Y);
    begin
        case Cell.Piece is
            when Empty => return '.';
            when Pawn => return (if Cell.Player = White then 'P' else 'p');
            when Rook => return (if Cell.Player = White then 'R' else 'r');
            when Knight => return (if Cell.Player = White then 'N' else 'n');
            when Bishop => return (if Cell.Player = White then 'B' else 'b');
            when Queen => return (if Cell.Player = White then 'Q' else 'q');
            when King => return (if Cell.Player = White then 'K' else 'k');
            when Forbidden => return 'X';    -- should throw an error
        end case;
    end Collect;

    procedure Read_Fen(Line : in String; Last : in Natural) is
        Index                   : Natural := 1;
        Position                : Coordinate := (1, 8);
    begin
        for X in Range_Board loop
            Chess.Board(X, -1) := (Forbidden, Unknown);
            Chess.Board(X, 0) := (Forbidden, Unknown);
            Chess.Board(X, 9) := (Forbidden, Unknown);
            Chess.Board(X, 10) := (Forbidden, Unknown);
        end loop;

        while Index <= Last loop
            exit when Line(Index) = ' ';
            Place(Line(Index), Position);
            Index := Index + 1;
        end loop;

        Chess.Board(-1, 1) := (Forbidden, Unknown);
        Chess.Board(0, 1) := (Forbidden, Unknown);
        Chess.Board(9, 1) := (Forbidden, Unknown);
        Chess.Board(10, 1) := (Forbidden, Unknown);

        Index := Index + 1;

        if Line(Index) = 'w' then
            Chess.Player := White;
        elsif Line(Index) = 'b' then
            Chess.Player := Black;
        end if;
        Index := Index + 2;

        Chess.White_Castling_Q := False;
        Chess.White_Castling_K := False;
        Chess.Black_Castling_Q := False;
        Chess.Black_Castling_K := False;

        while Index <= Last loop
            exit when Line(Index) = ' ';
            case Line(Index) is
                when 'Q' => Chess.White_Castling_Q := True;
                when 'K' => Chess.White_Castling_K := True;
                when 'q' => Chess.Black_Castling_Q := True;
                when 'k' => Chess.Black_Castling_K := True;
                when others => Null;
            end case;
            Index := Index + 1;
        end loop;
        Index := Index + 1;
        
        if Line(Index) = '-' then
            Index := Index + 2;
        else
            Chess.En_Passant_Target.Y := Character'Pos(Line(Index)) - 96;
            Index := Index + 1;
            Chess.En_Passant_Target.X := Character'Pos(Line(Index)) - 48;
            Index := Index + 2;
        end if;

        if Index < Last then
            declare
                Tmp             : Natural := Index;
            begin
                while Index <= Last loop
                    exit when Line(Index) = ' ';
                    Index := Index + 1;
                end loop;

                Chess.Halfmove := Integer'Value(Line(Tmp .. Index - 1));
                Index := Index + 1;
            end;

            Chess.Fullmove := Integer'Value(Line(Index .. Last));
        end if;

        Chess.Is_Enemy_Check := Is_Check(Chess.Player);
    end Read_Fen;

    procedure Load_Fen(Filename : in String) is
        Input                   : File_Type;
        Line                    : String(1..256);
        Last                    : Natural;
    begin
        Open(File => Input,
             Mode => In_File,
             Name => Filename);

        Get_Line(Input, Line, Last);
        Read_Fen(Line, Last);

        Close(Input);
    end Load_Fen;

    function Write_Fen return String is
        Line                    : String(1 .. 256);
        Index                   : Natural := 1;
        Number                  : String(1 .. 256);
    begin
        for Y in reverse Range_Inner_Board loop
            declare
                Count           : Natural := 0;
            begin
                for X in Range_Inner_Board loop
                    declare
                        Char    : Character := Collect((X, Y));
                    begin
                        if Char = '.' then
                            Count := Count + 1;
                        else
                            if Count > 0 then
                                Line(Index) := Character'Val(Count + 48);
                                Index := Index + 1;
                                Count := 0;
                            end if;
                            Line(Index) := Char;
                            Index := Index + 1;
                        end if;
                    end;
                end loop;

                if Count > 0 then
                    Line(Index) := Character'Val(Count + 48);
                    Index := Index + 1;
                    Count := 0;
                end if;

                Line(Index) := (if Y = 1 then ' ' else '/');
                Index := Index + 1;
            end;
        end loop;

        Line(Index) := (if Chess.Player = White then 'w' else 'b');
        Index := Index + 1;
        Line(Index) := ' ';
        Index := Index + 1;

        if Chess.White_Castling_Q then
            Line(Index) := 'Q';
            Index := Index + 1;
        end if;
        if Chess.White_Castling_K then
            Line(Index) := 'K';
            Index := Index + 1;
        end if;
        if Chess.Black_Castling_Q then
            Line(Index) := 'q';
            Index := Index + 1;
        end if;
        if Chess.Black_Castling_K then
            Line(Index) := 'k';
            Index := Index + 1;
        end if;
        if not Chess.White_Castling_Q and
           not Chess.White_Castling_K and
           not Chess.Black_Castling_Q and
           not Chess.Black_Castling_K then
            Line(Index) := '-';
            Index := Index + 1;
        end if;
        Line(Index) := ' ';
        Index := Index + 1;

        if Chess.En_Passant_Target.Y = 1 then
            Line(Index) := '-';
            Index := Index + 1;
        else
            Line(Index) := Character'Val(Chess.En_Passant_Target.X + 96);
            Index := Index + 1;
            Line(Index) := Character'Val(Chess.En_Passant_Target.Y + 48);
            Index := Index + 1;
        end if;
        Line(Index) := ' ';
        Index := Index + 1;

        Number := Integer'Image(Chess.Halfmove) & " ";
        for Char of Number loop
            Line(Index) := Char;
            Index := Index + 1;
        end loop;

        Number := Integer'Image(Chess.Fullmove);
        for Char of Number loop
            Line(Index) := Char;
            Index := Index + 1;
        end loop;

        return Line;
    end Write_Fen;

    procedure Save_Fen(Filename : in String) is
        Output                  : File_Type;
        Line                    : String(1 .. 256) := (others => ' ');
    begin
        Create(File => Output,
               Mode => Out_File,
               Name => Filename);

        Line := Write_Fen;
        Put_Line(Output, Line);

        Close(Output);
    end Save_Fen;

    procedure Move_Piece(Move : in Move_Type) is
    begin
        if Get_Piece_At(Move.Start).Piece = Pawn
            or Get_Piece_At(Move.Target).Piece /= Empty then
            Halfmove_Done := False;
        end if;

        Board(Move.Target.X, Move.Target.Y) := Get_Piece_At(Move.Start);
        Board(Move.Start.X, Move.Start.Y) := (Empty, Unknown);
    end Move_Piece;

    -- procedure Undo_Move is --
    -- begin --
    -- end Undo_Move; --

    procedure End_Turn is
    begin
        Halfmove := (if Halfmove_Done then Halfmove + 1 else 0);
        Halfmove_Done := True;

        if Player = Black then
            Fullmove := Fullmove + 1;
        end if;

        Player := Get_Enemy(Player);

        Is_Enemy_Check := Is_Check(Player);
    end End_Turn;

    procedure Print is
    begin
        if Chess.Player = White then
            for Y in reverse Range_Inner_Board loop
                for X in Range_Inner_Board loop
                    Put(Collect((X, Y)));
                end loop;
                Put_Line("");
            end loop;
        else
            for Y in Range_Inner_Board loop
                for X in reverse Range_Inner_Board loop
                    Put(Collect((X, Y)));
                end loop;
                Put_Line("");
            end loop;
        end if;
    end Print;

end Chess;