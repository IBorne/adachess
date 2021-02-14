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

with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

With Move; use Move;
with Chess; use Chess;
with Gui; use Gui;

procedure main_Gui is
   Unused_Bool : Boolean;
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

   procedure Set_Image(Layout : Gtk_Layout; image: in String) is
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
   end Set_Image;



   procedure Set_Image_Chess(Button : Gtk_Button; I : Gint; J : Gint) is
   begin
      if (I = 1 and J = 1) then
         Set_Image(Button, "chess/White_Rook.png");
      elsif (I = 2 and J = 1) then
         Set_Image(Button, "chess/White_Knight.png");
      elsif (I = 3 and J = 1) then
         Set_Image(Button, "chess/White_Bishop.png");
      elsif (I = 4 and J = 1) then
         Set_Image(Button, "chess/White_Queen.png");
      elsif (I = 5 and J = 1) then
         Set_Image(Button, "chess/White_King.png");
      elsif (I = 6 and J = 1) then
         Set_Image(Button, "chess/White_Bishop.png");
      elsif (I = 7 and J = 1) then
         Set_Image(Button, "chess/White_Knight.png");
      elsif (I = 8 and J = 1) then
         Set_Image(Button, "chess/White_Rook.png");
      elsif (I = 1 and J = 8) then
         Set_Image(Button, "chess/Black_Rook.png");
      elsif (I = 2 and J = 8) then
         Set_Image(Button, "chess/Black_Bishop.png");
      elsif (I = 3 and J = 8) then
         Set_Image(Button, "chess/Black_Knight.png");
      elsif (I = 4 and J = 8) then
         Set_Image(Button, "chess/Black_King.png");
      elsif (I = 5 and J = 8) then
         Set_Image(Button, "chess/Black_Queen.png");
      elsif (I = 6 and J = 8) then
         Set_Image(Button, "chess/Black_Bishop.png");
      elsif (I = 7 and J = 8) then
         Set_Image(Button, "chess/Black_Knight.png");
      elsif (I = 8 and J = 8) then
         Set_Image(Button, "chess/Black_Rook.png");
      elsif (J = 2) then
         Set_Image(Button, "chess/White_Pawn.png");
      elsif (J = 7) then
         Set_Image(Button, "chess/Black_Pawn.png");
      end if;
   end Set_Image_Chess;

begin
   Gtk.Main.Init;
   Unused_Bool := Read_Fen("rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1", 56);
   Init_Image_Board;
   Gtk_New(Win);
   Win.Set_Default_Size(Win_Height, Win_Width);

   Win.Set_Title("adachess");
   Win.On_Delete_Event (Delete_Event_Cb'Unrestricted_Access);

   -- Layout
   Gtk_New(Layout);
   Set_Image(Layout, "chess/chess_board.png");
   Layout.Set_Size_Request(Width  => Win_Width, Height => Win_Width);
   Win.Add(Layout);

   --Buttons
   Gtk_New(Table);
   Layout.Add(Table);

   for I in Button_Board_Range loop
      for J in Button_Board_Range loop
         Gtk_New (Button);
         Button.Set_Hexpand(False);
         Button_Board(I, J) := Button;
         Button.Set_Relief(Relief_None);
         Button.On_Clicked(Button_Mapping'Access);

         Set_Image_Chess(Button, Gint(I), Gint(9 - J));

         Button.Set_Size_Request(Gint(Win_Width / 8), Gint(Win_Height / 8));
         Button.Set_Opacity(Opacity => Gdouble(0.5));
         Table.Attach (Button, Gint (I), Gint (J));
      end loop;
   end loop;

   Win.Show_All;
   Win.Present;
   Gtk.Main.Main;
end Main_Gui;
