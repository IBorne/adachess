with Move; use Move;

package body Chess is

    procedure Set_Debug(Debug : Boolean) is
    begin
        Chess.Debug := Debug;
    end Set_Debug;

    procedure Simulate_Enter is
    begin
        Chess.Simulate := Chess.Simulate + 1;
    end Simulate_Enter;

    procedure Simulate_Leave is
    begin
        Chess.Simulate := Chess.Simulate - 1;
    end Simulate_Leave;

    function Simulated return Boolean is
    begin
        return Chess.Simulate /= 0;
    end Simulated;

    procedure Print_Debug(Str : String) is
    begin
        if Chess.Simulate = 0 and Chess.Debug then
            Put_Line(Get_Player_Name(Player) & " -"
                   & Integer'Image(Fullmove) & " : " & Str);
        end if;
    end Print_Debug;

    function Get_Piece_At(Position : in Coordinate) return Cell_Type is
    begin
        return Chess.Board(Position.X, Position.Y);
    end Get_Piece_At;

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

    --------------- Check detection ---------------

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

        Pawn_Y : Range_Board := (if Enemy = Black then Pos.Y + 1 else Pos.Y - 1);
    begin
        -- Queen, Rook
        -- Vertical lower part
        if Pos.Y > Range_Inner_Board'First then
            for Y in reverse Range_Inner_Board'First .. Pos.Y - 1 loop
                if Is_Enemy_Queen_Rook((Pos.X, Y), Enemy) then
                    Print_Debug("Check by " & Get_Player_Name(Enemy)
                              & " Queen or Rook under the king ("
                              & Integer'Image(Integer(Pos.X)) & ","
                              & Integer'Image(Integer(Y)) & " ) -> ("
                              & Integer'Image(Integer(Pos.X)) & ","
                              & Integer'Image(Integer(POs.Y)) & " )");
                    return True;
                end if;

                exit when not Is_Empty_Cell((Pos.X, Y));
            end loop;
        end if;

        -- Vertical upper part
        if Pos.Y < Range_Inner_Board'Last then
            for Y in Pos.Y + 1 .. Range_Inner_Board'Last loop
                if Is_Enemy_Queen_Rook((Pos.X, Y), Enemy) then
                    Print_Debug("Check by " & Get_Player_Name(Enemy)
                              & " Queen or Rook above the king ("
                              & Integer'Image(Integer(Pos.X)) & ","
                              & Integer'Image(Integer(Y)) & " ) -> ("
                              & Integer'Image(Integer(Pos.X)) & ","
                              & Integer'Image(Integer(Pos.Y)) & " )");
                    return True;
                end if;

                exit when not Is_Empty_Cell((Pos.X, Y));
            end loop;
        end if;

        -- Horizontal left part
        if Pos.X > Range_Inner_Board'First then
            for X in reverse Range_Inner_Board'First .. Pos.X - 1 loop
                if Is_Enemy_Queen_Rook((X, Pos.Y), Enemy) then
                    Print_Debug("Check by " & Get_Player_Name(Enemy)
                              & " Queen or Rook at the left of the king ("
                              & Integer'Image(Integer(X)) & ","
                              & Integer'Image(Integer(Pos.Y)) & " ) -> ("
                              & Integer'Image(Integer(Pos.X)) & ","
                              & Integer'Image(Integer(Pos.Y)) & " )");
                    return True;
                end if;

                exit when not Is_Empty_Cell((X, Pos.Y));
            end loop;
        end if;

        -- Vertical upper part
        if Pos.X < Range_Inner_Board'Last then
            for X in Pos.X + 1 .. Range_Inner_Board'Last loop
                if Is_Enemy_Queen_Rook((X, Pos.Y), Enemy) then
                    Print_Debug("Check by Queen or Rook at the right of the king ("
                              & Integer'Image(Integer(X)) & ","
                              & Integer'Image(Integer(Pos.Y)) & " ) -> ("
                              & Integer'Image(Integer(Pos.X)) & ","
                              & Integer'Image(Integer(Pos.Y)) & " )");
                    return True;
                end if;

                exit when not Is_Empty_Cell((X, Pos.Y));
            end loop;
        end if;

        -- FIXME: Queen, Bishop
        -- Diagonal upper left
        -- Diagonal upper right
        -- Diagonal lower left
        -- Diagonal lower right

        -- Knight
        if     Get_Piece_At((Pos.X - 1, Pos.Y - 2)) = (Knight, Enemy)
            or Get_Piece_At((Pos.X - 1, Pos.Y + 2)) = (Knight, Enemy)
            or Get_Piece_At((Pos.X + 1, Pos.Y - 2)) = (Knight, Enemy)
            or Get_Piece_At((Pos.X + 1, Pos.Y + 2)) = (Knight, Enemy)
            or Get_Piece_At((Pos.X - 2, Pos.Y - 1)) = (Knight, Enemy)
            or Get_Piece_At((Pos.X - 2, Pos.Y + 1)) = (Knight, Enemy)
            or Get_Piece_At((Pos.X + 2, Pos.Y - 1)) = (Knight, Enemy)
            or Get_Piece_At((Pos.X + 2, Pos.Y + 1)) = (Knight, Enemy) then
            Print_Debug("Check by " & Get_Player_Name(Enemy) & " Knight");
            return True;
        end if;

        -- King
        if     Get_Piece_At((Pos.X - 1, Pos.Y - 1)) = (King, Enemy)
            or Get_Piece_At((Pos.X + 0, Pos.Y - 1)) = (King, Enemy)
            or Get_Piece_At((Pos.X + 1, Pos.Y - 1)) = (King, Enemy)
            or Get_Piece_At((Pos.X - 1, Pos.Y + 0)) = (King, Enemy)
            or Get_Piece_At((Pos.X + 1, Pos.Y + 0)) = (King, Enemy)
            or Get_Piece_At((Pos.X - 1, Pos.Y + 1)) = (King, Enemy)
            or Get_Piece_At((Pos.X + 0, Pos.Y + 1)) = (King, Enemy)
            or Get_Piece_At((Pos.X + 1, Pos.Y + 1)) = (King, Enemy) then
            Print_Debug("Check by " & Get_Player_Name(Enemy) & " King");
            return True;
        end if;

        -- Pawn
        if     Get_Piece_At((Pos.X - 1, Pawn_Y)) = (Pawn, Enemy)
            or Get_Piece_At((Pos.X + 1, Pawn_Y)) = (Pawn, Enemy) then
            Print_Debug("Check by " & Get_Player_Name(Enemy) & " Pawn");
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

    --------------- FEN Management ---------------

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
    exception
        when Name_Error => Put_Line("Couldn't find file " & Filename);
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

    procedure Check_Promote_Pawn(Pos : in Coordinate) is
        Cell    : Cell_Type := Get_Piece_At(Pos);
        Str     : String(1 .. 80);
        Last    : Natural;
    begin
        if Cell.Piece = Pawn and Pos.Y = (if Cell.Player = White then 8 else 1) then
            loop
                Put("Enter the piece to promote the pawn into (Q/N/R/B) : ");
                Get_Line(Str, Last);

                if Last = 1 then
                    case Str(1) is
                        when 'Q' => Board(Pos.X, Pos.Y).Piece := Queen;     exit;
                        when 'N' => Board(Pos.X, Pos.Y).Piece := Knight;    exit;
                        when 'R' => Board(Pos.X, Pos.Y).Piece := Rook;      exit;
                        when 'B' => Board(Pos.X, Pos.Y).Piece := Bishop;    exit;
                        when others => Null;
                    end case;
                end if;

                Put_Line("Invalid promotion : " & Str(1 .. Last) & ". Should be Q, N, R or B.");
            end loop;
        end if;
    end Check_Promote_Pawn;

    procedure Move_Piece(Move : in Move_Type) is
        Castling_K : Boolean := (if Player = White then White_Castling_K else Black_Castling_K);
        Castling_Q : Boolean := (if Player = White then White_Castling_Q else Black_Castling_Q);
    begin
        if not Simulated then
            -- Not an halfmove if we move a pawn or take a piece
            if Get_Piece_At(Move.Start).Piece = Pawn
                or Get_Piece_At(Move.Target).Piece /= Empty then
                Halfmove_Done := False;
            end if;

            -- Disable castling if king move or disable the side when a rook moves
            if Castling_K or Castling_Q then
                case Get_Piece_At(Move.Start).Piece is
                    when King =>
                        Castling_K := False;
                        Castling_Q := False;

                    when Rook =>
                        if Move.Start.X = 1 then Castling_Q := False; end if;
                        if Move.Start.X = 8 then Castling_K := False; end if;

                    when others => Null;
                end case;

                if Player = White then
                    White_Castling_K := Castling_K;
                    White_Castling_Q := Castling_Q;
                else
                    Black_Castling_K := Castling_K;
                    Black_Castling_Q := Castling_Q;
                end if;
            end if;

            -- Set En_Passant_Target if the move can trigger an En Passant
            if Get_Piece_At(Move.Start).Piece = Pawn
                and abs (Integer(Move.Target.Y) - Integer(Move.Start.Y)) = 2 then
                En_Passant_Target := (Move.Start.X, (Move.Start.Y + Move.Target.Y) / 2);
            else
                En_Passant_Target := (0, 0);    -- should never be a valid location
            end if;
        end if;

        -- Actually move the piece
        Board(Move.Target.X, Move.Target.Y) := Get_Piece_At(Move.Start);
        Board(Move.Start.X, Move.Start.Y) := (Empty, Unknown);

        -- Promote the piece if it needed
        if not Simulated then
            Check_Promote_Pawn(Move.Target);
        end if;
    end Move_Piece;

    procedure Move_Castling(Side : in Side_Type; Player : in Player_Type) is
        Y : Range_Board := (if Player = White then 1 else 8);
    begin
        if Side = Kingside then
            Move_Piece(((5, Y), (7, Y)));
            Move_Piece(((8, Y), (6, Y)));
        elsif Side = Queenside then
            Move_Piece(((5, Y), (3, Y)));
            Move_Piece(((1, Y), (4, Y)));
        end if;
    end Move_Castling;

    -- procedure Undo_Move is --
    -- begin --
    -- end Undo_Move; --

    function Save_Board return Board_Save is
    begin
        return (Player,
                White_Castling_Q,
                White_Castling_K,
                Black_Castling_Q,
                Black_Castling_K,
                Is_Enemy_Check,
                En_Passant_Target,
                Board,
                Halfmove,
                Halfmove_Done,
                Fullmove);
    end Save_Board;

    procedure Revert_Board(Save : Board_Save) is
    begin
        Chess.Player              := Save.Player;
        Chess.White_Castling_Q    := Save.White_Castling_Q;
        Chess.White_Castling_K    := Save.White_Castling_K;
        Chess.Black_Castling_Q    := Save.Black_Castling_Q;
        Chess.Black_Castling_K    := Save.Black_Castling_K;
        Chess.Is_Enemy_Check      := Save.Is_Enemy_Check;
        Chess.En_Passant_Target   := Save.En_Passant_Target;
        Chess.Board               := Save.Board;
        Chess.Halfmove            := Save.Halfmove;
        Chess.Halfmove_Done       := Save.Halfmove_Done;
        Chess.Fullmove            := Save.Fullmove;
    end Revert_Board;

    --------------- Checkmate detection ---------------

    function Get_Piece_Name(Piece : Piece_Type) return String is
    begin
        case Piece is
            when Pawn => return "Pawn";
            when Rook => return "Rook";
            when Knight => return "Knight";
            when Bishop => return "Bishop";
            when Queen => return "Queen";
            when King => return "King";
            when Empty | Forbidden => return "X";
        end case;
    end Get_Piece_Name;

    -- this function is always short-circuit'ed as it can lead to invalid
    -- states if the move is not valid (ex: King disappear)
    function Check_Not_Checkmate(Pos : in Coordinate; Target : in Coordinate;
                                 Player : in Player_Type; Save : in Board_Save) return Boolean is
        Is_Still_Check : Boolean;
    begin
        Move_Piece((Pos, Target));
        Is_Still_Check := Is_Check(Player);
        Revert_Board(Save);

        return Is_Still_Check = False;
    end Check_Not_Checkmate;

    function Avoid_Checkmate_Pawn(X : in Range_Board; Y : in Range_Board;
                               Player : in Player_Type; Save : in Board_Save) return Boolean is
        Y_1 : constant Range_Board := (if Player = White then Y + 1 else Y - 1);
        Y_2 : constant Range_Board := (if Player = White then Y + 2 else Y - 2);

        Positions : Coordinate_Array := ((X - 1, Y_1), (X, Y_1), (X + 1, Y_1), (X, Y_2));
    begin
        for Pos of Positions loop
            if is_valid_move(((X, Y), Pos), Player) and then Check_Not_Checkmate((X, Y), Pos, Player, Save) then
                return True;
            end if;
        end loop;

        return False;
    end Avoid_Checkmate_Pawn;

    function Avoid_Checkmate_Rook(X : in Range_Board; Y : in Range_Board;
                                 Player : in Player_Type; Save : Board_Save) return Boolean is
    begin
        if Range_Inner_Board'First < X then
            for Pos_X in reverse Range_Inner_Board'First .. X - 1 loop
                if is_valid_move(((X, Y), (Pos_X, Y)), Player) and then Check_Not_Checkmate((X, Y), (Pos_X, Y), Player, Save) then
                    return True;
                end if;
            end loop;
        end if;

        if X < Range_Inner_Board'Last then
            for Pos_X in X + 1 .. Range_Inner_Board'Last loop
                if is_valid_move(((X, Y), (Pos_X, Y)), Player) and then Check_Not_Checkmate((X, Y), (Pos_X, Y), Player, Save) then
                    return True;
                end if;
            end loop;
        end if;

        if Range_Inner_Board'First < Y then
            for Pos_Y in Range_Inner_Board'First .. Y - 1 loop
                if is_valid_move(((X, Y), (X, Pos_Y)), Player) and then Check_Not_Checkmate((X, Y), (X, Pos_Y), Player, Save) then
                    return True;
                end if;
            end loop;
        end if;

        if Y < Range_Inner_Board'Last then
            for Pos_Y in reverse Y + 1 .. Range_Inner_Board'Last loop
                if is_valid_move(((X, Y), (X, Pos_Y)), Player) and then Check_Not_Checkmate((X, Y), (X, Pos_Y), Player, Save) then
                    return True;
                end if;
            end loop;
        end if;

        return False;
    end Avoid_Checkmate_Rook;

    function Avoid_Checkmate_Knight(X : in Range_Board; Y : in Range_Board;
                                    Player : in Player_Type; Save : in Board_Save) return Boolean is
        Positions : Coordinate_Array := ((X - 2, Y - 1), (X - 2, Y + 1), (X - 1, Y - 2), (X - 1, Y + 2),
                                         (X + 1, Y - 2), (X + 1, Y + 2), (X + 2, Y - 1), (X + 2, Y + 1));
    begin
        for Pos of Positions loop
            if is_valid_move(((X, Y), Pos), Player) and then Check_Not_Checkmate((X, Y), Pos, Player, Save) then
                return True;
            end if;
        end loop;

        return False;
    end Avoid_Checkmate_Knight;

    function Avoid_Checkmate_Bishop(X : in Range_Board; Y : in Range_Board;
                                    Player : in Player_Type; Save : in Board_Save) return Boolean is
        Left : constant Integer := Integer(X) - Integer(Range_Inner_Board'First);
        Right : constant Integer := Integer(Range_Inner_Board'Last) - Integer(X);
        Down : constant Integer := Integer(Y) - Integer(Range_Inner_Board'First);
        Up : constant Integer := Integer(Range_Inner_Board'Last) - Integer(Y);

        Len_Up_Left : constant Integer := Integer'Min(Up, Left);
        Len_Up_Right : constant Integer := Integer'Min(Up, Right);
        Len_Down_Left : constant Integer := Integer'Min(Down, Left);
        Len_Down_Right : constant Integer := Integer'Min(Down, Right);
    begin
        if Len_Up_Left /= 0 then
            for I in Range_Board range 1 .. Range_Board(Len_Up_Left) loop
                if is_valid_move(((X, Y), (X - I, Y + I)), Player) and then Check_Not_Checkmate((X, Y), (X - I, Y + I), Player, Save) then
                    return True;
                end if;
            end loop;
        end if;

        if Len_Up_Right /= 0 then
            for I in Range_Board range 1 .. Range_Board(Len_Up_Right) loop
                if is_valid_move(((X, Y), (X + I, Y + I)), Player) and then Check_Not_Checkmate((X, Y), (X + I, Y + I), Player, Save) then
                    return True;
                end if;
            end loop;
        end if;

        if Len_Down_Left /= 0 then
            for I in Range_Board range 1 .. Range_Board(Len_Down_Left) loop
                if is_valid_move(((X, Y), (X - I, Y - I)), Player) and then Check_Not_Checkmate((X, Y), (X - I, Y - I), Player, Save) then
                    return True;
                end if;
            end loop;
        end if;

        if Len_Down_Right /= 0 then
            for I in Range_Board range 1 .. Range_Board(Len_Down_Right) loop
                if is_valid_move(((X, Y), (X + I, Y - I)), Player) and then Check_Not_Checkmate((X, Y), (X + I, Y - I), Player, Save) then
                    return True;
                end if;
            end loop;
        end if;

        return False;
    end Avoid_Checkmate_Bishop;

    function Avoid_Checkmate_Queen(X : in Range_Board; Y : in Range_Board;
                                   Player : in Player_Type; Save : in Board_Save) return Boolean is
    begin
        return Avoid_Checkmate_Bishop(X, Y, Player, Save) or Avoid_Checkmate_Rook(X, Y, Player, Save);
    end Avoid_Checkmate_Queen;

    function Avoid_Checkmate_King(X : in Range_Board; Y : in Range_Board;
                                  Player : in Player_Type; Save : in Board_Save) return Boolean is
        Positions : Coordinate_Array := ((X - 1, Y - 1), (X, Y - 1), (X + 1, Y - 1),
                                         (X - 1, Y),     (X, Y),     (X + 1, Y),
                                         (X - 1, Y + 1), (X, Y + 1), (X + 1, Y + 1));
    begin
        for Pos of Positions loop
            if is_valid_move(((X, Y), Pos), Player) and then Check_Not_Checkmate((X, Y), Pos, Player, Save) then
                return True;
            end if;
        end loop;

        return False;
    end Avoid_Checkmate_King;

    function Is_Checkmate_Avoided(Player : in Player_Type) return Boolean is
        Save : Board_Save := Save_Board;
        Check_Avoided : Boolean;
    begin
        Simulate_Enter;

        for Y in Range_Inner_Board loop
            for X in Range_Inner_Board loop
                if Get_Piece_At((X, Y)).Player = Player then
                    case Get_Piece_At((X, Y)).Piece is
                        when Pawn   => Check_Avoided := Avoid_Checkmate_Pawn(X, Y, Player, Save);
                        when Rook   => Check_Avoided := Avoid_Checkmate_Rook(X, Y, Player, Save);
                        when Knight => Check_Avoided := Avoid_Checkmate_Knight(X, Y, Player, Save);
                        when Bishop => Check_Avoided := Avoid_Checkmate_Bishop(X, Y, Player, Save);
                        when Queen  => Check_Avoided := Avoid_Checkmate_Queen(X, Y, Player, Save);
                        when King   => Check_Avoided := Avoid_Checkmate_King(X, Y, Player, Save);
                        when Empty  | Forbidden => return False;
                    end case;

                    if Check_Avoided then
                        Simulate_Leave;
                        return True;
                    end if;
                end if;
            end loop;
        end loop;

        Simulate_Leave;
        return False;
    end Is_Checkmate_Avoided;

    function End_Turn return Boolean is
    begin
        Halfmove := (if Halfmove_Done then Halfmove + 1 else 0);
        Halfmove_Done := True;

        if Player = Black then
            Fullmove := Fullmove + 1;
        end if;

        Player := Get_Enemy(Player);

        -- Add 50 moves rule (Halfmove = 50)

        Is_Enemy_Check := Is_Check(Player);
        if Is_Enemy_Check and then Is_Checkmate_Avoided(Player) = False then
            return True;
        end if;

        return False;
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

    function Get_Player_Name(Player : in Player_Type) return String is
    begin
        return (if Player = White then "White" else "Black");
    end Get_Player_Name;

    function Is_Valid_Board return Boolean is
        White_Rook_Q_Origin : Boolean := False;
        White_Rook_K_Origin : Boolean := False;
        White_King_Origin : Boolean := False;
        White_King : Boolean := False;
        Black_Rook_Q_Origin : Boolean := False;
        Black_Rook_K_Origin : Boolean := False;
        Black_King_Origin : Boolean := False;
        Black_King : Boolean := False;
    begin
        for X in Range_Board loop
            for Y in Range_Board loop
                if X in Range_Inner_Board and Y in Range_Inner_Board then
                    if Chess.Board(X, Y).Piece = Forbidden then
                        return False;
                    elsif Chess.Board(X, Y).Piece = King then
                        if Chess.Board(X, Y).Player = White then
                            if X = 5 and Y = 1 then
                                White_King_Origin := True;
                            end if;
                            White_King := True;
                        else
                            if X = 5 and Y = 1 then
                                Black_King_Origin := True;
                            end if;
                            Black_King := True;
                        end if;
                    elsif Chess.Board(X, Y).Piece = Rook then
                        if Chess.Board(X, Y).Player = White then
                            if X = 1 and Y = 1 then
                                White_Rook_Q_Origin := True;
                            elsif X = 8 and Y = 1 then
                                White_Rook_K_Origin := True;
                            end if;
                        else
                            if X = 1 and Y = 8 then
                                Black_Rook_Q_Origin := True;
                            elsif X = 8 and Y = 8 then
                                Black_Rook_K_Origin := True;
                            end if;
                        end if;
                    end if;
                else
                    if Chess.Board(X, Y).Piece /= Forbidden then
                        return False;
                    end if;
                end if;
            end loop;
        end loop;

        if Chess.White_Castling_Q and (not White_Rook_Q_Origin or not White_King_Origin) then
            return False;
        end if;

        if Chess.White_Castling_K and (not White_Rook_K_Origin or not White_King_Origin) then
            return False;
        end if;

        if Chess.Black_Castling_Q and (not Black_Rook_Q_Origin or not Black_King_Origin) then
            return False;
        end if;

        if Chess.Black_Castling_K and (not Black_Rook_K_Origin or not Black_King_Origin) then
            return False;
        end if;

        return White_King and Black_King;
    end Is_Valid_Board;

end Chess;
