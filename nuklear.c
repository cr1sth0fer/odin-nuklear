#define _CRT_SECURE_NO_WARNINGS
#define NK_INCLUDE_FIXED_TYPES
#define NK_INCLUDE_STANDARD_BOOL
#define NK_INCLUDE_COMMAND_USERDATA
#define NK_KEYSTATE_BASED_INPUT

#include <stdint.h>

#ifndef ASSERTIONS
#ifndef DEBUG
#define NK_ASSERT(condition) ((void)0)
#else
    extern void nuklear_assert_handler(const char*, const char*, int);
    #define NK_ASSERT(condition) \
        do { \
            if (!(condition)) { \
                nuklear_assert_handler(#condition, __FILE__, __LINE__); \
            } \
        } while (0)
#endif

extern void nuklear_memset(void* dest, int c0, uint64_t size);
#define NK_MEMSET nuklear_memset

extern void* nuklear_memcpy(void* dest, const void* src, uint64_t size);
#define NK_MEMCPY nuklear_memcpy

extern float nuklear_inv_sqrt(float n);
#define NK_INV_SQRT nuklear_inv_sqrt

extern float nuklear_sin(float x);
#define NK_SIN nuklear_sin

extern float nuklear_cos(float x);
#define NK_COS nuklear_cos

extern float nuklear_atan(float x);
#define NK_ATAN nuklear_atan

extern float nuklear_atan2(float y, float x);
#define NK_ATAN2 nuklear_atan2
#endif // ASSERTIONS

#define NK_IMPLEMENTATION
#include "nuklear.h"

#ifdef ASSERTIONS

#include "stdio.h"
#define TYPE_ASSERT(_C_Type_, _Odin_Type_) fprintf(file, "#assert(size_of(%s) == %llu)\n", _Odin_Type_, sizeof(_C_Type_))

int main()
{
    FILE* file = fopen("assertions.odin", "w");
    fprintf(file, "package nuklear\n\n");
    TYPE_ASSERT(struct nk_rect, "Rect");
    TYPE_ASSERT(struct nk_recti, "RectI");
    TYPE_ASSERT(nk_handle, "Handle");
    TYPE_ASSERT(struct nk_image, "Image");
    TYPE_ASSERT(struct nk_nine_slice, "Nine_Slice");
    TYPE_ASSERT(struct nk_cursor, "Cursor");
    TYPE_ASSERT(struct nk_scroll, "Scroll");
    TYPE_ASSERT(struct nk_allocator, "Allocator");
    TYPE_ASSERT(struct nk_list_view, "List_View");
    TYPE_ASSERT(struct nk_user_font, "User_Font");
    TYPE_ASSERT(struct nk_memory_status, "Memory_Status");
    TYPE_ASSERT(struct nk_buffer_marker, "Buffer_Marker");
    TYPE_ASSERT(struct nk_memory, "Memory");
    TYPE_ASSERT(struct nk_buffer, "Buffer");
    TYPE_ASSERT(struct nk_str, "Str");
    TYPE_ASSERT(struct nk_clipboard, "Clipboard");
    TYPE_ASSERT(struct nk_text_undo_record, "Text_Undo_Record");
    TYPE_ASSERT(struct nk_text_undo_state, "Text_Undo_State");
    TYPE_ASSERT(struct nk_text_edit, "Text_Edit");
    TYPE_ASSERT(struct nk_command, "Command");
    TYPE_ASSERT(struct nk_command_scissor, "Command_Scissor");
    TYPE_ASSERT(struct nk_command_line, "Command_Line");
    TYPE_ASSERT(struct nk_command_curve, "Command_Curve");
    TYPE_ASSERT(struct nk_command_rect, "Command_Rect");
    TYPE_ASSERT(struct nk_command_rect_filled, "Command_Rect_Filled");
    TYPE_ASSERT(struct nk_command_rect_multi_color, "Command_Rect_Multi_Color");
    TYPE_ASSERT(struct nk_command_triangle, "Command_Triangle");
    TYPE_ASSERT(struct nk_command_triangle_filled, "Command_Triangle_Filled");
    TYPE_ASSERT(struct nk_command_circle, "Command_Circle");
    TYPE_ASSERT(struct nk_command_circle_filled, "Command_Circle_Filled");
    TYPE_ASSERT(struct nk_command_arc, "Command_Arc");
    TYPE_ASSERT(struct nk_command_arc_filled, "Command_Arc_Filled");
    TYPE_ASSERT(struct nk_command_polygon, "Command_Polygon");
    TYPE_ASSERT(struct nk_command_polygon_filled, "Command_Polygon_Filled");
    TYPE_ASSERT(struct nk_command_polyline, "Command_Polyline");
    TYPE_ASSERT(struct nk_command_image, "Command_Image");
    TYPE_ASSERT(struct nk_command_custom, "Command_Custom");
    TYPE_ASSERT(struct nk_command_text, "Command_Text");
    TYPE_ASSERT(struct nk_command_buffer, "Command_Buffer");
    TYPE_ASSERT(struct nk_mouse_button, "Mouse_Button");
    TYPE_ASSERT(struct nk_mouse, "Mouse");
    TYPE_ASSERT(struct nk_key, "Key");
    TYPE_ASSERT(struct nk_keyboard, "Keyboard");
    TYPE_ASSERT(struct nk_input, "Input");
    TYPE_ASSERT(union nk_style_item_data, "Style_Item_Data");
    TYPE_ASSERT(struct nk_style_item, "Style_Item");
    TYPE_ASSERT(struct nk_style_text, "Style_Text");
    TYPE_ASSERT(struct nk_style_button, "Style_Button");
    TYPE_ASSERT(struct nk_style_toggle, "Style_Toggle");
    TYPE_ASSERT(struct nk_style_selectable, "Style_Selectable");
    TYPE_ASSERT(struct nk_style_slider, "Style_Slider");
    TYPE_ASSERT(struct nk_style_progress, "Style_Progress");
    TYPE_ASSERT(struct nk_style_scrollbar, "Style_Scrollbar");
    TYPE_ASSERT(struct nk_style_edit, "Style_Edit");
    TYPE_ASSERT(struct nk_style_property, "Style_Property");
    TYPE_ASSERT(struct nk_style_chart, "Style_Chart");
    TYPE_ASSERT(struct nk_style_combo, "Style_Combo");
    TYPE_ASSERT(struct nk_style_tab, "Style_Tab");
    TYPE_ASSERT(struct nk_style_window, "Style_Window");
    TYPE_ASSERT(struct nk_style, "Style");
    TYPE_ASSERT(struct nk_chart_slot, "Chart_Slot");
    TYPE_ASSERT(struct nk_chart, "Chart");
    TYPE_ASSERT(struct nk_row_layout, "Row_Layout");
    TYPE_ASSERT(struct nk_popup_buffer, "Popup_Buffer");
    TYPE_ASSERT(struct nk_menu_state, "Menu_State");
    TYPE_ASSERT(struct nk_panel, "Panel");
    TYPE_ASSERT(struct nk_popup_state, "Popup_State");
    TYPE_ASSERT(struct nk_edit_state, "Edit_State");
    TYPE_ASSERT(struct nk_property_state, "Property_State");
    TYPE_ASSERT(struct nk_window, "Window");
    TYPE_ASSERT(struct nk_configuration_stacks, "Configuration_Stacks");
    TYPE_ASSERT(struct nk_table, "Table");
    TYPE_ASSERT(union nk_page_data, "Page_Data");
    TYPE_ASSERT(union nk_style_item_data, "Style_Item_Data");
    TYPE_ASSERT(struct nk_page_element, "Page_Element");
    TYPE_ASSERT(struct nk_page, "Page");
    TYPE_ASSERT(struct nk_pool, "Pool");
    TYPE_ASSERT(struct nk_context, "Context");

    TYPE_ASSERT(struct nk_config_stack_style_item, "Config_Stack_Style_Item");
    TYPE_ASSERT(struct nk_config_stack_float, "Config_Stack_Float");
    TYPE_ASSERT(struct nk_config_stack_vec2, "Config_Stack_Vec2");
    TYPE_ASSERT(struct nk_config_stack_flags, "Config_Stack_Flags");
    TYPE_ASSERT(struct nk_config_stack_color, "Config_Stack_Color");
    TYPE_ASSERT(struct nk_config_stack_user_font, "Config_Stack_User_Font");
    TYPE_ASSERT(struct nk_config_stack_button_behavior, "Config_Stack_Button_Behavior");
    fclose(file);

    return 0;
}

#endif
