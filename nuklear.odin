package nuklear

UNDEFINED :: -1.0

/* internal invalid utf8 rune */
UTF_INVALID : rune : 0xFFFD

/* describes the number of bytes a glyph consists of*/
UTF_SIZE :: size_of(rune)

INPUT_MAX                :: #config(NUKLEAR_INPUT_MAX, 16)
MAX_NUMBER_BUFFER        :: #config(NUKLEAR_MAX_NUMBER_BUFFER, 64)
SCROLLBAR_HIDING_TIMEOUT :: #config(NUKLEAR_SCROLLBAR_HIDING_TIMEOUT, 4.0)

INCLUDE_COMMAND_USERDATA :: #config(NK_INCLUDE_COMMAND_USERDATA, true)
INCLUDE_DEFAULT_ALLOCATOR :: #config(NK_INCLUDE_DEFAULT_ALLOCATOR, true)
KEYSTATE_BASED_INPUT :: #config(NK_KEYSTATE_BASED_INPUT, true)

Hash :: u32
Flags :: u32

Color   :: [4]u8
ColorF  :: [4]f32
Vec2    :: [2]f32
Vec2I   :: [2]i16

Rect :: struct
{
    x, y, w, h: f32,
}

RectI :: struct
{
    x, y, w, h: i16,
}

Handle :: struct #raw_union
{
    ptr: rawptr,
    id: i32,
}

Image :: struct
{
    handle: Handle,
    w, h: u16,
    region: [4]u16,
}

Nine_Slice :: struct
{
    img: Image,
    l, t, r, b: u16,
}

Cursor :: struct
{
    img: Image,
    size, offset: Vec2,
}

Scroll :: [2]u32

Heading :: enum i32
{
    Up,
    Right,
    Down,
    Left,
}

Button_Behavior :: enum i32
{
    Default,
    Repeater,
}

Modify :: enum i32
{
    Fixed = 0,
    Modifiable = 1,
}

Orientation :: enum i32
{
    Vertical,
    Horizontal,
}

Collapse_States :: enum i32
{
    Minimized = 0,
    Maximized = 1,
}

Show_States :: enum i32
{
    Hidden = 0,
    Shown = 1,
}

Chart_Type :: enum i32
{
    Lines,
    Column,
    Max,
}

Chart_Event :: enum i32
{
    Hovering = 0x01,
    Clicked = 0x02,
}

Color_Format :: enum i32
{
    RGB,
    RGBA,
}

Popup_Type :: enum i32
{
    Static,
    Dynamic,
}

Layout_Format :: enum i32
{
    Dynamic,
    Static,
}

Tree_Type :: enum i32
{
    Node,
    Tab,
}

Plugin_Alloc  :: #type proc "c" (Handle, rawptr, i64) -> rawptr
Plugin_Free   :: #type proc "c" (Handle, rawptr)
Plugin_Filter :: #type proc "c" (^Text_Edit, rune) -> bool
Plugin_Paste  :: #type proc "c" (Handle, ^Text_Edit)
Plugin_Copy   :: #type proc "c" (Handle, cstring, i32)

Allocator :: struct
{
    userdata: Handle,
    alloc: Plugin_Alloc,
    free: Plugin_Free,
}

Symbol_Type :: enum i32
{
    None,
    X,
    Underscore,
    Circle_Solid,
    Circle_Outline,
    Rect_Solid,
    Rect_Outline,
    Triangle_Up,
    Triangle_Down,
    Triangle_Left,
    Triangle_Right,
    Plus,
    Minus,
    Triangle_Up_Outline,
    Triangle_Down_Outline,
    Triangle_Left_Outline,
    Triangle_Right_Outline,
    Max,
}

Keys :: enum i32
{
    None,
    Shift,
    Ctrl,
    Del,
    Enter,
    Tab,
    Backspace,
    Copy,
    Cut,
    Paste,
    Up,
    Down,
    Left,
    Right,

    /* Shortcuts: text field */
    Text_Insert_Mode,
    Text_Replace_Mode,
    Text_Reset_Mode,
    Text_Line_Start,
    Text_Line_End,
    Text_Start,
    Text_End,
    Text_Undo,
    Text_Redo,
    Text_Select_All,
    Text_Word_Left,
    Text_Word_Right,

    /* Shortcuts: scrollbar */
    Scroll_Start,
    Scroll_End,
    Scroll_Down,
    Scroll_Up,
}

Buttons :: enum i32
{
    Left,
    Middle,
    Right,
    Double,
}

// Anti_Aliasing :: enum i32
// {
//     Off,
//     On,
// }

// Convert_Result_Flag :: enum i32
// {
//     Invalid_Param       = 0b1,
//     Command_Buffer_Full = 0b01,
//     Vertex_Buffer_Full  = 0b001,
//     Element_Buffer_Full = 0b0001,
// }

// Convert_Result :: bit_set[Convert_Result_Flag; i32]

// CONVERT_SUCCESS :: Convert_Result{}

// Draw_Null_Texture :: struct
// {
//     /* texture handle to a texture with a white pixel */
//     texture: Handle,

//     /* coordinates to a white pixel in the texture  */
//     uv: Vec2,
// }

/*
// #### nk_panel_flags
// Flag                        | Description
// ----------------------------|----------------------------------------
// NK_WINDOW_BORDER            | Draws a border around the window to visually separate window from the background
// NK_WINDOW_MOVABLE           | The movable flag indicates that a window can be moved by user input or by dragging the window header
// NK_WINDOW_SCALABLE          | The scalable flag indicates that a window can be scaled by user input by dragging a scaler icon at the button of the window
// NK_WINDOW_CLOSABLE          | Adds a closable icon into the header
// NK_WINDOW_MINIMIZABLE       | Adds a minimize icon into the header
// NK_WINDOW_NO_SCROLLBAR      | Removes the scrollbar from the window
// NK_WINDOW_TITLE             | Forces a header at the top at the window showing the title
// NK_WINDOW_SCROLL_AUTO_HIDE  | Automatically hides the window scrollbar if no user interaction: also requires delta time in `nk_context` to be set each frame
// NK_WINDOW_BACKGROUND        | Always keep window in the background
// NK_WINDOW_SCALE_LEFT        | Puts window scaler in the left-bottom corner instead right-bottom
// NK_WINDOW_NO_INPUT          | Prevents window of scaling, moving or getting focus
//
// #### nk_collapse_states
// State           | Description
// ----------------|-----------------------------------------------------------
// __NK_MINIMIZED__| UI section is collased and not visible until maximized
// __NK_MAXIMIZED__| UI section is extended and visible until minimized
*/
Panel_Flag :: enum i32
{
    Border,
    Movable,
    Scalable,
    Closable,
    Minimizable,
    No_Scrollbar,
    Title,
    Scroll_Auto_Hide,
    Background,
    Scale_Left,
    No_Input,
}

Panel_Flags :: bit_set[Panel_Flag; i32]

Widget_Align_Flag :: enum i32
{
    Left,
    Centered,
    Right,
    Top,
    Middle,
    Bottom,
}

Widget_Align :: bit_set[Widget_Align_Flag; i32]

WIDGET_ALIGNMNET_LEFT     :: Widget_Align{.Middle, .Left}
WIDGET_ALIGNMNET_CENTERED :: Widget_Align{.Middle, .Centered}
WIDGET_ALIGNMNET_RIGHT    :: Widget_Align{.Middle, .Right}

List_View :: struct
{
    /* public: */
    begin, end, count: i32,

    /* private: */
    total_height: i32,
    ctx: ^Context,
    scroll_pointer: ^u32,
    scroll_value: u32,
}

Widget_Layout_States :: enum i32
{
    /* The widget cannot be seen and is completely out of view */
    Invalid,

    /* The widget is completely inside the window and can be updated and drawn */
    Valid,

    /* The widget is partially visible and cannot be updated */
    Rom,

    /* The widget is manually disabled and acts like NK_WIDGET_ROM */
    Disabled,
}

Widget_States_Flag :: enum i32
{
    Modified,
    
    /* widget is neither active nor hovered */
    Inactive,
    
    /* widget has been hovered on the current frame */
    Entered,
    
    /* widget is being hovered */
    Hover,
    
    /* widget is currently activated */
    Actived,
    
    /* widget is from this frame on not hovered anymore */
    Left,
}

Widget_States :: bit_set[Widget_States_Flag; i32]

/* widget is being hovered */
WIDGET_STATE_HOVERED :: Widget_States{.Hover, .Modified}

/* widget is currently activated */
WIDGET_STATE_ACTIVE :: Widget_States{.Actived, .Modified}

Text_Align :: enum i32
{
    Left,
    Centered,
    Right,
    Top,
    Middle,
    Bottom,
}

Text_Alignment :: bit_set[Text_Align; i32]

TEXT_ALIGNMENT_LEFT     :: Text_Alignment{.Middle, .Left}
TEXT_ALIGNMENT_CENTERED :: Text_Alignment{.Middle, .Centered}
TEXT_ALIGNMENT_RIGHT    :: Text_Alignment{.Middle, .Right}

Edit_Flag :: enum i32
{
    Read_Only,
    Auto_Select,
    Sig_Enter,
    Allow_Tab,
    No_Cursor,
    Selectable,
    Clipboard,
    Ctrl_Enter_Newline,
    No_Horizontal_Scroll,
    Always_Insert_Mode,
    Multiline,
    Goto_End_On_Activate,
}

Edit_Flags :: bit_set[Edit_Flag; i32]

EDIT_SIMPLE     :: Edit_Flags{.Always_Insert_Mode}
EDIT_FIELD      :: Edit_Flags{.Always_Insert_Mode, .Selectable, .Clipboard}
EDIT_BOX        :: Edit_Flags{.Always_Insert_Mode, .Selectable, .Multiline, .Allow_Tab, .Clipboard}
EDIT_EDITOR     :: Edit_Flags{.Selectable, .Multiline, .Allow_Tab, .Clipboard}

Edit_Event_Flag :: enum i32
{
    /* edit widget is currently being modified */
    Active,

    /* edit widget is not active and is not being modified */
    Inactive,

    /* edit widget went from state inactive to state active */
    Activated,

    /* edit widget went from state active to state inactive */
    Deactivated,

    /* edit widget has received an enter and lost focus */
    Commited,
}

Edit_Events :: bit_set[Edit_Event_Flag; i32]

WIDGET_DISABLED_FACTOR :: 0.5

Style_Colors :: enum i32
{
    Text,
    Window,
    Header,
    Border,
    Button,
    Button_Hover,
    Button_Active,
    Toggle,
    Toggle_Hover,
    Toggle_Cursor,
    Select,
    Select_Active,
    Slider,
    Slider_Cursor,
    Slider_Cursor_Hover,
    Slider_Cursor_Active,
    Property,
    Edit,
    Edit_Cursor,
    Combo,
    Chart,
    Chart_Color,
    Chart_Color_Highlight,
    Scrollbar,
    Scrollbar_Cursor,
    Scrollbar_Cursor_Hover,
    Scrollbar_Cursor_Active,
    Tab_Header,
    Knob,
    Knob_Cursor,
    Knob_Cursor_Hover,
    Knob_Cursor_Active,
    Count,
}

Style_Cursor :: enum i32
{
    Arrow,
    Text,
    Move,
    Resize_Vertical,
    Resize_Horizontal,
    Resize_Top_Left_Down_Right,
    Resize_Top_Right_Down_Left,
    Count,
}

Text_Width_F :: #type proc "c" (handle: Handle, height: f32, text: cstring, len: i32) -> f32

User_Font :: struct
{
    /* user provided font handle */
    userdata: Handle,

    /* max height of the font */
    height: f32,

    /* font string width in pixel callback */
    width: Text_Width_F,
}

/*
// ### Memory Buffer
// A basic (double)-buffer with linear allocation and resetting as only
// freeing policy. The buffer's main purpose is to control all memory management
// inside the GUI toolkit and still leave memory control as much as possible in
// the hand of the user while also making sure the library is easy to use if
// not as much control is needed.
// In general all memory inside this library can be provided from the user in
// three different ways.
// 
// The first way and the one providing most control is by just passing a fixed
// size memory block. In this case all control lies in the hand of the user
// since he can exactly control where the memory comes from and how much memory
// the library should consume. Of course using the fixed size API removes the
// ability to automatically resize a buffer if not enough memory is provided so
// you have to take over the resizing. While being a fixed sized buffer sounds
// quite limiting, it is very effective in this library since the actual memory
// consumption is quite stable and has a fixed upper bound for a lot of cases.
// 
// If you don't want to think about how much memory the library should allocate
// at all time or have a very dynamic UI with unpredictable memory consumption
// habits but still want control over memory allocation you can use the dynamic
// allocator based API. The allocator consists of two callbacks for allocating
// and freeing memory and optional userdata so you can plugin your own allocator.
// 
// The final and easiest way can be used by defining
// NK_INCLUDE_DEFAULT_ALLOCATOR which uses the standard library memory
// allocation functions malloc and free and takes over complete control over
// memory in this library.
*/
Memory_Status :: struct
{
    memory: rawptr,
    type: u32,
    size,
    allocated,
    needed,
    calls: i64,
}

Allocation_Type :: enum i32
{
    Buffer_Fixed,
    Buffer_Dynamic,
}

Buffer_Allocation_Type :: enum i32
{
    Front,
    Back,
}

Buffer_Marker :: struct
{
    active: bool,
    offset: i64,
}

Memory :: struct
{
    ptr: rawptr,
    size: i64,
}

Buffer :: struct
{
    /* buffer marker to free a buffer to a certain offset */
    marker: [len(Buffer_Allocation_Type)]Buffer_Marker,

    /* allocator callback for dynamic buffers */
    pool: Allocator,

    /* memory management type */
    type: Allocation_Type,

    /* memory and size of the current memory block */
    memory: Memory,

    /* growing factor for dynamic memory management */
    grow_factor: f32,

    /* total amount of memory allocated */
    allocated: i64,

    /* totally consumed memory given that enough memory is present */
    needed: i64,

    /* number of allocation calls */
    calls: i64,

    /* current size of the buffer */
    size: i64,
}

/*  Basic string buffer which is only used in context with the text editor
 *  to manage and manipulate dynamic or fixed size string content. This is _NOT_
 *  the default string handling method. The only instance you should have any contact
 *  with this API is if you interact with an `nk_text_edit` object inside one of the
 *  copy and paste functions and even there only for more advanced cases. */
Str :: struct
{
    buffer: Buffer,

    /* in codepoints/runes/glyphs */
    len: i32,
}

TEXTEDIT_UNDOSTATECOUNT :: #config(NK_TEXTEDIT_UNDOSTATECOUNT, 99)
TEXTEDIT_UNDOCHARCOUNT :: #config(NK_TEXTEDIT_UNDOCHARCOUNT, 999)

Clipboard :: struct
{
    userdata: Handle,
    paste: Plugin_Paste,
    copy: Plugin_Copy,
}

Text_Undo_Record :: struct
{
   where_: i32,
   insert_length,
   delete_length,
   char_storage: i16,
}

Text_Undo_State :: struct
{
   undo_rec: [TEXTEDIT_UNDOSTATECOUNT]Text_Undo_Record,
   undo_char: [TEXTEDIT_UNDOCHARCOUNT]rune,
   undo_point,
   redo_point,
   undo_char_point,
   redo_char_point: i16,
}

Text_Edit_Type :: enum i32
{
    Single_Line,
    Multi_Line,
}

Text_Edit_Mode :: enum i32
{
    View,
    Insert,
    Replace,
}

Text_Edit :: struct
{
    clip: Clipboard,
    string: Str,
    filter: Plugin_Filter,
    scrollbar: Vec2,

    cursor,
    select_start,
    select_end: i32,
    mode,
    cursor_at_end_of_line,
    initialized,
    has_preferred_x,
    single_line,
    active,
    padding1: u8,
    preferred_x: f32,
    undo: Text_Undo_State,
}

Command_Type :: enum i32
{
    Nop,
    Scissor,
    Line,
    Curve,
    Rect,
    Rect_Filled,
    Rect_Multi_Color,
    Circle,
    Circle_Filled,
    Arc,
    Arc_Filled,
    Triangle,
    Triangle_Filled,
    Polygon,
    Polygon_Filled,
    Polyline,
    Text,
    Image,
    Custom,
}

/* command base and header of every command inside the buffer */
Command :: struct
{
    type: Command_Type,
    next: i64,
}

Command_Scissor :: struct
{
    header: Command,
    x, y: i16,
    w, h: u16,
}

Command_Line :: struct
{
    header: Command,
    line_thickness: u16,
    begin,
    end: Vec2I,
    color: Color,
}

Command_Curve :: struct
{
    header: Command,
    line_thickness: u16,
    begin: Vec2I,
    end: Vec2I,
    ctrl: [2]Vec2I,
    color: Color,
}

Command_Rect :: struct
{
    header: Command,
    rounding,
    line_thickness: u16,
    x, y: i16,
    w, h: u16,
    color: Color,
}

Command_Rect_Filled :: struct
{
    header: Command,
    rounding: u16,
    x, y: i16,
    w, h: u16,
    color: Color,
}

Command_Rect_Multi_Color :: struct
{
    header: Command,
    x, y: i16,
    w, h: u16,
    left,
    top,
    bottom,
    right: Color,
}

Command_Triangle :: struct
{
    header: Command,
    line_thickness: u16,
    a, b, c: Vec2I,
    color: Color,
}

Command_Triangle_Filled :: struct
{
    header: Command,
    a, b, c: Vec2I,
    color: Color,
}

Command_Circle :: struct
{
    header: Command,
    x, y: i16,
    line_thickness: u16,
    w, h: u16,
    color: Color,   
}

Command_Circle_Filled :: struct
{
    header: Command,
    x, y: i16,
    w, h: u16,
    color: Color,
}

Command_Arc :: struct
{
    header: Command,
    cx, cy: i16,
    r,
    line_thickness: u16,
    a: [2]f32,
    color: Color,
}

Command_Arc_Filled :: struct
{
    header: Command,
    cx, cy: i16,
    r: u16,
    a: [2]f32,
    color: Color,
}

Command_Polygon :: struct
{
    header: Command,
    color: Color,
    line_thickness,
    point_count: u16,
    points: [1]Vec2I,
}

Command_Polygon_Filled :: struct
{
    header: Command,
    color: Color,
    point_count: u16,
    points: [1]Vec2I,
}

Command_Polyline :: struct
{
    header: Command,
    color: Color,
    line_thickness,
    point_count: u16,
    points: [1]Vec2I,
}

Command_Image :: struct
{
    header: Command,
    x, y: i16,
    w, h: u16,
    img: Image,
    col: Color,
}

Command_Custom_Callback :: #type proc "c" (canvas: rawptr, x, y: i16, w, h: u16, callback_data: Handle)

Command_Custom :: struct
{
    header: Command,
    x, y: i16,
    w, h: u16,
    callback_data: Handle,
    callback: Command_Custom_Callback,
}

Command_Text :: struct
{
    header: Command,
    font: ^User_Font,
    background,
    foreground: Color,
    x, y: i16,
    w, h: u16,
    height: f32,
    length: i32,
    string_: [1]u8,
}

Command_Clipping :: enum i32
{
    Off = 0,
    On = 1,
}

Command_Buffer :: struct
{
    base: ^Buffer,
    clip: Rect,
    use_clipping: i32,
    userdata: Handle,
    begin, end, last: i64,
}

Mouse_Button :: struct
{
    down: bool,
    clicked: u32,
    clicked_pos: Vec2,
}

Mouse :: struct
{
    buttons: [len(Buttons)]Mouse_Button,
    pos,
    prev,
    delta,
    scroll_delta: Vec2,
    grab,
    grabbed,
    ungrab: u8,
}

Key :: struct
{
    down: bool,
    clicked: u32,
}

Keyboard :: struct
{
    keys: [len(Keys)]Key,
    text: [INPUT_MAX]u8,
    text_len: i32,
}

Input :: struct
{
    keyboard: Keyboard,
    mouse: Mouse,
}

Style_Item_Type :: enum i32
{
    Color,
    Image,
    Nine_Slice,
}

Style_Item_Data :: struct #raw_union
{
    color: Color,
    image: Image,
    slice: Nine_Slice,
}

Style_Item :: struct
{
    type: Style_Item_Type,
    data: Style_Item_Data,
}

Style_Text :: struct
{
    color: Color,
    padding: Vec2,
    color_factor,
    disabled_factor: f32,
}

Style_Button :: struct
{
    /* background */
    normal,
    hover,
    active: Style_Item,
    border_color: Color,
    color_factor_background: f32,

    /* text */
    text_background,
    text_normal,
    text_hover,
    text_active: Color,
    text_alignment: Text_Alignment,
    color_factor_text: f32,

    /* properties */
    border,
    rounding: f32,
    padding,
    image_padding,
    touch_padding: Vec2,
    disabled_factor: f32,

    /* optional user callbacks */
    userdata: Handle,

    draw_begin: proc(^Command_Buffer, Handle),
    draw_end: proc(^Command_Buffer, Handle),
}

Style_Toggle :: struct
{
    /* background */
    normal,
    hover,
    active: Style_Item,
    border_color: Color,

    /* cursor */
    cursor_normal,
    cursor_hover: Style_Item,

    /* text */
    text_normal,
    text_hover,
    text_active,
    text_background: Color,
    text_alignment: Text_Alignment,

    /* properties */
    padding,
    touch_padding: Vec2,
    spacing,
    border,
    color_factor,
    disabled_factor: f32,

    /* optional user callbacks */
    userdata: Handle,
    draw_begin: proc(^Command_Buffer, Handle),
    draw_end: proc(^Command_Buffer, Handle),
}

