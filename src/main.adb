with Ada.Text_IO; use Ada.Text_IO;
with Chess; use Chess;
with Move; use Move;

with Gtk.Image; use Gtk.Image;
with Gdk.Pixbuf; use Gdk.Pixbuf;
with Gtk.Style; use Gtk.Style;
with Gtk.Enums; use Gtk.Enums;

with Gtk.Button; use Gtk.Button;
with Gtk.Grid;            use Gtk.Grid;
with Gtk.Handlers; use Gtk.Handlers;
with Gtk.Window; use Gtk.Window;
with Gtk.Main; use Gtk.Main;
with Gtk.Layout; use Gtk.Layout;
with Gtk.Widget;      use Gtk.Widget;
with Gdk.Event;       use Gdk.Event;
with Gtk.Label;       use Gtk.Label;
with Gtk.Handlers;
with Glib; use Glib;
with Glib.Error; use Glib.Error;
with Glib.Main; use Glib.Main;

with Pango.Font;          use Pango.Font;

with Ada.Command_Line; use Ada.Command_Line;

procedure main is
   Win : Gtk_Window;
   Layout : Gtk_Layout;
   Table : Gtk_Grid;
   Button    : Gtk_Button;
   Win_Height : Gint := 800;
   Win_Width : Gint := 800;

   function Delete_Event_Cb
     (Self  : access Gtk_Widget_Record'Class;
      Event : Gdk.Event.Gdk_Event)
      return Boolean;

   ---------------------
   -- Delete_Event_Cb --
   ---------------------

   function Delete_Event_Cb
     (Self  : access Gtk_Widget_Record'Class;
      Event : Gdk.Event.Gdk_Event)
      return Boolean
   is
      pragma Unreferenced (Self, Event);
   begin
      Gtk.Main.Main_Quit;
      return True;
   end Delete_Event_Cb;

 procedure set_image(Layout : Gtk_Layout; image: in String) is
      img : Gtk_Image;
      Buf : Gdk_Pixbuf;
      er: Glib.Error.GError;
   begin
      Gdk_New_From_File (Buf, image, er);
      Buf := Scale_Simple(Src         => Buf,
                          Dest_Width  => Win_Width,
                          Dest_Height => Win_Height,
                          Inter_Type  => Interp_Bilinear);
      Gtk_New (Img, Buf);
      Layout.Put(Child_Widget => img, X => 0, Y => 0);
   end set_image;

 procedure set_image(Button : Gtk_Button; image: in String) is
      img : Gtk_Image;
      Buf : Gdk_Pixbuf;
      er: Glib.Error.GError;
   begin
      Gdk_New_From_File (Buf, image, er);
      Buf := Scale_Simple(Src         => Buf,
                          Dest_Width  => Win_Width / 8,
                          Dest_Height => Win_Height / 8,
                          Inter_Type  => Interp_Bilinear);
      Gtk_New (Img, Buf);
      Button.Add(Widget => img);
   end set_image;

   procedure main_chess is
      Move : Move_Type;

      function Check_Move(Str : String) return Boolean is
      begin
         if Str'Length /= 4 then
            return False;
         end if;

         if     not ('a' <= Str(Str'First + 0) and Str(Str'First + 0) <= 'h')
           or not ('0' <= Str(Str'First + 1) and Str(Str'First + 1) <= '8')
           or not ('a' <= Str(Str'First + 2) and Str(Str'First + 2) <= 'h')
           or not ('0' <= Str(Str'First + 3) and Str(Str'First + 3) <= '8') then
            return False;
         end if;

         Move.Start.X := Character'Pos(Str(Str'First + 0)) - 96;
         Move.Start.Y := Character'Pos(Str(Str'First + 1)) - 48;
         Move.Target.X := Character'Pos(Str(Str'First + 2)) - 96;
         Move.Target.Y := Character'Pos(Str(Str'First + 3)) - 48;

         return True;
      exception
         when others => return False;
      end Check_Move;

      function Check_Validity(Str : String) return Boolean is
      begin
         if Str = "O-O" then
            if not is_valid_castling(Kingside, Player) then
               Put_Line("Invalid Kingside Castle : " & Str);
               return False;
            end if;

            Move_Castling(Kingside, Player);
         elsif Str = "O-O-O" then
            if not is_valid_castling(Queenside, Player) then
               Put_Line("Invalid Queenside Castle : " & Str);
               return False;
            end if;

            Move_Castling(Queenside, Player);
         elsif Check_Move(Str) then
            if not is_valid_move(Move, Player) then
               Put_Line("Invalid move : " & Str);
               return False;
            end if;

            move_piece(Move);
         else
            Put_Line("Invalid input : " & Str & ". Use help for more info.");
            return False;
         end if;

         return True;
      end Check_Validity;

      Unused_Bool : Boolean;
   begin
      -- Won't fail
      Unused_Bool := Read_Fen("rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1", 56);
      Put_Line("Welcome to Adachess");

      for I in 1 .. Argument_Count loop
         if Argument(I) = "-d" or Argument(I) = "--debug" then
            Set_Debug(True);
         end if;
      end loop;

      while True loop
         Put_Line("");
         Put_Line(get_player_name(Player) & " to move:");
         Print;
         Put_Line("");

         declare
            Move_Str : String := Get_Line;
         begin
            if Move_Str /= "" then
               if Move_Str = "exit" then
                  exit;
               elsif Move_Str = "load" then
                  loop
                     declare
                        FEN : String := Get_Line;
                     begin
                        exit when Read_Fen(FEN, FEN'Length);
                        Put_Line("Invalid FEN : " & FEN);
                     end;
                  end loop;
               elsif Move_Str = "save" then
                  declare
                     Length : Natural := 1;
                  begin
                     Put_Line(Write_Fen(Length)(1 .. Length));
                  end;
               elsif Move_Str = "h" or Move_Str = "help" then
                  Put_Line("List of commands :");
                  Put_Line("    help: print the list of commands");
                  Put_Line("    exit: exit the game");
                  Put_Line("    load: prompt a FEN to load");
                  Put_Line("    save: print the current FEN");
                  Put_Line("    [a-h][1-8][a-h][1-8]: move a piece");
                  Put_Line("    O-O: perform a Kingside Castling");
                  Put_Line("    O-O-O: perform a Queenside Castling");
               elsif Check_Validity(Move_Str) then
                  if End_Turn then
                     Put_Line((if Player = Black then "White" else "Black") & " won.");
                     exit;
                  end if;
               end if;
            end if;
         end;
      end loop;
   end main_chess;

begin
   Gtk.Main.Init;

   Gtk_New(Win);
   Win.Set_Default_Size(800, 800);

   Win.Set_Title("adachess");
   Win.On_Delete_Event (Delete_Event_Cb'Unrestricted_Access);

   -- Layout
   Gtk_New(Layout);
   set_image(Layout, "chess/chess_board.png");
   Win.Add(Layout);

   --Buttons
   Gtk_New(Table);
   Layout.Add(Table);

   for I in 0 .. 8 loop
      for J in 0 .. 8 loop
         Gtk_New (Button);--, "(" & Integer'Image (I) & "," & Integer'Image (J) & ")");
         Button.Set_Size_Request(Width  => Gint(100), Height => Gint(100));
         Button.Set_Relief(Relief_None);
         Set_Image(Button, "chess/Black_Pawn.png");
         Button.Set_Opacity(Opacity => Gdouble(0.2));
         Table.Attach (Button, Gint (I), Gint (J));
      end loop;
   end loop;

   Win.Show_All;
   Win.Present;
   Gtk.Main.Main;
end main;
