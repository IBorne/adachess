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
               Put_Line("End of the line");
               return;
            end if;

         end if;
            Start_I := 0;
            Start_J := 0;
      end if;
   end Button_Mapping;
end Gui;