Style_Selectable :: struct
{
    /* background (inactive) */
    normal,
    hover,
    pressed,

    /* background (active) */
    normal_active,
    hover_active,
    pressed_active: Style_Item,

    /* text color (inactive) */
    text_normal,
    text_hover,
    text_pressed,

    /* text color (active) */
    text_normal_active,
    text_hover_active,
    text_pressed_active,
    text_background: Color,
    text_alignment: Text_Alignment,

    /* properties */
    rounding: f32,
    padding,
    touch_padding,
    image_padding: Vec2,
    color_factor,
    disabled_factor: f32,

    /* optional user callbacks */
    userdata: Handle,
    draw_begin: proc(^Command_Buffer, Handle),
    draw_end: proc(^Command_Buffer, Handle),
}

Style_Slider :: struct
{
    /* background */
    normal,
    hover,
    active: Style_Item,
    border_color: Color,

    /* background bar */
    bar_normal,
    bar_hover,
    bar_active,
    bar_filled: Color,

    /* cursor */
    cursor_normal,
    cursor_hover,
    cursor_active: Style_Item,

    /* properties */
    border,
    rounding,
    bar_height: f32,
    padding,
    spacing,
    cursor_size: Vec2,
    color_factor,
    disabled_factor: f32,

    /* optional buttons */
    show_buttons: i32,
    inc_button,
    dec_button: Style_Button,
    inc_symbol,
    dec_symbol: Symbol_Type,

    /* optional user callbacks */
    userdata: Handle,
    draw_begin: proc(^Command_Buffer, Handle),
    draw_end: proc(^Command_Buffer, Handle),
}

Style_Knob :: struct
{
    /* background */
    normal: Style_Item,
    hover: Style_Item,
    active: Style_Item,
    border_color: Color,

    /* knob */
    knob_normal: Color,
    knob_hover: Color,
    knob_active: Color,
    knob_border_color: Color,

    /* cursor */
    cursor_normal: Color,
    cursor_hover: Color,
    cursor_active: Color,

    /* properties */
    border: f32,
    knob_border: f32,
    padding: Vec2,
    spacing: Vec2,
    cursor_width: f32,
    color_factor: f32,
    disabled_factor: f32,

    /* optional user callbacks */
    userdata: Handle,
    draw_begin: proc "c" (^Command_Buffer, Handle),
    draw_end: proc "c" (^Command_Buffer, Handle),
};

Style_Progress :: struct
{
    /* background */
    normal,
    hover,
    active: Style_Item,
    border_color: Color,

    /* cursor */
    cursor_normal,
    cursor_hover,
    cursor_active: Style_Item,
    cursor_border_color: Color,

    /* properties */
    rounding,
    border,
    cursor_border,
    cursor_rounding: f32,
    padding: Vec2,
    color_factor,
    disabled_factor: f32,

    /* optional user callbacks */
    userdata: Handle,
    draw_begin: proc(^Command_Buffer, Handle),
    draw_end: proc(^Command_Buffer, Handle),
}

Style_Scrollbar :: struct
{
    /* background */
    normal,
    hover,
    active: Style_Item,
    border_color: Color,

    /* cursor */
    cursor_normal,
    cursor_hover,
    cursor_active: Style_Item,
    cursor_border_color: Color,

    /* properties */
    border,
    rounding,
    border_cursor,
    rounding_cursor: f32,
    padding: Vec2,
    color_factor,
    disabled_factor: f32,

    /* optional buttons */
    show_buttons: i32,
    inc_button,
    dec_button: Style_Button,
    inc_symbol,
    dec_symbol: Symbol_Type,

    /* optional user callbacks */
    userdata: Handle,
    draw_begin: proc(^Command_Buffer, Handle),
    draw_end: proc(^Command_Buffer, Handle),
}

Style_Edit :: struct
{
    /* background */
    normal,
    hover,
    active: Style_Item,
    border_color: Color,
    scrollbar: Style_Scrollbar,

    /* cursor  */
    cursor_normal,
    cursor_hover,
    cursor_text_normal,
    cursor_text_hover: Color,

    /* text (unselected) */
    text_normal,
    text_hover,
    text_active: Color,

    /* text (selected) */
    selected_normal,
    selected_hover,
    selected_text_normal,
    selected_text_hover: Color,

    /* properties */
    border,
    rounding,
    cursor_size: f32,
    scrollbar_size,
    padding: Vec2,
    row_padding,
    color_factor,
    disabled_factor: f32,
}

Style_Property :: struct
{
    /* background */
    normal,
    hover,
    active: Style_Item,
    border_color: Color,

    /* text */
    label_normal,
    label_hover,
    label_active: Color,

    /* symbols */
    sym_left,
    sym_right: Symbol_Type,

    /* properties */
    border,
    rounding: f32,
    padding: Vec2,
    color_factor,
    disabled_factor: f32,

    edit: Style_Edit,
    inc_button,
    dec_button: Style_Button,

    /* optional user callbacks */
    userdata: Handle,
    draw_begin: proc(^Command_Buffer, Handle),
    draw_end: proc(^Command_Buffer, Handle),
}

Style_Chart :: struct
{
    /* colors */
    background: Style_Item,
    border_color,
    selected_color,
    color: Color,

    /* properties */
    border,
    rounding: f32,
    padding: Vec2,
    color_factor,
    disabled_factor: f32,
    show_markers: bool,
}

Style_Combo :: struct
{
    /* background */
    normal,
    hover,
    active: Style_Item,
    border_color: Color,

    /* label */
    label_normal,
    label_hover,
    label_active: Color,

    /* symbol */
    symbol_normal,
    symbol_hover,
    symbol_active: Color,

    /* button */
    button: Style_Button,
    sym_normal,
    sym_hover,
    sym_active: Symbol_Type,

    /* properties */
    border,
    rounding: f32,
    content_padding,
    button_padding,
    spacing: Vec2,
    color_factor,
    disabled_factor: f32,
}

Style_Tab :: struct
{
    /* background */
    background: Style_Item,
    border_color,
    text: Color,

    /* button */
    tab_maximize_button,
    tab_minimize_button,
    node_maximize_button,
    node_minimize_button: Style_Button,
    sym_minimize,
    sym_maximize: Symbol_Type,

    /* properties */
    border,
    rounding,
    indent: f32,
    padding,
    spacing: Vec2,
    color_factor,
    disabled_factor: f32,
}

Style_Header_Align :: enum i32
{
    Left,
    Right,
}

Style_Window_Header :: struct
{
    /* background */
    normal,
    hover,
    active: Style_Item,

    /* button */
    close_button,
    minimize_button: Style_Button,
    close_symbol,
    minimize_symbol,
    maximize_symbol: Symbol_Type,

    /* title */
    label_normal,
    label_hover,
    label_active: Color,

    /* properties */
    align: Style_Header_Align,
    padding,
    label_padding,
    spacing: Vec2,
}

Style_Window :: struct
{
    header: Style_Window_Header,
    fixed_background: Style_Item,
    background: Color,

    border_color,
    popup_border_color,
    combo_border_color,
    contextual_border_color,
    menu_border_color,
    group_border_color,
    tooltip_border_color: Color,
    scaler: Style_Item,

    border,
    combo_border,
    contextual_border,
    menu_border,
    group_border,
    tooltip_border,
    popup_border,
    min_row_height_padding: f32,

    rounding: f32,
    spacing,
    scrollbar_size,
    min_size: Vec2,

    padding,
    group_padding,
    popup_padding,
    combo_padding,
    contextual_padding,
    menu_padding,
    tooltip_padding: Vec2,
}

Style :: struct
{
    font: ^User_Font,
    cursors: [Style_Cursor.Count]^Cursor,
    cursor_active,
    cursor_last: ^Cursor,
    cursor_visible: i32,

    text                : Style_Text,
    button              : Style_Button,
    contextual_button   : Style_Button,
    menu_button         : Style_Button,
    option              : Style_Toggle,
    checkbox            : Style_Toggle,
    selectable          : Style_Selectable,
    slider              : Style_Slider,
    nkob                : Style_Knob,
    progress            : Style_Progress,
    property            : Style_Property,
    edit                : Style_Edit,
    chart               : Style_Chart,
    scrollh             : Style_Scrollbar,
    scrollv             : Style_Scrollbar,
    tab                 : Style_Tab,
    combo               : Style_Combo,
    window              : Style_Window,
}

MAX_LAYOUT_ROW_TEMPLATE_COLUMNS :: #config(NK_MAX_LAYOUT_ROW_TEMPLATE_COLUMNS, 16)
CHART_MAX_SLOT :: #config(NK_CHART_MAX_SLOT, 4)

Panel_Types :: enum i32
{
    Window,
    Group,
    Popup,
    Contextual,
    Combo,
    Menu,
    Tooltip,
}

Panel_Type :: bit_set[Panel_Types; i32]

Panel_Set :: enum i32
{
    Nonblock = cast(i32)Panel_Type{.Contextual, .Combo, .Menu, .Tooltip},
    Popup = cast(i32)Panel_Type{.Contextual, .Combo, .Menu, .Tooltip, .Popup},
    Sub = cast(i32)Panel_Type{.Contextual, .Combo, .Menu, .Tooltip, .Popup, .Group},
}

Chart_Slot :: struct
{
    type: Chart_Type,
    color,
    highlight: Color,
    min, max, range: f32,
    count: i32,
    last: Vec2,
    index: i32,
    show_markers: bool,
}

Chart :: struct
{
    slot: i32,
    x, y, w, h: f32,
    slots: [CHART_MAX_SLOT]Chart_Slot,
}

Panel_Row_Layout_Type :: enum i32
{
    Dynamic_Fixed = 0,
    Dynamic_Row,
    Dynamic_Free,
    Dynamic,
    Static_Fixed,
    Static_Row,
    Static_Free,
    Static,
    Template,
    Count,
}

Row_Layout :: struct
{
    type: Panel_Row_Layout_Type,
    index: i32,
    height,
    min_height: f32,
    columns: i32,
    ratio: ^f32,
    item_width,
    item_height,
    item_offset,
    filled: f32,
    item: Rect,
    tree_depth: i32,
    templates: [MAX_LAYOUT_ROW_TEMPLATE_COLUMNS]f32,
}

Popup_Buffer :: struct
{
    begin,
    parent,
    last,
    end: i64,
    active: bool,
}

Menu_State :: struct
{
    x, y, w, h: f32,
    offset: Scroll,
}

Panel :: struct
{
    type: Panel_Type,
    flags: Panel_Flags,
    bounds: Rect,
    offset_x,
    offset_y: ^u32,
    at_x, at_y, max_x,
    footer_height,
    header_height,
    border: f32,
    has_scrolling: u32,
    clip: Rect,
    menu: Menu_State,
    row: Row_Layout,
    chart: Chart,
    buffer: ^Command_Buffer,
    parent: ^Panel,
}

WINDOW_MAX_NAME :: #config(NK_WINDOW_MAX_NAME, 64)

Window_Flag :: enum i32
{
    Private       = 11,

    /* special window type growing up in height while being filled to a certain maximum height */
    Dynamic       = 11,

    /* sets window widgets into a read only mode and does not allow input changes */
    Rom           = 12,

    /* prevents all interaction caused by input to either window or widgets inside */
    Not_Interactive = i32(12|Panel_Flag.No_Input),

    /* Hides window and stops any window interaction and drawing */
    Hidden        = 13,

    /* Directly closes and frees the window at the end of the frame */
    Closed        = 14,

    /* marks the window as minimized */
    Minimized     = 15,

    /* Removes read only mode at the end of the window */
    Remove_Rom    = 16,
}

Window_Flags :: bit_set[Window_Flag; i32]

Popup_State :: struct
{
    win: ^Window,
    type: Panel_Type,
    buf: Popup_Buffer,
    name: Hash,
    active: bool,
    combo_count,
    con_count, con_old,
    active_con: u32,
    header: Rect,
}

Edit_State :: struct
{
    name: Hash,
    seq,
    old: u32,
    active, prev,
    cursor,
    sel_start,
    sel_end: i32,
    scrollbar: Scroll,
    mode,
    single_line: u8,
}

Property_State :: struct
{
    active, prev: i32,
    buffer: [MAX_NUMBER_BUFFER]u8,
    length,
    cursor,
    select_start,
    select_end: i32,
    name: Hash,
    seq,
    old: u32,
    state: i32,
}

Window :: struct
{
    seq: u32,
    name: Hash,
    name_string: [WINDOW_MAX_NAME]u8,
    flags: Window_Flags,

    bounds: Rect,
    scrollbar: Scroll,
    buffer: Command_Buffer,
    layout: ^Panel,
    scrollbar_hiding_timer: f32,

    /* persistent widget state */
    property: Property_State,
    popup: Popup_State,
    edit: Edit_State,
    scrolled: u32,
    widgets_disabled: bool,

    tables: [^]Table,
    table_count: u32,

    /* window list hooks */
    next,
    prev,
    parent: ^Window,
}

BUTTON_BEHAVIOR_STACK_SIZE  :: #config(NK_BUTTON_BEHAVIOR_STACK_SIZE, 8)
FONT_STACK_SIZE             :: #config(NK_FONT_STACK_SIZE, 8)
STYLE_ITEM_STACK_SIZE       :: #config(NK_STYLE_ITEM_STACK_SIZE, 16)
FLOAT_STACK_SIZE            :: #config(NK_FLOAT_STACK_SIZE, 32)
VECTOR_STACK_SIZE           :: #config(NK_VECTOR_STACK_SIZE, 16)
FLAGS_STACK_SIZE            :: #config(NK_FLAGS_STACK_SIZE, 32)
COLOR_STACK_SIZE            :: #config(NK_COLOR_STACK_SIZE, 32)

Config_Stack_Element :: struct(T: typeid)
{
    address: ^T,
    old_value: T,
}

Config_Stack :: struct(T: typeid, S: i32)
{
    head: i32,
    elements: [S]Config_Stack_Element(T),
}

Config_Stack_Style_Item         :: Config_Stack(Style_Item, STYLE_ITEM_STACK_SIZE)
Config_Stack_Float              :: Config_Stack(f32, FLOAT_STACK_SIZE)
Config_Stack_Vec2               :: Config_Stack(Vec2, VECTOR_STACK_SIZE)
Config_Stack_Flags              :: Config_Stack(Flags, FLAGS_STACK_SIZE)
Config_Stack_Color              :: Config_Stack(Color, COLOR_STACK_SIZE)
Config_Stack_User_Font          :: Config_Stack(^User_Font, FONT_STACK_SIZE)
Config_Stack_Button_Behavior    :: Config_Stack(Button_Behavior, BUTTON_BEHAVIOR_STACK_SIZE)

Configuration_Stacks :: struct
{
    style_items: Config_Stack_Style_Item,
    floats: Config_Stack_Float,
    vectors: Config_Stack_Vec2,
    flags: Config_Stack_Flags,
    colors: Config_Stack_Color,
    fonts: Config_Stack_User_Font,
    button_behaviors: Config_Stack_Button_Behavior,
}

VALUE_PAGE_CAPACITY :: max(size_of(Window), size_of(Panel)) / size_of(u32) / 2

Table :: struct
{
    seq,
    size: u32,
    keys: [VALUE_PAGE_CAPACITY]Hash,
    values: [VALUE_PAGE_CAPACITY]u32,
    next, prev: ^Table,
}

Page_Data :: struct #raw_union
{
    tbl: Table,
    pan: Panel,
    win: Window,
}

Page_Element :: struct
{
    data: Page_Data,
    next,
    prev: ^Page_Element,
}

Page :: struct
{
    size: u32,
    next: ^Page,
    win: [1]Page_Element,
}

Pool :: struct
{
    alloc: Allocator,
    type: Allocation_Type,
    page_count: u32,
    pages: [^]Page,
    freelist: ^Page_Element,
    capacity: u32,
    size,
    cap: i64,
}

Context :: struct
{
    /* public: can be accessed freely */
    input: Input,
    style: Style,
    memory: Buffer,
    clip: Clipboard,
    last_widget_state: Flags,
    button_behavior: Button_Behavior,
    stacks: Configuration_Stacks,
    delta_time_seconds: f32,

    /* text editor objects are quite big because of an internal
    * undo/redo stack. Therefore it does not make sense to have one for
    * each window for temporary use cases, so I only provide *one* instance
    * for all windows. This works because the content is cleared anyway */
    text_edit: Text_Edit,
    
    /* draw buffer used for overlay drawing operation like cursor */
    overlay: Command_Buffer,
    
    /* windows */
    build,
    use_pool: i32,
    pool: Pool,
    begin,
    end,
    active,
    current: ^Window,
    freelist: ^Page_Element,
    count,
    seq: u32,
}

when ODIN_OS == .Windows && ODIN_ARCH == .amd64
{
   foreign import nuklear "nuklear_windows_amd64.lib"
}

