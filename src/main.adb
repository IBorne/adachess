with Gdk.Event;       use Gdk.Event;

with Gtk.Box;         use Gtk.Box;
with Gtk.Label;       use Gtk.Label;
with Gtk.Widget;      use Gtk.Widget;
with Gtk.Main;
with Gtk.Window;      use Gtk.Window;

procedure Main is

   Win   : Gtk_Window;
   Label : Gtk_Label;
   Box   : Gtk_Vbox;

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

begin
   --  Initialize GtkAda.
   Gtk.Main.Init;

   --  Create a window with a size of 400x400
   Gtk_New (Win);
   Win.Set_Default_Size (400, 400);

   --  Create a box to organize vertically the contents of the window
   Gtk_New_Vbox (Box);
   Win.Add (Box);

   --  Add a label
   Gtk_New (Label, "Hello world.");
   Box.Add (Label);

   -- Stop the Gtk process when closing the window
   Win.On_Delete_Event (Delete_Event_Cb'Unrestricted_Access);

   --  Show the window and present it
   Win.Show_All;
   Win.Present;

   --  Start the Gtk+ main loop
   Gtk.Main.Main;
end Main;


with Ada.Text_IO; use Ada.Text_IO;
with Chess; use Chess;
with Move; use Move;

procedure main is
    Str     : String (1 .. 80);
    Last    : Natural;

	Move : Move_Type;

    function check_input return Boolean is
    begin
        Ada.Text_IO.Get_Line (Str, Last);

        if Str(1 .. Last)'Length /= 4 then
            return False;
        end if;

	    Move.Start.X := Character'Pos(Str(1)) - Character'Pos('A') + 1;
        Move.Start.Y := Range_Board(Integer'Value(Str(2 .. 2)));
        Move.Target.X := Character'Pos(Str(3)) - Character'Pos('A') + 1;
        Move.Target.Y := Range_Board(Integer'Value(Str(4 .. 4)));

        return True;
    exception
            when others => return False;
    end check_input;
begin
    Read_Fen("rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1", 56);
    Put_Line("Welcome to Adachess");

    while(True) loop -- is_game_end()
        Put_Line((if Player = White then "White" else "Black") & " to move:");
	    Print;

        -- TODO: take care of castling

        if not check_input then
            if Str(1 .. 4) = "quit" then
                Put_Line((if Player = White then "Black" else "White") & " win ! exiting game.");
                exit;
            end if;
            Put_Line("Wrong input, Usage: E2E4.");
        elsif not is_valid_move(Move, Player) then
            Put_Line("Input a valid move.");
        else
            -- TODO: take care of cases where king is check
            -- TODO: transform a pawn into queen if pawn at last row
            move_piece(Move);
			End_Turn;
        end if;
    end loop;
end main;
