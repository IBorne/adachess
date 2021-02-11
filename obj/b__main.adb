pragma Warnings (Off);
pragma Ada_95;
pragma Source_File_Name (ada_main, Spec_File_Name => "b__main.ads");
pragma Source_File_Name (ada_main, Body_File_Name => "b__main.adb");
pragma Suppress (Overflow_Check);
with Ada.Exceptions;

package body ada_main is

   E072 : Short_Integer; pragma Import (Ada, E072, "system__os_lib_E");
   E011 : Short_Integer; pragma Import (Ada, E011, "ada__exceptions_E");
   E015 : Short_Integer; pragma Import (Ada, E015, "system__soft_links_E");
   E025 : Short_Integer; pragma Import (Ada, E025, "system__exception_table_E");
   E040 : Short_Integer; pragma Import (Ada, E040, "ada__containers_E");
   E068 : Short_Integer; pragma Import (Ada, E068, "ada__io_exceptions_E");
   E052 : Short_Integer; pragma Import (Ada, E052, "ada__strings_E");
   E054 : Short_Integer; pragma Import (Ada, E054, "ada__strings__maps_E");
   E058 : Short_Integer; pragma Import (Ada, E058, "ada__strings__maps__constants_E");
   E078 : Short_Integer; pragma Import (Ada, E078, "interfaces__c_E");
   E027 : Short_Integer; pragma Import (Ada, E027, "system__exceptions_E");
   E080 : Short_Integer; pragma Import (Ada, E080, "system__object_reader_E");
   E047 : Short_Integer; pragma Import (Ada, E047, "system__dwarf_lines_E");
   E017 : Short_Integer; pragma Import (Ada, E017, "system__soft_links__initialize_E");
   E039 : Short_Integer; pragma Import (Ada, E039, "system__traceback__symbolic_E");
   E099 : Short_Integer; pragma Import (Ada, E099, "ada__tags_E");
   E107 : Short_Integer; pragma Import (Ada, E107, "ada__streams_E");
   E180 : Short_Integer; pragma Import (Ada, E180, "gnat_E");
   E147 : Short_Integer; pragma Import (Ada, E147, "interfaces__c__strings_E");
   E115 : Short_Integer; pragma Import (Ada, E115, "system__file_control_block_E");
   E114 : Short_Integer; pragma Import (Ada, E114, "system__finalization_root_E");
   E112 : Short_Integer; pragma Import (Ada, E112, "ada__finalization_E");
   E111 : Short_Integer; pragma Import (Ada, E111, "system__file_io_E");
   E153 : Short_Integer; pragma Import (Ada, E153, "system__storage_pools_E");
   E149 : Short_Integer; pragma Import (Ada, E149, "system__finalization_masters_E");
   E159 : Short_Integer; pragma Import (Ada, E159, "system__storage_pools__subpools_E");
   E105 : Short_Integer; pragma Import (Ada, E105, "ada__text_io_E");
   E374 : Short_Integer; pragma Import (Ada, E374, "system__assertions_E");
   E155 : Short_Integer; pragma Import (Ada, E155, "system__pool_global_E");
   E142 : Short_Integer; pragma Import (Ada, E142, "glib_E");
   E145 : Short_Integer; pragma Import (Ada, E145, "gtkada__types_E");
   E117 : Short_Integer; pragma Import (Ada, E117, "chess_E");
   E119 : Short_Integer; pragma Import (Ada, E119, "move_E");
   E235 : Short_Integer; pragma Import (Ada, E235, "gdk__frame_timings_E");
   E191 : Short_Integer; pragma Import (Ada, E191, "glib__glist_E");
   E217 : Short_Integer; pragma Import (Ada, E217, "gdk__visual_E");
   E193 : Short_Integer; pragma Import (Ada, E193, "glib__gslist_E");
   E358 : Short_Integer; pragma Import (Ada, E358, "glib__poll_E");
   E185 : Short_Integer; pragma Import (Ada, E185, "gtkada__c_E");
   E175 : Short_Integer; pragma Import (Ada, E175, "glib__object_E");
   E177 : Short_Integer; pragma Import (Ada, E177, "glib__type_conversion_hooks_E");
   E187 : Short_Integer; pragma Import (Ada, E187, "glib__types_E");
   E189 : Short_Integer; pragma Import (Ada, E189, "glib__values_E");
   E179 : Short_Integer; pragma Import (Ada, E179, "gtkada__bindings_E");
   E195 : Short_Integer; pragma Import (Ada, E195, "cairo_E");
   E197 : Short_Integer; pragma Import (Ada, E197, "cairo__region_E");
   E199 : Short_Integer; pragma Import (Ada, E199, "gdk__rectangle_E");
   E173 : Short_Integer; pragma Import (Ada, E173, "glib__generic_properties_E");
   E227 : Short_Integer; pragma Import (Ada, E227, "gdk__color_E");
   E209 : Short_Integer; pragma Import (Ada, E209, "gdk__rgba_E");
   E171 : Short_Integer; pragma Import (Ada, E171, "gdk__event_E");
   E336 : Short_Integer; pragma Import (Ada, E336, "glib__key_file_E");
   E219 : Short_Integer; pragma Import (Ada, E219, "glib__properties_E");
   E360 : Short_Integer; pragma Import (Ada, E360, "glib__spawn_E");
   E356 : Short_Integer; pragma Import (Ada, E356, "glib__main_E");
   E298 : Short_Integer; pragma Import (Ada, E298, "glib__string_E");
   E296 : Short_Integer; pragma Import (Ada, E296, "glib__variant_E");
   E294 : Short_Integer; pragma Import (Ada, E294, "glib__g_icon_E");
   E366 : Short_Integer; pragma Import (Ada, E366, "gtk__actionable_E");
   E239 : Short_Integer; pragma Import (Ada, E239, "gtk__builder_E");
   E278 : Short_Integer; pragma Import (Ada, E278, "gtk__buildable_E");
   E310 : Short_Integer; pragma Import (Ada, E310, "gtk__cell_area_context_E");
   E326 : Short_Integer; pragma Import (Ada, E326, "gtk__css_section_E");
   E221 : Short_Integer; pragma Import (Ada, E221, "gtk__enums_E");
   E284 : Short_Integer; pragma Import (Ada, E284, "gtk__orientable_E");
   E338 : Short_Integer; pragma Import (Ada, E338, "gtk__paper_size_E");
   E334 : Short_Integer; pragma Import (Ada, E334, "gtk__page_setup_E");
   E346 : Short_Integer; pragma Import (Ada, E346, "gtk__print_settings_E");
   E249 : Short_Integer; pragma Import (Ada, E249, "gtk__target_entry_E");
   E247 : Short_Integer; pragma Import (Ada, E247, "gtk__target_list_E");
   E254 : Short_Integer; pragma Import (Ada, E254, "pango__enums_E");
   E272 : Short_Integer; pragma Import (Ada, E272, "pango__attributes_E");
   E258 : Short_Integer; pragma Import (Ada, E258, "pango__font_metrics_E");
   E260 : Short_Integer; pragma Import (Ada, E260, "pango__language_E");
   E256 : Short_Integer; pragma Import (Ada, E256, "pango__font_E");
   E352 : Short_Integer; pragma Import (Ada, E352, "gtk__text_attributes_E");
   E354 : Short_Integer; pragma Import (Ada, E354, "gtk__text_tag_E");
   E264 : Short_Integer; pragma Import (Ada, E264, "pango__font_face_E");
   E262 : Short_Integer; pragma Import (Ada, E262, "pango__font_family_E");
   E266 : Short_Integer; pragma Import (Ada, E266, "pango__fontset_E");
   E268 : Short_Integer; pragma Import (Ada, E268, "pango__matrix_E");
   E252 : Short_Integer; pragma Import (Ada, E252, "pango__context_E");
   E342 : Short_Integer; pragma Import (Ada, E342, "pango__font_map_E");
   E274 : Short_Integer; pragma Import (Ada, E274, "pango__tabs_E");
   E270 : Short_Integer; pragma Import (Ada, E270, "pango__layout_E");
   E340 : Short_Integer; pragma Import (Ada, E340, "gtk__print_context_E");
   E204 : Short_Integer; pragma Import (Ada, E204, "gdk__display_E");
   E233 : Short_Integer; pragma Import (Ada, E233, "gdk__frame_clock_E");
   E202 : Short_Integer; pragma Import (Ada, E202, "gdk__pixbuf_E");
   E215 : Short_Integer; pragma Import (Ada, E215, "gdk__screen_E");
   E229 : Short_Integer; pragma Import (Ada, E229, "gdk__device_E");
   E231 : Short_Integer; pragma Import (Ada, E231, "gdk__drag_contexts_E");
   E288 : Short_Integer; pragma Import (Ada, E288, "gdk__window_E");
   E237 : Short_Integer; pragma Import (Ada, E237, "gtk__accel_group_E");
   E282 : Short_Integer; pragma Import (Ada, E282, "gtk__adjustment_E");
   E300 : Short_Integer; pragma Import (Ada, E300, "gtk__cell_editable_E");
   E302 : Short_Integer; pragma Import (Ada, E302, "gtk__editable_E");
   E304 : Short_Integer; pragma Import (Ada, E304, "gtk__entry_buffer_E");
   E322 : Short_Integer; pragma Import (Ada, E322, "gtk__icon_source_E");
   E344 : Short_Integer; pragma Import (Ada, E344, "gtk__print_operation_preview_E");
   E243 : Short_Integer; pragma Import (Ada, E243, "gtk__selection_data_E");
   E245 : Short_Integer; pragma Import (Ada, E245, "gtk__style_E");
   E350 : Short_Integer; pragma Import (Ada, E350, "gtk__text_iter_E");
   E316 : Short_Integer; pragma Import (Ada, E316, "gtk__tree_model_E");
   E225 : Short_Integer; pragma Import (Ada, E225, "gtk__widget_E");
   E314 : Short_Integer; pragma Import (Ada, E314, "gtk__cell_renderer_E");
   E312 : Short_Integer; pragma Import (Ada, E312, "gtk__cell_layout_E");
   E308 : Short_Integer; pragma Import (Ada, E308, "gtk__cell_area_E");
   E280 : Short_Integer; pragma Import (Ada, E280, "gtk__container_E");
   E290 : Short_Integer; pragma Import (Ada, E290, "gtk__bin_E");
   E276 : Short_Integer; pragma Import (Ada, E276, "gtk__box_E");
   E306 : Short_Integer; pragma Import (Ada, E306, "gtk__entry_completion_E");
   E328 : Short_Integer; pragma Import (Ada, E328, "gtk__misc_E");
   E330 : Short_Integer; pragma Import (Ada, E330, "gtk__notebook_E");
   E348 : Short_Integer; pragma Import (Ada, E348, "gtk__status_bar_E");
   E223 : Short_Integer; pragma Import (Ada, E223, "gtk__style_provider_E");
   E213 : Short_Integer; pragma Import (Ada, E213, "gtk__settings_E");
   E324 : Short_Integer; pragma Import (Ada, E324, "gtk__style_context_E");
   E320 : Short_Integer; pragma Import (Ada, E320, "gtk__icon_set_E");
   E318 : Short_Integer; pragma Import (Ada, E318, "gtk__image_E");
   E292 : Short_Integer; pragma Import (Ada, E292, "gtk__gentry_E");
   E286 : Short_Integer; pragma Import (Ada, E286, "gtk__window_E");
   E211 : Short_Integer; pragma Import (Ada, E211, "gtk__dialog_E");
   E332 : Short_Integer; pragma Import (Ada, E332, "gtk__print_operation_E");
   E207 : Short_Integer; pragma Import (Ada, E207, "gtk__arguments_E");
   E384 : Short_Integer; pragma Import (Ada, E384, "glib__menu_model_E");
   E364 : Short_Integer; pragma Import (Ada, E364, "gtk__action_E");
   E368 : Short_Integer; pragma Import (Ada, E368, "gtk__activatable_E");
   E362 : Short_Integer; pragma Import (Ada, E362, "gtk__button_E");
   E370 : Short_Integer; pragma Import (Ada, E370, "gtk__grid_E");
   E394 : Short_Integer; pragma Import (Ada, E394, "gtk__main_E");
   E376 : Short_Integer; pragma Import (Ada, E376, "gtk__marshallers_E");
   E386 : Short_Integer; pragma Import (Ada, E386, "gtk__menu_item_E");
   E388 : Short_Integer; pragma Import (Ada, E388, "gtk__menu_shell_E");
   E382 : Short_Integer; pragma Import (Ada, E382, "gtk__menu_E");
   E380 : Short_Integer; pragma Import (Ada, E380, "gtk__label_E");
   E392 : Short_Integer; pragma Import (Ada, E392, "gtk__scrollable_E");
   E390 : Short_Integer; pragma Import (Ada, E390, "gtk__layout_E");
   E378 : Short_Integer; pragma Import (Ada, E378, "gtk__tree_view_column_E");

   Sec_Default_Sized_Stacks : array (1 .. 1) of aliased System.Secondary_Stack.SS_Stack (System.Parameters.Runtime_Default_Sec_Stack_Size);

   Local_Priority_Specific_Dispatching : constant String := "";
   Local_Interrupt_States : constant String := "";

   Is_Elaborated : Boolean := False;

   procedure finalize_library is
   begin
      E378 := E378 - 1;
      declare
         procedure F1;
         pragma Import (Ada, F1, "gtk__tree_view_column__finalize_spec");
      begin
         F1;
      end;
      E390 := E390 - 1;
      declare
         procedure F2;
         pragma Import (Ada, F2, "gtk__layout__finalize_spec");
      begin
         F2;
      end;
      E380 := E380 - 1;
      declare
         procedure F3;
         pragma Import (Ada, F3, "gtk__label__finalize_spec");
      begin
         F3;
      end;
      E382 := E382 - 1;
      declare
         procedure F4;
         pragma Import (Ada, F4, "gtk__menu__finalize_spec");
      begin
         F4;
      end;
      E388 := E388 - 1;
      declare
         procedure F5;
         pragma Import (Ada, F5, "gtk__menu_shell__finalize_spec");
      begin
         F5;
      end;
      E386 := E386 - 1;
      declare
         procedure F6;
         pragma Import (Ada, F6, "gtk__menu_item__finalize_spec");
      begin
         F6;
      end;
      E370 := E370 - 1;
      declare
         procedure F7;
         pragma Import (Ada, F7, "gtk__grid__finalize_spec");
      begin
         F7;
      end;
      E362 := E362 - 1;
      declare
         procedure F8;
         pragma Import (Ada, F8, "gtk__button__finalize_spec");
      begin
         F8;
      end;
      E364 := E364 - 1;
      declare
         procedure F9;
         pragma Import (Ada, F9, "gtk__action__finalize_spec");
      begin
         F9;
      end;
      E384 := E384 - 1;
      declare
         procedure F10;
         pragma Import (Ada, F10, "glib__menu_model__finalize_spec");
      begin
         F10;
      end;
      E286 := E286 - 1;
      E225 := E225 - 1;
      E316 := E316 - 1;
      E324 := E324 - 1;
      E245 := E245 - 1;
      E348 := E348 - 1;
      E332 := E332 - 1;
      E330 := E330 - 1;
      E292 := E292 - 1;
      E306 := E306 - 1;
      E304 := E304 - 1;
      E211 := E211 - 1;
      E280 := E280 - 1;
      E314 := E314 - 1;
      E308 := E308 - 1;
      E282 := E282 - 1;
      E237 := E237 - 1;
      E233 := E233 - 1;
      E204 := E204 - 1;
      declare
         procedure F11;
         pragma Import (Ada, F11, "gtk__print_operation__finalize_spec");
      begin
         F11;
      end;
      declare
         procedure F12;
         pragma Import (Ada, F12, "gtk__dialog__finalize_spec");
      begin
         F12;
      end;
      declare
         procedure F13;
         pragma Import (Ada, F13, "gtk__window__finalize_spec");
      begin
         F13;
      end;
      declare
         procedure F14;
         pragma Import (Ada, F14, "gtk__gentry__finalize_spec");
      begin
         F14;
      end;
      E318 := E318 - 1;
      declare
         procedure F15;
         pragma Import (Ada, F15, "gtk__image__finalize_spec");
      begin
         F15;
      end;
      E320 := E320 - 1;
      declare
         procedure F16;
         pragma Import (Ada, F16, "gtk__icon_set__finalize_spec");
      begin
         F16;
      end;
      declare
         procedure F17;
         pragma Import (Ada, F17, "gtk__style_context__finalize_spec");
      begin
         F17;
      end;
      E213 := E213 - 1;
      declare
         procedure F18;
         pragma Import (Ada, F18, "gtk__settings__finalize_spec");
      begin
         F18;
      end;
      declare
         procedure F19;
         pragma Import (Ada, F19, "gtk__status_bar__finalize_spec");
      begin
         F19;
      end;
      declare
         procedure F20;
         pragma Import (Ada, F20, "gtk__notebook__finalize_spec");
      begin
         F20;
      end;
      E328 := E328 - 1;
      declare
         procedure F21;
         pragma Import (Ada, F21, "gtk__misc__finalize_spec");
      begin
         F21;
      end;
      declare
         procedure F22;
         pragma Import (Ada, F22, "gtk__entry_completion__finalize_spec");
      begin
         F22;
      end;
      E276 := E276 - 1;
      declare
         procedure F23;
         pragma Import (Ada, F23, "gtk__box__finalize_spec");
      begin
         F23;
      end;
      E290 := E290 - 1;
      declare
         procedure F24;
         pragma Import (Ada, F24, "gtk__bin__finalize_spec");
      begin
         F24;
      end;
      declare
         procedure F25;
         pragma Import (Ada, F25, "gtk__container__finalize_spec");
      begin
         F25;
      end;
      declare
         procedure F26;
         pragma Import (Ada, F26, "gtk__cell_area__finalize_spec");
      begin
         F26;
      end;
      declare
         procedure F27;
         pragma Import (Ada, F27, "gtk__cell_renderer__finalize_spec");
      begin
         F27;
      end;
      declare
         procedure F28;
         pragma Import (Ada, F28, "gtk__widget__finalize_spec");
      begin
         F28;
      end;
      declare
         procedure F29;
         pragma Import (Ada, F29, "gtk__tree_model__finalize_spec");
      begin
         F29;
      end;
      declare
         procedure F30;
         pragma Import (Ada, F30, "gtk__style__finalize_spec");
      begin
         F30;
      end;
      E243 := E243 - 1;
      declare
         procedure F31;
         pragma Import (Ada, F31, "gtk__selection_data__finalize_spec");
      begin
         F31;
      end;
      E322 := E322 - 1;
      declare
         procedure F32;
         pragma Import (Ada, F32, "gtk__icon_source__finalize_spec");
      begin
         F32;
      end;
      declare
         procedure F33;
         pragma Import (Ada, F33, "gtk__entry_buffer__finalize_spec");
      begin
         F33;
      end;
      declare
         procedure F34;
         pragma Import (Ada, F34, "gtk__adjustment__finalize_spec");
      begin
         F34;
      end;
      declare
         procedure F35;
         pragma Import (Ada, F35, "gtk__accel_group__finalize_spec");
      begin
         F35;
      end;
      E231 := E231 - 1;
      declare
         procedure F36;
         pragma Import (Ada, F36, "gdk__drag_contexts__finalize_spec");
      begin
         F36;
      end;
      E229 := E229 - 1;
      declare
         procedure F37;
         pragma Import (Ada, F37, "gdk__device__finalize_spec");
      begin
         F37;
      end;
      E215 := E215 - 1;
      declare
         procedure F38;
         pragma Import (Ada, F38, "gdk__screen__finalize_spec");
      begin
         F38;
      end;
      E202 := E202 - 1;
      declare
         procedure F39;
         pragma Import (Ada, F39, "gdk__pixbuf__finalize_spec");
      begin
         F39;
      end;
      declare
         procedure F40;
         pragma Import (Ada, F40, "gdk__frame_clock__finalize_spec");
      begin
         F40;
      end;
      declare
         procedure F41;
         pragma Import (Ada, F41, "gdk__display__finalize_spec");
      begin
         F41;
      end;
      E340 := E340 - 1;
      declare
         procedure F42;
         pragma Import (Ada, F42, "gtk__print_context__finalize_spec");
      begin
         F42;
      end;
      E270 := E270 - 1;
      declare
         procedure F43;
         pragma Import (Ada, F43, "pango__layout__finalize_spec");
      begin
         F43;
      end;
      E274 := E274 - 1;
      declare
         procedure F44;
         pragma Import (Ada, F44, "pango__tabs__finalize_spec");
      begin
         F44;
      end;
      E342 := E342 - 1;
      declare
         procedure F45;
         pragma Import (Ada, F45, "pango__font_map__finalize_spec");
      begin
         F45;
      end;
      E252 := E252 - 1;
      declare
         procedure F46;
         pragma Import (Ada, F46, "pango__context__finalize_spec");
      begin
         F46;
      end;
      E266 := E266 - 1;
      declare
         procedure F47;
         pragma Import (Ada, F47, "pango__fontset__finalize_spec");
      begin
         F47;
      end;
      E262 := E262 - 1;
      declare
         procedure F48;
         pragma Import (Ada, F48, "pango__font_family__finalize_spec");
      begin
         F48;
      end;
      E264 := E264 - 1;
      declare
         procedure F49;
         pragma Import (Ada, F49, "pango__font_face__finalize_spec");
      begin
         F49;
      end;
      E354 := E354 - 1;
      declare
         procedure F50;
         pragma Import (Ada, F50, "gtk__text_tag__finalize_spec");
      begin
         F50;
      end;
      E256 := E256 - 1;
      declare
         procedure F51;
         pragma Import (Ada, F51, "pango__font__finalize_spec");
      begin
         F51;
      end;
      E260 := E260 - 1;
      declare
         procedure F52;
         pragma Import (Ada, F52, "pango__language__finalize_spec");
      begin
         F52;
      end;
      E258 := E258 - 1;
      declare
         procedure F53;
         pragma Import (Ada, F53, "pango__font_metrics__finalize_spec");
      begin
         F53;
      end;
      E272 := E272 - 1;
      declare
         procedure F54;
         pragma Import (Ada, F54, "pango__attributes__finalize_spec");
      begin
         F54;
      end;
      E247 := E247 - 1;
      declare
         procedure F55;
         pragma Import (Ada, F55, "gtk__target_list__finalize_spec");
      begin
         F55;
      end;
      E346 := E346 - 1;
      declare
         procedure F56;
         pragma Import (Ada, F56, "gtk__print_settings__finalize_spec");
      begin
         F56;
      end;
      E334 := E334 - 1;
      declare
         procedure F57;
         pragma Import (Ada, F57, "gtk__page_setup__finalize_spec");
      begin
         F57;
      end;
      E338 := E338 - 1;
      declare
         procedure F58;
         pragma Import (Ada, F58, "gtk__paper_size__finalize_spec");
      begin
         F58;
      end;
      E326 := E326 - 1;
      declare
         procedure F59;
         pragma Import (Ada, F59, "gtk__css_section__finalize_spec");
      begin
         F59;
      end;
      E310 := E310 - 1;
      declare
         procedure F60;
         pragma Import (Ada, F60, "gtk__cell_area_context__finalize_spec");
      begin
         F60;
      end;
      E239 := E239 - 1;
      declare
         procedure F61;
         pragma Import (Ada, F61, "gtk__builder__finalize_spec");
      begin
         F61;
      end;
      E296 := E296 - 1;
      declare
         procedure F62;
         pragma Import (Ada, F62, "glib__variant__finalize_spec");
      begin
         F62;
      end;
      E175 := E175 - 1;
      declare
         procedure F63;
         pragma Import (Ada, F63, "glib__object__finalize_spec");
      begin
         F63;
      end;
      E235 := E235 - 1;
      declare
         procedure F64;
         pragma Import (Ada, F64, "gdk__frame_timings__finalize_spec");
      begin
         F64;
      end;
      E142 := E142 - 1;
      declare
         procedure F65;
         pragma Import (Ada, F65, "glib__finalize_spec");
      begin
         F65;
      end;
      E155 := E155 - 1;
      declare
         procedure F66;
         pragma Import (Ada, F66, "system__pool_global__finalize_spec");
      begin
         F66;
      end;
      E105 := E105 - 1;
      declare
         procedure F67;
         pragma Import (Ada, F67, "ada__text_io__finalize_spec");
      begin
         F67;
      end;
      E159 := E159 - 1;
      declare
         procedure F68;
         pragma Import (Ada, F68, "system__storage_pools__subpools__finalize_spec");
      begin
         F68;
      end;
      E149 := E149 - 1;
      declare
         procedure F69;
         pragma Import (Ada, F69, "system__finalization_masters__finalize_spec");
      begin
         F69;
      end;
      declare
         procedure F70;
         pragma Import (Ada, F70, "system__file_io__finalize_body");
      begin
         E111 := E111 - 1;
         F70;
      end;
      declare
         procedure Reraise_Library_Exception_If_Any;
            pragma Import (Ada, Reraise_Library_Exception_If_Any, "__gnat_reraise_library_exception_if_any");
      begin
         Reraise_Library_Exception_If_Any;
      end;
   end finalize_library;

   procedure adafinal is
      procedure s_stalib_adafinal;
      pragma Import (Ada, s_stalib_adafinal, "system__standard_library__adafinal");

      procedure Runtime_Finalize;
      pragma Import (C, Runtime_Finalize, "__gnat_runtime_finalize");

   begin
      if not Is_Elaborated then
         return;
      end if;
      Is_Elaborated := False;
      Runtime_Finalize;
      s_stalib_adafinal;
   end adafinal;

   type No_Param_Proc is access procedure;
   pragma Favor_Top_Level (No_Param_Proc);

   procedure adainit is
      Main_Priority : Integer;
      pragma Import (C, Main_Priority, "__gl_main_priority");
      Time_Slice_Value : Integer;
      pragma Import (C, Time_Slice_Value, "__gl_time_slice_val");
      WC_Encoding : Character;
      pragma Import (C, WC_Encoding, "__gl_wc_encoding");
      Locking_Policy : Character;
      pragma Import (C, Locking_Policy, "__gl_locking_policy");
      Queuing_Policy : Character;
      pragma Import (C, Queuing_Policy, "__gl_queuing_policy");
      Task_Dispatching_Policy : Character;
      pragma Import (C, Task_Dispatching_Policy, "__gl_task_dispatching_policy");
      Priority_Specific_Dispatching : System.Address;
      pragma Import (C, Priority_Specific_Dispatching, "__gl_priority_specific_dispatching");
      Num_Specific_Dispatching : Integer;
      pragma Import (C, Num_Specific_Dispatching, "__gl_num_specific_dispatching");
      Main_CPU : Integer;
      pragma Import (C, Main_CPU, "__gl_main_cpu");
      Interrupt_States : System.Address;
      pragma Import (C, Interrupt_States, "__gl_interrupt_states");
      Num_Interrupt_States : Integer;
      pragma Import (C, Num_Interrupt_States, "__gl_num_interrupt_states");
      Unreserve_All_Interrupts : Integer;
      pragma Import (C, Unreserve_All_Interrupts, "__gl_unreserve_all_interrupts");
      Detect_Blocking : Integer;
      pragma Import (C, Detect_Blocking, "__gl_detect_blocking");
      Default_Stack_Size : Integer;
      pragma Import (C, Default_Stack_Size, "__gl_default_stack_size");
      Default_Secondary_Stack_Size : System.Parameters.Size_Type;
      pragma Import (C, Default_Secondary_Stack_Size, "__gnat_default_ss_size");
      Bind_Env_Addr : System.Address;
      pragma Import (C, Bind_Env_Addr, "__gl_bind_env_addr");

      procedure Runtime_Initialize (Install_Handler : Integer);
      pragma Import (C, Runtime_Initialize, "__gnat_runtime_initialize");

      Finalize_Library_Objects : No_Param_Proc;
      pragma Import (C, Finalize_Library_Objects, "__gnat_finalize_library_objects");
      Binder_Sec_Stacks_Count : Natural;
      pragma Import (Ada, Binder_Sec_Stacks_Count, "__gnat_binder_ss_count");
      Default_Sized_SS_Pool : System.Address;
      pragma Import (Ada, Default_Sized_SS_Pool, "__gnat_default_ss_pool");

   begin
      if Is_Elaborated then
         return;
      end if;
      Is_Elaborated := True;
      Main_Priority := -1;
      Time_Slice_Value := -1;
      WC_Encoding := 'b';
      Locking_Policy := ' ';
      Queuing_Policy := ' ';
      Task_Dispatching_Policy := ' ';
      Priority_Specific_Dispatching :=
        Local_Priority_Specific_Dispatching'Address;
      Num_Specific_Dispatching := 0;
      Main_CPU := -1;
      Interrupt_States := Local_Interrupt_States'Address;
      Num_Interrupt_States := 0;
      Unreserve_All_Interrupts := 0;
      Detect_Blocking := 0;
      Default_Stack_Size := -1;

      ada_main'Elab_Body;
      Default_Secondary_Stack_Size := System.Parameters.Runtime_Default_Sec_Stack_Size;
      Binder_Sec_Stacks_Count := 1;
      Default_Sized_SS_Pool := Sec_Default_Sized_Stacks'Address;

      Runtime_Initialize (1);

      Finalize_Library_Objects := finalize_library'access;

      Ada.Exceptions'Elab_Spec;
      System.Soft_Links'Elab_Spec;
      System.Exception_Table'Elab_Body;
      E025 := E025 + 1;
      Ada.Containers'Elab_Spec;
      E040 := E040 + 1;
      Ada.Io_Exceptions'Elab_Spec;
      E068 := E068 + 1;
      Ada.Strings'Elab_Spec;
      E052 := E052 + 1;
      Ada.Strings.Maps'Elab_Spec;
      E054 := E054 + 1;
      Ada.Strings.Maps.Constants'Elab_Spec;
      E058 := E058 + 1;
      Interfaces.C'Elab_Spec;
      E078 := E078 + 1;
      System.Exceptions'Elab_Spec;
      E027 := E027 + 1;
      System.Object_Reader'Elab_Spec;
      E080 := E080 + 1;
      System.Dwarf_Lines'Elab_Spec;
      E047 := E047 + 1;
      System.Os_Lib'Elab_Body;
      E072 := E072 + 1;
      System.Soft_Links.Initialize'Elab_Body;
      E017 := E017 + 1;
      E015 := E015 + 1;
      System.Traceback.Symbolic'Elab_Body;
      E039 := E039 + 1;
      E011 := E011 + 1;
      Ada.Tags'Elab_Spec;
      Ada.Tags'Elab_Body;
      E099 := E099 + 1;
      Ada.Streams'Elab_Spec;
      E107 := E107 + 1;
      Gnat'Elab_Spec;
      E180 := E180 + 1;
      Interfaces.C.Strings'Elab_Spec;
      E147 := E147 + 1;
      System.File_Control_Block'Elab_Spec;
      E115 := E115 + 1;
      System.Finalization_Root'Elab_Spec;
      E114 := E114 + 1;
      Ada.Finalization'Elab_Spec;
      E112 := E112 + 1;
      System.File_Io'Elab_Body;
      E111 := E111 + 1;
      System.Storage_Pools'Elab_Spec;
      E153 := E153 + 1;
      System.Finalization_Masters'Elab_Spec;
      System.Finalization_Masters'Elab_Body;
      E149 := E149 + 1;
      System.Storage_Pools.Subpools'Elab_Spec;
      E159 := E159 + 1;
      Ada.Text_Io'Elab_Spec;
      Ada.Text_Io'Elab_Body;
      E105 := E105 + 1;
      System.Assertions'Elab_Spec;
      E374 := E374 + 1;
      System.Pool_Global'Elab_Spec;
      E155 := E155 + 1;
      Glib'Elab_Spec;
      Gtkada.Types'Elab_Spec;
      E145 := E145 + 1;
      E142 := E142 + 1;
      Chess'Elab_Spec;
      E119 := E119 + 1;
      E117 := E117 + 1;
      Gdk.Frame_Timings'Elab_Spec;
      Gdk.Frame_Timings'Elab_Body;
      E235 := E235 + 1;
      E191 := E191 + 1;
      Gdk.Visual'Elab_Body;
      E217 := E217 + 1;
      E193 := E193 + 1;
      E358 := E358 + 1;
      E185 := E185 + 1;
      Glib.Object'Elab_Spec;
      E177 := E177 + 1;
      Glib.Values'Elab_Body;
      E189 := E189 + 1;
      E179 := E179 + 1;
      Glib.Object'Elab_Body;
      E175 := E175 + 1;
      E187 := E187 + 1;
      E195 := E195 + 1;
      E197 := E197 + 1;
      E199 := E199 + 1;
      Glib.Generic_Properties'Elab_Spec;
      Glib.Generic_Properties'Elab_Body;
      E173 := E173 + 1;
      Gdk.Color'Elab_Spec;
      E227 := E227 + 1;
      E209 := E209 + 1;
      E171 := E171 + 1;
      E336 := E336 + 1;
      E219 := E219 + 1;
      E360 := E360 + 1;
      E356 := E356 + 1;
      E298 := E298 + 1;
      Glib.Variant'Elab_Spec;
      Glib.Variant'Elab_Body;
      E296 := E296 + 1;
      E294 := E294 + 1;
      Gtk.Actionable'Elab_Spec;
      E366 := E366 + 1;
      Gtk.Builder'Elab_Spec;
      Gtk.Builder'Elab_Body;
      E239 := E239 + 1;
      E278 := E278 + 1;
      Gtk.Cell_Area_Context'Elab_Spec;
      Gtk.Cell_Area_Context'Elab_Body;
      E310 := E310 + 1;
      Gtk.Css_Section'Elab_Spec;
      Gtk.Css_Section'Elab_Body;
      E326 := E326 + 1;
      E221 := E221 + 1;
      Gtk.Orientable'Elab_Spec;
      E284 := E284 + 1;
      Gtk.Paper_Size'Elab_Spec;
      Gtk.Paper_Size'Elab_Body;
      E338 := E338 + 1;
      Gtk.Page_Setup'Elab_Spec;
      Gtk.Page_Setup'Elab_Body;
      E334 := E334 + 1;
      Gtk.Print_Settings'Elab_Spec;
      Gtk.Print_Settings'Elab_Body;
      E346 := E346 + 1;
      E249 := E249 + 1;
      Gtk.Target_List'Elab_Spec;
      Gtk.Target_List'Elab_Body;
      E247 := E247 + 1;
      E254 := E254 + 1;
      Pango.Attributes'Elab_Spec;
      Pango.Attributes'Elab_Body;
      E272 := E272 + 1;
      Pango.Font_Metrics'Elab_Spec;
      Pango.Font_Metrics'Elab_Body;
      E258 := E258 + 1;
      Pango.Language'Elab_Spec;
      Pango.Language'Elab_Body;
      E260 := E260 + 1;
      Pango.Font'Elab_Spec;
      Pango.Font'Elab_Body;
      E256 := E256 + 1;
      E352 := E352 + 1;
      Gtk.Text_Tag'Elab_Spec;
      Gtk.Text_Tag'Elab_Body;
      E354 := E354 + 1;
      Pango.Font_Face'Elab_Spec;
      Pango.Font_Face'Elab_Body;
      E264 := E264 + 1;
      Pango.Font_Family'Elab_Spec;
      Pango.Font_Family'Elab_Body;
      E262 := E262 + 1;
      Pango.Fontset'Elab_Spec;
      Pango.Fontset'Elab_Body;
      E266 := E266 + 1;
      E268 := E268 + 1;
      Pango.Context'Elab_Spec;
      Pango.Context'Elab_Body;
      E252 := E252 + 1;
      Pango.Font_Map'Elab_Spec;
      Pango.Font_Map'Elab_Body;
      E342 := E342 + 1;
      Pango.Tabs'Elab_Spec;
      Pango.Tabs'Elab_Body;
      E274 := E274 + 1;
      Pango.Layout'Elab_Spec;
      Pango.Layout'Elab_Body;
      E270 := E270 + 1;
      Gtk.Print_Context'Elab_Spec;
      Gtk.Print_Context'Elab_Body;
      E340 := E340 + 1;
      Gdk.Display'Elab_Spec;
      Gdk.Frame_Clock'Elab_Spec;
      Gdk.Pixbuf'Elab_Spec;
      E202 := E202 + 1;
      Gdk.Screen'Elab_Spec;
      Gdk.Screen'Elab_Body;
      E215 := E215 + 1;
      Gdk.Device'Elab_Spec;
      Gdk.Device'Elab_Body;
      E229 := E229 + 1;
      Gdk.Drag_Contexts'Elab_Spec;
      Gdk.Drag_Contexts'Elab_Body;
      E231 := E231 + 1;
      Gdk.Window'Elab_Spec;
      E288 := E288 + 1;
      Gtk.Accel_Group'Elab_Spec;
      Gtk.Adjustment'Elab_Spec;
      Gtk.Cell_Editable'Elab_Spec;
      Gtk.Entry_Buffer'Elab_Spec;
      Gtk.Icon_Source'Elab_Spec;
      Gtk.Icon_Source'Elab_Body;
      E322 := E322 + 1;
      Gtk.Selection_Data'Elab_Spec;
      Gtk.Selection_Data'Elab_Body;
      E243 := E243 + 1;
      Gtk.Style'Elab_Spec;
      E350 := E350 + 1;
      Gtk.Tree_Model'Elab_Spec;
      Gtk.Widget'Elab_Spec;
      Gtk.Cell_Renderer'Elab_Spec;
      E312 := E312 + 1;
      Gtk.Cell_Area'Elab_Spec;
      Gtk.Container'Elab_Spec;
      Gtk.Bin'Elab_Spec;
      Gtk.Bin'Elab_Body;
      E290 := E290 + 1;
      Gtk.Box'Elab_Spec;
      Gtk.Box'Elab_Body;
      E276 := E276 + 1;
      Gtk.Entry_Completion'Elab_Spec;
      Gtk.Misc'Elab_Spec;
      Gtk.Misc'Elab_Body;
      E328 := E328 + 1;
      Gtk.Notebook'Elab_Spec;
      Gtk.Status_Bar'Elab_Spec;
      E223 := E223 + 1;
      Gtk.Settings'Elab_Spec;
      Gtk.Settings'Elab_Body;
      E213 := E213 + 1;
      Gtk.Style_Context'Elab_Spec;
      Gtk.Icon_Set'Elab_Spec;
      Gtk.Icon_Set'Elab_Body;
      E320 := E320 + 1;
      Gtk.Image'Elab_Spec;
      Gtk.Image'Elab_Body;
      E318 := E318 + 1;
      Gtk.Gentry'Elab_Spec;
      Gtk.Window'Elab_Spec;
      Gtk.Dialog'Elab_Spec;
      Gtk.Print_Operation'Elab_Spec;
      E207 := E207 + 1;
      Gdk.Display'Elab_Body;
      E204 := E204 + 1;
      Gdk.Frame_Clock'Elab_Body;
      E233 := E233 + 1;
      Gtk.Accel_Group'Elab_Body;
      E237 := E237 + 1;
      Gtk.Adjustment'Elab_Body;
      E282 := E282 + 1;
      Gtk.Cell_Area'Elab_Body;
      E308 := E308 + 1;
      E300 := E300 + 1;
      Gtk.Cell_Renderer'Elab_Body;
      E314 := E314 + 1;
      Gtk.Container'Elab_Body;
      E280 := E280 + 1;
      Gtk.Dialog'Elab_Body;
      E211 := E211 + 1;
      E302 := E302 + 1;
      Gtk.Entry_Buffer'Elab_Body;
      E304 := E304 + 1;
      Gtk.Entry_Completion'Elab_Body;
      E306 := E306 + 1;
      Gtk.Gentry'Elab_Body;
      E292 := E292 + 1;
      Gtk.Notebook'Elab_Body;
      E330 := E330 + 1;
      Gtk.Print_Operation'Elab_Body;
      E332 := E332 + 1;
      E344 := E344 + 1;
      Gtk.Status_Bar'Elab_Body;
      E348 := E348 + 1;
      Gtk.Style'Elab_Body;
      E245 := E245 + 1;
      Gtk.Style_Context'Elab_Body;
      E324 := E324 + 1;
      Gtk.Tree_Model'Elab_Body;
      E316 := E316 + 1;
      Gtk.Widget'Elab_Body;
      E225 := E225 + 1;
      Gtk.Window'Elab_Body;
      E286 := E286 + 1;
      Glib.Menu_Model'Elab_Spec;
      Glib.Menu_Model'Elab_Body;
      E384 := E384 + 1;
      Gtk.Action'Elab_Spec;
      Gtk.Action'Elab_Body;
      E364 := E364 + 1;
      Gtk.Activatable'Elab_Spec;
      E368 := E368 + 1;
      Gtk.Button'Elab_Spec;
      Gtk.Button'Elab_Body;
      E362 := E362 + 1;
      Gtk.Grid'Elab_Spec;
      Gtk.Grid'Elab_Body;
      E370 := E370 + 1;
      E394 := E394 + 1;
      E376 := E376 + 1;
      Gtk.Menu_Item'Elab_Spec;
      Gtk.Menu_Item'Elab_Body;
      E386 := E386 + 1;
      Gtk.Menu_Shell'Elab_Spec;
      Gtk.Menu_Shell'Elab_Body;
      E388 := E388 + 1;
      Gtk.Menu'Elab_Spec;
      Gtk.Menu'Elab_Body;
      E382 := E382 + 1;
      Gtk.Label'Elab_Spec;
      Gtk.Label'Elab_Body;
      E380 := E380 + 1;
      Gtk.Scrollable'Elab_Spec;
      E392 := E392 + 1;
      Gtk.Layout'Elab_Spec;
      Gtk.Layout'Elab_Body;
      E390 := E390 + 1;
      Gtk.Tree_View_Column'Elab_Spec;
      Gtk.Tree_View_Column'Elab_Body;
      E378 := E378 + 1;
   end adainit;

   procedure Ada_Main_Program;
   pragma Import (Ada, Ada_Main_Program, "_ada_main");

   function main
     (argc : Integer;
      argv : System.Address;
      envp : System.Address)
      return Integer
   is
      procedure Initialize (Addr : System.Address);
      pragma Import (C, Initialize, "__gnat_initialize");

      procedure Finalize;
      pragma Import (C, Finalize, "__gnat_finalize");
      SEH : aliased array (1 .. 2) of Integer;

      Ensure_Reference : aliased System.Address := Ada_Main_Program_Name'Address;
      pragma Volatile (Ensure_Reference);

   begin
      if gnat_argc = 0 then
         gnat_argc := argc;
         gnat_argv := argv;
      end if;
      gnat_envp := envp;

      Initialize (SEH'Address);
      adainit;
      Ada_Main_Program;
      adafinal;
      Finalize;
      return (gnat_exit_status);
   end;

--  BEGIN Object file/option list
   --   C:\Users\necro\Desktop\adachess\obj\move.o
   --   C:\Users\necro\Desktop\adachess\obj\chess.o
   --   C:\Users\necro\Desktop\adachess\obj\main.o
   --   -LC:\Users\necro\Desktop\adachess\obj\
   --   -LC:\Users\necro\Desktop\adachess\obj\
   --   -LC:\GtkAda\lib\gtkada\gtkada.static\gtkada\
   --   -LC:/gnat/community/lib/gcc/x86_64-pc-mingw32/9.3.1/adalib/
   --   -static
   --   -shared-libgcc
   --   -shared-libgcc
   --   -shared-libgcc
   --   -lgnat
   --   -Wl,--stack=0x2000000
--  END Object file/option list   

end ada_main;