@(default_calling_convention="c", link_prefix="nk_")
foreign nuklear
{
    /**
    * # nk_init_fixed
    * Initializes a `nk_context` struct from single fixed size memory block
    * Should be used if you want complete control over nuklear's memory management.
    * Especially recommended for system with little memory or systems with virtual memory.
    * For the later case you can just allocate for example 16MB of virtual memory
    * and only the required amount of memory will actually be committed.
    *
    * ```c
    * nk_bool nk_init_fixed(struct nk_context *ctx, void *memory, nk_size size, const struct nk_user_font *font);
    * ```
    *
    * !!! Warning
    *     make sure the passed memory block is aligned correctly for `nk_draw_commands`.
    *
    * Parameter   | Description
    * ------------|--------------------------------------------------------------
    * \param[in] ctx     | Must point to an either stack or heap allocated `nk_context` struct
    * \param[in] memory  | Must point to a previously allocated memory block
    * \param[in] size    | Must contain the total size of memory
    * \param[in] font    | Must point to a previously initialized font handle for more info look at font documentation
    *
    * \returns either `false(0)` on failure or `true(1)` on success.
    */
    init_fixed :: proc(ctx: ^Context, memory: rawptr, size: i64, user_font: ^User_Font) -> bool ---

    /**
    * # nk_init
    * Initializes a `nk_context` struct with memory allocation callbacks for nuklear to allocate
    * memory from. Used internally for `nk_init_default` and provides a kitchen sink allocation
    * interface to nuklear. Can be useful for cases like monitoring memory consumption.
    *
    * ```c
    * nk_bool nk_init(struct nk_context *ctx, const struct nk_allocator *alloc, const struct nk_user_font *font);
    * ```
    *
    * Parameter   | Description
    * ------------|---------------------------------------------------------------
    * \param[in] ctx     | Must point to an either stack or heap allocated `nk_context` struct
    * \param[in] alloc   | Must point to a previously allocated memory allocator
    * \param[in] font    | Must point to a previously initialized font handle for more info look at font documentation
    *
    * \returns either `false(0)` on failure or `true(1)` on success.
    */
    init :: proc(ctx: ^Context, allocator: ^Allocator, user_font: ^User_Font) -> bool ---

    /**
    * \brief Initializes a `nk_context` struct from two different either fixed or growing buffers.
    *
    * \details
    * The first buffer is for allocating draw commands while the second buffer is
    * used for allocating windows, panels and state tables.
    *
    * ```c
    * nk_bool nk_init_custom(struct nk_context *ctx, struct nk_buffer *cmds, struct nk_buffer *pool, const struct nk_user_font *font);
    * ```
    *
    * \param[in] ctx    Must point to an either stack or heap allocated `nk_context` struct
    * \param[in] cmds   Must point to a previously initialized memory buffer either fixed or dynamic to store draw commands into
    * \param[in] pool   Must point to a previously initialized memory buffer either fixed or dynamic to store windows, panels and tables
    * \param[in] font   Must point to a previously initialized font handle for more info look at font documentation
    *
    * \returns either `false(0)` on failure or `true(1)` on success.
    */
    init_custom :: proc(ctx: ^Context, cmds: ^Buffer, pool: ^Buffer, user_font: ^User_Font) -> bool ---

    /**
    * \brief Resets the context state at the end of the frame.
    *
    * \details
    * This includes mostly garbage collector tasks like removing windows or table
    * not called and therefore used anymore.
    *
    * ```c
    * void nk_clear(struct nk_context *ctx);
    * ```
    *
    * \param[in] ctx  Must point to a previously initialized `nk_context` struct
    */
    clear :: proc(ctx: ^Context) ---

    /**
    * \brief Frees all memory allocated by nuklear; Not needed if context was initialized with `nk_init_fixed`.
    *
    * \details
    * ```c
    * void nk_free(struct nk_context *ctx);
    * ```
    *
    * \param[in] ctx  Must point to a previously initialized `nk_context` struct
    */
    free :: proc(ctx: ^Context) ---
    
    /**
    * \brief Begins the input mirroring process by resetting text, scroll
    * mouse, previous mouse position and movement as well as key state transitions.
    *
    * \details
    * ```c
    * void nk_input_begin(struct nk_context*);
    * ```
    *
    * \param[in] ctx Must point to a previously initialized `nk_context` struct
    */
    input_begin :: proc(ctx: ^Context) ---

    /**
    * \brief Mirrors current mouse position to nuklear
    *
    * \details
    * ```c
    * void nk_input_motion(struct nk_context *ctx, int x, int y);
    * ```
    *
    * \param[in] ctx   Must point to a previously initialized `nk_context` struct
    * \param[in] x     Must hold an integer describing the current mouse cursor x-position
    * \param[in] y     Must hold an integer describing the current mouse cursor y-position
    */
    input_motion :: proc(ctx: ^Context, x, y: i32) ---
    
    /**
    * \brief Mirrors the state of a specific key to nuklear
    *
    * \details
    * ```c
    * void nk_input_key(struct nk_context*, enum nk_keys key, nk_bool down);
    * ```
    *
    * \param[in] ctx      Must point to a previously initialized `nk_context` struct
    * \param[in] key      Must be any value specified in enum `nk_keys` that needs to be mirrored
    * \param[in] down     Must be 0 for key is up and 1 for key is down
    */
    input_key :: proc(ctx: ^Context, key: Keys, down: bool) ---

    /**
    * \brief Mirrors the state of a specific mouse button to nuklear
    *
    * \details
    * ```c
    * void nk_input_button(struct nk_context *ctx, enum nk_buttons btn, int x, int y, nk_bool down);
    * ```
    *
    * \param[in] ctx     Must point to a previously initialized `nk_context` struct
    * \param[in] btn     Must be any value specified in enum `nk_buttons` that needs to be mirrored
    * \param[in] x       Must contain an integer describing mouse cursor x-position on click up/down
    * \param[in] y       Must contain an integer describing mouse cursor y-position on click up/down
    * \param[in] down    Must be 0 for key is up and 1 for key is down
    */
    input_button :: proc(ctx: ^Context, button: Buttons, x, y: i32, down: bool) ---

    /**
    * \brief Copies the last mouse scroll value to nuklear.
    *
    * \details
    * Is generally a scroll value. So does not have to come from mouse and could
    * also originate from balls, tracks, linear guide rails, or other programs.
    *
    * ```c
    * void nk_input_scroll(struct nk_context *ctx, struct nk_vec2 val);
    * ```
    *
    * \param[in] ctx     | Must point to a previously initialized `nk_context` struct
    * \param[in] val     | vector with both X- as well as Y-scroll value
    */
    input_scroll :: proc(ctx: ^Context, val: Vec2) ---

    /**
    * \brief Copies a single ASCII character into an internal text buffer
    *
    * \details
    * This is basically a helper function to quickly push ASCII characters into
    * nuklear.
    *
    * \note
    *     Stores up to NK_INPUT_MAX bytes between `nk_input_begin` and `nk_input_end`.
    *
    * ```c
    * void nk_input_char(struct nk_context *ctx, char c);
    * ```
    *
    * \param[in] ctx     | Must point to a previously initialized `nk_context` struct
    * \param[in] c       | Must be a single ASCII character preferable one that can be printed
    */
    input_char :: proc(ctx: ^Context, char_: u8) ---

    /**
    * \brief Converts an encoded unicode rune into UTF-8 and copies the result into an
    * internal text buffer.
    *
    * \note
    *     Stores up to NK_INPUT_MAX bytes between `nk_input_begin` and `nk_input_end`.
    *
    * ```c
    * void nk_input_glyph(struct nk_context *ctx, const nk_glyph g);
    * ```
    *
    * \param[in] ctx     | Must point to a previously initialized `nk_context` struct
    * \param[in] g       | UTF-32 unicode codepoint
    */
    input_glyph :: proc(ctx: ^Context, codepoint: rune) ---

    /**
    * \brief Converts a unicode rune into UTF-8 and copies the result
    * into an internal text buffer.
    *
    * \details
    * \note
    *     Stores up to NK_INPUT_MAX bytes between `nk_input_begin` and `nk_input_end`.
    *
    * ```c
    * void nk_input_unicode(struct nk_context*, nk_rune rune);
    * ```
    *
    * \param[in] ctx     | Must point to a previously initialized `nk_context` struct
    * \param[in] rune    | UTF-32 unicode codepoint
    */
    input_unicode :: proc(ctx: ^Context, codepoint: rune) ---

/**
 * \brief End the input mirroring process by resetting mouse grabbing
 * state to ensure the mouse cursor is not grabbed indefinitely.
 *
 * \details
 * ```c
 * void nk_input_end(struct nk_context *ctx);
 * ```
 *
 * \param[in] ctx     | Must point to a previously initialized `nk_context` struct
 */
    input_end :: proc(ctx: ^Context) ---

/**
 * \brief Returns a draw command list iterator to iterate all draw
 * commands accumulated over one frame.
 *
 * \details
 * ```c
 * const struct nk_command* nk__begin(struct nk_context*);
 * ```
 *
 * \param[in] ctx     | must point to an previously initialized `nk_context` struct at the end of a frame
 *
 * \returns draw command pointer pointing to the first command inside the draw command list
 */
    _begin :: proc(ctx: ^Context) -> ^Command ---

/**
 * \brief Returns draw command pointer pointing to the next command inside the draw command list
 *
 * \details
 * ```c
 * const struct nk_command* nk__next(struct nk_context*, const struct nk_command*);
 * ```
 *
 * \param[in] ctx     | Must point to an previously initialized `nk_context` struct at the end of a frame
 * \param[in] cmd     | Must point to an previously a draw command either returned by `nk__begin` or `nk__next`
 *
 * \returns draw command pointer pointing to the next command inside the draw command list
 */
    _next :: proc(ctx: ^Context, cmd: ^Command) -> ^Command ---

/**
 * # # nk_begin
 * Starts a new window; needs to be called every frame for every
 * window (unless hidden) or otherwise the window gets removed
 *
 * ```c
 * nk_bool nk_begin(struct nk_context *ctx, const char *title, struct nk_rect bounds, nk_flags flags);
 * ```
 *
 * Parameter   | Description
 * ------------|-----------------------------------------------------------
 * \param[in] ctx     | Must point to an previously initialized `nk_context` struct
 * \param[in] title   | Window title and identifier. Needs to be persistent over frames to identify the window
 * \param[in] bounds  | Initial position and window size. However if you do not define `NK_WINDOW_SCALABLE` or `NK_WINDOW_MOVABLE` you can set window position and size every frame
 * \param[in] flags   | Window flags defined in the nk_panel_flags section with a number of different window behaviors
 *
 * \returns `true(1)` if the window can be filled up with widgets from this point
 * until `nk_end` or `false(0)` otherwise for example if minimized

 */
    begin :: proc(ctx: ^Context, title: cstring, bounds: Rect, flags: Panel_Flags) -> bool ---

/**
 * # # nk_begin_titled
 * Extended window start with separated title and identifier to allow multiple
 * windows with same title but not name
 *
 * ```c
 * nk_bool nk_begin_titled(struct nk_context *ctx, const char *name, const char *title, struct nk_rect bounds, nk_flags flags);
 * ```
 *
 * Parameter   | Description
 * ------------|-----------------------------------------------------------
 * \param[in] ctx     | Must point to an previously initialized `nk_context` struct
 * \param[in] name    | Window identifier. Needs to be persistent over frames to identify the window
 * \param[in] title   | Window title displayed inside header if flag `NK_WINDOW_TITLE` or either `NK_WINDOW_CLOSABLE` or `NK_WINDOW_MINIMIZED` was set
 * \param[in] bounds  | Initial position and window size. However if you do not define `NK_WINDOW_SCALABLE` or `NK_WINDOW_MOVABLE` you can set window position and size every frame
 * \param[in] flags   | Window flags defined in the nk_panel_flags section with a number of different window behaviors
 *
 * \returns `true(1)` if the window can be filled up with widgets from this point
 * until `nk_end` or `false(0)` otherwise for example if minimized

 */
    begin_titled :: proc(ctx: ^Context, name: cstring, title: cstring, bounds: Rect, flags: Panel_Flags) -> bool ---

/**
 * # # nk_end
 * Needs to be called at the end of the window building process to process scaling, scrollbars and general cleanup.
 * All widget calls after this functions will result in asserts or no state changes
 *
 * ```c
 * void nk_end(struct nk_context *ctx);
 * ```
 *
 * Parameter   | Description
 * ------------|-----------------------------------------------------------
 * \param[in] ctx     | Must point to an previously initialized `nk_context` struct

 */
    end :: proc(ctx: ^Context) ---

/**
 * # # nk_window_find
 * Finds and returns a window from passed name
 *
 * ```c
 * struct nk_window *nk_window_find(struct nk_context *ctx, const char *name);
 * ```
 *
 * Parameter   | Description
 * ------------|-----------------------------------------------------------
 * \param[in] ctx     | Must point to an previously initialized `nk_context` struct
 * \param[in] name    | Window identifier
 *
 * \returns a `nk_window` struct pointing to the identified window or NULL if
 * no window with the given name was found
 */
    window_find :: proc(ctx: ^Context, name: cstring) -> ^Window ---

/**
 * # # nk_window_get_bounds
 * \returns a rectangle with screen position and size of the currently processed window
 *
 * !!! \warning
 *     Only call this function between calls `nk_begin_xxx` and `nk_end`
 * ```c
 * struct nk_rect nk_window_get_bounds(const struct nk_context *ctx);
 * ```
 *
 * Parameter   | Description
 * ------------|-----------------------------------------------------------
 * \param[in] ctx     | Must point to an previously initialized `nk_context` struct
 *
 * \returns a `nk_rect` struct with window upper left window position and size

 */
    window_get_bounds :: proc(ctx: ^Context) -> Rect ---

/**
 * # # nk_window_get_position
 * \returns the position of the currently processed window.
 *
 * !!! \warning
 *     Only call this function between calls `nk_begin_xxx` and `nk_end`
 * ```c
 * struct nk_vec2 nk_window_get_position(const struct nk_context *ctx);
 * ```
 *
 * Parameter   | Description
 * ------------|-----------------------------------------------------------
 * \param[in] ctx     | Must point to an previously initialized `nk_context` struct
 *
 * \returns a `nk_vec2` struct with window upper left position

 */
    window_get_position :: proc(ctx: ^Context) -> Vec2 ---

/**
 * # # nk_window_get_size
 * \returns the size with width and height of the currently processed window.
 *
 * !!! \warning
 *     Only call this function between calls `nk_begin_xxx` and `nk_end`
 * ```c
 * struct nk_vec2 nk_window_get_size(const struct nk_context *ctx);
 * ```
 *
 * Parameter   | Description
 * ------------|-----------------------------------------------------------
 * \param[in] ctx     | Must point to an previously initialized `nk_context` struct
 *
 * \returns a `nk_vec2` struct with window width and height

 */
    window_get_size :: proc(ctx: ^Context) -> Vec2 ---

/**
 * nk_window_get_width
 * \returns the width of the currently processed window.
 *
 * !!! \warning
 *     Only call this function between calls `nk_begin_xxx` and `nk_end`
 * ```c
 * float nk_window_get_width(const struct nk_context *ctx);
 * ```
 *
 * Parameter   | Description
 * ------------|-----------------------------------------------------------
 * \param[in] ctx     | Must point to an previously initialized `nk_context` struct
 *
 * \returns the current window width
 */
    window_get_width :: proc(ctx: ^Context) -> f32 ---

/**
 * # # nk_window_get_height
 * \returns the height of the currently processed window.
 *
 * !!! \warning
 *     Only call this function between calls `nk_begin_xxx` and `nk_end`
 * ```c
 * float nk_window_get_height(const struct nk_context *ctx);
 * ```
 *
 * Parameter   | Description
 * ------------|-----------------------------------------------------------
 * \param[in] ctx     | Must point to an previously initialized `nk_context` struct
 *
 * \returns the current window height

 */
    window_get_height :: proc(ctx: ^Context) -> f32 ---

/**
 * # # nk_window_get_panel
 * \returns the underlying panel which contains all processing state of the current window.
 *
 * !!! \warning
 *     Only call this function between calls `nk_begin_xxx` and `nk_end`
 * !!! \warning
 *     Do not keep the returned panel pointer around, it is only valid until `nk_end`
 * ```c
 * struct nk_panel* nk_window_get_panel(struct nk_context *ctx);
 * ```
 *
 * Parameter   | Description
 * ------------|-----------------------------------------------------------
 * \param[in] ctx     | Must point to an previously initialized `nk_context` struct
 *
 * \returns a pointer to window internal `nk_panel` state.

 */
    window_get_panel :: proc(ctx: ^Context) -> ^Panel ---

/**
 * # # nk_window_get_content_region
 * \returns the position and size of the currently visible and non-clipped space
 * inside the currently processed window.
 *
 * !!! \warning
 *     Only call this function between calls `nk_begin_xxx` and `nk_end`
 *
 * ```c
 * struct nk_rect nk_window_get_content_region(struct nk_context *ctx);
 * ```
 *
 * Parameter   | Description
 * ------------|-----------------------------------------------------------
 * \param[in] ctx     | Must point to an previously initialized `nk_context` struct
 *
 * \returns `nk_rect` struct with screen position and size (no scrollbar offset)
 * of the visible space inside the current window

 */
    window_get_content_region :: proc(ctx: ^Context) -> Rect ---

/**
 * # # nk_window_get_content_region_min
 * \returns the upper left position of the currently visible and non-clipped
 * space inside the currently processed window.
 *
 * !!! \warning
 *     Only call this function between calls `nk_begin_xxx` and `nk_end`
 *
 * ```c
 * struct nk_vec2 nk_window_get_content_region_min(struct nk_context *ctx);
 * ```
 *
 * Parameter   | Description
 * ------------|-----------------------------------------------------------
 * \param[in] ctx     | Must point to an previously initialized `nk_context` struct
 *
 * returns `nk_vec2` struct with  upper left screen position (no scrollbar offset)
 * of the visible space inside the current window

 */
    window_get_content_region_min :: proc(ctx: ^Context) -> Vec2 ---

/**
 * # # nk_window_get_content_region_max
 * \returns the lower right screen position of the currently visible and
 * non-clipped space inside the currently processed window.
 *
 * !!! \warning
 *     Only call this function between calls `nk_begin_xxx` and `nk_end`
 *
 * ```c
 * struct nk_vec2 nk_window_get_content_region_max(struct nk_context *ctx);
 * ```
 *
 * Parameter   | Description
 * ------------|-----------------------------------------------------------
 * \param[in] ctx     | Must point to an previously initialized `nk_context` struct
 *
 * \returns `nk_vec2` struct with lower right screen position (no scrollbar offset)
 * of the visible space inside the current window

 */
    window_get_content_region_max :: proc(ctx: ^Context) -> Vec2 ---

/**
 * # # nk_window_get_content_region_size
 * \returns the size of the currently visible and non-clipped space inside the
 * currently processed window
 *
 * !!! \warning
 *     Only call this function between calls `nk_begin_xxx` and `nk_end`
 *
 * ```c
 * struct nk_vec2 nk_window_get_content_region_size(struct nk_context *ctx);
 * ```
 *
 * Parameter   | Description
 * ------------|-----------------------------------------------------------
 * \param[in] ctx     | Must point to an previously initialized `nk_context` struct
 *
 * \returns `nk_vec2` struct with size the visible space inside the current window

 */
    window_get_content_region_size :: proc(ctx: ^Context) -> Vec2 ---

/**
 * # # nk_window_get_canvas
 * \returns the draw command buffer. Can be used to draw custom widgets
 * !!! \warning
 *     Only call this function between calls `nk_begin_xxx` and `nk_end`
 * !!! \warning
 *     Do not keep the returned command buffer pointer around it is only valid until `nk_end`
 *
 * ```c
 * struct nk_command_buffer* nk_window_get_canvas(struct nk_context *ctx);
 * ```
 *
 * Parameter   | Description
 * ------------|-----------------------------------------------------------
 * \param[in] ctx     | Must point to an previously initialized `nk_context` struct
 *
 * \returns a pointer to window internal `nk_command_buffer` struct used as
 * drawing canvas. Can be used to do custom drawing.
 */
    window_get_canvas :: proc(ctx: ^Context) -> ^Command_Buffer ---

/**
 * # # nk_window_get_scroll
 * Gets the scroll offset for the current window
 * !!! \warning
 *     Only call this function between calls `nk_begin_xxx` and `nk_end`
 *
 * ```c
 * void nk_window_get_scroll(struct nk_context *ctx, nk_uint *offset_x, nk_uint *offset_y);
 * ```
 *
 * Parameter    | Description
 * -------------|-----------------------------------------------------------
 * \param[in] ctx      | Must point to an previously initialized `nk_context` struct
 * \param[in] offset_x | A pointer to the x offset output (or NULL to ignore)
 * \param[in] offset_y | A pointer to the y offset output (or NULL to ignore)

 */
    window_get_scroll :: proc(ctx: ^Context, offset_x, offset_y: ^u32) ---

/**
 * # # nk_window_has_focus
 * \returns if the currently processed window is currently active
 * !!! \warning
 *     Only call this function between calls `nk_begin_xxx` and `nk_end`
 * ```c
 * nk_bool nk_window_has_focus(const struct nk_context *ctx);
 * ```
 *
 * Parameter   | Description
 * ------------|-----------------------------------------------------------
 * \param[in] ctx     | Must point to an previously initialized `nk_context` struct
 *
 * \returns `false(0)` if current window is not active or `true(1)` if it is

 */
    window_has_focus :: proc(ctx: ^Context) -> bool ---

/**
 * # # nk_window_is_hovered
 * Return if the current window is being hovered
 * !!! \warning
 *     Only call this function between calls `nk_begin_xxx` and `nk_end`
 * ```c
 * nk_bool nk_window_is_hovered(struct nk_context *ctx);
 * ```
 *
 * Parameter   | Description
 * ------------|-----------------------------------------------------------
 * \param[in] ctx     | Must point to an previously initialized `nk_context` struct
 *
 * \returns `true(1)` if current window is hovered or `false(0)` otherwise

 */
    window_is_hovered :: proc(ctx: ^Context) -> bool ---

/**
 * # # nk_window_is_collapsed
 * \returns if the window with given name is currently minimized/collapsed
 * ```c
 * nk_bool nk_window_is_collapsed(struct nk_context *ctx, const char *name);
 * ```
 *
 * Parameter   | Description
 * ------------|-----------------------------------------------------------
 * \param[in] ctx     | Must point to an previously initialized `nk_context` struct
 * \param[in] name    | Identifier of window you want to check if it is collapsed
 *
 * \returns `true(1)` if current window is minimized and `false(0)` if window not
 * found or is not minimized

 */
    window_is_collapsed :: proc(ctx: ^Context, name: cstring) -> bool ---

/**
 * # # nk_window_is_closed
 * \returns if the window with given name was closed by calling `nk_close`
 * ```c
 * nk_bool nk_window_is_closed(struct nk_context *ctx, const char *name);
 * ```
 *
 * Parameter   | Description
 * ------------|-----------------------------------------------------------
 * \param[in] ctx     | Must point to an previously initialized `nk_context` struct
 * \param[in] name    | Identifier of window you want to check if it is closed
 *
 * \returns `true(1)` if current window was closed or `false(0)` window not found or not closed

 */
    window_is_closed :: proc(ctx: ^Context, name: cstring) -> bool ---

/**
 * # # nk_window_is_hidden
 * \returns if the window with given name is hidden
 * ```c
 * nk_bool nk_window_is_hidden(struct nk_context *ctx, const char *name);
 * ```
 *
 * Parameter   | Description
 * ------------|-----------------------------------------------------------
 * \param[in] ctx     | Must point to an previously initialized `nk_context` struct
 * \param[in] name    | Identifier of window you want to check if it is hidden
 *
 * \returns `true(1)` if current window is hidden or `false(0)` window not found or visible

 */
    window_is_hidden :: proc(ctx: ^Context, name: cstring) -> bool ---

/**
 * # # nk_window_is_active
 * Same as nk_window_has_focus for some reason
 * ```c
 * nk_bool nk_window_is_active(struct nk_context *ctx, const char *name);
 * ```
 *
 * Parameter   | Description
 * ------------|-----------------------------------------------------------
 * \param[in] ctx     | Must point to an previously initialized `nk_context` struct
 * \param[in] name    | Identifier of window you want to check if it is active
 *
 * \returns `true(1)` if current window is active or `false(0)` window not found or not active
 */
    window_is_active :: proc(ctx: ^Context, name: cstring) -> bool ---

/**
 * # # nk_window_is_any_hovered
 * \returns if the any window is being hovered
 * ```c
 * nk_bool nk_window_is_any_hovered(struct nk_context*);
 * ```
 *
 * Parameter   | Description
 * ------------|-----------------------------------------------------------
 * \param[in] ctx     | Must point to an previously initialized `nk_context` struct
 *
 * \returns `true(1)` if any window is hovered or `false(0)` otherwise
 */
    window_is_any_hovered :: proc(ctx: ^Context) -> bool ---

/**
 * # # nk_item_is_any_active
 * \returns if the any window is being hovered or any widget is currently active.
 * Can be used to decide if input should be processed by UI or your specific input handling.
 * Example could be UI and 3D camera to move inside a 3D space.
 * ```c
 * nk_bool nk_item_is_any_active(struct nk_context*);
 * ```
 *
 * Parameter   | Description
 * ------------|-----------------------------------------------------------
 * \param[in] ctx     | Must point to an previously initialized `nk_context` struct
 *
 * \returns `true(1)` if any window is hovered or any item is active or `false(0)` otherwise

 */
    item_is_any_active :: proc(ctx: ^Context) -> bool ---

/**
 * # # nk_window_set_bounds
 * Updates position and size of window with passed in name
 * ```c
 * void nk_window_set_bounds(struct nk_context*, const char *name, struct nk_rect bounds);
 * ```
 *
 * Parameter   | Description
 * ------------|-----------------------------------------------------------
 * \param[in] ctx     | Must point to an previously initialized `nk_context` struct
 * \param[in] name    | Identifier of the window to modify both position and size
 * \param[in] bounds  | Must point to a `nk_rect` struct with the new position and size

 */
    window_set_bounds :: proc(ctx: ^Context, name: cstring, bounds: Rect) ---

/**
 * # # nk_window_set_position
 * Updates position of window with passed name
 * ```c
 * void nk_window_set_position(struct nk_context*, const char *name, struct nk_vec2 pos);
 * ```
 *
 * Parameter   | Description
 * ------------|-----------------------------------------------------------
 * \param[in] ctx     | Must point to an previously initialized `nk_context` struct
 * \param[in] name    | Identifier of the window to modify both position
 * \param[in] pos     | Must point to a `nk_vec2` struct with the new position

 */
    window_set_position :: proc(ctx: ^Context, name: cstring, pos: Vec2) ---

/**
 * # # nk_window_set_size
 * Updates size of window with passed in name
 * ```c
 * void nk_window_set_size(struct nk_context*, const char *name, struct nk_vec2);
 * ```
 *
 * Parameter   | Description
 * ------------|-----------------------------------------------------------
 * \param[in] ctx     | Must point to an previously initialized `nk_context` struct
 * \param[in] name    | Identifier of the window to modify both window size
 * \param[in] size    | Must point to a `nk_vec2` struct with new window size

 */
    window_set_size :: proc(ctx: ^Context, name: cstring, size: Vec2) ---

/**
 * # # nk_window_set_focus
 * Sets the window with given name as active
 * ```c
 * void nk_window_set_focus(struct nk_context*, const char *name);
 * ```
 *
 * Parameter   | Description
 * ------------|-----------------------------------------------------------
 * \param[in] ctx     | Must point to an previously initialized `nk_context` struct
 * \param[in] name    | Identifier of the window to set focus on

 */
    window_set_focus :: proc(ctx: ^Context, name: cstring) ---

/**
 * # # nk_window_set_scroll
 * Sets the scroll offset for the current window
 * !!! \warning
 *     Only call this function between calls `nk_begin_xxx` and `nk_end`
 *
 * ```c
 * void nk_window_set_scroll(struct nk_context *ctx, nk_uint offset_x, nk_uint offset_y);
 * ```
 *
 * Parameter    | Description
 * -------------|-----------------------------------------------------------
 * \param[in] ctx      | Must point to an previously initialized `nk_context` struct
 * \param[in] offset_x | The x offset to scroll to
 * \param[in] offset_y | The y offset to scroll to

 */
    window_set_scroll :: proc(ctx: ^Context, offset_x, offset_y: u32) ---

/**
 * # # nk_window_close
 * Closes a window and marks it for being freed at the end of the frame
 * ```c
 * void nk_window_close(struct nk_context *ctx, const char *name);
 * ```
 *
 * Parameter   | Description
 * ------------|-----------------------------------------------------------
 * \param[in] ctx     | Must point to an previously initialized `nk_context` struct
 * \param[in] name    | Identifier of the window to close

 */
    window_close :: proc(ctx: ^Context, name: cstring) ---

/**
 * # # nk_window_collapse
 * Updates collapse state of a window with given name
 * ```c
 * void nk_window_collapse(struct nk_context*, const char *name, enum nk_collapse_states state);
 * ```
 *
 * Parameter   | Description
 * ------------|-----------------------------------------------------------
 * \param[in] ctx     | Must point to an previously initialized `nk_context` struct
 * \param[in] name    | Identifier of the window to close
 * \param[in] state   | value out of nk_collapse_states section

 */
    window_collapse :: proc(ctx: ^Context, name: cstring, state: Collapse_States) ---

/**
 * # # nk_window_collapse_if
 * Updates collapse state of a window with given name if given condition is met
 * ```c
 * void nk_window_collapse_if(struct nk_context*, const char *name, enum nk_collapse_states, int cond);
 * ```
 *
 * Parameter   | Description
 * ------------|-----------------------------------------------------------
 * \param[in] ctx     | Must point to an previously initialized `nk_context` struct
 * \param[in] name    | Identifier of the window to either collapse or maximize
 * \param[in] state   | value out of nk_collapse_states section the window should be put into
 * \param[in] cond    | condition that has to be met to actually commit the collapse state change

 */
    window_collapse_if :: proc(ctx: ^Context, name: cstring, state: Collapse_States, cond: i32) ---

/**
 * # # nk_window_show
 * updates visibility state of a window with given name
 * ```c
 * void nk_window_show(struct nk_context*, const char *name, enum nk_show_states);
 * ```
 *
 * Parameter   | Description
 * ------------|-----------------------------------------------------------
 * \param[in] ctx     | Must point to an previously initialized `nk_context` struct
 * \param[in] name    | Identifier of the window to either collapse or maximize
 * \param[in] state   | state with either visible or hidden to modify the window with
 */
    window_show :: proc(ctx: ^Context, name: cstring, state: Show_States) ---

/**
 * # # nk_window_show_if
 * Updates visibility state of a window with given name if a given condition is met
 * ```c
 * void nk_window_show_if(struct nk_context*, const char *name, enum nk_show_states, int cond);
 * ```
 *
 * Parameter   | Description
 * ------------|-----------------------------------------------------------
 * \param[in] ctx     | Must point to an previously initialized `nk_context` struct
 * \param[in] name    | Identifier of the window to either hide or show
 * \param[in] state   | state with either visible or hidden to modify the window with
 * \param[in] cond    | condition that has to be met to actually commit the visibility state change

 */
    window_show_if :: proc(ctx: ^Context, name: cstring, state: Show_States, cond: i32) ---

/**
 * # # nk_window_show_if
 * Line for visual separation. Draws a line with thickness determined by the current row height.
 * ```c
 * void nk_rule_horizontal(struct nk_context *ctx, struct nk_color color, NK_BOOL rounding)
 * ```
 *
 * Parameter       | Description
 * ----------------|-------------------------------------------------------
 * \param[in] ctx         | Must point to an previously initialized `nk_context` struct
 * \param[in] color       | Color of the horizontal line
 * \param[in] rounding    | Whether or not to make the line round
 */
    rule_horizontal :: proc(ctx: ^Context, color: Color, rounding: bool) ---

/* =============================================================================
 *
 *                                  LAYOUT
 *
 * =============================================================================*/
/**
 * \page Layouting
 * Layouting in general describes placing widget inside a window with position and size.
 * While in this particular implementation there are five different APIs for layouting
 * each with different trade offs between control and ease of use. <br /><br />
 *
 * All layouting methods in this library are based around the concept of a row.
 * A row has a height the window content grows by and a number of columns and each
 * layouting method specifies how each widget is placed inside the row.
 * After a row has been allocated by calling a layouting functions and then
 * filled with widgets will advance an internal pointer over the allocated row. <br /><br />
 *
 * To actually define a layout you just call the appropriate layouting function
 * and each subsequent widget call will place the widget as specified. Important
 * here is that if you define more widgets then columns defined inside the layout
 * functions it will allocate the next row without you having to make another layouting <br /><br />
 * call.
 *
 * Biggest limitation with using all these APIs outside the `nk_layout_space_xxx` API
 * is that you have to define the row height for each. However the row height
 * often depends on the height of the font. <br /><br />
 *
 * To fix that internally nuklear uses a minimum row height that is set to the
 * height plus padding of currently active font and overwrites the row height
 * value if zero. <br /><br />
 *
 * If you manually want to change the minimum row height then
 * use nk_layout_set_min_row_height, and use nk_layout_reset_min_row_height to
 * reset it back to be derived from font height. <br /><br />
 *
 * Also if you change the font in nuklear it will automatically change the minimum
 * row height for you and. This means if you change the font but still want
 * a minimum row height smaller than the font you have to repush your value. <br /><br />
 *
 * For actually more advanced UI I would even recommend using the `nk_layout_space_xxx`
 * layouting method in combination with a cassowary constraint solver (there are
 * some versions on github with permissive license model) to take over all control over widget
 * layouting yourself. However for quick and dirty layouting using all the other layouting
 * functions should be fine.
 *
 * # Usage
 * 1.  __nk_layout_row_dynamic__<br /><br />
 *     The easiest layouting function is `nk_layout_row_dynamic`. It provides each
 *     widgets with same horizontal space inside the row and dynamically grows
 *     if the owning window grows in width. So the number of columns dictates
 *     the size of each widget dynamically by formula:
 *
 *     ```c
 *     widget_width = (window_width - padding - spacing) * (1/column_count)
 *     ```
 *
 *     Just like all other layouting APIs if you define more widget than columns this
 *     library will allocate a new row and keep all layouting parameters previously
 *     defined.
 *
 *     ```c
 *     if (nk_begin_xxx(...) {
 *         // first row with height: 30 composed of two widgets
 *         nk_layout_row_dynamic(&ctx, 30, 2);
 *         nk_widget(...);
 *         nk_widget(...);
 *         //
 *         // second row with same parameter as defined above
 *         nk_widget(...);
 *         nk_widget(...);
 *         //
 *         // third row uses 0 for height which will use auto layouting
 *         nk_layout_row_dynamic(&ctx, 0, 2);
 *         nk_widget(...);
 *         nk_widget(...);
 *     }
 *     nk_end(...);
 *     ```
 *
 * 2.  __nk_layout_row_static__<br /><br />
 *     Another easy layouting function is `nk_layout_row_static`. It provides each
 *     widget with same horizontal pixel width inside the row and does not grow
 *     if the owning window scales smaller or bigger.
 *
 *     ```c
 *     if (nk_begin_xxx(...) {
 *         // first row with height: 30 composed of two widgets with width: 80
 *         nk_layout_row_static(&ctx, 30, 80, 2);
 *         nk_widget(...);
 *         nk_widget(...);
 *         //
 *         // second row with same parameter as defined above
 *         nk_widget(...);
 *         nk_widget(...);
 *         //
 *         // third row uses 0 for height which will use auto layouting
 *         nk_layout_row_static(&ctx, 0, 80, 2);
 *         nk_widget(...);
 *         nk_widget(...);
 *     }
 *     nk_end(...);
 *     ```
 *
 * 3.  __nk_layout_row_xxx__<br /><br />
 *     A little bit more advanced layouting API are functions `nk_layout_row_begin`,
 *     `nk_layout_row_push` and `nk_layout_row_end`. They allow to directly
 *     specify each column pixel or window ratio in a row. It supports either
 *     directly setting per column pixel width or widget window ratio but not
 *     both. Furthermore it is a immediate mode API so each value is directly
 *     pushed before calling a widget. Therefore the layout is not automatically
 *     repeating like the last two layouting functions.
 *
 *     ```c
 *     if (nk_begin_xxx(...) {
 *         // first row with height: 25 composed of two widgets with width 60 and 40
 *         nk_layout_row_begin(ctx, NK_STATIC, 25, 2);
 *         nk_layout_row_push(ctx, 60);
 *         nk_widget(...);
 *         nk_layout_row_push(ctx, 40);
 *         nk_widget(...);
 *         nk_layout_row_end(ctx);
 *         //
 *         // second row with height: 25 composed of two widgets with window ratio 0.25 and 0.75
 *         nk_layout_row_begin(ctx, NK_DYNAMIC, 25, 2);
 *         nk_layout_row_push(ctx, 0.25f);
 *         nk_widget(...);
 *         nk_layout_row_push(ctx, 0.75f);
 *         nk_widget(...);
 *         nk_layout_row_end(ctx);
 *         //
 *         // third row with auto generated height: composed of two widgets with window ratio 0.25 and 0.75
 *         nk_layout_row_begin(ctx, NK_DYNAMIC, 0, 2);
 *         nk_layout_row_push(ctx, 0.25f);
 *         nk_widget(...);
 *         nk_layout_row_push(ctx, 0.75f);
 *         nk_widget(...);
 *         nk_layout_row_end(ctx);
 *     }
 *     nk_end(...);
 *     ```
 *
 * 4.  __nk_layout_row__<br /><br />
 *     The array counterpart to API nk_layout_row_xxx is the single nk_layout_row
 *     functions. Instead of pushing either pixel or window ratio for every widget
 *     it allows to define it by array. The trade of for less control is that
 *     `nk_layout_row` is automatically repeating. Otherwise the behavior is the
 *     same.
 *
 *     ```c
 *     if (nk_begin_xxx(...) {
 *         // two rows with height: 30 composed of two widgets with width 60 and 40
 *         const float ratio[] = {60,40};
 *         nk_layout_row(ctx, NK_STATIC, 30, 2, ratio);
 *         nk_widget(...);
 *         nk_widget(...);
 *         nk_widget(...);
 *         nk_widget(...);
 *         //
 *         // two rows with height: 30 composed of two widgets with window ratio 0.25 and 0.75
 *         const float ratio[] = {0.25, 0.75};
 *         nk_layout_row(ctx, NK_DYNAMIC, 30, 2, ratio);
 *         nk_widget(...);
 *         nk_widget(...);
 *         nk_widget(...);
 *         nk_widget(...);
 *         //
 *         // two rows with auto generated height composed of two widgets with window ratio 0.25 and 0.75
 *         const float ratio[] = {0.25, 0.75};
 *         nk_layout_row(ctx, NK_DYNAMIC, 30, 2, ratio);
 *         nk_widget(...);
 *         nk_widget(...);
 *         nk_widget(...);
 *         nk_widget(...);
 *     }
 *     nk_end(...);
 *     ```
 *
 * 5.  __nk_layout_row_template_xxx__<br /><br />
 *     The most complex and second most flexible API is a simplified flexbox version without
 *     line wrapping and weights for dynamic widgets. It is an immediate mode API but
 *     unlike `nk_layout_row_xxx` it has auto repeat behavior and needs to be called
 *     before calling the templated widgets.
 *     The row template layout has three different per widget size specifier. The first
 *     one is the `nk_layout_row_template_push_static`  with fixed widget pixel width.
 *     They do not grow if the row grows and will always stay the same.
 *     The second size specifier is `nk_layout_row_template_push_variable`
 *     which defines a minimum widget size but it also can grow if more space is available
 *     not taken by other widgets.
 *     Finally there are dynamic widgets with `nk_layout_row_template_push_dynamic`
 *     which are completely flexible and unlike variable widgets can even shrink
 *     to zero if not enough space is provided.
 *
 *     ```c
 *     if (nk_begin_xxx(...) {
 *         // two rows with height: 30 composed of three widgets
 *         nk_layout_row_template_begin(ctx, 30);
 *         nk_layout_row_template_push_dynamic(ctx);
 *         nk_layout_row_template_push_variable(ctx, 80);
 *         nk_layout_row_template_push_static(ctx, 80);
 *         nk_layout_row_template_end(ctx);
 *         //
 *         // first row
 *         nk_widget(...); // dynamic widget can go to zero if not enough space
 *         nk_widget(...); // variable widget with min 80 pixel but can grow bigger if enough space
 *         nk_widget(...); // static widget with fixed 80 pixel width
 *         //
 *         // second row same layout
 *         nk_widget(...);
 *         nk_widget(...);
 *         nk_widget(...);
 *     }
 *     nk_end(...);
 *     ```
 *
 * 6.  __nk_layout_space_xxx__<br /><br />
 *     Finally the most flexible API directly allows you to place widgets inside the
 *     window. The space layout API is an immediate mode API which does not support
 *     row auto repeat and directly sets position and size of a widget. Position
 *     and size hereby can be either specified as ratio of allocated space or
 *     allocated space local position and pixel size. Since this API is quite
 *     powerful there are a number of utility functions to get the available space
 *     and convert between local allocated space and screen space.
 *
 *     ```c
 *     if (nk_begin_xxx(...) {
 *         // static row with height: 500 (you can set column count to INT_MAX if you don't want to be bothered)
 *         nk_layout_space_begin(ctx, NK_STATIC, 500, INT_MAX);
 *         nk_layout_space_push(ctx, nk_rect(0,0,150,200));
 *         nk_widget(...);
 *         nk_layout_space_push(ctx, nk_rect(200,200,100,200));
 *         nk_widget(...);
 *         nk_layout_space_end(ctx);
 *         //
 *         // dynamic row with height: 500 (you can set column count to INT_MAX if you don't want to be bothered)
 *         nk_layout_space_begin(ctx, NK_DYNAMIC, 500, INT_MAX);
 *         nk_layout_space_push(ctx, nk_rect(0.5,0.5,0.1,0.1));
 *         nk_widget(...);
 *         nk_layout_space_push(ctx, nk_rect(0.7,0.6,0.1,0.1));
 *         nk_widget(...);
 *     }
 *     nk_end(...);
 *     ```
 *
 * # Reference
 * Function                                     | Description
 * ---------------------------------------------|------------------------------------
 * \ref nk_layout_set_min_row_height            | Set the currently used minimum row height to a specified value
 * \ref nk_layout_reset_min_row_height          | Resets the currently used minimum row height to font height
 * \ref nk_layout_widget_bounds                 | Calculates current width a static layout row can fit inside a window
 * \ref nk_layout_ratio_from_pixel              | Utility functions to calculate window ratio from pixel size
 * \ref nk_layout_row_dynamic                   | Current layout is divided into n same sized growing columns
 * \ref nk_layout_row_static                    | Current layout is divided into n same fixed sized columns
 * \ref nk_layout_row_begin                     | Starts a new row with given height and number of columns
 * \ref nk_layout_row_push                      | Pushes another column with given size or window ratio
 * \ref nk_layout_row_end                       | Finished previously started row
 * \ref nk_layout_row                           | Specifies row columns in array as either window ratio or size
 * \ref nk_layout_row_template_begin            | Begins the row template declaration
 * \ref nk_layout_row_template_push_dynamic     | Adds a dynamic column that dynamically grows and can go to zero if not enough space
 * \ref nk_layout_row_template_push_variable    | Adds a variable column that dynamically grows but does not shrink below specified pixel width
 * \ref nk_layout_row_template_push_static      | Adds a static column that does not grow and will always have the same size
 * \ref nk_layout_row_template_end              | Marks the end of the row template
 * \ref nk_layout_space_begin                   | Begins a new layouting space that allows to specify each widgets position and size
 * \ref nk_layout_space_push                    | Pushes position and size of the next widget in own coordinate space either as pixel or ratio
 * \ref nk_layout_space_end                     | Marks the end of the layouting space
 * \ref nk_layout_space_bounds                  | Callable after nk_layout_space_begin and returns total space allocated
 * \ref nk_layout_space_to_screen               | Converts vector from nk_layout_space coordinate space into screen space
 * \ref nk_layout_space_to_local                | Converts vector from screen space into nk_layout_space coordinates
 * \ref nk_layout_space_rect_to_screen          | Converts rectangle from nk_layout_space coordinate space into screen space
 * \ref nk_layout_space_rect_to_local           | Converts rectangle from screen space into nk_layout_space coordinates
 */

/**
 * Sets the currently used minimum row height.
 * !!! \warning
 *     The passed height needs to include both your preferred row height
 *     as well as padding. No internal padding is added.
 *
 * ```c
 * void nk_layout_set_min_row_height(struct nk_context*, float height);
 * ```
 *
 * \param[in] ctx     | Must point to an previously initialized `nk_context` struct after call `nk_begin_xxx`
 * \param[in] height  | New minimum row height to be used for auto generating the row height
 */
    layout_set_min_row_height :: proc(ctx: ^Context, height: f32) ---

/**
 * Reset the currently used minimum row height back to `font_height + text_padding + padding`
 * ```c
 * void nk_layout_reset_min_row_height(struct nk_context*);
 * ```
 *
 * \param[in] ctx     | Must point to an previously initialized `nk_context` struct after call `nk_begin_xxx`
 */
    layout_reset_min_row_height :: proc(ctx: ^Context) ---

/**
 * \brief Returns the width of the next row allocate by one of the layouting functions
 *
 * \details
 * ```c
 * struct nk_rect nk_layout_widget_bounds(struct nk_context*);
 * ```
 *
 * \param[in] ctx     | Must point to an previously initialized `nk_context` struct after call `nk_begin_xxx`
 *
 * \return `nk_rect` with both position and size of the next row
 */
    layout_widget_bounds :: proc(ctx: ^Context) -> Rect ---

/**
 * \brief Utility functions to calculate window ratio from pixel size
 *
 * \details
 * ```c
 * float nk_layout_ratio_from_pixel(struct nk_context*, float pixel_width);
 * ```
 *
 * \param[in] ctx     | Must point to an previously initialized `nk_context` struct after call `nk_begin_xxx`
 * \param[in] pixel   | Pixel_width to convert to window ratio
 *
 * \returns `nk_rect` with both position and size of the next row
 */
    layout_ratio_from_pixel :: proc(ctx: ^Context, pixel_width: f32) -> f32 ---

/**
 * \brief Sets current row layout to share horizontal space
 * between @cols number of widgets evenly. Once called all subsequent widget
 * calls greater than @cols will allocate a new row with same layout.
 *
 * \details
 * ```c
 * void nk_layout_row_dynamic(struct nk_context *ctx, float height, int cols);
 * ```
 *
 * \param[in] ctx     | Must point to an previously initialized `nk_context` struct after call `nk_begin_xxx`
 * \param[in] height  | Holds height of each widget in row or zero for auto layouting
 * \param[in] columns | Number of widget inside row
 */
    layout_row_dynamic :: proc(ctx: ^Context, height: f32, cols: i32) ---

/**
 * \brief Sets current row layout to fill @cols number of widgets
 * in row with same @item_width horizontal size. Once called all subsequent widget
 * calls greater than @cols will allocate a new row with same layout.
 *
 * \details
 * ```c
 * void nk_layout_row_static(struct nk_context *ctx, float height, int item_width, int cols);
 * ```
 *
 * \param[in] ctx     | Must point to an previously initialized `nk_context` struct after call `nk_begin_xxx`
 * \param[in] height  | Holds height of each widget in row or zero for auto layouting
 * \param[in] width   | Holds pixel width of each widget in the row
 * \param[in] columns | Number of widget inside row
 */
    layout_row_static :: proc(ctx: ^Context, height: f32, item_width, cols: i32) ---

/**
 * \brief Starts a new dynamic or fixed row with given height and columns.
 *
 * \details
 * ```c
 * void nk_layout_row_begin(struct nk_context *ctx, enum nk_layout_format fmt, float row_height, int cols);
 * ```
 *
 * \param[in] ctx     | Must point to an previously initialized `nk_context` struct after call `nk_begin_xxx`
 * \param[in] fmt     | either `NK_DYNAMIC` for window ratio or `NK_STATIC` for fixed size columns
 * \param[in] height  | holds height of each widget in row or zero for auto layouting
 * \param[in] columns | Number of widget inside row
 */
    layout_row_begin :: proc(ctx: ^Context, fmt: Layout_Format, row_height: f32, cols: i32) ---

/**
 * \breif Specifies either window ratio or width of a single column
 *
 * \details
 * ```c
 * void nk_layout_row_push(struct nk_context*, float value);
 * ```
 *
 * \param[in] ctx     | Must point to an previously initialized `nk_context` struct after call `nk_begin_xxx`
 * \param[in] value   | either a window ratio or fixed width depending on @fmt in previous `nk_layout_row_begin` call
 */
    layout_row_push :: proc(ctx: ^Context, value: f32) ---

/**
 * \brief Finished previously started row
 *
 * \details
 * ```c
 * void nk_layout_row_end(struct nk_context*);
 * ```
 *
 * \param[in] ctx     | Must point to an previously initialized `nk_context` struct after call `nk_begin_xxx`
 */
    layout_row_end :: proc(ctx: ^Context) ---

/**
 * \brief Specifies row columns in array as either window ratio or size
 *
 * \details
 * ```c
 * void nk_layout_row(struct nk_context*, enum nk_layout_format, float height, int cols, const float *ratio);
 * ```
 *
 * \param[in] ctx     | Must point to an previously initialized `nk_context` struct after call `nk_begin_xxx`
 * \param[in] fmt     | Either `NK_DYNAMIC` for window ratio or `NK_STATIC` for fixed size columns
 * \param[in] height  | Holds height of each widget in row or zero for auto layouting
 * \param[in] columns | Number of widget inside row
 */
    layout_row :: proc(ctx: ^Context, format: Layout_Format, height: f32, cols: i32, ratio: [^]f32) ---

/**
 * # # nk_layout_row_template_begin
 * Begins the row template declaration
 * ```c
 * void nk_layout_row_template_begin(struct nk_context*, float row_height);
 * ```
 *
 * Parameter   | Description
 * ------------|-----------------------------------------------------------
 * \param[in] ctx     | Must point to an previously initialized `nk_context` struct after call `nk_begin_xxx`
 * \param[in] height  | Holds height of each widget in row or zero for auto layouting
 */
    layout_row_template_begin :: proc(ctx: ^Context, row_height: f32) ---

/**
 * # # nk_layout_row_template_push_dynamic
 * Adds a dynamic column that dynamically grows and can go to zero if not enough space
 * ```c
 * void nk_layout_row_template_push_dynamic(struct nk_context*);
 * ```
 *
 * Parameter   | Description
 * ------------|-----------------------------------------------------------
 * \param[in] ctx     | Must point to an previously initialized `nk_context` struct after call `nk_begin_xxx`
 * \param[in] height  | Holds height of each widget in row or zero for auto layouting
 */
    layout_row_template_push_dynamic :: proc(ctx: ^Context) ---

/**
 * # # nk_layout_row_template_push_variable
 * Adds a variable column that dynamically grows but does not shrink below specified pixel width
 * ```c
 * void nk_layout_row_template_push_variable(struct nk_context*, float min_width);
 * ```
 *
 * Parameter   | Description
 * ------------|-----------------------------------------------------------
 * \param[in] ctx     | Must point to an previously initialized `nk_context` struct after call `nk_begin_xxx`
 * \param[in] width   | Holds the minimum pixel width the next column must always be
 */
    layout_row_template_push_variable :: proc(ctx: ^Context, min_width: f32) ---

/**
 * # # nk_layout_row_template_push_static
 * Adds a static column that does not grow and will always have the same size
 * ```c
 * void nk_layout_row_template_push_static(struct nk_context*, float width);
 * ```
 *
 * Parameter   | Description
 * ------------|-----------------------------------------------------------
 * \param[in] ctx     | Must point to an previously initialized `nk_context` struct after call `nk_begin_xxx`
 * \param[in] width   | Holds the absolute pixel width value the next column must be
 */
    layout_row_template_push_static :: proc(ctx: ^Context, width: f32) ---

/**
 * # # nk_layout_row_template_end
 * Marks the end of the row template
 * ```c
 * void nk_layout_row_template_end(struct nk_context*);
 * ```
 *
 * Parameter   | Description
 * ------------|-----------------------------------------------------------
 * \param[in] ctx     | Must point to an previously initialized `nk_context` struct after call `nk_begin_xxx`
 */
    layout_row_template_end :: proc(ctx: ^Context) ---

/**
 * # # nk_layout_space_begin
 * Begins a new layouting space that allows to specify each widgets position and size.
 * ```c
 * void nk_layout_space_begin(struct nk_context*, enum nk_layout_format, float height, int widget_count);
 * ```
 *
 * Parameter   | Description
 * ------------|-----------------------------------------------------------
 * \param[in] ctx     | Must point to an previously initialized `nk_context` struct after call `nk_begin_xxx`
 * \param[in] fmt     | Either `NK_DYNAMIC` for window ratio or `NK_STATIC` for fixed size columns
 * \param[in] height  | Holds height of each widget in row or zero for auto layouting
 * \param[in] columns | Number of widgets inside row
 */
    layout_space_begin :: proc(ctx: ^Context, format: Layout_Format, height: f32, widget_count: i32) ---

/**
 * # # nk_layout_space_push
 * Pushes position and size of the next widget in own coordinate space either as pixel or ratio
 * ```c
 * void nk_layout_space_push(struct nk_context *ctx, struct nk_rect bounds);
 * ```
 *
 * Parameter   | Description
 * ------------|-----------------------------------------------------------
 * \param[in] ctx     | Must point to an previously initialized `nk_context` struct after call `nk_layout_space_begin`
 * \param[in] bounds  | Position and size in laoyut space local coordinates
 */
    layout_space_push :: proc(ctx: ^Context, bounds: Rect) ---

/**
 * # # nk_layout_space_end
 * Marks the end of the layout space
 * ```c
 * void nk_layout_space_end(struct nk_context*);
 * ```
 *
 * Parameter   | Description
 * ------------|-----------------------------------------------------------
 * \param[in] ctx     | Must point to an previously initialized `nk_context` struct after call `nk_layout_space_begin`
 */
    layout_space_end :: proc(ctx: ^Context) ---
    
/**
 * # # nk_layout_space_bounds
 * Utility function to calculate total space allocated for `nk_layout_space`
 * ```c
 * struct nk_rect nk_layout_space_bounds(struct nk_context*);
 * ```
 *
 * Parameter   | Description
 * ------------|-----------------------------------------------------------
 * \param[in] ctx     | Must point to an previously initialized `nk_context` struct after call `nk_layout_space_begin`
 *
 * \returns `nk_rect` holding the total space allocated
 */
    layout_space_bounds :: proc(ctx: ^Context) -> Rect ---

/**
 * # # nk_layout_space_to_screen
 * Converts vector from nk_layout_space coordinate space into screen space
 * ```c
 * struct nk_vec2 nk_layout_space_to_screen(struct nk_context*, struct nk_vec2);
 * ```
 *
 * Parameter   | Description
 * ------------|-----------------------------------------------------------
 * \param[in] ctx     | Must point to an previously initialized `nk_context` struct after call `nk_layout_space_begin`
 * \param[in] vec     | Position to convert from layout space into screen coordinate space
 *
 * \returns transformed `nk_vec2` in screen space coordinates
 */
    layout_space_to_screen :: proc(ctx: ^Context, vec: Vec2) -> Vec2 ---

/**
 * # # nk_layout_space_to_local
 * Converts vector from layout space into screen space
 * ```c
 * struct nk_vec2 nk_layout_space_to_local(struct nk_context*, struct nk_vec2);
 * ```
 *
 * Parameter   | Description
 * ------------|-----------------------------------------------------------
 * \param[in] ctx     | Must point to an previously initialized `nk_context` struct after call `nk_layout_space_begin`
 * \param[in] vec     | Position to convert from screen space into layout coordinate space
 *
 * \returns transformed `nk_vec2` in layout space coordinates
 */
    layout_space_to_local :: proc(ctx: ^Context, vec: Vec2) -> Vec2 ---

/**
 * # # nk_layout_space_rect_to_screen
 * Converts rectangle from screen space into layout space
 * ```c
 * struct nk_rect nk_layout_space_rect_to_screen(struct nk_context*, struct nk_rect);
 * ```
 *
 * Parameter   | Description
 * ------------|-----------------------------------------------------------
 * \param[in] ctx     | Must point to an previously initialized `nk_context` struct after call `nk_layout_space_begin`
 * \param[in] bounds  | Rectangle to convert from layout space into screen space
 *
 * \returns transformed `nk_rect` in screen space coordinates
 */
    layout_space_rect_to_screen :: proc(ctx: ^Context, bounds: Rect) -> Rect ---

/**
 * # # nk_layout_space_rect_to_local
 * Converts rectangle from layout space into screen space
 * ```c
 * struct nk_rect nk_layout_space_rect_to_local(struct nk_context*, struct nk_rect);
 * ```
 *
 * Parameter   | Description
 * ------------|-----------------------------------------------------------
 * \param[in] ctx     | Must point to an previously initialized `nk_context` struct after call `nk_layout_space_begin`
 * \param[in] bounds  | Rectangle to convert from layout space into screen space
 *
 * \returns transformed `nk_rect` in layout space coordinates
 */
    layout_space_rect_to_local :: proc(ctx: ^Context, bounds: Rect) -> Rect ---

/**
 * # # nk_spacer
 * Spacer is a dummy widget that consumes space as usual but doesn't draw anything
 * ```c
 * void nk_spacer(struct nk_context* );
 * ```
 *
 * Parameter   | Description
 * ------------|-----------------------------------------------------------
 * \param[in] ctx     | Must point to an previously initialized `nk_context` struct after call `nk_layout_space_begin`
 *
 */
    spacer :: proc(ctx: ^Context) ---

/** =============================================================================
 *
 *                                  GROUP
 *
 * =============================================================================*/
/**
 * \page Groups
 * Groups are basically windows inside windows. They allow to subdivide space
 * in a window to layout widgets as a group. Almost all more complex widget
 * layouting requirements can be solved using groups and basic layouting
 * fuctionality. Groups just like windows are identified by an unique name and
 * internally keep track of scrollbar offsets by default. However additional
 * versions are provided to directly manage the scrollbar.
 *
 * # Usage
 * To create a group you have to call one of the three `nk_group_begin_xxx`
 * functions to start group declarations and `nk_group_end` at the end. Furthermore it
 * is required to check the return value of `nk_group_begin_xxx` and only process
 * widgets inside the window if the value is not 0.
 * Nesting groups is possible and even encouraged since many layouting schemes
 * can only be achieved by nesting. Groups, unlike windows, need `nk_group_end`
 * to be only called if the corresponding `nk_group_begin_xxx` call does not return 0:
 *
 * ```c
 * if (nk_group_begin_xxx(ctx, ...) {
 *     // [... widgets ...]
 *     nk_group_end(ctx);
 * }
 * ```
 *
 * In the grand concept groups can be called after starting a window
 * with `nk_begin_xxx` and before calling `nk_end`:
 *
 * ```c
 * struct nk_context ctx;
 * nk_init_xxx(&ctx, ...);
 * while (1) {
 *     // Input
 *     Event evt;
 *     nk_input_begin(&ctx);
 *     while (GetEvent(&evt)) {
 *         if (evt.type == MOUSE_MOVE)
 *             nk_input_motion(&ctx, evt.motion.x, evt.motion.y);
 *         else if (evt.type == [...]) {
 *             nk_input_xxx(...);
 *         }
 *     }
 *     nk_input_end(&ctx);
 *     //
 *     // Window
 *     if (nk_begin_xxx(...) {
 *         // [...widgets...]
 *         nk_layout_row_dynamic(...);
 *         if (nk_group_begin_xxx(ctx, ...) {
 *             //[... widgets ...]
 *             nk_group_end(ctx);
 *         }
 *     }
 *     nk_end(ctx);
 *     //
 *     // Draw
 *     const struct nk_command *cmd = 0;
 *     nk_foreach(cmd, &ctx) {
 *     switch (cmd->type) {
 *     case NK_COMMAND_LINE:
 *         your_draw_line_function(...)
 *         break;
 *     case NK_COMMAND_RECT
 *         your_draw_rect_function(...)
 *         break;
 *     case ...:
 *         // [...]
 *     }
 *     nk_clear(&ctx);
 * }
 * nk_free(&ctx);
 * ```
 * # Reference
 * Function                        | Description
 * --------------------------------|-------------------------------------------
 * \ref nk_group_begin                  | Start a new group with internal scrollbar handling
 * \ref nk_group_begin_titled           | Start a new group with separated name and title and internal scrollbar handling
 * \ref nk_group_end                    | Ends a group. Should only be called if nk_group_begin returned non-zero
 * \ref nk_group_scrolled_offset_begin  | Start a new group with manual separated handling of scrollbar x- and y-offset
 * \ref nk_group_scrolled_begin         | Start a new group with manual scrollbar handling
 * \ref nk_group_scrolled_end           | Ends a group with manual scrollbar handling. Should only be called if nk_group_begin returned non-zero
 * \ref nk_group_get_scroll             | Gets the scroll offset for the given group
 * \ref nk_group_set_scroll             | Sets the scroll offset for the given group
 */


 /**
 * \brief Starts a new widget group. Requires a previous layouting function to specify a pos/size.
 * ```c
 * nk_bool nk_group_begin(struct nk_context*, const char *title, nk_flags);
 * ```
 *
 * Parameter   | Description
 * ------------|-----------------------------------------------------------
 * \param[in] ctx     | Must point to an previously initialized `nk_context` struct
 * \param[in] title   | Must be an unique identifier for this group that is also used for the group header
 * \param[in] flags   | Window flags defined in the nk_panel_flags section with a number of different group behaviors
 *
 * \returns `true(1)` if visible and fillable with widgets or `false(0)` otherwise
 */
    group_begin :: proc(ctx: ^Context, title: cstring, flags: Panel_Flags) -> bool ---

 /**
 * \brief Starts a new widget group. Requires a previous layouting function to specify a pos/size.
 * ```c
 * nk_bool nk_group_begin_titled(struct nk_context*, const char *name, const char *title, nk_flags);
 * ```
 *
 * \param[in] ctx     | Must point to an previously initialized `nk_context` struct
 * \param[in] id      | Must be an unique identifier for this group
 * \param[in] title   | Group header title
 * \param[in] flags   | Window flags defined in the nk_panel_flags section with a number of different group behaviors
 *
 * \returns `true(1)` if visible and fillable with widgets or `false(0)` otherwise
 */
    group_begin_titled :: proc(ctx: ^Context, name, title: cstring, flags: Panel_Flags) -> bool ---

/**
 * # # nk_group_end
 * Ends a widget group
 * ```c
 * void nk_group_end(struct nk_context*);
 * ```
 *
 * Parameter   | Description
 * ------------|-----------------------------------------------------------
 * \param[in] ctx     | Must point to an previously initialized `nk_context` struct
 */
    group_end :: proc(ctx: ^Context) ---

/**
 * # # nk_group_scrolled_offset_begin
 * starts a new widget group. requires a previous layouting function to specify
 * a size. Does not keep track of scrollbar.
 * ```c
 * nk_bool nk_group_scrolled_offset_begin(struct nk_context*, nk_uint *x_offset, nk_uint *y_offset, const char *title, nk_flags flags);
 * ```
 *
 * Parameter   | Description
 * ------------|-----------------------------------------------------------
 * \param[in] ctx     | Must point to an previously initialized `nk_context` struct
 * \param[in] x_offset| Scrollbar x-offset to offset all widgets inside the group horizontally.
 * \param[in] y_offset| Scrollbar y-offset to offset all widgets inside the group vertically
 * \param[in] title   | Window unique group title used to both identify and display in the group header
 * \param[in] flags   | Window flags from the nk_panel_flags section
 *
 * \returns `true(1)` if visible and fillable with widgets or `false(0)` otherwise
 */
    group_scrolled_offset_begin :: proc(ctx: ^Context, x_offset, y_offset: ^u32, title: cstring, flags: Panel_Flags) -> bool ---

/**
 * # # nk_group_scrolled_begin
 * Starts a new widget group. requires a previous
 * layouting function to specify a size. Does not keep track of scrollbar.
 * ```c
 * nk_bool nk_group_scrolled_begin(struct nk_context*, struct nk_scroll *off, const char *title, nk_flags);
 * ```
 *
 * Parameter   | Description
 * ------------|-----------------------------------------------------------
 * \param[in] ctx     | Must point to an previously initialized `nk_context` struct
 * \param[in] off     | Both x- and y- scroll offset. Allows for manual scrollbar control
 * \param[in] title   | Window unique group title used to both identify and display in the group header
 * \param[in] flags   | Window flags from nk_panel_flags section
 *
 * \returns `true(1)` if visible and fillable with widgets or `false(0)` otherwise
 */
    group_scrolled_begin :: proc(ctx: ^Context, off: ^Scroll, title: cstring, flags: Panel_Flags) -> bool ---

/**
 * # # nk_group_scrolled_end
 * Ends a widget group after calling nk_group_scrolled_offset_begin or nk_group_scrolled_begin.
 * ```c
 * void nk_group_scrolled_end(struct nk_context*);
 * ```
 *
 * Parameter   | Description
 * ------------|-----------------------------------------------------------
 * \param[in] ctx     | Must point to an previously initialized `nk_context` struct
 */
    group_scrolled_end :: proc(ctx: ^Context) ---

    /*
    // #### nk_group_get_scroll
    // Gets the scroll position of the given group.
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~c
    // void nk_group_get_scroll(ctx: ^Context, const char *id, nk_uint *x_offset, nk_uint *y_offset);
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    //
    // Parameter    | Description
    // -------------|-----------------------------------------------------------
    // __ctx__      | Must point to an previously initialized `nk_context` 
    // __id__       | The id of the group to get the scroll position of
    // __x_offset__ | A pointer to the x offset output (or NULL to ignore)
    // __y_offset__ | A pointer to the y offset output (or NULL to ignore)
    */
    group_get_scroll :: proc(ctx: ^Context, id: cstring, x_offset, y_offset: ^u32) ---

/**
 * # # nk_group_get_scroll
 * Gets the scroll position of the given group.
 * ```c
 * void nk_group_get_scroll(struct nk_context*, const char *id, nk_uint *x_offset, nk_uint *y_offset);
 * ```
 *
 * Parameter    | Description
 * -------------|-----------------------------------------------------------
 * \param[in] ctx      | Must point to an previously initialized `nk_context` struct
 * \param[in] id       | The id of the group to get the scroll position of
 * \param[in] x_offset | A pointer to the x offset output (or NULL to ignore)
 * \param[in] y_offset | A pointer to the y offset output (or NULL to ignore)
 */
    group_set_scroll :: proc(ctx: ^Context, id: cstring, x_offset, y_offset: u32) ---

/** =============================================================================
 *
 *                                  TREE
 *
 * =============================================================================*/
/**
 * \page Tree
 * Trees represent two different concept. First the concept of a collapsible
 * UI section that can be either in a hidden or visible state. They allow the UI
 * user to selectively minimize the current set of visible UI to comprehend.
 * The second concept are tree widgets for visual UI representation of trees.<br /><br />
 *
 * Trees thereby can be nested for tree representations and multiple nested
 * collapsible UI sections. All trees are started by calling of the
 * `nk_tree_xxx_push_tree` functions and ended by calling one of the
 * `nk_tree_xxx_pop_xxx()` functions. Each starting functions takes a title label
 * and optionally an image to be displayed and the initial collapse state from
 * the nk_collapse_states section.<br /><br />
 *
 * The runtime state of the tree is either stored outside the library by the caller
 * or inside which requires a unique ID. The unique ID can either be generated
 * automatically from `__FILE__` and `__LINE__` with function `nk_tree_push`,
 * by `__FILE__` and a user provided ID generated for example by loop index with
 * function `nk_tree_push_id` or completely provided from outside by user with
 * function `nk_tree_push_hashed`.
 *
 * # Usage
 * To create a tree you have to call one of the seven `nk_tree_xxx_push_xxx`
 * functions to start a collapsible UI section and `nk_tree_xxx_pop` to mark the
 * end.
 * Each starting function will either return `false(0)` if the tree is collapsed
 * or hidden and therefore does not need to be filled with content or `true(1)`
 * if visible and required to be filled.
 *
 * !!! Note
 *     The tree header does not require and layouting function and instead
 *     calculates a auto height based on the currently used font size
 *
 * The tree ending functions only need to be called if the tree content is
 * actually visible. So make sure the tree push function is guarded by `if`
 * and the pop call is only taken if the tree is visible.
 *
 * ```c
 * if (nk_tree_push(ctx, NK_TREE_TAB, "Tree", NK_MINIMIZED)) {
 *     nk_layout_row_dynamic(...);
 *     nk_widget(...);
 *     nk_tree_pop(ctx);
 * }
 * ```
 *
 * # Reference
 * Function                    | Description
 * ----------------------------|-------------------------------------------
 * nk_tree_push                | Start a collapsible UI section with internal state management
 * nk_tree_push_id             | Start a collapsible UI section with internal state management callable in a look
 * nk_tree_push_hashed         | Start a collapsible UI section with internal state management with full control over internal unique ID use to store state
 * nk_tree_image_push          | Start a collapsible UI section with image and label header
 * nk_tree_image_push_id       | Start a collapsible UI section with image and label header and internal state management callable in a look
 * nk_tree_image_push_hashed   | Start a collapsible UI section with image and label header and internal state management with full control over internal unique ID use to store state
 * nk_tree_pop                 | Ends a collapsible UI section
 * nk_tree_state_push          | Start a collapsible UI section with external state management
 * nk_tree_state_image_push    | Start a collapsible UI section with image and label header and external state management
 * nk_tree_state_pop           | Ends a collapsabale UI section
 *
 * # nk_tree_type
 * Flag            | Description
 * ----------------|----------------------------------------
 * NK_TREE_NODE    | Highlighted tree header to mark a collapsible UI section
 * NK_TREE_TAB     | Non-highlighted tree header closer to tree representations
 */

   /**
 * # # nk_tree_push
 * Starts a collapsible UI section with internal state management
 * !!! \warning
 *     To keep track of the runtime tree collapsible state this function uses
 *     defines `__FILE__` and `__LINE__` to generate a unique ID. If you want
 *     to call this function in a loop please use `nk_tree_push_id` or
 *     `nk_tree_push_hashed` instead.
 *
 * ```c
 * #define nk_tree_push(ctx, type, title, state)
 * ```
 *
 * Parameter   | Description
 * ------------|-----------------------------------------------------------
 * \param[in] ctx     | Must point to an previously initialized `nk_context` struct
 * \param[in] type    | Value from the nk_tree_type section to visually mark a tree node header as either a collapseable UI section or tree node
 * \param[in] title   | Label printed in the tree header
 * \param[in] state   | Initial tree state value out of nk_collapse_states
 *
 * \returns `true(1)` if visible and fillable with widgets or `false(0)` otherwise
 */
    tree_push_hashed :: proc(ctx: ^Context, type: Tree_Type, title: cstring, initial_state: Collapse_States, hash: [^]u8, len, seed: i32) -> bool ---

/**
 * # # nk_tree_image_push_hashed
 * Start a collapsible UI section with internal state management with full
 * control over internal unique ID used to store state
 * ```c
 * nk_bool nk_tree_image_push_hashed(struct nk_context*, enum nk_tree_type, struct nk_image, const char *title, enum nk_collapse_states initial_state, const char *hash, int len,int seed);
 * ```
 *
 * Parameter   | Description
 * ------------|-----------------------------------------------------------
 * \param[in] ctx     | Must point to an previously initialized `nk_context` struct
 * \param[in] type    | Value from the nk_tree_type section to visually mark a tree node header as either a collapseable UI section or tree node
 * \param[in] img     | Image to display inside the header on the left of the label
 * \param[in] title   | Label printed in the tree header
 * \param[in] state   | Initial tree state value out of nk_collapse_states
 * \param[in] hash    | Memory block or string to generate the ID from
 * \param[in] len     | Size of passed memory block or string in __hash__
 * \param[in] seed    | Seeding value if this function is called in a loop or default to `0`
 *
 * \returns `true(1)` if visible and fillable with widgets or `false(0)` otherwise
 */
    tree_image_push_hashed :: proc(ctx: ^Context, Tree_Type, Image, title: cstring, initial_state: Collapse_States, hash: cstring, len, seed: i32) -> bool ---

/**
 * # # nk_tree_pop
 * Ends a collapsabale UI section
 * ```c
 * void nk_tree_pop(struct nk_context*);
 * ```
 *
 * Parameter   | Description
 * ------------|-----------------------------------------------------------
 * \param[in] ctx     | Must point to an previously initialized `nk_context` struct after calling `nk_tree_xxx_push_xxx`
 */
    tree_pop :: proc(ctx: ^Context) ---

/**
 * # # nk_tree_state_push
 * Start a collapsible UI section with external state management
 * ```c
 * nk_bool nk_tree_state_push(struct nk_context*, enum nk_tree_type, const char *title, enum nk_collapse_states *state);
 * ```
 *
 * Parameter   | Description
 * ------------|-----------------------------------------------------------
 * \param[in] ctx     | Must point to an previously initialized `nk_context` struct after calling `nk_tree_xxx_push_xxx`
 * \param[in] type    | Value from the nk_tree_type section to visually mark a tree node header as either a collapseable UI section or tree node
 * \param[in] title   | Label printed in the tree header
 * \param[in] state   | Persistent state to update
 *
 * \returns `true(1)` if visible and fillable with widgets or `false(0)` otherwise
 */
    tree_state_push :: proc(ctx: ^Context, type: Tree_Type, title: cstring, state: ^Collapse_States) -> bool ---

/**
 * # # nk_tree_state_image_push
 * Start a collapsible UI section with image and label header and external state management
 * ```c
 * nk_bool nk_tree_state_image_push(struct nk_context*, enum nk_tree_type, struct nk_image, const char *title, enum nk_collapse_states *state);
 * ```
 *
 * Parameter   | Description
 * ------------|-----------------------------------------------------------
 * \param[in] ctx     | Must point to an previously initialized `nk_context` struct after calling `nk_tree_xxx_push_xxx`
 * \param[in] img     | Image to display inside the header on the left of the label
 * \param[in] type    | Value from the nk_tree_type section to visually mark a tree node header as either a collapseable UI section or tree node
 * \param[in] title   | Label printed in the tree header
 * \param[in] state   | Persistent state to update
 *
 * \returns `true(1)` if visible and fillable with widgets or `false(0)` otherwise
 */
    tree_state_image_push :: proc(ctx: ^Context, type: Tree_Type, image: Image, title: cstring, state: ^Collapse_States) -> bool ---

/**
 * # # nk_tree_state_pop
 * Ends a collapsabale UI section
 * ```c
 * void nk_tree_state_pop(struct nk_context*);
 * ```
 *
 * Parameter   | Description
 * ------------|-----------------------------------------------------------
 * \param[in] ctx     | Must point to an previously initialized `nk_context` struct after calling `nk_tree_xxx_push_xxx`
 */
    tree_state_pop :: proc(ctx: ^Context) ---

    tree_element_push_hashed :: proc(ctx: ^Context, type: Tree_Type, title: cstring, initial_state: Collapse_States, selected: ^bool, hash: cstring, len, seed: i32) -> bool ---
    tree_element_image_push_hashed :: proc(ctx: ^Context, type: Tree_Type, image: Image, title: cstring, initial_state: Collapse_States, selected: ^bool, hash: cstring, len, seed: i32) -> bool ---
    tree_element_pop :: proc(ctx: ^Context) ---

/* =============================================================================
 *
 *                                  LIST VIEW
 *
 * ============================================================================= */


    list_view_begin :: proc(ctx: ^Context, out: ^List_View, id: cstring, flags: Flags, row_height, row_count: i32) -> bool ---
    list_view_end :: proc(list: ^List_View) ---

    widget :: proc(^Rect, ^Context) -> Widget_Layout_States ---
    widget_fitting :: proc(^Rect, ^Context, Vec2) -> Widget_Layout_States ---
    widget_bounds :: proc(ctx: ^Context) -> Rect ---
    widget_position :: proc(ctx: ^Context) -> Vec2 ---
    widget_size :: proc(ctx: ^Context) -> Vec2 ---
    widget_width :: proc(ctx: ^Context) -> f32 ---
    widget_height :: proc(ctx: ^Context) -> f32 ---
    widget_is_hovered :: proc(ctx: ^Context) -> bool ---
    widget_is_mouse_clicked :: proc(ctx: ^Context, button: Buttons) -> bool ---
    widget_has_mouse_click_down :: proc(ctx: ^Context, button: Buttons, down: bool) -> bool ---
    spacing :: proc(ctx: ^Context, cols: i32) ---
    widget_disable_begin :: proc(ctx: ^Context) ---
    widget_disable_end :: proc(ctx: ^Context) ---


/* =============================================================================
 *
 *                                  TEXT
 *
 * ============================================================================= */


    text :: proc(ctx: ^Context, name: [^]u8, len: i32, alignment: Text_Alignment) ---
    text_colored :: proc(ctx: ^Context, name: cstring, i: i32, flags: Flags, color: Color) ---
    text_wrap :: proc(ctx: ^Context, name: cstring, i: i32) ---
    text_wrap_colored :: proc(ctx: ^Context, name: cstring, i32, color: Color) ---
    label :: proc(ctx: ^Context, name: cstring, align: Text_Alignment) ---
    label_colored :: proc(ctx: ^Context, name: cstring, align: Text_Alignment, color: Color) ---
    label_wrap :: proc(ctx: ^Context, name: cstring) ---
    label_colored_wrap :: proc(ctx: ^Context, name: cstring, color: Color) ---
    image :: proc(ctx: ^Context, image: Image) ---
    image_color :: proc(ctx: ^Context, image: Image, color: Color) ---


/* =============================================================================
 *
 *                                  BUTTON
 *
 * ============================================================================= */


    button_text :: proc(ctx: ^Context, title: [^]u8, len: i32) -> bool ---
    button_label :: proc(ctx: ^Context, title: cstring) -> bool ---
    button_color :: proc(ctx: ^Context, color: Color) -> bool ---
    button_symbol :: proc(ctx: ^Context, type: Symbol_Type) -> bool ---
    button_image :: proc(ctx: ^Context, img: Image) -> bool ---
    button_symbol_label :: proc(ctx: ^Context, type: Symbol_Type, cstring, text_alignment: Text_Alignment) -> bool ---
    button_symbol_text :: proc(ctx: ^Context, type: Symbol_Type, cstring, len: i32, alignment: Text_Alignment) -> bool ---
    button_image_label :: proc(ctx: ^Context, img: Image, cstring, text_alignment: Text_Alignment) -> bool ---
    button_image_text :: proc(ctx: ^Context, img: Image, cstring, len: i32, alignment: Text_Alignment) -> bool ---
    button_text_styled :: proc(ctx: ^Context, style: ^Style_Button, title: cstring, len: i32) -> bool ---
    button_label_styled :: proc(ctx: ^Context, style: ^Style_Button, title: cstring) -> bool ---
    button_symbol_styled :: proc(ctx: ^Context, style: ^Style_Button, type: Symbol_Type) -> bool ---
    button_image_styled :: proc(ctx: ^Context, style: ^Style_Button, img: Image) -> bool ---
    button_symbol_text_styled :: proc(ctx: ^Context, style: ^Style_Button, symbol: Symbol_Type, title: cstring, len: i32, alignment: Text_Alignment) -> bool ---
    button_symbol_label_styled :: proc(ctx: ^Context, style: ^Style_Button, symbol: Symbol_Type, title: cstring, align: Text_Alignment) -> bool ---
    button_image_label_styled :: proc(ctx: ^Context, style: ^Style_Button, img: Image, title: cstring, text_alignment: Text_Alignment) -> bool ---
    button_image_text_styled :: proc(ctx: ^Context, style: ^Style_Button, img: Image, title: cstring, len: i32, alignment: Text_Alignment) -> bool ---
    button_set_behavior :: proc(ctx: ^Context, behavior: Button_Behavior) ---
    button_push_behavior :: proc(ctx: ^Context, behavior: Button_Behavior) -> bool ---
    button_pop_behavior :: proc(ctx: ^Context) -> bool ---


/* =============================================================================
 *
 *                                  CHECKBOX
 *
 * ============================================================================= */


    check_label :: proc(ctx: ^Context, label: cstring, active: bool) -> bool ---
    check_text :: proc(ctx: ^Context, label: cstring, len: i32, active: bool) -> bool ---
    check_text_align :: proc(ctx: ^Context, label: cstring, len: i32, active: bool, widget_alignment: Text_Alignment, text_alignment: Text_Alignment) -> bool ---
    check_flags_label :: proc(ctx: ^Context, label: cstring, flags, value: u32) -> u32 ---
    check_flags_text :: proc(ctx: ^Context, label: cstring, len: i32, flags, value: u32) -> u32 ---
    checkbox_label :: proc(ctx: ^Context, label: cstring, active: ^bool) -> bool ---
    checkbox_label_align :: proc(ctx: ^Context, label: cstring, active: ^bool, widget_alignment, text_alignment: Text_Alignment) -> bool ---
    checkbox_text :: proc(ctx: ^Context, label: cstring, len: i32, active: ^bool) -> bool  ---
    checkbox_text_align :: proc(ctx: ^Context, label: cstring, len: i32, active: ^bool, widget_alignment, text_alignment: Text_Alignment) -> bool ---
    checkbox_flags_label :: proc(ctx: ^Context, label: cstring, flags: ^u32, value: u32) -> bool ---
    checkbox_flags_text :: proc(ctx: ^Context, label: cstring, len: i32, flags: ^u32, value: u32) -> bool ---


/* =============================================================================
 *
 *                                  RADIO BUTTON
 *
 * ============================================================================= */


    radio_label :: proc(ctx: ^Context, label: cstring, active: ^bool) -> bool ---
    radio_label_align :: proc(ctx: ^Context, label: cstring, active: ^bool, widget_alignment, text_alignment: Text_Alignment) -> bool ---
    radio_text :: proc(ctx: ^Context, text: cstring, len: i32, active: ^bool) -> bool ---
    radio_text_align :: proc(ctx: ^Context, text: cstring, len: i32, active: ^bool, widget_alignment, text_alignment: Text_Alignment) -> bool ---
    option_label :: proc(ctx: ^Context, label: cstring, active: bool) -> bool ---
    option_label_align :: proc(ctx: ^Context, label: cstring, active: bool, widget_alignment, text_alignment: Text_Alignment) -> bool ---
    option_text :: proc(ctx: ^Context, text: cstring, len: i32, active: bool) -> bool ---
    option_text_align :: proc(ctx: ^Context, text: cstring, len: i32, is_active: bool, widget_alignment, text_alignment: Text_Alignment) -> bool ---


/* =============================================================================
 *
 *                                  SELECTABLE
 *
 * ============================================================================= */


    selectable_label :: proc(ctx: ^Context, label: cstring, align: Text_Alignment, value: ^bool) -> bool ---
    selectable_text :: proc(ctx: ^Context, label: [^]u8, len: i32, align: Text_Alignment, value: ^bool) -> bool ---
    selectable_image_label :: proc(ctx: ^Context, img: Image,  text: cstring, align: Text_Alignment, value: ^bool) -> bool ---
    selectable_image_text :: proc(ctx: ^Context, img: Image, text: cstring, len: i32, align: Text_Alignment, value: ^bool) -> bool ---
    selectable_symbol_label :: proc(ctx: ^Context, symbol: Symbol_Type, text: cstring, align: Text_Alignment, value: ^bool) -> bool ---
    selectable_symbol_text :: proc(ctx: ^Context, symbol: Symbol_Type, text: cstring, len: i32, align: Text_Alignment, value: ^bool) -> bool ---

    select_label :: proc(ctx: ^Context, label: cstring, align: Text_Alignment, value: ^bool) -> bool ---
    select_text :: proc(ctx: ^Context, label: [^]u8, len: i32, align: Text_Alignment, value: ^bool) -> bool ---
    select_image_label :: proc(ctx: ^Context, img: Image, text: cstring, align: Text_Alignment, value: ^bool) -> bool ---
    select_image_text :: proc(ctx: ^Context, img: Image, text: cstring, len: i32, align: Text_Alignment, value: ^bool) -> bool ---
    select_symbol_label :: proc(ctx: ^Context, symbol: Symbol_Type, text: cstring, align: Text_Alignment, value: ^bool) -> bool ---
    select_symbol_text :: proc(ctx: ^Context, symbol: Symbol_Type, text: cstring, len: i32, align: Text_Alignment, value: ^bool) -> bool ---


/* =============================================================================
 *
 *                                  SLIDER
 *
 * ============================================================================= */


    slide_float :: proc(ctx: ^Context, min, val, max, step: f32) -> f32 ---
    slide_int :: proc(ctx: ^Context, min, val, max, step: i32) -> i32 ---
    slider_float :: proc(ctx: ^Context, min: f32, val: ^f32, max, step: f32) -> bool ---
    slider_int :: proc(ctx: ^Context, min: i32, val: ^i32, max, step: i32) -> bool ---


/* =============================================================================
 *
 *                                   KNOB
 *
 * ============================================================================= */


    knob_float :: proc(ctx: ^Context, min: f32,  val: ^f32, max, step: f32, zero_direction: Heading, dead_zone_degrees: f32) -> bool ---
    knob_int :: proc(ctx: ^Context, min: i32,  val: ^i32, max, step: i32, zero_direction: Heading, dead_zone_degrees: f32) -> bool ---


/* =============================================================================
 *
 *                                  PROGRESSBAR
 *
 * ============================================================================= */


    progress :: proc(ctx: ^Context, cur: ^i64, max: i64, modifyable: bool) -> bool ---
    prog :: proc(ctx: ^Context, cur: i64, max: i64, modifyable: bool) -> i64 ---


/* =============================================================================
 *
 *                                  COLOR PICKER
 *
 * ============================================================================= */


    color_picker :: proc(ctx: ^Context, color: ColorF, format: Color_Format) -> ColorF ---
    color_pick :: proc(ctx: ^Context, color: ^ColorF, format: Color_Format) -> bool ---

/* =============================================================================
 *
 *                                  PROPERTIES
 *
 * =============================================================================*/
/**
 * \page Properties
 * Properties are the main value modification widgets in Nuklear. Changing a value
 * can be achieved by dragging, adding/removing incremental steps on button click
 * or by directly typing a number.
 *
 * # Usage
 * Each property requires a unique name for identification that is also used for
 * displaying a label. If you want to use the same name multiple times make sure
 * add a '#' before your name. The '#' will not be shown but will generate a
 * unique ID. Each property also takes in a minimum and maximum value. If you want
 * to make use of the complete number range of a type just use the provided
 * type limits from `limits.h`. For example `INT_MIN` and `INT_MAX` for
 * `nk_property_int` and `nk_propertyi`. In additional each property takes in
 * a increment value that will be added or subtracted if either the increment
 * decrement button is clicked. Finally there is a value for increment per pixel
 * dragged that is added or subtracted from the value.
 *
 * ```c
 * int value = 0;
 * struct nk_context ctx;
 * nk_init_xxx(&ctx, ...);
 * while (1) {
 *     // Input
 *     Event evt;
 *     nk_input_begin(&ctx);
 *     while (GetEvent(&evt)) {
 *         if (evt.type == MOUSE_MOVE)
 *             nk_input_motion(&ctx, evt.motion.x, evt.motion.y);
 *         else if (evt.type == [...]) {
 *             nk_input_xxx(...);
 *         }
 *     }
 *     nk_input_end(&ctx);
 *     //
 *     // Window
 *     if (nk_begin_xxx(...) {
 *         // Property
 *         nk_layout_row_dynamic(...);
 *         nk_property_int(ctx, "ID", INT_MIN, &value, INT_MAX, 1, 1);
 *     }
 *     nk_end(ctx);
 *     //
 *     // Draw
 *     const struct nk_command *cmd = 0;
 *     nk_foreach(cmd, &ctx) {
 *     switch (cmd->type) {
 *     case NK_COMMAND_LINE:
 *         your_draw_line_function(...)
 *         break;
 *     case NK_COMMAND_RECT
 *         your_draw_rect_function(...)
 *         break;
 *     case ...:
 *         // [...]
 *     }
 *     nk_clear(&ctx);
 * }
 * nk_free(&ctx);
 * ```
 *
 * # Reference
 * Function            | Description
 * --------------------|-------------------------------------------
 * \ref nk_property_int     | Integer property directly modifying a passed in value
 * \ref nk_property_float   | Float property directly modifying a passed in value
 * \ref nk_property_double  | Double property directly modifying a passed in value
 * \ref nk_propertyi        | Integer property returning the modified int value
 * \ref nk_propertyf        | Float property returning the modified float value
 * \ref nk_propertyd        | Double property returning the modified double value
 */

/*
 * # # nk_property_int
 * Integer property directly modifying a passed in value
 * !!! \warning
 *     To generate a unique property ID using the same label make sure to insert
 *     a `#` at the beginning. It will not be shown but guarantees correct behavior.
 *
 * ```c
 * void nk_property_int(struct nk_context *ctx, const char *name, int min, int *val, int max, int step, float inc_per_pixel);
 * ```
 *
 * Parameter           | Description
 * --------------------|-----------------------------------------------------------
 * \param[in] ctx             | Must point to an previously initialized `nk_context` struct after calling a layouting function
 * \param[in] name            | String used both as a label as well as a unique identifier
 * \param[in] min             | Minimum value not allowed to be underflown
 * \param[in] val             | Integer pointer to be modified
 * \param[in] max             | Maximum value not allowed to be overflown
 * \param[in] step            | Increment added and subtracted on increment and decrement button
 * \param[in] inc_per_pixel   | Value per pixel added or subtracted on dragging
 */
    property_int :: proc(ctx: ^Context, name: cstring, min: i32, val: ^i32, max, step: i32, inc_per_pixel: f32) ---

/**
 * # # nk_property_float
 * Float property directly modifying a passed in value
 * !!! \warning
 *     To generate a unique property ID using the same label make sure to insert
 *     a `#` at the beginning. It will not be shown but guarantees correct behavior.
 *
 * ```c
 * void nk_property_float(struct nk_context *ctx, const char *name, float min, float *val, float max, float step, float inc_per_pixel);
 * ```
 *
 * Parameter           | Description
 * --------------------|-----------------------------------------------------------
 * \param[in] ctx             | Must point to an previously initialized `nk_context` struct after calling a layouting function
 * \param[in] name            | String used both as a label as well as a unique identifier
 * \param[in] min             | Minimum value not allowed to be underflown
 * \param[in] val             | Float pointer to be modified
 * \param[in] max             | Maximum value not allowed to be overflown
 * \param[in] step            | Increment added and subtracted on increment and decrement button
 * \param[in] inc_per_pixel   | Value per pixel added or subtracted on dragging
 */
    property_float :: proc(ctx: ^Context, name: cstring, min: f32, val: ^f32, max, step: f32, inc_per_pixel: f32) ---

/**
 * # # nk_property_double
 * Double property directly modifying a passed in value
 * !!! \warning
 *     To generate a unique property ID using the same label make sure to insert
 *     a `#` at the beginning. It will not be shown but guarantees correct behavior.
 *
 * ```c
 * void nk_property_double(struct nk_context *ctx, const char *name, double min, double *val, double max, double step, double inc_per_pixel);
 * ```
 *
 * Parameter           | Description
 * --------------------|-----------------------------------------------------------
 * \param[in] ctx             | Must point to an previously initialized `nk_context` struct after calling a layouting function
 * \param[in] name            | String used both as a label as well as a unique identifier
 * \param[in] min             | Minimum value not allowed to be underflown
 * \param[in] val             | Double pointer to be modified
 * \param[in] max             | Maximum value not allowed to be overflown
 * \param[in] step            | Increment added and subtracted on increment and decrement button
 * \param[in] inc_per_pixel   | Value per pixel added or subtracted on dragging
 */
    property_double :: proc(ctx: ^Context, name: cstring, min: f64, val: ^f64, max, step: f64, inc_per_pixel: f32) ---

/**
 * # # nk_propertyi
 * Integer property modifying a passed in value and returning the new value
 * !!! \warning
 *     To generate a unique property ID using the same label make sure to insert
 *     a `#` at the beginning. It will not be shown but guarantees correct behavior.
 *
 * ```c
 * int nk_propertyi(struct nk_context *ctx, const char *name, int min, int val, int max, int step, float inc_per_pixel);
 * ```
 *
 * \param[in] ctx              Must point to an previously initialized `nk_context` struct after calling a layouting function
 * \param[in] name             String used both as a label as well as a unique identifier
 * \param[in] min              Minimum value not allowed to be underflown
 * \param[in] val              Current integer value to be modified and returned
 * \param[in] max              Maximum value not allowed to be overflown
 * \param[in] step             Increment added and subtracted on increment and decrement button
 * \param[in] inc_per_pixel    Value per pixel added or subtracted on dragging
 *
 * \returns the new modified integer value
 */
    propertyi :: proc(ctx: ^Context, name: cstring, min, val, max, step: i32, inc_per_pixel: f32) -> i32 ---

/**
 * # # nk_propertyf
 * Float property modifying a passed in value and returning the new value
 * !!! \warning
 *     To generate a unique property ID using the same label make sure to insert
 *     a `#` at the beginning. It will not be shown but guarantees correct behavior.
 *
 * ```c
 * float nk_propertyf(struct nk_context *ctx, const char *name, float min, float val, float max, float step, float inc_per_pixel);
 * ```
 *
 * \param[in] ctx              Must point to an previously initialized `nk_context` struct after calling a layouting function
 * \param[in] name             String used both as a label as well as a unique identifier
 * \param[in] min              Minimum value not allowed to be underflown
 * \param[in] val              Current float value to be modified and returned
 * \param[in] max              Maximum value not allowed to be overflown
 * \param[in] step             Increment added and subtracted on increment and decrement button
 * \param[in] inc_per_pixel    Value per pixel added or subtracted on dragging
 *
 * \returns the new modified float value
 */
    propertyf :: proc(ctx: ^Context, name: cstring, min, val, max, step: f32, inc_per_pixel: f32) -> f32 ---

/**
 * # # nk_propertyd
 * Float property modifying a passed in value and returning the new value
 * !!! \warning
 *     To generate a unique property ID using the same label make sure to insert
 *     a `#` at the beginning. It will not be shown but guarantees correct behavior.
 *
 * ```c
 * float nk_propertyd(struct nk_context *ctx, const char *name, double min, double val, double max, double step, double inc_per_pixel);
 * ```
 *
 * \param[in] ctx              Must point to an previously initialized `nk_context` struct after calling a layouting function
 * \param[in] name             String used both as a label as well as a unique identifier
 * \param[in] min              Minimum value not allowed to be underflown
 * \param[in] val              Current double value to be modified and returned
 * \param[in] max              Maximum value not allowed to be overflown
 * \param[in] step             Increment added and subtracted on increment and decrement button
 * \param[in] inc_per_pixel    Value per pixel added or subtracted on dragging
 *
 * \returns the new modified double value
 */
    propertyd :: proc(ctx: ^Context, name: cstring, min, val, max, step: f64, inc_per_pixel: f32) -> f64 ---


/* =============================================================================
 *
 *                                  TEXT EDIT
 *
 * ============================================================================= */


    edit_string :: proc(ctx: ^Context, flags: Edit_Flags, buffer: [^]u8, len: ^i32, max: i32, fn: Plugin_Filter) -> Flags ---
    edit_string_zero_terminated :: proc(ctx: ^Context, flags: Edit_Flags, buffer: [^]u8, max: i32, fn: Plugin_Filter) -> Flags ---
    edit_buffer :: proc(ctx: ^Context, flags: Flags, text_edit: ^Text_Edit, fn: Plugin_Filter) -> Flags ---
    edit_focus :: proc(ctx: ^Context, flags: Flags) ---
    edit_unfocus :: proc(ctx: ^Context) ---


/* =============================================================================
 *
 *                                  CHART
 *
 * ============================================================================= */


    chart_begin :: proc(ctx: ^Context, type: Chart_Type, num: i32, min, max: f32) -> bool ---
    chart_begin_colored :: proc(ctx: ^Context, type: Chart_Type, color, active: Color, num: i32, min, max: f32) -> bool ---
    chart_add_slot :: proc(ctx: ^Context, type: Chart_Type, count: i32, min_value, max_value: f32) ---
    chart_add_slot_colored :: proc(ctx: ^Context, type: Chart_Type, color, active: Color, count: i32, min_value, max_value: f32) ---
    chart_push :: proc(ctx: ^Context, f: f32) -> Flags ---
    chart_push_slot :: proc(ctx: ^Context, f: f32, i: i32) -> Flags ---
    chart_end :: proc(ctx: ^Context) ---
    plot :: proc(ctx: ^Context, type: Chart_Type, values: [^]f32, count, offset: i32) ---
    plot_function :: proc(ctx: ^Context, type: Chart_Type, userdata: rawptr, p: proc "c" (user: rawptr, index: i32) -> f32, count, offset: i32) ---


/* =============================================================================
 *
 *                                  POPUP
 *
 * ============================================================================= */


    popup_begin :: proc(ctx: ^Context, type: Popup_Type, name: cstring, flags: Panel_Flags, bounds: Rect) -> bool ---
    popup_close :: proc(ctx: ^Context) ---
    popup_end :: proc(ctx: ^Context) ---
    popup_get_scroll :: proc(ctx: ^Context, offset_x, offset_y: ^u32) ---
    popup_set_scroll :: proc(ctx: ^Context, offset_x, offset_y: u32) ---


/* =============================================================================
 *
 *                                  COMBOBOX
 *
 * ============================================================================= */


    combo :: proc(ctx: ^Context, items: [^]cstring, count, selected, item_height: i32, size: Vec2) -> i32 ---
    combo_separator :: proc(ctx: ^Context, items_separated_by_separator: cstring, separator, selected, count, item_height: i32, size: Vec2) -> i32 ---
    combo_string :: proc(ctx: ^Context, items_separated_by_zeros: cstring, selected, count, item_height: i32, size: Vec2) -> i32 ---
    combo_callback :: proc(ctx: ^Context, item_getter: proc "c" (rawptr, i32, [^]cstring), userdata: rawptr, selected, count, item_height: i32, size: Vec2) -> i32 ---
    combobox :: proc(ctx: ^Context, items: [^]cstring, count: i32, selected: ^i32, item_height: i32, size: Vec2) ---
    combobox_string :: proc(ctx: ^Context, items_separated_by_zeros: cstring, selected: ^i32, count, item_height: i32, size: Vec2) ---
    combobox_separator :: proc(ctx: ^Context, items_separated_by_separator: cstring, separator: i32, selected: ^i32, count, item_height: i32, size: Vec2) ---
    combobox_callback :: proc(ctx: ^Context, item_getter: proc "c"(rawptr, i32, [^]cstring), userdata: rawptr, selected: ^i32, count, item_height: i32, size: Vec2) ---


/* =============================================================================
 *
 *                                  ABSTRACT COMBOBOX
 *
 * ============================================================================= */


    combo_begin_text :: proc(ctx: ^Context, selected: cstring, len: i32, size: Vec2) -> bool ---
    combo_begin_label :: proc(ctx: ^Context, selected: cstring, size: Vec2) -> bool ---
    combo_begin_color :: proc(ctx: ^Context, color: Color, size: Vec2) -> bool ---
    combo_begin_symbol :: proc(ctx: ^Context, symbol: Symbol_Type, size: Vec2) -> bool ---
    combo_begin_symbol_label :: proc(ctx: ^Context, selected: cstring, symbol: Symbol_Type, size: Vec2) -> bool ---
    combo_begin_symbol_text :: proc(ctx: ^Context, selected: cstring, len: i32, symbol: Symbol_Type, size: Vec2) -> bool ---
    combo_begin_image :: proc(ctx: ^Context, img: Image, size: Vec2) -> bool ---
    combo_begin_image_label :: proc(ctx: ^Context, selected: cstring, img: Image, size: Vec2) -> bool ---
    combo_begin_image_text :: proc(ctx: ^Context,  selected: cstring, len: i32, img: Image, size: Vec2) -> bool ---
    combo_item_label :: proc(ctx: ^Context, text: cstring, alignment: Text_Alignment) -> bool ---
    combo_item_text :: proc(ctx: ^Context, text: cstring, len: i32, alignment: Text_Alignment) -> bool ---
    combo_item_image_label :: proc(ctx: ^Context, img: Image, text: cstring, alignment: Text_Alignment) -> bool ---
    combo_item_image_text :: proc(ctx: ^Context, img: Image, text: cstring, len: i32, alignment: Text_Alignment) -> bool ---
    combo_item_symbol_label :: proc(ctx: ^Context, symbol: Symbol_Type, text: cstring, alignment: Text_Alignment) -> bool ---
    combo_item_symbol_text :: proc(ctx: ^Context, symbol: Symbol_Type, text: cstring, len: i32, alignment: Text_Alignment) -> bool ---
    combo_close :: proc(ctx: ^Context) ---
    combo_end :: proc(ctx: ^Context) ---


/* =============================================================================
 *
 *                                  CONTEXTUAL
 *
 * ============================================================================= */


    contextual_begin :: proc(ctx: ^Context, flags: Flags, v: Vec2, trigger_bounds: Rect) -> bool ---
    contextual_item_text :: proc(ctx: ^Context, text: cstring, len: i32, align: Text_Alignment) -> bool ---
    contextual_item_label :: proc(ctx: ^Context, text: cstring, align: Text_Alignment) -> bool ---
    contextual_item_image_label :: proc(ctx: ^Context, img: Image, text: cstring, alignment: Text_Alignment) -> bool ---
    contextual_item_image_text :: proc(ctx: ^Context, img: Image, text: cstring, len: i32, alignment: Text_Alignment) -> bool ---
    contextual_item_symbol_label :: proc(ctx: ^Context, symbol: Symbol_Type, text: cstring, alignment: Text_Alignment) -> bool ---
    contextual_item_symbol_text :: proc(ctx: ^Context, symbol: Symbol_Type, text: cstring, len: i32, alignment: Text_Alignment) -> bool ---
    contextual_close :: proc(ctx: ^Context) ---
    contextual_end :: proc(ctx: ^Context) ---


/* =============================================================================
 *
 *                                  TOOLTIP
 *
 * ============================================================================= */


    tooltip :: proc(ctx: ^Context, str: cstring) ---
    tooltip_begin :: proc(ctx: ^Context, width: f32) -> bool ---
    tooltip_end :: proc(ctx: ^Context) ---


/* =============================================================================
 *
 *                                  MENU
 *
 * ============================================================================= */


    menubar_begin :: proc(ctx: ^Context) ---
    menubar_end :: proc(ctx: ^Context) ---
    menu_begin_text :: proc(ctx: ^Context, str: cstring, title_len: i32, align: Text_Alignment, size: Vec2) -> bool ---
    menu_begin_label :: proc(ctx: ^Context, str: cstring, align: Text_Alignment, size: Vec2) -> bool ---
    menu_begin_image :: proc(ctx: ^Context, str: cstring, img: Image, size: Vec2) -> bool ---
    menu_begin_image_text :: proc(ctx: ^Context, str: cstring, len: i32, align: Text_Alignment, img: Image, size: Vec2) -> bool ---
    menu_begin_image_label :: proc(ctx: ^Context, str: cstring, align: Text_Alignment, img: Image, size: Vec2) -> bool ---
    menu_begin_symbol :: proc(ctx: ^Context, str: cstring, symbol: Symbol_Type, size: Vec2) -> bool ---
    menu_begin_symbol_text :: proc(ctx: ^Context, str: cstring, len: i32, align: Text_Alignment, symbol: Symbol_Type, size: Vec2) -> bool ---
    menu_begin_symbol_label :: proc(ctx: ^Context, str: cstring, align: Text_Alignment, symbol: Symbol_Type, size: Vec2) -> bool ---
    menu_item_text :: proc(ctx: ^Context, str: cstring, len: i32, align: Text_Alignment) -> bool ---
    menu_item_label :: proc(ctx: ^Context, str: cstring, alignment: Text_Alignment) -> bool ---
    menu_item_image_label :: proc(ctx: ^Context, img: Image, str: cstring, alignment: Text_Alignment) -> bool ---
    menu_item_image_text :: proc(ctx: ^Context, img: Image, str: cstring, len: i32, alignment: Text_Alignment) -> bool ---
    menu_item_symbol_text :: proc(ctx: ^Context, symbol: Symbol_Type, str: cstring, i32, alignment: Text_Alignment) -> bool ---
    menu_item_symbol_label :: proc(ctx: ^Context, symbol: Symbol_Type, str: cstring, alignment: Text_Alignment) -> bool ---
    menu_close :: proc(ctx: ^Context) ---
    menu_end :: proc(ctx: ^Context) ---


/* =============================================================================
 *
 *                                  STYLE
 *
 * ============================================================================= */


    style_default :: proc(ctx: ^Context) ---
    style_from_table :: proc(ctx: ^Context, color: ^Color) ---
    style_load_cursor :: proc(ctx: ^Context, style: Style_Cursor, cursor: ^Cursor) ---
    style_load_all_cursors :: proc(ctx: ^Context, cursor: ^Cursor) ---
    style_get_color_by_name :: proc(style: Style_Colors) -> cstring ---
    style_set_font :: proc(ctx: ^Context, font: ^User_Font) ---
    style_set_cursor :: proc(ctx: ^Context, style: Style_Cursor) -> bool ---
    style_show_cursor :: proc(ctx: ^Context) ---
    style_hide_cursor :: proc(ctx: ^Context) ---

    style_push_font :: proc(ctx: ^Context, font: ^User_Font) -> bool ---
    style_push_float :: proc(ctx: ^Context, f: ^f32, v: f32) -> bool ---
    style_push_vec2 :: proc(ctx: ^Context, v0: ^Vec2, v1: Vec2) -> bool ---
    style_push_style_item :: proc(ctx: ^Context, p_si: ^Style_Item, si: Style_Item) -> bool ---
    style_push_flags :: proc(ctx: ^Context, p_flags: ^Flags, flags: Flags) -> bool ---
    style_push_color :: proc(ctx: ^Context, p_v: ^Color, c: Color) -> bool ---

    style_pop_font :: proc(ctx: ^Context) -> bool ---
    style_pop_float :: proc(ctx: ^Context) -> bool ---
    style_pop_vec2 :: proc(ctx: ^Context) -> bool ---
    style_pop_style_item :: proc(ctx: ^Context) -> bool ---
    style_pop_flags :: proc(ctx: ^Context) -> bool ---
    style_pop_color :: proc(ctx: ^Context) -> bool ---

    rgb :: proc(r, g, b: i32) -> Color ---
    rgb_iv :: proc(rgb: [^]i32) -> Color ---
    rgb_bv :: proc(rgb: [^]byte) -> Color ---
    rgb_f :: proc(r, g, b: f32) -> Color ---
    rgb_fv :: proc(rgb: [^]f32) -> Color ---
    rgb_cf :: proc(c: ColorF) -> Color ---
    rgb_hex :: proc(rgb: cstring) -> Color ---
    rgb_factor :: proc(col: Color, factor: f32) -> Color ---

    rgba :: proc(r, g, b, a: i32) -> Color ---
    rgba_u32 :: proc(u: u32) -> Color ---
    rgba_iv :: proc(rgba: [^]i32) -> Color ---
    rgba_bv :: proc(rgba: [^]u8) -> Color ---
    rgba_f :: proc(r, g, b, a: f32) -> Color ---
    rgba_fv :: proc(rgba: [^]f32) -> Color ---
    rgba_cf :: proc(c: ColorF) -> Color ---
    rgba_hex :: proc(rgb: cstring) -> Color ---

    hsva_colorf :: proc(h: ^f32, s, v, a: f32) -> Color ---
    hsva_colorfv :: proc(c: ^f32) -> Color ---
    colorf_hsva_f :: proc(out_h, out_s, out_v, out_a: ^f32, in_: ColorF) ---
    colorf_hsva_fv :: proc(hsva: ^f32, in_: ColorF) ---

    hsv :: proc(h, s, v: i32) -> Color ---
    hsv_iv :: proc(hsv: [^]i32) -> Color ---
    hsv_bv :: proc(hsv: [^]byte) -> Color ---
    hsv_f :: proc(h, s, v: f32) -> Color ---
    hsv_fv :: proc(hsv: [^]f32) -> Color ---

    hsva :: proc(h, s, v, a: i32) -> Color ---
    hsva_iv :: proc(hsva: [^]i32) -> Color ---
    hsva_bv :: proc(hsva: [^]byte) -> Color ---
    hsva_f :: proc(h, s, v, a: f32) -> Color ---
    hsva_fv :: proc(hsva: [^]f32) -> Color ---

    color_f :: proc(r, g, b, a: ^f32, color: Color) ---
    color_fv :: proc(rgba_out: [^]f32, color: Color) ---
    color_cf :: proc(color: Color) -> ColorF ---
    color_d :: proc(r, g, b, a: f64, color: Color) ---
    color_dv :: proc(rgba_out: [^]f64, color: Color) ---

    color_u32 :: proc(color: Color) -> u32 ---
    color_hex_rgba :: proc(output: [^]u8, color: Color) ---
    color_hex_rgb :: proc(output: [^]u8, color: Color) ---
    
    color_hsv_i :: proc(out_h, out_s, out_v: ^i32, color: Color) ---
    color_hsv_b :: proc(out_h, out_s, out_v: ^byte, color: Color) ---
    color_hsv_iv :: proc(hsv_out: [^]i32, color: Color) ---
    color_hsv_bv :: proc(hsv_out: [^]byte, color: Color) ---
    color_hsv_f :: proc(out_h, out_s, out_v: ^f32, color: Color) ---
    color_hsv_fv :: proc(hsv_out: [^]f32, color: Color) ---

    color_hsva_i :: proc(h, s, v, a: ^i32, color: Color) ---
    color_hsva_b :: proc(h, s, v, a: ^byte, color: Color) ---
    color_hsva_iv :: proc(hsva_out: ^i32, color: Color) ---
    color_hsva_bv :: proc(hsva_out: [^]byte, color: Color) ---
    color_hsva_f :: proc(out_h, out_s, out_v, out_a: ^f32, color: Color) ---
    color_hsva_fv :: proc(hsva_out: [^]f32, color: Color) ---


/* =============================================================================
 *
 *                                  IMAGE
 *
 * ============================================================================= */


    handle_ptr :: proc(ptr: rawptr) -> Handle ---
    handle_id :: proc(id: i32) -> Handle ---
    image_handle :: proc(handle: Handle) -> Image ---
    image_ptr :: proc(ptr: rawptr) -> Image ---
    image_id :: proc(id: i32) -> Image ---
    image_is_subimage :: proc(img: ^Image) -> bool ---
    subimage_ptr :: proc(ptr: rawptr, w, h: u16, sub_region: Rect) -> Image ---
    subimage_id :: proc(id: i32, w, h: u16, sub_region: Rect) -> Image ---
    subimage_handle :: proc(handle: Handle, w, h: u16, sub_region: Rect) -> Image ---


/* =============================================================================
 *
 *                                  9-SLICE
 *
 * ============================================================================= */


    nine_slice_handle :: proc(handle: Handle, l, t, r, b: u16) -> Nine_Slice ---
    nine_slice_ptr :: proc(ptr: rawptr, l, t, r, b: u16) -> Nine_Slice ---
    nine_slice_id :: proc(id: i32, l, t, r, b: u16) -> Nine_Slice ---
    nine_slice_is_sub9slice :: proc(img: ^Nine_Slice) -> i32 ---
    sub9slice_ptr :: proc(ptr: rawptr, w, h: u16, sub_region: Rect, l, t, r, b: u16) -> Nine_Slice ---
    sub9slice_id :: proc(i32, w, h: u16, sub_region: Rect, l, t, r, b: u16) -> Nine_Slice ---
    sub9slice_handle :: proc(handle: Handle, w, h: u16, sub_region: Rect, l, t, r, b: u16) -> Nine_Slice ---


/* =============================================================================
 *
 *                                  MATH
 *
 * ============================================================================= */


    murmur_hash :: proc(key: rawptr, len: i32, seed: Hash) -> Hash ---
    triangle_from_direction :: proc(result: ^Vec2, r: Rect, pad_x, pad_y: f32, heading: Heading) ---

    vec2 :: proc(x, y: f32) -> Vec2 ---
    vec2i :: proc(x, y: i32) -> Vec2 ---
    vec2v :: proc(xy: [^]f32) -> Vec2 ---
    vec2iv :: proc(xy: [^]i32) -> Vec2 ---

    get_null_rect :: proc() -> Rect ---
    rect :: proc(x, y, w, h: f32) -> Rect ---
    recti :: proc(x, y, w, h: i32) -> Rect ---
    recta :: proc(pos, size: Vec2) -> Rect ---
    rectv :: proc(xywh: [^]f32) -> Rect ---
    rectiv :: proc(xywh: [^]i32) -> Rect ---
    rect_pos :: proc(rect: Rect) -> Vec2 ---
    rect_size :: proc(rect: Rect) -> Vec2 ---


/* =============================================================================
 *
 *                                  STRING
 *
 * ============================================================================= */


    strlen :: proc(str: cstring) -> i32 ---
    stricmp :: proc(s1, s2: cstring) -> i32 ---
    stricmpn :: proc(s1, s2: cstring, n: i32) -> i32 ---
    strtoi :: proc(str: cstring, endptr: [^]cstring) -> i32 ---
    strtof :: proc(str: cstring, endptr: [^]cstring) -> f32 ---

    strfilter :: proc(text, regexp: cstring) -> i32 ---
    strmatch_fuzzy_string :: proc(str, pattern: cstring, out_score: ^i32) -> i32 ---
    strmatch_fuzzy_text :: proc(txt: cstring, txt_len: i32, pattern: cstring, out_score: ^i32) -> i32 ---


/* =============================================================================
 *
 *                                  UTF-8
 *
 * ============================================================================= */


    utf_decode :: proc(cstring, ^rune, i32) -> i32 ---
    utf_encode :: proc(rune, ^u8, i32) -> i32 ---
    utf_len :: proc(cstring, byte_len: i32) -> i32 ---
    utf_at :: proc(buffer: cstring, length, index: i32, unicode: ^rune, len: ^i32) -> cstring ---


/* ===============================================================
 *
 *                          FONT
 *
 * ===============================================================*/
/**
 * \page Font
 * Font handling in this library was designed to be quite customizable and lets
 * you decide what you want to use and what you want to provide. There are three
 * different ways to use the font atlas. The first two will use your font
 * handling scheme and only requires essential data to run nuklear. The next
 * slightly more advanced features is font handling with vertex buffer output.
 * Finally the most complex API wise is using nuklear's font baking API.
 *
 * # Using your own implementation without vertex buffer output
 *
 * So first up the easiest way to do font handling is by just providing a
 * `nk_user_font` struct which only requires the height in pixel of the used
 * font and a callback to calculate the width of a string. This way of handling
 * fonts is best fitted for using the normal draw shape command API where you
 * do all the text drawing yourself and the library does not require any kind
 * of deeper knowledge about which font handling mechanism you use.
 * IMPORTANT: the `nk_user_font` pointer provided to nuklear has to persist
 * over the complete life time! I know this sucks but it is currently the only
 * way to switch between fonts.
 *
 * ```c
 *     float your_text_width_calculation(nk_handle handle, float height, const char *text, int len)
 *     {
 *         your_font_type *type = handle.ptr;
 *         float text_width = ...;
 *         return text_width;
 *     }
 *
 *     struct nk_user_font font;
 *     font.userdata.ptr = &your_font_class_or_struct;
 *     font.height = your_font_height;
 *     font.width = your_text_width_calculation;
 *
 *     struct nk_context ctx;
 *     nk_init_default(&ctx, &font);
 * ```
 * # Using your own implementation with vertex buffer output
 *
 * While the first approach works fine if you don't want to use the optional
 * vertex buffer output it is not enough if you do. To get font handling working
 * for these cases you have to provide two additional parameters inside the
 * `nk_user_font`. First a texture atlas handle used to draw text as subimages
 * of a bigger font atlas texture and a callback to query a character's glyph
 * information (offset, size, ...). So it is still possible to provide your own
 * font and use the vertex buffer output.
 *
 * ```c
 *     float your_text_width_calculation(nk_handle handle, float height, const char *text, int len)
 *     {
 *         your_font_type *type = handle.ptr;
 *         float text_width = ...;
 *         return text_width;
 *     }
 *     void query_your_font_glyph(nk_handle handle, float font_height, struct nk_user_font_glyph *glyph, nk_rune codepoint, nk_rune next_codepoint)
 *     {
 *         your_font_type *type = handle.ptr;
 *         glyph.width = ...;
 *         glyph.height = ...;
 *         glyph.xadvance = ...;
 *         glyph.uv[0].x = ...;
 *         glyph.uv[0].y = ...;
 *         glyph.uv[1].x = ...;
 *         glyph.uv[1].y = ...;
 *         glyph.offset.x = ...;
 *         glyph.offset.y = ...;
 *     }
 *
 *     struct nk_user_font font;
 *     font.userdata.ptr = &your_font_class_or_struct;
 *     font.height = your_font_height;
 *     font.width = your_text_width_calculation;
 *     font.query = query_your_font_glyph;
 *     font.texture.id = your_font_texture;
 *
 *     struct nk_context ctx;
 *     nk_init_default(&ctx, &font);
 * ```
 *
 * # Nuklear font baker
 *
 * The final approach if you do not have a font handling functionality or don't
 * want to use it in this library is by using the optional font baker.
 * The font baker APIs can be used to create a font plus font atlas texture
 * and can be used with or without the vertex buffer output.
 *
 * It still uses the `nk_user_font` struct and the two different approaches
 * previously stated still work. The font baker is not located inside
 * `nk_context` like all other systems since it can be understood as more of
 * an extension to nuklear and does not really depend on any `nk_context` state.
 *
 * Font baker need to be initialized first by one of the nk_font_atlas_init_xxx
 * functions. If you don't care about memory just call the default version
 * `nk_font_atlas_init_default` which will allocate all memory from the standard library.
 * If you want to control memory allocation but you don't care if the allocated
 * memory is temporary and therefore can be freed directly after the baking process
 * is over or permanent you can call `nk_font_atlas_init`.
 *
 * After successfully initializing the font baker you can add Truetype(.ttf) fonts from
 * different sources like memory or from file by calling one of the `nk_font_atlas_add_xxx`.
 * functions. Adding font will permanently store each font, font config and ttf memory block(!)
 * inside the font atlas and allows to reuse the font atlas. If you don't want to reuse
 * the font baker by for example adding additional fonts you can call
 * `nk_font_atlas_cleanup` after the baking process is over (after calling nk_font_atlas_end).
 *
 * As soon as you added all fonts you wanted you can now start the baking process
 * for every selected glyph to image by calling `nk_font_atlas_bake`.
 * The baking process returns image memory, width and height which can be used to
 * either create your own image object or upload it to any graphics library.
 * No matter which case you finally have to call `nk_font_atlas_end` which
 * will free all temporary memory including the font atlas image so make sure
 * you created our texture beforehand. `nk_font_atlas_end` requires a handle
 * to your font texture or object and optionally fills a `struct nk_draw_null_texture`
 * which can be used for the optional vertex output. If you don't want it just
 * set the argument to `NULL`.
 *
 * At this point you are done and if you don't want to reuse the font atlas you
 * can call `nk_font_atlas_cleanup` to free all truetype blobs and configuration
 * memory. Finally if you don't use the font atlas and any of it's fonts anymore
 * you need to call `nk_font_atlas_clear` to free all memory still being used.
 *
 * ```c
 *     struct nk_font_atlas atlas;
 *     nk_font_atlas_init_default(&atlas);
 *     nk_font_atlas_begin(&atlas);
 *     nk_font *font = nk_font_atlas_add_from_file(&atlas, "Path/To/Your/TTF_Font.ttf", 13, 0);
 *     nk_font *font2 = nk_font_atlas_add_from_file(&atlas, "Path/To/Your/TTF_Font2.ttf", 16, 0);
 *     const void* img = nk_font_atlas_bake(&atlas, &img_width, &img_height, NK_FONT_ATLAS_RGBA32);
 *     nk_font_atlas_end(&atlas, nk_handle_id(texture), 0);
 *
 *     struct nk_context ctx;
 *     nk_init_default(&ctx, &font->handle);
 *     while (1) {
 *
 *     }
 *     nk_font_atlas_clear(&atlas);
 * ```
 * The font baker API is probably the most complex API inside this library and
 * I would suggest reading some of my examples `example/` to get a grip on how
 * to use the font atlas. There are a number of details I left out. For example
 * how to merge fonts, configure a font with `nk_font_config` to use other languages,
 * use another texture coordinate format and a lot more:
 *
 * ```c
 *     struct nk_font_config cfg = nk_font_config(font_pixel_height);
 *     cfg.merge_mode = nk_false or nk_true;
 *     cfg.range = nk_font_korean_glyph_ranges();
 *     cfg.coord_type = NK_COORD_PIXEL;
 *     nk_font *font = nk_font_atlas_add_from_file(&atlas, "Path/To/Your/TTF_Font.ttf", 13, &cfg);
 * ```
 */


    buffer_init_default :: proc(^Buffer) ---

    buffer_init :: proc(buffer: ^Buffer, allocator: ^Allocator, size: i64) ---
    buffer_init_fixed :: proc(buffer: ^Buffer, memory: rawptr, size: i64) ---
    buffer_info :: proc(status: ^Memory_Status, buffer: ^Buffer) ---
    buffer_push :: proc(buffer: ^Buffer, type: Buffer_Allocation_Type, memory: rawptr, size, align: i64) ---
    buffer_mark :: proc(buffer: ^Buffer, type: Buffer_Allocation_Type) ---
    buffer_reset :: proc(buffer: ^Buffer, type: Buffer_Allocation_Type) ---
    buffer_clear :: proc(buffer: ^Buffer) ---
    buffer_free :: proc(buffer: ^Buffer) ---
    buffer_memory :: proc(buffer: ^Buffer) -> rawptr ---
    buffer_memory_const :: proc(buffer: ^Buffer) -> rawptr ---
    buffer_total :: proc(buffer: ^Buffer) -> i64 ---


/** ==============================================================
 *
 *                          STRING
 *
 * ===============================================================*/
/**  Basic string buffer which is only used in context with the text editor
 *  to manage and manipulate dynamic or fixed size string content. This is _NOT_
 *  the default string handling method. The only instance you should have any contact
 *  with this API is if you interact with an `nk_text_edit` object inside one of the
 *  copy and paste functions and even there only for more advanced cases. */

 
    str_init_default :: proc(str: ^Str) ---

    str_init :: proc(str: ^Str, allocator: ^Allocator, size: i64) ---
    str_init_fixed :: proc(str: ^Str, memory: rawptr, size: i64) ---
    str_clear :: proc(str: ^Str) ---
    str_free :: proc(str: ^Str) ---

    str_append_text_char :: proc(str: ^Str, cstr: cstring, len: i32) ---
    str_append_str_char :: proc(str: ^Str, cstr: cstring) ---
    str_append_text_utf8 :: proc(str: ^Str, cstr: cstring, len: i32) ---
    str_append_str_utf8 :: proc(str: ^Str, cstr: cstring) ---
    str_append_text_runes :: proc(str: ^Str, runes: [^]rune, len: i32) ---
    str_append_str_runes :: proc(str: ^Str, runes: [^]rune) ---

    str_insert_at_char :: proc(str: ^Str, pos: i32, cstr: cstring, len: i32) -> i32 ---
    str_insert_at_rune :: proc(str: ^Str, pos: i32, cstr: cstring, len: i32) -> i32 ---

    str_insert_text_char :: proc(str: ^Str, pos: i32, cstr: cstring, len: i32) -> i32 ---
    str_insert_str_char :: proc(str: ^Str, pos: i32, cstr: cstring) -> i32 ---
    str_insert_text_utf8 :: proc(str: ^Str, pos: i32, cstr: cstring, len: i32) -> i32 ---
    str_insert_str_utf8 :: proc(str: ^Str, pos: i32, cstr: cstring) -> i32 ---
    str_insert_text_runes :: proc(str: ^Str, pos: i32, runes: [^]rune, len: i32) -> i32 ---
    str_insert_str_runes :: proc(str: ^Str, pos: i32, runes: [^]rune) -> i32 ---

    str_remove_chars :: proc(str: ^Str, len: i32) ---
    str_remove_runes :: proc(str: ^Str, len: i32) ---
    str_delete_chars :: proc(str: ^Str, pos: i32, len: i32) ---
    str_delete_runes :: proc(str: ^Str, pos: i32, len: i32) ---

    str_at_char :: proc(str: ^Str, pos: i32) -> cstring ---
    str_at_rune :: proc(str: ^Str, pos: i32, unicode: ^rune, len: ^i32) -> cstring ---
    str_rune_at :: proc(str: ^Str, pos: i32) -> rune ---
    str_at_char_const :: proc(str: ^Str, pos: i32) -> cstring ---
    str_at_const :: proc(str: ^Str, pos: i32, unicode: ^rune, len: ^i32) -> cstring ---

    str_get :: proc(str: ^Str) -> cstring ---
    str_get_const :: proc(str: ^Str) -> cstring ---
    str_len :: proc(str: ^Str) -> i32 ---
    str_len_char :: proc(str: ^Str) -> i32 ---

    filter_default :: proc(edit: ^Text_Edit, unicode: rune) -> bool ---
    filter_ascii :: proc(edit: ^Text_Edit, unicode: rune) -> bool ---
    filter_float :: proc(edit: ^Text_Edit, unicode: rune) -> bool ---
    filter_decimal :: proc(edit: ^Text_Edit, unicode: rune) -> bool ---
    filter_hex :: proc(edit: ^Text_Edit, unicode: rune) -> bool ---
    filter_oct :: proc(edit: ^Text_Edit, unicode: rune) -> bool ---
    filter_binary :: proc(edit: ^Text_Edit, unicode: rune) -> bool ---


/**===============================================================
 *
 *                      TEXT EDITOR
 *
 * ===============================================================*/
/**
 * \page Text Editor
 * Editing text in this library is handled by either `nk_edit_string` or
 * `nk_edit_buffer`. But like almost everything in this library there are multiple
 * ways of doing it and a balance between control and ease of use with memory
 * as well as functionality controlled by flags.
 *
 * This library generally allows three different levels of memory control:
 * First of is the most basic way of just providing a simple char array with
 * string length. This method is probably the easiest way of handling simple
 * user text input. Main upside is complete control over memory while the biggest
 * downside in comparison with the other two approaches is missing undo/redo.
 *
 * For UIs that require undo/redo the second way was created. It is based on
 * a fixed size nk_text_edit struct, which has an internal undo/redo stack.
 * This is mainly useful if you want something more like a text editor but don't want
 * to have a dynamically growing buffer.
 *
 * The final way is using a dynamically growing nk_text_edit struct, which
 * has both a default version if you don't care where memory comes from and an
 * allocator version if you do. While the text editor is quite powerful for its
 * complexity I would not recommend editing gigabytes of data with it.
 * It is rather designed for uses cases which make sense for a GUI library not for
 * an full blown text editor.
 */


    textedit_init_default :: proc(edit: ^Text_Edit) ---

    textedit_init :: proc(edit: ^Text_Edit, allocator: ^Allocator, size: i64) ---
    textedit_init_fixed :: proc(edit: ^Text_Edit, memory: rawptr, size: i64) ---
    textedit_free :: proc(edit: ^Text_Edit) ---
    textedit_text :: proc(edit: ^Text_Edit, cstr: cstring, total_len: i32) ---
    textedit_delete :: proc(edit: ^Text_Edit, where_, len: i32) ---
    textedit_delete_selection :: proc(edit: ^Text_Edit) ---
    textedit_select_all :: proc(edit: ^Text_Edit) ---
    textedit_cut :: proc(edit: ^Text_Edit) -> bool ---
    textedit_paste :: proc(edit: ^Text_Edit, cstr: cstring, len: i32) -> bool ---
    textedit_undo :: proc(edit: ^Text_Edit) ---
    textedit_redo :: proc(edit: ^Text_Edit) ---


/* ===============================================================
 *
 *                          DRAWING
 *
 * ===============================================================*/
/**
 * \page Drawing
 * This library was designed to be render backend agnostic so it does
 * not draw anything to screen. Instead all drawn shapes, widgets
 * are made of, are buffered into memory and make up a command queue.
 * Each frame therefore fills the command buffer with draw commands
 * that then need to be executed by the user and his own render backend.
 * After that the command buffer needs to be cleared and a new frame can be
 * started. It is probably important to note that the command buffer is the main
 * drawing API and the optional vertex buffer API only takes this format and
 * converts it into a hardware accessible format.
 *
 * To use the command queue to draw your own widgets you can access the
 * command buffer of each window by calling `nk_window_get_canvas` after
 * previously having called `nk_begin`:
 *
 * ```c
 *     void draw_red_rectangle_widget(struct nk_context *ctx)
 *     {
 *         struct nk_command_buffer *canvas;
 *         struct nk_input *input = &ctx->input;
 *         canvas = nk_window_get_canvas(ctx);
 *
 *         struct nk_rect space;
 *         enum nk_widget_layout_states state;
 *         state = nk_widget(&space, ctx);
 *         if (!state) return;
 *
 *         if (state != NK_WIDGET_ROM)
 *             update_your_widget_by_user_input(...);
 *         nk_fill_rect(canvas, space, 0, nk_rgb(255,0,0));
 *     }
 *
 *     if (nk_begin(...)) {
 *         nk_layout_row_dynamic(ctx, 25, 1);
 *         draw_red_rectangle_widget(ctx);
 *     }
 *     nk_end(..)
 *
 * ```
 * Important to know if you want to create your own widgets is the `nk_widget`
 * call. It allocates space on the panel reserved for this widget to be used,
 * but also returns the state of the widget space. If your widget is not seen and does
 * not have to be updated it is '0' and you can just return. If it only has
 * to be drawn the state will be `NK_WIDGET_ROM` otherwise you can do both
 * update and draw your widget. The reason for separating is to only draw and
 * update what is actually necessary which is crucial for performance.
 */

 
    stroke_line :: proc(b: ^Command_Buffer, x0, y0, x1, y1, line_thickness: f32, color: Color) ---
    stroke_curve :: proc(b: ^Command_Buffer, f1, f2, f3, f4, f5, f6, f7, f8, f9, line_thickness: f32, color: Color) ---
    stroke_rect :: proc(b: ^Command_Buffer, rect: Rect, rounding, line_thickness: f32, color: Color) ---
    stroke_circle :: proc(b: ^Command_Buffer, rect: Rect, line_thickness: f32, color: Color) ---
    stroke_arc :: proc(b: ^Command_Buffer, cx, cy, radius, a_min, a_max, line_thickness: f32, color: Color) ---
    stroke_triangle :: proc(b: ^Command_Buffer, f1, f2, f3, f4, f5, f6, line_thichness: f32, color: Color) ---
    stroke_polyline :: proc(b: ^Command_Buffer, points: [^]f32, point_count: i32, line_thickness: f32, color: Color) ---
    stroke_polygon :: proc(b: ^Command_Buffer, points: [^]f32, point_count: i32, line_thickness: f32, color: Color) ---

    fill_rect :: proc(cmd: ^Command_Buffer, rect: Rect, rounding: f32, color: Color) ---
    fill_rect_multi_color :: proc(cmd: ^Command_Buffer, rect: Rect, left, top, right, bottom: Color) ---
    fill_circle :: proc(cmd: ^Command_Buffer, rect: Rect, color: Color) ---
    fill_arc :: proc(cmd: ^Command_Buffer, cx, cy, radius, a_min, a_max: f32, color: Color) ---
    fill_triangle :: proc(cmd: ^Command_Buffer, x0, y0, x1, y1, x2, y2: f32, color: Color) ---
    fill_polygon :: proc(cmd: ^Command_Buffer, points: [^]f32, point_count: i32, color: Color) ---

    /* misc */
    draw_image :: proc(cmd: ^Command_Buffer, rect: Rect, img: ^Image, color: Color) ---
    draw_nine_slice :: proc(cmd: ^Command_Buffer, rect: Rect, slice: ^Nine_Slice, color: Color) ---
    draw_text :: proc(cmd: ^Command_Buffer, rect: Rect, text: cstring, len: i32, font: ^User_Font, color1, color2: Color) ---
    push_scissor :: proc(cmd: ^Command_Buffer, rect: Rect) ---
    push_custom :: proc(cmd: ^Command_Buffer, rect: Rect, custom: Command_Custom_Callback, usr: Handle) ---


/* ===============================================================
 *
 *                          INPUT
 *
 * ===============================================================*/


    input_has_mouse_click :: proc(input: ^Input, btn: Buttons) -> bool ---
    input_has_mouse_click_in_rect :: proc(input: ^Input, btn: Buttons, rect: Rect) -> bool ---
    input_has_mouse_click_in_button_rect :: proc(input: ^Input, btn: Buttons, rect: Rect) -> bool ---
    input_has_mouse_click_down_in_rect :: proc(input: ^Input, btn: Buttons, rect: Rect, down: bool) -> bool ---
    input_is_mouse_click_in_rect :: proc(input: ^Input, btn: Buttons, rect: Rect) -> bool ---
    input_is_mouse_click_down_in_rect :: proc(input: ^Input, btn: Buttons, rect: Rect, down: bool) -> bool ---
    input_any_mouse_click_in_rect :: proc(input: ^Input, rect: Rect) -> bool ---
    input_is_mouse_prev_hovering_rect :: proc(input: ^Input, rect: Rect) -> bool ---
    input_is_mouse_hovering_rect :: proc(input: ^Input, rect: Rect) -> bool ---
    input_mouse_clicked :: proc(input: ^Input, btn: Buttons, rect: Rect) -> bool ---
    input_is_mouse_down :: proc(input: ^Input, btn: Buttons) -> bool ---
    input_is_mouse_pressed :: proc(input: ^Input, btn: Buttons) -> bool ---
    input_is_mouse_released :: proc(input: ^Input, btn: Buttons) -> bool ---
    input_is_key_pressed :: proc(input: ^Input, key: Keys) -> bool ---
    input_is_key_released :: proc(input: ^Input, key: Keys) -> bool ---
    input_is_key_down :: proc(input: ^Input, key: Keys) -> bool ---


/* ===============================================================
 *
 *                          DRAW LIST
 *
 * ===============================================================*/


    style_item_color :: proc(color: Color) -> Style_Item ---
    style_item_image :: proc(img: Image) -> Style_Item ---
    style_item_nine_slice :: proc(slice: Nine_Slice) -> Style_Item ---
    style_item_hide :: proc() -> Style_Item ---
}

rgb_from :: proc{
    rgb,
    rgb_iv,
    rgb_bv,
    rgb_f,
    rgb_fv,
    rgb_cf,
    rgb_hex,
    rgb_factor,
}

style_item :: proc{
    style_item_color,
    style_item_image,
    style_item_nine_slice,
    style_item_hide,
}