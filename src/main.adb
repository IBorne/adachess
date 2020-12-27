with Ada.Text_IO; use Ada.Text_IO;

with Agar.Init;
with Agar.Error;
with Agar.Data_Source;
with Agar.Event;
with Agar.Timer;
with Agar.Object;

with Agar.Init_GUI;
with Agar.Surface; use Agar.Surface;
with Agar.Text;
with Interfaces; use Interfaces;
with System;

--with Chess; use Chess;

procedure Main is
  package T_IO renames Ada.Text_IO;
  input: String(1 .. 80);
  len: Integer;

  player_turn : Boolean := True;
  x_start : Integer;
  y_start : letter;
  x_end : Integer;
  y_end : letter;
begin
  declare
    W        : constant Natural := 640;
    H        : constant Natural := 480;
    Surf     : constant Surface_Access := New_Surface(W,H);
    Blue     : aliased AG_Color := Color_8(0,0,200,255);
    Border_W : constant Natural := 20;
  begin
    if Surf = null then
      raise Program_Error with Agar.Error.Get_Error;
    end if;
    Fill_Rect(Surface => Surf, Color => Color_8(200,0,0));
    declare
      Hello_Label    : Surface_Access;
      Text_W, Text_H : Natural;
      Line_Count     : Natural;
    begin
      Agar.Text.Push_Text_State;
      Agar.Text.Text_Set_Color_8(16#73fa00ff#);
      Hello_Label := Agar.Text.Text_Render("Hello, world!");
      Blit_Surface(Source => Hello_Label, Target => Surf, Dst_X  => 0, Dst_Y  => 0);
      Free_Surface(Hello_Label);
      Agar.Text.Pop_Text_State;
    end;
    Free_Surface(Surf);
  end;
    loop
        Put_Line("Player " & (if player_turn then "1" else "2") & " your moves");
        get_line(input, len);
        exit when len = 0; -- when game state is check mat
        put(input(1 .. len));
        player_turn := not player_turn;
    end loop;
    Agar.Init.Quit;
 end Main;

