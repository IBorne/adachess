with Ada.Text_IO; use Ada.Text_IO;

package Chess is

    type Player_Type is (Black,
                         White,
                         Unknown);

    type Piece_Type is (Empty,
                        Forbidden,
                        Pawn,
                        Rook,
                        Knight,
                        Bishop,
                        Queen,
                        King);

    type Cell_Type is record
        Piece           : Piece_Type := Forbidden;
        Player          : Player_Type := Unknown;
    end record;

    type Range_Board is range -1 .. 10;
    subtype Range_Inner_Board is Range_Board range 1 .. 8;

    type Coordinate is record
        X, Y : Range_Board := 1;
    end record;

    type Coordinate_Array is array (Positive range <>) of Coordinate;

    type Board_Type is array (Range_Board, Range_Board) of Cell_Type;

    type Move_Type is record
        Start, Target   : Coordinate;
    end record;

    type Side_Type is (Kingside, Queenside);

    type Board_Save is record
        Player              : Player_Type;
        White_Castling_Q    : Boolean;
        White_Castling_K    : Boolean;
        Black_Castling_Q    : Boolean;
        Black_Castling_K    : Boolean;
        Is_Enemy_Check      : Boolean;
        En_Passant_Target   : Coordinate;
        Board               : Board_Type;
        Halfmove            : Natural;
        Halfmove_Done       : Boolean;
        Fullmove            : Natural;
    end record;

    -- type Move_List_Type is array (Buffer_Size) of Move_Type; --

    Player              : Player_Type;
    White_Castling_Q    : Boolean;
    White_Castling_K    : Boolean;
    Black_Castling_Q    : Boolean;
    Black_Castling_K    : Boolean;
    Is_Enemy_Check      : Boolean;
    En_Passant_Target   : Coordinate;
    -- Move_List           : Move_List_Type; --

    procedure Set_Debug(Debug : Boolean);
    procedure Print_Debug(Str : String);
    procedure Simulate_Enter;
    procedure Simulate_Leave;
    function Simulated return Boolean;
    function Is_Valid_Board return Boolean;

    function Read_Fen(Line : in String; Last : in Natural) return Boolean
    with Post => Is_Valid_Board;
    function Load_Fen(Filename : in String) return Boolean;
    function Write_Fen(Length : out Natural) return String
    with Pre => Is_Valid_Board;
    procedure Save_Fen(Filename : in String);
    procedure Check_Promote_Pawn(Pos : in Coordinate)
    with Pre => not Simulated;
    procedure Move_Piece(Move : in Move_Type)
    with Pre => Is_Valid_Board,
         Post => Is_Valid_Board;
    procedure Move_Castling(Side : in Side_Type; Player : in Player_Type)
    with Pre => Is_Valid_Board,
         Post => Is_Valid_Board;
    -- procedure Undo_Move; --Chess.Chess.
    function Is_Check(Player : in Player_Type) return Boolean;
    function Get_Piece_At(Position : in Coordinate) return Cell_Type;
    function Save_Board return Board_Save;
    procedure Revert_Board(Save : Board_Save)
    with Post => Is_Valid_Board;
    function End_Turn return Boolean
    with Post => Is_Valid_Board and Player'Old /= Player;
    procedure Print;
    function Get_Player_Name(Player : in Player_Type) return String;

private

    Board               : Board_Type;
    Halfmove            : Natural := 0;
    Halfmove_Done       : Boolean := True;
    Fullmove            : Natural := 1;

    Debug               : Boolean := False;
    Simulate            : Natural := 0;

end Chess;
