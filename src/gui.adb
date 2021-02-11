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

procedure Gui
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
end Gui;