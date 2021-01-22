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

    type Board_Type is array (Range_Board, Range_Board) of Cell_Type;

    type Move_Type is record
        Start, Target   : Coordinate;
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

    procedure Read_Fen(Line : in String; Last : in Natural);
    procedure Load_Fen(Filename : in String);
    function Write_Fen return String;
    procedure Save_Fen(Filename : in String);
	procedure Check_Promote_Pawn(Pos : in Coordinate);
    procedure Move_Piece(Move : in Move_Type);
    -- procedure Undo_Move; --
    function Is_Check(Player : in Player_Type) return Boolean;
    function Get_Piece_At(Position : in Coordinate) return Cell_Type;
	procedure Set_Piece_At(Pos : in Coordinate; Cell : in Cell_Type);
    procedure End_Turn;
    procedure Print;

private

    Board               : Board_Type;
    Halfmove            : Natural := 0;
    Halfmove_Done       : Boolean := True;
    Fullmove            : Natural := 1;

end Chess;