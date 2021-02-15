with Ada.Text_IO; use Ada.Text_IO;

With Move; use Move;
with Chess; use Chess;
with Gui; use Gui;
package body Gui is
   procedure Init_Image_Board is

   begin
      Button_Image_Board(1,1) := To_Unbounded_String("chess/White_Rook.png");
      Button_Image_Board(2,1) := To_Unbounded_String("chess/White_Knight.png");
      Button_Image_Board(3,1) := To_Unbounded_String("chess/White_Bishop.png");
      Button_Image_Board(4,1) := To_Unbounded_String("chess/White_Queen.png");
      Button_Image_Board(5,1) := To_Unbounded_String("chess/White_King.png");
      Button_Image_Board(6,1) := To_Unbounded_String("chess/White_Bishop.png");
      Button_Image_Board(7,1) := To_Unbounded_String("chess/White_Knight.png");
      Button_Image_Board(8,1) := To_Unbounded_String("chess/White_Rook.png");
      Button_Image_Board(1,8) := To_Unbounded_String("chess/Black_Rook.png");
      Button_Image_Board(2,8) := To_Unbounded_String("chess/Black_Knight.png");
      Button_Image_Board(3,8) := To_Unbounded_String("chess/Black_Bishop.png");
      Button_Image_Board(4,8) := To_Unbounded_String("chess/Black_King.png");
      Button_Image_Board(5,8) := To_Unbounded_String("chess/Black_Queen.png");
      Button_Image_Board(6,8) := To_Unbounded_String("chess/Black_Bishop.png");
      Button_Image_Board(7,8) := To_Unbounded_String("chess/Black_Knight.png");
      Button_Image_Board(8,8) := To_Unbounded_String("chess/Black_Rook.png");
      Button_Image_Board(1,2) := To_Unbounded_String("chess/White_Pawn.png");
      Button_Image_Board(2,2) := To_Unbounded_String("chess/White_Pawn.png");
      Button_Image_Board(3,2) := To_Unbounded_String("chess/White_Pawn.png");
      Button_Image_Board(4,2) := To_Unbounded_String("chess/White_Pawn.png");
      Button_Image_Board(5,2) := To_Unbounded_String("chess/White_Pawn.png");
      Button_Image_Board(6,2) := To_Unbounded_String("chess/White_Pawn.png");
      Button_Image_Board(7,2) := To_Unbounded_String("chess/White_Pawn.png");
      Button_Image_Board(8,2) := To_Unbounded_String("chess/White_Pawn.png");
      Button_Image_Board(1,7) := To_Unbounded_String("chess/Black_Pawn.png");
      Button_Image_Board(2,7) := To_Unbounded_String("chess/Black_Pawn.png");
      Button_Image_Board(3,7) := To_Unbounded_String("chess/Black_Pawn.png");
      Button_Image_Board(4,7) := To_Unbounded_String("chess/Black_Pawn.png");
      Button_Image_Board(5,7) := To_Unbounded_String("chess/Black_Pawn.png");
      Button_Image_Board(6,7) := To_Unbounded_String("chess/Black_Pawn.png");
      Button_Image_Board(7,7) := To_Unbounded_String("chess/Black_Pawn.png");
      Button_Image_Board(8,7) := To_Unbounded_String("chess/Black_Pawn.png");

   end Init_Image_Board;

   procedure Set_Image(Button : Gtk_Button; image: in String) is
      img : Gtk_Image;
      Buf : Gdk_Pixbuf;
      er: Glib.Error.GError;
   begin
      Gdk_New_From_File (Buf, image, er);
      Buf := Scale_Simple(Src         => Buf,
                          Dest_Width  => Win_Width / 16,
                          Dest_Height => Win_Height / 16,
                          Inter_Type  => Interp_Bilinear);
      Gtk_New (Img, Buf);
      Button.Set_Image(Image => img);
   end Set_Image;

    procedure Highlight_Button(X : in Range_Board; Y : in Range_Board) is
    begin
        Null;
    end Highlight_Button;

    procedure Highlight_Valid_Pawn(X : in Range_Board; Y : in Range_Board;
                                   Player : in Player_Type) is
        Y_1 : constant Range_Board := (if Player = White then Y + 1 else Y - 1);
        Y_2 : constant Range_Board := (if Player = White then Y + 2 else Y - 2);

        Positions : Coordinate_Array := ((X - 1, Y_1), (X, Y_1), (X + 1, Y_1), (X, Y_2));
    begin
        for Pos of Positions loop
            exit when is_valid_move(((X, Y), Pos), Player) = False;
            Highlight_Button(Pos.X, Pos.Y);
        end loop;
    end Highlight_Valid_Pawn;

    procedure Highlight_Valid_Rook(X : in Range_Board; Y : in Range_Board;
                                 Player : in Player_Type) is
    begin
        if Range_Inner_Board'First < X then
            for Pos_X in reverse Range_Inner_Board'First .. X - 1 loop
                exit when is_valid_move(((X, Y), (Pos_X, Y)), Player) = False;
                Highlight_Button(Pos_X, Y);
            end loop;
        end if;

        if X < Range_Inner_Board'Last then
            for Pos_X in X + 1 .. Range_Inner_Board'Last loop
                exit when is_valid_move(((X, Y), (Pos_X, Y)), Player) = False;
                Highlight_Button(Pos_X, Y);
            end loop;
        end if;

        if Range_Inner_Board'First < Y then
            for Pos_Y in Range_Inner_Board'First .. Y - 1 loop
                exit when is_valid_move(((X, Y), (X, Pos_Y)), Player) = False;
                Highlight_Button(X, Pos_Y);
            end loop;
        end if;

        if Y < Range_Inner_Board'Last then
            for Pos_Y in reverse Y + 1 .. Range_Inner_Board'Last loop
                exit when is_valid_move(((X, Y), (X, Pos_Y)), Player) = False;
                Highlight_Button(X, Y);
            end loop;
        end if;
    end Highlight_Valid_Rook;

    procedure Highlight_Valid_Knight(X : in Range_Board; Y : in Range_Board;
                                    Player : in Player_Type) is
        Positions : Coordinate_Array := ((X - 2, Y - 1), (X - 2, Y + 1), (X - 1, Y - 2), (X - 1, Y + 2),
                                         (X + 1, Y - 2), (X + 1, Y + 2), (X + 2, Y - 1), (X + 2, Y + 1));
    begin
        for Pos of Positions loop
            if is_valid_move(((X, Y), Pos), Player) then
                Highlight_Button(X, Y);
            end if;
        end loop;
    end Highlight_Valid_Knight;

    procedure Highlight_Valid_Bishop(X : in Range_Board; Y : in Range_Board;
                                    Player : in Player_Type; Save : in Board_Save) is
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
                exit when is_valid_move(((X, Y), (X - I, Y + I)), Player) = False;
                Highlight_Button(X, Y);
            end loop;
        end if;

        if Len_Up_Right /= 0 then
            for I in Range_Board range 1 .. Range_Board(Len_Up_Right) loop
                exit when is_valid_move(((X, Y), (X + I, Y + I)), Player) = False;
                Highlight_Button(X, Y);
            end loop;
        end if;

        if Len_Down_Left /= 0 then
            for I in Range_Board range 1 .. Range_Board(Len_Down_Left) loop
                exit when is_valid_move(((X, Y), (X - I, Y - I)), Player) = False;
                Highlight_Button(X, Y);
            end loop;
        end if;

        if Len_Down_Right /= 0 then
            for I in Range_Board range 1 .. Range_Board(Len_Down_Right) loop
                exit when is_valid_move(((X, Y), (X + I, Y - I)), Player) = False;
                Highlight_Button(X, Y);
            end loop;
        end if;
    end Highlight_Valid_Bishop;

    procedure Highlight_Valid_Queen(X : in Range_Board; Y : in Range_Board;
                                   Player : in Player_Type) is
    begin
        Highlight_Valid_Bishop(X, Y, Player, Save);
        Highlight_Valid_Rook(X, Y, Player, Save);
    end Highlight_Valid_Queen;

    procedure Highlight_Valid_King(X : in Range_Board; Y : in Range_Board;
                                  Player : in Player_Type) is
        Positions : Coordinate_Array := ((X - 1, Y - 1), (X, Y - 1), (X + 1, Y - 1),
                                         (X - 1, Y),     (X, Y),     (X + 1, Y),
                                         (X - 1, Y + 1), (X, Y + 1), (X + 1, Y + 1));
    begin
        for Pos of Positions loop
            if is_valid_move(((X, Y), Pos), Player) then
                Highlight_Button(X, Y);
            end if;
        end loop;
    end Highlight_Valid_King;

    procedure Highlight_Valid_Piece(X : in Range_Board; Y : in Range_Board) is
        Player : Player_Type := Get_Piece_At((X, Y)).Player;
    begin
        case Get_Piece_At((X, Y)).Piece is
            when Pawn   => Highlight_Valid_Pawn(X, Y, Player);
            when Rook   => Highlight_Valid_Rook(X, Y, Player);
            when Knight => Highlight_Valid_Knight(X, Y, Player);
            when Bishop => Highlight_Valid_Bishop(X, Y, Player);
            when Queen  => Highlight_Valid_Queen(X, Y, Player);
            when King   => Highlight_Valid_King(X, Y, Player);
            when Empty  | Forbidden => Null;
        end case;
    end Highlight_Valid_Piece;

   procedure Button_Mapping (Button : access Gtk_Button_Record'Class) is
      Temp_Win : Gtk_Widget := Button.Get_Parent;
      Temp_I: Gint := 0;
      Temp_J: Gint := 0;
      I : Integer;
      J : Integer;
      Coord_Start : Coordinate;
      Coord_End : Coordinate;
      End_Button : Gtk_Button;
      End_String : Unbounded_String;
   begin
      Temp_Win.Get_Pointer(Temp_I, Temp_J);
      I := Integer(Temp_I / Gint(75)) + 1;
      J := Integer(Temp_J / Gint(75)) + 1;
      if (Start_I = 0) then
         Start_I := I;
         Start_J := J;

         Highlight_Valid_Piece(Range_Board(I), Range_Board(J));
      else
         Put_Line("Start_I: " & Integer'Image(Start_I) & ", Start_J: " & Integer'Image(9 - Start_J));
         Put_Line("End_I: " & Integer'Image(I) & ", End_J: " & Integer'Image(9 - J));
         Coord_Start := (Range_Board(Start_I), Range_Board(9 - Start_J));
         Coord_End := (Range_Board(I), Range_Board(9 - J));
         if (Move.is_valid_move((Coord_Start, Coord_End), Chess.Player)) then
            Chess.Move_Piece((Coord_Start, Coord_End));

            Put_Line("Piece is moving");
            End_Button := Button_Board(Button_Board_Range(I), Button_Board_Range(J));
            End_String := (Button_Image_Board(Button_Board_Range(Start_I), Button_Board_Range(9 - Start_J)));
            Set_Image( End_Button, To_String(End_String));
            Button_Board(Button_Board_Range(Start_I), Button_Board_Range(Start_J)).Set_Visible(False);
            Button_Image_Board(Button_Board_Range(I), Button_Board_Range(9 - J)) := End_String;

            if (Chess.End_Turn) then
               return;
            end if;

         end if;

         Start_I := 0;
         Start_J := 0;
      end if;
   end Button_Mapping;
end Gui;
