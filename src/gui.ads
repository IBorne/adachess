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

package Gui is
   
   Win : Gtk_Window;
   Layout : Gtk_Layout;
   Table : Gtk_Grid;
   Button    : Gtk_Button;
   Win_Height : Gint := 600;
   Win_Width : Gint := 600;

   type Button_Board_Range is range 1 .. 8;
   type Button_Board_Type is array (Button_Board_Range, Button_Board_Range) of Gtk_Button;
   Button_Board : Button_Board_Type;
   
   type Button_Image_Board_Type is array (Button_Board_Range, Button_Board_Range) of Unbounded_String;
   Button_Image_Board : Button_Image_Board_Type := (others => (others => To_Unbounded_String("")));
   Start_I : Integer := 0;
   Start_J : Integer := 0;
   
   procedure Button_Mapping (Button : access Gtk_Button_Record'Class);
   procedure Set_Image(Button : Gtk_Button; image : String);
   procedure Init_Image_Board;
end Gui;
