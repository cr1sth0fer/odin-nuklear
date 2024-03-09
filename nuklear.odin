package nuklear

UNDEFINED :: -1.0

/* internal invalid utf8 rune */
UTF_INVALID : rune : 0xFFFD

/* describes the number of bytes a glyph consists of */
UTF_SIZE :: 4

INPUT_MAX :: #config(NUKLEAR_INPUT_MAX, 16)
MAX_NUMBER_BUFFER :: #config(NUKLEAR_MAX_NUMBER_BUFFER, 64)
SCROLLBAR_HIDING_TIMEOUT :: #config(NUKLEAR_SCROLLBAR_HIDING_TIMEOUT, 4.0)

Char :: rune
UChar :: u8
UByte :: u8
Short :: i16
UShort :: u16
Int :: i32
UInt :: u32
Size :: i64
Ptr :: rawptr

/// NK_INCLUDE_DEFAULT_ALLOCATOR    | If defined it will include header `<stdlib.h>` and provide additional functions to use this library without caring for memory allocation control and therefore ease memory management.
/// NK_INCLUDE_STANDARD_IO          | If defined it will include header `<stdio.h>` and provide additional functions depending on file loading.
/// NK_INCLUDE_STANDARD_VARARGS     | If defined it will include header <stdarg.h> and provide additional functions depending on file loading.
/// NK_INCLUDE_STANDARD_BOOL        | If defined it will include header `<stdbool.h>` for nk_bool otherwise nuklear defines nk_bool as int.
/// NK_INCLUDE_VERTEX_BUFFER_OUTPUT | Defining this adds a vertex draw command list backend to this library, which allows you to convert queue commands into vertex draw commands. This is mainly if you need a hardware accessible format for OpenGL, DirectX, Vulkan, Metal,...
/// NK_INCLUDE_FONT_BAKING          | Defining this adds `stb_truetype` and `stb_rect_pack` implementation to this library and provides font baking and rendering. If you already have font handling or do not want to use this font handler you don't have to define it.
/// NK_INCLUDE_DEFAULT_FONT         | Defining this adds the default font: ProggyClean.ttf into this library which can be loaded into a font atlas and allows using this library without having a truetype font
/// NK_INCLUDE_COMMAND_USERDATA     | Defining this adds a userdata pointer into each command. Can be useful for example if you want to provide custom shaders depending on the used widget. Can be combined with the style structures.
/// NK_BUTTON_TRIGGER_ON_RELEASE    | Different platforms require button clicks occurring either on buttons being pressed (up to down) or released (down to up). By default this library will react on buttons being pressed, but if you define this it will only trigger if a button is released.
/// NK_ZERO_COMMAND_MEMORY          | Defining this will zero out memory for each drawing command added to a drawing queue (inside nk_command_buffer_push). Zeroing command memory is very useful for fast checking (using memcmp) if command buffers are equal and avoid drawing frames when nothing on screen has changed since previous frame.
/// NK_UINT_DRAW_INDEX              | Defining this will set the size of vertex index elements when using NK_VERTEX_BUFFER_OUTPUT to 32bit instead of the default of 16bit
/// NK_KEYSTATE_BASED_INPUT         | Define this if your backend uses key state for each frame rather than key press/release events

Hash :: UInt
Flags :: UInt
Rune :: UInt

Color :: [4]u8
ColorF :: [4]f32
Vec2 :: [2]f32
Vec2I :: [2]Short
Rect :: struct {x, y, w, h: f32}
RectI :: struct {x, y, w, h: Short}
Handle :: struct #raw_union {ptr: rawptr, id: i32}
Image :: struct {handle: Handle, w, h: UShort, region: [4]UShort}
Nine_Slice :: struct {img: Image, l, t, r, b: UShort}
Cursor :: struct {img: Image, size, offset: Vec2}
Scroll :: struct {x, y: UInt}

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
    Horizontal
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

Plugin_Alloc :: #type proc "c" (Handle, rawptr, i64) -> rawptr
Plugin_Free :: #type proc "c" (Handle, rawptr)
Plugin_Filter :: #type proc "c" (^Text_Edit, rune) -> bool
Plugin_Paste :: #type proc "c" (Handle, ^Text_Edit)
Plugin_Copy :: #type proc "c" (Handle, cstring, i32)

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
    Max
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
    Max,
}

Buttons :: enum i32
{
    Left,
    Middle,
    Right,
    Double,
    Max,
}

Anti_Aliasing :: enum i32
{
    Off,
    On,
}

Convert_Result :: enum i32
{
    Success             = 0b0,
    Invalid_Param       = 0b1,
    Command_Buffer_Full = 0b01,
    Vertex_Buffer_Full  = 0b001,
    Element_Buffer_Full = 0b0001,
}

Draw_Null_Texture :: struct
{
    /* texture handle to a texture with a white pixel */
    texture: Handle,

    /* coordinates to a white pixel in the texture  */
    uv: Vec2,
}

Convert_Config :: struct
{
    /* global alpha value */
    global_alpha: f32,

    /* line anti-aliasing flag can be turned off if you are tight on memory */
    line_aa,

    /* shape anti-aliasing flag can be turned off if you are tight on memory */
    shape_aa: Anti_Aliasing,

    /* number of segments used for circles: default to 22 */
    circle_segment_count,

    /* number of segments used for arcs: default to 22 */
    arc_segment_count,

    /* number of segments used for curves: default to 22 */
    curve_segment_count: u32,

    /* handle to texture with a white pixel for shape drawing */
    tex_null: Draw_Null_Texture,

    /* describes the vertex output format and packing */
    vertex_layout: ^Draw_Vertex_Layout_Element,

    /* sizeof one vertex for vertex packing */
    vertex_size,

    /* vertex alignment: Can be obtained by NK_ALIGNOF */
    vertex_alignment: Size,
}

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

Widget_Align :: enum i32
{
    Left        = 0x01,
    Centered    = 0x02,
    Right       = 0x04,
    Top         = 0x08,
    Middle      = 0x10,
    Bottom      = 0x20
}

Widget_Alignment :: enum i32
{
    Left     = i32(Widget_Align.Middle | Widget_Align.Left),
    Centered = i32(Widget_Align.Middle | Widget_Align.Centered),
    Right    = i32(Widget_Align.Middle | Widget_Align.Right),
}

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

Widget_States :: enum i32
{
    Modified = 0b1,
    
    /* widget is neither active nor hovered */
    Inactive = 0b10,
    
    /* widget has been hovered on the current frame */
    Entered  = 0b100,
    
    /* widget is being hovered */
    Hover    = 0b1000,
    
    /* widget is currently activated */
    Actived  = 0b10000,
    
    /* widget is from this frame on not hovered anymore */
    Left     = 0b100000,
}

/* widget is being hovered */
WIDGET_STATE_HOVERED :: i32(Widget_States.Hover | Widget_States.Modified)

/* widget is currently activated */
WIDGET_STATE_ACTIVE  :: i32(Widget_States.Actived | Widget_States.Modified)

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

EDIT_DEFAULT :: Edit_Flags{}
EDIT_SIMPLE  :: Edit_Flags{.Always_Insert_Mode}
EDIT_FIELD  :: Edit_Flags{.Always_Insert_Mode, .Selectable, .Clipboard}
EDIT_BOX  :: Edit_Flags{.Always_Insert_Mode, .Selectable, .Multiline, .Allow_Tab, .Clipboard}
EDIT_EDITOR  :: Edit_Flags{.Selectable, .Multiline, .Allow_Tab, .Clipboard}

Edit_Event :: enum i32
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

Edit_Events :: bit_set[Edit_Event; i32]

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
Query_Font_Glyph_F :: #type proc "c" (handle: Handle, font_height: f32, glyph: ^User_Font_Glyph, codepoint, next_codepoint: rune)

User_Font_Glyph :: struct
{
    /* texture coordinates */
    uv: [2]Vec2,

    /* offset between top left and glyph */
    offset: Vec2,

    /* size of the glyph */
    width, height,

    /* offset to the next glyph */
    xadvance: f32,
}

when #config(NK_INCLUDE_VERTEX_BUFFER_OUTPUT, false) || #config(NK_INCLUDE_SOFTWARE_FONT, false)
{

}

when #config(NK_INCLUDE_VERTEX_BUFFER_OUTPUT, false)
{
    User_Font :: struct
    {
        /* user provided font handle */
        userdata: Handle,
    
        /* max height of the font */
        height: f32,
    
        /* font string width in pixel callback */
        width: Text_Width_F,
    
        /* font glyph callback to query drawing info */
        query: Query_Font_Glyph_F,

        /* texture handle to the used font atlas or texture */
        texture: Handle,
    }
}
else
{
    User_Font :: struct
    {
        /* user provided font handle */
        userdata: Handle,
    
        /* max height of the font */
        height: f32,
    
        /* font string width in pixel callback */
        width: Text_Width_F,
    }
}

when #config(NK_INCLUDE_FONT_BAKING, false)
{
    Font_Coord_Type :: enum i32
    {
        /* texture coordinates inside font glyphs are clamped between 0-1 */
        UV,

        /* texture coordinates inside font glyphs are in absolute pixel */
        Pixel,
    }

    Baked_Font :: struct
    {
        /* height of the font  */
        height: f32,

        /* font glyphs ascent and descent  */
        ascent, descent: f32,

        /* glyph array offset inside the font glyph baking output array  */
        glyph_offset: UInt,

        /* number of glyphs of this font inside the glyph baking array output */
        glyph_count: UInt,

        /* font codepoint ranges as pairs of (from/to) and 0 as last element */
        ranges: ^rune,
    };

    Font_Config :: struct
    {
        /* NOTE: only used internally */
        next: ^Font_Config,

        /* pointer to loaded TTF file memory block.
        * NOTE: not needed for nk_font_atlas_add_from_memory and nk_font_atlas_add_from_file. */
        ttf_blob: rawptr,

        /* size of the loaded TTF file memory block
        * NOTE: not needed for nk_font_atlas_add_from_memory and nk_font_atlas_add_from_file. */
        ttf_size: Size,
        
        /* used inside font atlas: default to: 0*/
        ttf_data_owned_by_atlas: u8,

        /* merges this font into the last font */
        merge_mode: u8,

        /* align every character to pixel boundary (if true set oversample (1,1)) */
        pixel_snap: u8,

        /* rasterize at high quality for sub-pixel position */
        oversample_v, oversample_h: u8,
        
        padding: [3]u8,

        /* baked pixel height of the font */
        size: f32,

        /* texture coordinate format with either pixel or UV coordinates */
        coord_type: Font_Coord_Type,

        /* extra pixel spacing between glyphs  */
        spacing: Vec2,

        /* list of unicode ranges (2 values per range, zero terminated) */
        range: ^rune,

        /* font to setup in the baking process: NOTE: not needed for font atlas */
        font: ^Baked_Font,

        /* fallback glyph to use if a given rune is not found */
        fallback_glyph: rune,

        p,
        n: ^Font_Config,
    }

    Font_Glyph :: struct
    {
        codepoint: rune,
        xadvance,
        x0, y0, x1, y1, w, h,
        u0, v0, u1, v1: f32,
    }

    Font :: struct
    {
        next: ^Font,
        handle: User_Font,
        info: Baked_Font,
        scale: f32,
        glyphs: [^]Font_Glyph,
        fallback: ^Font_Glyph,
        fallback_codepoint: rune,
        texture: Handle,
        config: ^Font_Config,
    }

    Font_Atlas_Format :: enum i32
    {
        Alpha8,
        RGBA32
    }

    Font_Atlas :: struct
    {
        pixel: rawptr,
        tex_width,
        tex_height: i32,
        
        permanent,
        temporary: Allocator,
        
        custom: RectI,
        cursors: [CURSOR_COUNT]Cursor,
        
        glyph_count: i32,
        glyphs: [^]Font_Glyph,
        default_font,
        fonts: ^Font,
        config: ^Font_Config,
        font_num: i32,
    }
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
    calls: Size,
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
    Max,
};

Buffer_Marker :: struct
{
    active: bool,
    offset: Size,
}

Memory :: struct
{
    ptr: rawptr,
    size: Size,
}

Buffer :: struct
{
    /* buffer marker to free a buffer to a certain offset */
    marker: [max(Buffer_Allocation_Type)]Buffer_Marker,

    /* allocator callback for dynamic buffers */
    pool: Allocator,

    /* memory management type */
    type: Allocation_Type,

    /* memory and size of the current memory block */
    memory: Memory,

    /* growing factor for dynamic memory management */
    grow_factor: f32,

    /* total amount of memory allocated */
    allocated: Size,

    /* totally consumed memory given that enough memory is present */
    needed: Size,

    /* number of allocation calls */
    calls: Size,

    /* current size of the buffer */
    size: Size
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
};

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
when #config(NK_INCLUDE_COMMAND_USERDATA, true)
{
    Command :: struct
    {
        type: Command_Type,
        next: Size,
        userdata: Handle,
    }
}
else
{
    Command :: struct
    {
        type: Command_Type,
        next: Size,
    }
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
    font: User_Font,
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
    base: Buffer,
    clip: Rect,
    use_clipping: i32,
    userdata: Handle,
    begin, end, last: Size,
}

Mouse_Button :: struct
{
    down: bool,
    clicked: u32,
    clicked_pos: Vec2,
}

when #config(NK_BUTTON_TRIGGER_ON_RELEASE, false)
{
    Mouse :: struct
    {
        buttons: [NK_BUTTON_MAX]mouse_button,
        pos,
        down_pos,
        prev,
        delta,
        scroll_delta: Vec2,
        grab,
        grabbed,
        ungrab: u8,
    }
}
else
{
    Mouse :: struct
    {
        buttons: [max(Buttons)]Mouse_Button,
        pos,
        prev,
        delta,
        scroll_delta: Vec2,
        grab,
        grabbed,
        ungrab: u8,
    }
}

Key :: struct
{
    down: bool,
    clicked: u32,
}

Keyboard :: struct
{
    keys: [max(Keys)]Key,
    text: [INPUT_MAX]u8,
    text_len: i32,
}

Input :: struct
{
    keyboard: Keyboard,
    mouse: Mouse,
}

when #config(NK_INCLUDE_VERTEX_BUFFER_OUTPUT, true)
{
    /* ### Draw List
    // The optional vertex buffer draw list provides a 2D drawing context
    // with antialiasing functionality which takes basic filled or outlined shapes
    // or a path and outputs vertexes, elements and draw commands.
    // The actual draw list API is not required to be used directly while using this
    // library since converting the default library draw command output is done by
    // just calling `nk_convert` but I decided to still make this library accessible
    // since it can be useful.
    // 
    // The draw list is based on a path buffering and polygon and polyline
    // rendering API which allows a lot of ways to draw 2D content to screen.
    // In fact it is probably more powerful than needed but allows even more crazy
    // things than this library provides by default.
    */
    when #config(NK_UINT_DRAW_INDEX, false) do Draw_Index :: u32
    else do Draw_Index :: u16

    Draw_List_Stroke :: enum i32
    {
        /* build up path has no connection back to the beginning */
        Open = 0,

        /* build up path has a connection back to the beginning */
        Closed = 1,
    }

    Draw_Vertex_Layout_Attribute :: enum i32
    {
        Position,
        Color,
        Texcoord,
    }

    Draw_Vertex_Layout_Format :: enum i32
    {
        SChar,
        SShort,
        SInt,
        UChar,
        UShort,
        UInt,
        Float,
        Double,
        R8G8B8,
        R16G15B16,
        R32G32B32,
        R8G8B8A8,
        B8G8R8A8,
        R16G15B16A16,
        R32G32B32A32,
        R32G32B32A32_Float,
        R32G32B32A32_Double,
        RGB32,
        RGBA32,
    }

    Draw_Vertex_Layout_Element :: struct
    {
        attribute: Draw_Vertex_Layout_Attribute,
        format: Draw_Vertex_Layout_Format,
        offset: Size,
    }

    when #config(NK_INCLUDE_COMMAND_USERDATA, true)
    {
        Draw_Command :: struct
        {
            /* number of elements in the current draw batch */
            elem_count: u32,
            
            /* current screen clipping rectangle */
            clip_rect: Rect,
            
            /* current texture to set */
            texture: Handle,
            
            userdata: Handle,
        }
    }
    else
    {
        Draw_Command :: struct
        {
            /* number of elements in the current draw batch */
            elem_count: u32,
            
            /* current screen clipping rectangle */
            clip_rect: Rect,
            
            /* current texture to set */
            texture: Handle,
        }
    }
    
    when #config(NK_INCLUDE_COMMAND_USERDATA, true)
    {   
        Draw_List :: struct
        {
            clip_rect: Rect,
            circle_vtx: [12]Vec2,
            config: Convert_Config,
            
            buffer,
            vertices,
            elements: ^Buffer,
            
            element_count,
            vertex_count,
            cmd_count: u32,
            cmd_offset: Size,
            
            path_count,
            path_offset: u32,
            
            line_aa,
            shape_aa: Anti_Aliasing,
            
            userdata: Handle,
        }
    }
    else
    {
        Draw_List :: struct
        {
            clip_rect: Rect,
            circle_vtx: [12]Vec2,
            config: Convert_Config,
            buffer,
            vertices,
            elements: ^Buffer,
            
            element_count,
            vertex_count,
            cmd_count: u32,
            cmd_offset: Size,
            
            path_count,
            path_offset: u32,
            
            line_aa,
            shape_aa: Anti_Aliasing,
        }
    }
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
    text_alignment: Flags,
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
    text_alignment: Flags,

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
    text_alignment: Flags,

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
};

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

    text: Style_Text,
    button: Style_Button,
    contextual_button: Style_Button,
    menu_button: Style_Button,
    option: Style_Toggle,
    checkbox: Style_Toggle,
    selectable: Style_Selectable,
    slider: Style_Slider,
    progress: Style_Progress,
    property: Style_Property,
    edit: Style_Edit,
    chart: Style_Chart,
    scrollh: Style_Scrollbar,
    scrollv: Style_Scrollbar,
    tab: Style_Tab,
    combo: Style_Combo,
    window: Style_Window,
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
    end: Size,
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
    flags: Flags,
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

Window_Flags :: enum i32
{
    Private       = 0b100000000000,

    /* special window type growing up in height while being filled to a certain maximum height */
    Dynamic       = 0b100000000000,

    /* sets window widgets into a read only mode and does not allow input changes */
    Rom           = 0b1000000000000,

    /* prevents all interaction caused by input to either window or widgets inside */
    Not_Interactive = i32(0b1000000000000 | 0b10000000000),

    /* Hides window and stops any window interaction and drawing */
    Hidden        = 0b10000000000000,

    /* Directly closes and frees the window at the end of the frame */
    Closed        = 0b100000000000000,

    /* marks the window as minimized */
    Minimized     = 0b100000000000000,

    /* Removes read only mode at the end of the window */
    Remove_Rom    = 0b1000000000000000,
}

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
    flags: Flags,

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

BUTTON_BEHAVIOR_STACK_SIZE :: #config(NK_BUTTON_BEHAVIOR_STACK_SIZE, 8)
FONT_STACK_SIZE :: #config(NK_FONT_STACK_SIZE, 8)
STYLE_ITEM_STACK_SIZE :: #config(NK_STYLE_ITEM_STACK_SIZE, 16)
FLOAT_STACK_SIZE :: #config(NK_FLOAT_STACK_SIZE, 32)
VECTOR_STACK_SIZE :: #config(NK_VECTOR_STACK_SIZE, 16)
FLAGS_STACK_SIZE :: #config(NK_FLAGS_STACK_SIZE, 32)
COLOR_STACK_SIZE :: #config(NK_COLOR_STACK_SIZE, 32)

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

Config_Stack_Style_Item_Element :: Config_Stack_Element(Style_Item)
Config_Stack_Float_Element :: Config_Stack_Element(f32)
Config_Stack_Vec2_Element :: Config_Stack_Element(Vec2)
Config_Stack_Flags_Element :: Config_Stack_Element(Flags)
Config_Stack_Color_Element :: Config_Stack_Element(Color)
Config_Stack_User_Font_Element :: Config_Stack_Element(User_Font)
Config_Stack_Button_Behavior_Element :: Config_Stack_Element(Button_Behavior)

Config_Stack_Style_Item :: Config_Stack(Style_Item, STYLE_ITEM_STACK_SIZE)
Config_Stack_Float :: Config_Stack(f32, FLOAT_STACK_SIZE)
Config_Stack_Vec2 :: Config_Stack(Vec2, VECTOR_STACK_SIZE)
Config_Stack_Flags :: Config_Stack(Flags, FLAGS_STACK_SIZE)
Config_Stack_Color :: Config_Stack(Color, COLOR_STACK_SIZE)
Config_Stack_User_Font :: Config_Stack(User_Font, FONT_STACK_SIZE)
Config_Stack_Button_Behavior :: Config_Stack(Button_Behavior, BUTTON_BEHAVIOR_STACK_SIZE)

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
    cap: Size,
}

INCLUDE_VERTEX_BUFFER_OUTPUT :: #config(NK_INCLUDE_VERTEX_BUFFER_OUTPUT, false)
INCLUDE_COMMAND_USERDATA :: #config(NK_INCLUDE_COMMAND_USERDATA, true)

when INCLUDE_VERTEX_BUFFER_OUTPUT && INCLUDE_COMMAND_USERDATA
{
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
        
        /*
        private:
        should only be accessed if you
        know what you are doing */
        draw_list: Draw_List,
        
        userdata: Handle,
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
}
else when INCLUDE_VERTEX_BUFFER_OUTPUT
{
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
        
        /*
        private:
        should only be accessed if you
        know what you are doing */
        draw_list: Draw_List,
        
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
}
else when INCLUDE_COMMAND_USERDATA
{
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
        
        userdata: Handle,
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
}
else
{
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
}


when ODIN_OS == .Windows && ODIN_ARCH == .amd64
{
   foreign import nuklear "nuklear_windows_amd64.lib"
}

//when ODIN_OS == .Windows && ODIN_ARCH == .amd64 && ODIN_DEBUG
//{
//    foreign import nuklear "nuklear_windows_amd64_debug.lib"
//}

@(default_calling_convention="c", link_prefix="nk_")
foreign nuklear
{
    when #config(NK_INCLUDE_DEFAULT_ALLOCATOR, false)
    {
        /*
        // #### nk_init_default
        // Initializes a `nk_context`  with a default standard library allocator.
        // Should be used if you don't want to be bothered with memory management in nuklear.
        //
        // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~c
        // bool nk_init_default(ctx: ^Context, const  nk_user_font *font);
        // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        //
        // Parameter   | Description
        // ------------|---------------------------------------------------------------
        // __ctx__     | Must point to an either stack or heap allocated `nk_context` 
        // __font__    | Must point to a previously initialized font handle for more info look at font documentation
        //
        // Returns either `false(0)` on failure or `true(1)` on success.
        //
        */
        init_default :: proc(ctx: ^Context, user_font: ^User_Font) -> bool ---
    }

    /*
    // #### nk_init_fixed
    // Initializes a `nk_context`  from single fixed size memory block
    // Should be used if you want complete control over nuklear's memory management.
    // Especially recommended for system with little memory or systems with virtual memory.
    // For the later case you can just allocate for example 16MB of virtual memory
    // and only the required amount of memory will actually be committed.
    //
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~c
    // bool nk_init_fixed(ctx: ^Context, void *memory, nk_size size, const  nk_user_font *font);
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    //
    // !!! Warning
    //     make sure the passed memory block is aligned correctly for `nk_draw_commands`.
    //
    // Parameter   | Description
    // ------------|--------------------------------------------------------------
    // __ctx__     | Must point to an either stack or heap allocated `nk_context` 
    // __memory__  | Must point to a previously allocated memory block
    // __size__    | Must contain the total size of __memory__
    // __font__    | Must point to a previously initialized font handle for more info look at font documentation
    //
    // Returns either `false(0)` on failure or `true(1)` on success.
    */
    init_fixed :: proc(ctx: ^Context, memory: rawptr, size: i64, user_font: ^User_Font) -> bool ---

    /*
    // #### nk_init
    // Initializes a `nk_context`  with memory allocation callbacks for nuklear to allocate
    // memory from. Used internally for `nk_init_default` and provides a kitchen sink allocation
    // interface to nuklear. Can be useful for cases like monitoring memory consumption.
    //
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~c
    // bool nk_init(ctx: ^Context,  nk_allocator *alloc, const  nk_user_font *font);
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    //
    // Parameter   | Description
    // ------------|---------------------------------------------------------------
    // __ctx__     | Must point to an either stack or heap allocated `nk_context` 
    // __alloc__   | Must point to a previously allocated memory allocator
    // __font__    | Must point to a previously initialized font handle for more info look at font documentation
    //
    // Returns either `false(0)` on failure or `true(1)` on success.
    */
    init :: proc(ctx: ^Context, allocator: ^Allocator, user_font: ^User_Font) -> bool ---

    /*
    // #### nk_init_custom
    // Initializes a `nk_context`  from two different either fixed or growing
    // buffers. The first buffer is for allocating draw commands while the second buffer is
    // used for allocating windows, panels and state tables.
    //
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~c
    // bool nk_init_custom(ctx: ^Context,  nk_buffer *cmds,  nk_buffer *pool, const  nk_user_font *font);
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    //
    // Parameter   | Description
    // ------------|---------------------------------------------------------------
    // __ctx__     | Must point to an either stack or heap allocated `nk_context` 
    // __cmds__    | Must point to a previously initialized memory buffer either fixed or dynamic to store draw commands into
    // __pool__    | Must point to a previously initialized memory buffer either fixed or dynamic to store windows, panels and tables
    // __font__    | Must point to a previously initialized font handle for more info look at font documentation
    //
    // Returns either `false(0)` on failure or `true(1)` on success.
    */
    init_custom :: proc(ctx: ^Context, cmds: ^Buffer, pool: ^Buffer, user_font: ^User_Font) -> bool ---
    
    /*
    // #### nk_clear
    // Resets the context state at the end of the frame. This includes mostly
    // garbage collector tasks like removing windows or table not called and therefore
    // used anymore.
    //
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~c
    // void nk_clear(ctx: ^Context);
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    //
    // Parameter   | Description
    // ------------|-----------------------------------------------------------
    // __ctx__     | Must point to a previously initialized `nk_context` 
    */
    clear :: proc(ctx: ^Context) ---

    /*
    // #### nk_free
    // Frees all memory allocated by nuklear. Not needed if context was
    // initialized with `nk_init_fixed`.
    //
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~c
    // void nk_free(ctx: ^Context);
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    //
    // Parameter   | Description
    // ------------|-----------------------------------------------------------
    // __ctx__     | Must point to a previously initialized `nk_context` 
    */
    free :: proc(ctx: ^Context) ---

    when #config(NK_INCLUDE_COMMAND_USERDATA, true)
    {
        /*
        // #### nk_set_user_data
        // Sets the currently passed userdata passed down into each draw command.
        //
        // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~c
        // void nk_set_user_data(ctx: ^Context, nk_handle data);
        // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        //
        // Parameter   | Description
        // ------------|--------------------------------------------------------------
        // __ctx__     | Must point to a previously initialized `nk_context` 
        // __data__    | Handle with either pointer or index to be passed into every draw commands
        */
        set_user_data :: proc(ctx: ^Context, handle: Handle) ---
    }

    when #config(NK_INCLUDE_COMMAND_USERDATA, true)
    {
        /*
        // #### nk_set_user_data
        // Sets the currently passed userdata passed down into each draw command.
        //
        // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~c
        // void nk_set_user_data(ctx: ^Context, nk_handle data);
        // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        //
        // Parameter   | Description
        // ------------|--------------------------------------------------------------
        // __ctx__     | Must point to a previously initialized `nk_context` 
        // __data__    | Handle with either pointer or index to be passed into every draw commands
        */
        //set_user_data :: proc(ctx: ^Context, handle: Handle) ---
    }

    /*
    // #### nk_input_begin
    // Begins the input mirroring process by resetting text, scroll
    // mouse, previous mouse position and movement as well as key state transitions,
    //
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~c
    // void nk_input_begin(ctx: ^Context);
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    //
    // Parameter   | Description
    // ------------|-----------------------------------------------------------
    // __ctx__     | Must point to a previously initialized `nk_context` 
    */
    input_begin :: proc(ctx: ^Context) ---

    /*
    // #### nk_input_motion
    // Mirrors current mouse position to nuklear
    //
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~c
    // void nk_input_motion(ctx: ^Context, i32 x, i32 y);
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    //
    // Parameter   | Description
    // ------------|-----------------------------------------------------------
    // __ctx__     | Must point to a previously initialized `nk_context` 
    // __x__       | Must hold an integer describing the current mouse cursor x-position
    // __y__       | Must hold an integer describing the current mouse cursor y-position
    */
    input_motion :: proc(ctx: ^Context, x, y: i32) ---
    
    /*
    // #### nk_input_key
    // Mirrors the state of a specific key to nuklear
    //
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~c
    // void nk_input_key(ctx: ^Context, nk_keys key, bool down);
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    //
    // Parameter   | Description
    // ------------|-----------------------------------------------------------
    // __ctx__     | Must point to a previously initialized `nk_context` 
    // __key__     | Must be any value specified in `nk_keys` that needs to be mirrored
    // __down__    | Must be 0 for key is up and 1 for key is down
    */
    input_key :: proc(ctx: ^Context, Keys, down: bool) ---

    /*
    // #### nk_input_button
    // Mirrors the state of a specific mouse button to nuklear
    //
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~c
    // void nk_input_button(ctx: ^Context, nk_buttons btn, i32 x, i32 y, bool down);
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    //
    // Parameter   | Description
    // ------------|-----------------------------------------------------------
    // __ctx__     | Must point to a previously initialized `nk_context` 
    // __btn__     | Must be any value specified in `nk_buttons` that needs to be mirrored
    // __x__       | Must contain an integer describing mouse cursor x-position on click up/down
    // __y__       | Must contain an integer describing mouse cursor y-position on click up/down
    // __down__    | Must be 0 for key is up and 1 for key is down
    */
    input_button :: proc(ctx: ^Context, Buttons, x, y, down: bool) ---

    /*
    // #### nk_input_scroll
    // Copies the last mouse scroll value to nuklear. Is generally
    // a scroll value. So does not have to come from mouse and could also originate
    // TODO finish this sentence
    //
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~c
    // void nk_input_scroll(ctx: ^Context, Vec2 val);
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    //
    // Parameter   | Description
    // ------------|-----------------------------------------------------------
    // __ctx__     | Must point to a previously initialized `nk_context` 
    // __val__     | vector with both X- as well as Y-scroll value
    */
    input_scroll :: proc(ctx: ^Context, val: Vec2) ---

    /*
    // #### nk_input_char
    // Copies a single ASCII character into an internal text buffer
    // This is basically a helper function to quickly push ASCII characters into
    // nuklear.
    //
    // !!! Note
    //     Stores up to NK_INPUT_MAX bytes between `nk_input_begin` and `nk_input_end`.
    //
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~c
    // void nk_input_char(ctx: ^Context, char c);
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    //
    // Parameter   | Description
    // ------------|-----------------------------------------------------------
    // __ctx__     | Must point to a previously initialized `nk_context` 
    // __c__       | Must be a single ASCII character preferable one that can be printed
    */
    input_char :: proc(ctx: ^Context, char_: u8) ---

    /*
    // #### nk_input_glyph
    // Converts an encoded unicode rune into UTF-8 and copies the result into an
    // internal text buffer.
    //
    // !!! Note
    //     Stores up to NK_INPUT_MAX bytes between `nk_input_begin` and `nk_input_end`.
    //
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~c
    // void nk_input_glyph(ctx: ^Context, const nk_glyph g);
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    //
    // Parameter   | Description
    // ------------|-----------------------------------------------------------
    // __ctx__     | Must point to a previously initialized `nk_context` 
    // __g__       | UTF-32 unicode codepoint
    */
    input_glyph :: proc(ctx: ^Context, codepoint: rune) ---

    /*
    // #### nk_input_unicode
    // Converts a unicode rune into UTF-8 and copies the result
    // into an internal text buffer.
    // !!! Note
    //     Stores up to NK_INPUT_MAX bytes between `nk_input_begin` and `nk_input_end`.
    //
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~c
    // void nk_input_unicode(ctx: ^Context, nk_rune rune);
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    //
    // Parameter   | Description
    // ------------|-----------------------------------------------------------
    // __ctx__     | Must point to a previously initialized `nk_context` 
    // __rune__    | UTF-32 unicode codepoint
    */
    input_unicode :: proc(ctx: ^Context, codepoint: rune) ---

    /*
    // #### nk_input_end
    // End the input mirroring process by resetting mouse grabbing
    // state to ensure the mouse cursor is not grabbed indefinitely.
    //
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~c
    // void nk_input_end(ctx: ^Context);
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    //
    // Parameter   | Description
    // ------------|-----------------------------------------------------------
    // __ctx__     | Must point to a previously initialized `nk_context` 
    */
    input_end :: proc(ctx: ^Context) ---

    /*
    // #### nk__begin
    // Returns a draw command list iterator to iterate all draw
    // commands accumulated over one frame.
    //
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~c
    // const  nk_command* nk__begin(ctx: ^Context);
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    //
    // Parameter   | Description
    // ------------|-----------------------------------------------------------
    // __ctx__     | must point to an previously initialized `nk_context`  at the end of a frame
    //
    // Returns draw command pointer pointing to the first command inside the draw command list
    */
    _begin :: proc(ctx: ^Context) -> ^Command ---

    /*
    // #### nk__next
    // Returns draw command pointer pointing to the next command inside the draw command list
    //
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~c
    // const  nk_command* nk__next(ctx: ^Context, const  nk_command*);
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    //
    // Parameter   | Description
    // ------------|-----------------------------------------------------------
    // __ctx__     | Must point to an previously initialized `nk_context`  at the end of a frame
    // __cmd__     | Must point to an previously a draw command either returned by `nk__begin` or `nk__next`
    //
    // Returns draw command pointer pointing to the next command inside the draw command list
    */
    _next :: proc(ctx: ^Context, cmd: ^Command) -> ^Command ---

    // /*
    // // #### nk_foreach
    // // Iterates over each draw command inside the context draw command list
    // //
    // // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~c
    // // #define nk_foreach(c, ctx)
    // // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    // //
    // // Parameter   | Description
    // // ------------|-----------------------------------------------------------
    // // __ctx__     | Must point to an previously initialized `nk_context`  at the end of a frame
    // // __cmd__     | Command pointer initialized to NULL
    // //
    // // Iterates over each draw command inside the context draw command list
    // */
    // #define nk_foreach(c, ctx) for((c) = nk__begin(ctx); (c) != 0; (c) = nk__next(ctx,c))

    when #config(NK_INCLUDE_VERTEX_BUFFER_OUTPUT, false)
    {
        /*
        // #### nk_convert
        // Converts all internal draw commands into vertex draw commands and fills
        // three buffers with vertexes, vertex draw commands and vertex indices. The vertex format
        // as well as some other configuration values have to be configured by filling out a
        // `nk_convert_config` .
        //
        // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~c
        // Flags nk_convert(ctx: ^Context,  nk_buffer *cmds,
        //      nk_buffer *vertices,  nk_buffer *elements, const  nk_convert_config*);
        // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        //
        // Parameter   | Description
        // ------------|-----------------------------------------------------------
        // __ctx__     | Must point to an previously initialized `nk_context`  at the end of a frame
        // __cmds__    | Must point to a previously initialized buffer to hold converted vertex draw commands
        // __vertices__| Must point to a previously initialized buffer to hold all produced vertices
        // __elements__| Must point to a previously initialized buffer to hold all produced vertex indices
        // __config__  | Must point to a filled out `nk_config`  to configure the conversion process
        //
        // Returns one of nk_convert_result error codes
        //
        // Parameter                       | Description
        // --------------------------------|-----------------------------------------------------------
        // NK_CONVERT_SUCCESS              | Signals a successful draw command to vertex buffer conversion
        // NK_CONVERT_INVALID_PARAM        | An invalid argument was passed in the function call
        // NK_CONVERT_COMMAND_BUFFER_FULL  | The provided buffer for storing draw commands is full or failed to allocate more memory
        // NK_CONVERT_VERTEX_BUFFER_FULL   | The provided buffer for storing vertices is full or failed to allocate more memory
        // NK_CONVERT_ELEMENT_BUFFER_FULL  | The provided buffer for storing indices is full or failed to allocate more memory
        */
        convert :: proc(ctx: ^Context, cmds, vertices, elements: ^Buffer, cfg: ^Convert_Config) -> Flags ---
        
        /*
        // #### nk__draw_begin
        // Returns a draw vertex command buffer iterator to iterate over the vertex draw command buffer
        //
        // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~c
        // const  nk_draw_command* nk__draw_begin(const ^Context, const  nk_buffer*);
        // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        //
        // Parameter   | Description
        // ------------|-----------------------------------------------------------
        // __ctx__     | Must point to an previously initialized `nk_context`  at the end of a frame
        // __buf__     | Must point to an previously by `nk_convert` filled out vertex draw command buffer
        //
        // Returns vertex draw command pointer pointing to the first command inside the vertex draw command buffer
        */
        _draw_begin :: proc(ctx: ^Context, buf: ^Buffer) -> ^Draw_Command ---
        
        /*
        // #### nk__draw_end
        // Returns the vertex draw command at the end of the vertex draw command buffer
        //
        // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~c
        // const  nk_draw_command* nk__draw_end(const ctx: ^Context, const  nk_buffer *buf);
        // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        //
        // Parameter   | Description
        // ------------|-----------------------------------------------------------
        // __ctx__     | Must point to an previously initialized `nk_context`  at the end of a frame
        // __buf__     | Must point to an previously by `nk_convert` filled out vertex draw command buffer
        //
        // Returns vertex draw command pointer pointing to the end of the last vertex draw command inside the vertex draw command buffer
        */
        _draw_end :: proc(ctx: ^Context, buf: ^Buffer) -> ^Draw_Command ---

        /*
        // #### nk__draw_next
        // Increments the vertex draw command buffer iterator
        //
        // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~c
        // const  nk_draw_command* nk__draw_next(const  nk_draw_command*, const  nk_buffer*, const ^Context);
        // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        //
        // Parameter   | Description
        // ------------|-----------------------------------------------------------
        // __cmd__     | Must point to an previously either by `nk__draw_begin` or `nk__draw_next` returned vertex draw command
        // __buf__     | Must point to an previously by `nk_convert` filled out vertex draw command buffer
        // __ctx__     | Must point to an previously initialized `nk_context`  at the end of a frame
        //
        // Returns vertex draw command pointer pointing to the end of the last vertex draw command inside the vertex draw command buffer
        */
        _draw_next :: proc(^Draw_Command, ^Buffer, ^Context) -> ^Draw_Command ---
        
        /*
        // #### nk_draw_foreach
        // Iterates over each vertex draw command inside a vertex draw command buffer
        //
        // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~c
        // #define nk_draw_foreach(cmd,ctx, b)
        // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        //
        // Parameter   | Description
        // ------------|-----------------------------------------------------------
        // __cmd__     | `nk_draw_command`iterator set to NULL
        // __buf__     | Must point to an previously by `nk_convert` filled out vertex draw command buffer
        // __ctx__     | Must point to an previously initialized `nk_context`  at the end of a frame
        #define nk_draw_foreach(cmd,ctx, b) for((cmd)=nk__draw_begin(ctx, b); (cmd)!=0; (cmd)=nk__draw_next(cmd, b, ctx))
        */
    }

    /*
    // #### nk_begin
    // Starts a new window; needs to be called every frame for every
    // window (unless hidden) or otherwise the window gets removed
    //
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~c
    // bool nk_begin(ctx: ^Context, title: cstring, bounds: Rect, flags: Flags);
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    //
    // Parameter   | Description
    // ------------|-----------------------------------------------------------
    // __ctx__     | Must point to an previously initialized `nk_context` 
    // __title__   | Window title and identifier. Needs to be persistent over frames to identify the window
    // __bounds__  | Initial position and window size. However if you do not define `NK_WINDOW_SCALABLE` or `NK_WINDOW_MOVABLE` you can set window position and size every frame
    // __flags__   | Window flags defined in the nk_panel_flags section with a number of different window behaviors
    //
    // Returns `true(1)` if the window can be filled up with widgets from this point
    // until `nk_end` or `false(0)` otherwise for example if minimized
    */
    begin :: proc(ctx: ^Context, title: cstring, bounds: Rect, flags: Panel_Flags) -> bool ---

    /*
    // #### nk_begin_titled
    // Extended window start with separated title and identifier to allow multiple
    // windows with same title but not name
    //
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~c
    // bool nk_begin_titled(ctx: ^Context, name: cstring, title: cstring, bounds: Rect, flags: Flags);
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    //
    // Parameter   | Description
    // ------------|-----------------------------------------------------------
    // __ctx__     | Must point to an previously initialized `nk_context` 
    // __name__    | Window identifier. Needs to be persistent over frames to identify the window
    // __title__   | Window title displayed inside header if flag `NK_WINDOW_TITLE` or either `NK_WINDOW_CLOSABLE` or `NK_WINDOW_MINIMIZED` was set
    // __bounds__  | Initial position and window size. However if you do not define `NK_WINDOW_SCALABLE` or `NK_WINDOW_MOVABLE` you can set window position and size every frame
    // __flags__   | Window flags defined in the nk_panel_flags section with a number of different window behaviors
    //
    // Returns `true(1)` if the window can be filled up with widgets from this point
    // until `nk_end` or `false(0)` otherwise for example if minimized
    */
    begin_titled :: proc(ctx: ^Context, name: cstring, title: cstring, bounds: Rect, flags: Panel_Flags) -> bool ---

    /*
    // #### nk_end
    // Needs to be called at the end of the window building process to process scaling, scrollbars and general cleanup.
    // All widget calls after this functions will result in asserts or no state changes
    //
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~c
    // void nk_end(ctx: ^Context);
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    //
    // Parameter   | Description
    // ------------|-----------------------------------------------------------
    // __ctx__     | Must point to an previously initialized `nk_context` 
    */
    end :: proc(ctx: ^Context) ---

    /*
    // #### nk_window_find
    // Finds and returns a window from passed name
    //
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~c
    //  nk_window *nk_window_find(ctx: ^Context, name: cstring);
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    //
    // Parameter   | Description
    // ------------|-----------------------------------------------------------
    // __ctx__     | Must point to an previously initialized `nk_context` 
    // __name__    | Window identifier
    //
    // Returns a `nk_window`  pointing to the identified window or NULL if
    // no window with the given name was found
    */
    window_find :: proc(ctx: ^Context, name: cstring) -> ^Window ---

    /*
    // #### nk_window_get_bounds
    // Returns a rectangle with screen position and size of the currently processed window
    //
    // !!! WARNING
    //     Only call this function between calls `nk_begin_xxx` and `nk_end`
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~c
    // Rect nk_window_get_bounds(const ctx: ^Context);
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    //
    // Parameter   | Description
    // ------------|-----------------------------------------------------------
    // __ctx__     | Must point to an previously initialized `nk_context` 
    //
    // Returns a `Rect`  with window upper left window position and size
    */
    window_get_bounds :: proc(ctx: ^Context) -> Rect ---

    /*
    // #### nk_window_get_position
    // Returns the position of the currently processed window.
    //
    // !!! WARNING
    //     Only call this function between calls `nk_begin_xxx` and `nk_end`
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~c
    // Vec2 nk_window_get_position(const ctx: ^Context);
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    //
    // Parameter   | Description
    // ------------|-----------------------------------------------------------
    // __ctx__     | Must point to an previously initialized `nk_context` 
    //
    // Returns a `Vec2`  with window upper left position
    */
    window_get_position :: proc(ctx: ^Context) -> Vec2 ---

    /*
    // #### nk_window_get_size
    // Returns the size with width and height of the currently processed window.
    //
    // !!! WARNING
    //     Only call this function between calls `nk_begin_xxx` and `nk_end`
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~c
    // Vec2 nk_window_get_size(const ctx: ^Context);
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    //
    // Parameter   | Description
    // ------------|-----------------------------------------------------------
    // __ctx__     | Must point to an previously initialized `nk_context` 
    //
    // Returns a `Vec2`  with window width and height
    */
    window_get_size :: proc(ctx: ^Context) -> Vec2 ---

    /*
    // #### nk_window_get_width
    // Returns the width of the currently processed window.
    //
    // !!! WARNING
    //     Only call this function between calls `nk_begin_xxx` and `nk_end`
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~c
    // f32 nk_window_get_width(const ctx: ^Context);
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    //
    // Parameter   | Description
    // ------------|-----------------------------------------------------------
    // __ctx__     | Must point to an previously initialized `nk_context` 
    //
    // Returns the current window width
    */
    window_get_width :: proc(ctx: ^Context) -> f32 ---

    /*
    // #### nk_window_get_height
    // Returns the height of the currently processed window.
    //
    // !!! WARNING
    //     Only call this function between calls `nk_begin_xxx` and `nk_end`
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~c
    // f32 nk_window_get_height(const ctx: ^Context);
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    //
    // Parameter   | Description
    // ------------|-----------------------------------------------------------
    // __ctx__     | Must point to an previously initialized `nk_context` 
    //
    // Returns the current window height
    */
    window_get_height :: proc(ctx: ^Context) -> f32 ---

    /*
    // #### nk_window_get_panel
    // Returns the underlying panel which contains all processing state of the current window.
    //
    // !!! WARNING
    //     Only call this function between calls `nk_begin_xxx` and `nk_end`
    // !!! WARNING
    //     Do not keep the returned panel pointer around, it is only valid until `nk_end`
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~c
    //  nk_panel* nk_window_get_panel(ctx: ^Context);
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    //
    // Parameter   | Description
    // ------------|-----------------------------------------------------------
    // __ctx__     | Must point to an previously initialized `nk_context` 
    //
    // Returns a pointer to window internal `nk_panel` state.
    */
    window_get_panel :: proc(ctx: ^Context) -> ^Panel ---

    /*
    // #### nk_window_get_content_region
    // Returns the position and size of the currently visible and non-clipped space
    // inside the currently processed window.
    //
    // !!! WARNING
    //     Only call this function between calls `nk_begin_xxx` and `nk_end`
    //
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~c
    // Rect nk_window_get_content_region(ctx: ^Context);
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    //
    // Parameter   | Description
    // ------------|-----------------------------------------------------------
    // __ctx__     | Must point to an previously initialized `nk_context` 
    //
    // Returns `Rect`  with screen position and size (no scrollbar offset)
    // of the visible space inside the current window
    */
    window_get_content_region :: proc(ctx: ^Context) -> Rect ---

    /*
    // #### nk_window_get_content_region_min
    // Returns the upper left position of the currently visible and non-clipped
    // space inside the currently processed window.
    //
    // !!! WARNING
    //     Only call this function between calls `nk_begin_xxx` and `nk_end`
    //
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~c
    // Vec2 nk_window_get_content_region_min(ctx: ^Context);
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    //
    // Parameter   | Description
    // ------------|-----------------------------------------------------------
    // __ctx__     | Must point to an previously initialized `nk_context` 
    //
    // returns `Vec2`  with  upper left screen position (no scrollbar offset)
    // of the visible space inside the current window
    */
    window_get_content_region_min :: proc(ctx: ^Context) -> Vec2 ---

    /*
    // #### nk_window_get_content_region_max
    // Returns the lower right screen position of the currently visible and
    // non-clipped space inside the currently processed window.
    //
    // !!! WARNING
    //     Only call this function between calls `nk_begin_xxx` and `nk_end`
    //
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~c
    // Vec2 nk_window_get_content_region_max(ctx: ^Context);
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    //
    // Parameter   | Description
    // ------------|-----------------------------------------------------------
    // __ctx__     | Must point to an previously initialized `nk_context` 
    //
    // Returns `Vec2`  with lower right screen position (no scrollbar offset)
    // of the visible space inside the current window
    */
    window_get_content_region_max :: proc(ctx: ^Context) -> Vec2 ---

    /*
    // #### nk_window_get_content_region_size
    // Returns the size of the currently visible and non-clipped space inside the
    // currently processed window
    //
    // !!! WARNING
    //     Only call this function between calls `nk_begin_xxx` and `nk_end`
    //
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~c
    // Vec2 nk_window_get_content_region_size(ctx: ^Context);
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    //
    // Parameter   | Description
    // ------------|-----------------------------------------------------------
    // __ctx__     | Must point to an previously initialized `nk_context` 
    //
    // Returns `Vec2`  with size the visible space inside the current window
    */
    window_get_content_region_size :: proc(ctx: ^Context) -> Vec2 ---

    /*
    // #### nk_window_get_canvas
    // Returns the draw command buffer. Can be used to draw custom widgets
    // !!! WARNING
    //     Only call this function between calls `nk_begin_xxx` and `nk_end`
    // !!! WARNING
    //     Do not keep the returned command buffer pointer around it is only valid until `nk_end`
    //
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~c
    //  nk_command_buffer* nk_window_get_canvas(ctx: ^Context);
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    //
    // Parameter   | Description
    // ------------|-----------------------------------------------------------
    // __ctx__     | Must point to an previously initialized `nk_context` 
    //
    // Returns a pointer to window internal `nk_command_buffer`  used as
    // drawing canvas. Can be used to do custom drawing.
    */
    window_get_canvas :: proc(ctx: ^Context) -> ^Command_Buffer ---

    /*
    // #### nk_window_get_scroll
    // Gets the scroll offset for the current window
    // !!! WARNING
    //     Only call this function between calls `nk_begin_xxx` and `nk_end`
    //
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~c
    // void nk_window_get_scroll(ctx: ^Context, nk_uint *offset_x, nk_uint *offset_y);
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    //
    // Parameter    | Description
    // -------------|-----------------------------------------------------------
    // __ctx__      | Must point to an previously initialized `nk_context` 
    // __offset_x__ | A pointer to the x offset output (or NULL to ignore)
    // __offset_y__ | A pointer to the y offset output (or NULL to ignore)
    */
    window_get_scroll :: proc(ctx: ^Context, offset_x, offset_y: ^u32) ---

    /*
    // #### nk_window_has_focus
    // Returns if the currently processed window is currently active
    // !!! WARNING
    //     Only call this function between calls `nk_begin_xxx` and `nk_end`
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~c
    // bool nk_window_has_focus(const ctx: ^Context);
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    //
    // Parameter   | Description
    // ------------|-----------------------------------------------------------
    // __ctx__     | Must point to an previously initialized `nk_context` 
    //
    // Returns `false(0)` if current window is not active or `true(1)` if it is
    */
    window_has_focus :: proc(ctx: ^Context) -> bool ---

    /*
    // #### nk_window_is_hovered
    // Return if the current window is being hovered
    // !!! WARNING
    //     Only call this function between calls `nk_begin_xxx` and `nk_end`
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~c
    // bool nk_window_is_hovered(ctx: ^Context);
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    //
    // Parameter   | Description
    // ------------|-----------------------------------------------------------
    // __ctx__     | Must point to an previously initialized `nk_context` 
    //
    // Returns `true(1)` if current window is hovered or `false(0)` otherwise
    */
    window_is_hovered :: proc(ctx: ^Context) -> bool ---

    /*
    // #### nk_window_is_collapsed
    // Returns if the window with given name is currently minimized/collapsed
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~c
    // bool nk_window_is_collapsed(ctx: ^Context, name: cstring);
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    //
    // Parameter   | Description
    // ------------|-----------------------------------------------------------
    // __ctx__     | Must point to an previously initialized `nk_context` 
    // __name__    | Identifier of window you want to check if it is collapsed
    //
    // Returns `true(1)` if current window is minimized and `false(0)` if window not
    // found or is not minimized
    */
    window_is_collapsed :: proc(ctx: ^Context, name: cstring) -> bool ---

    /*
    // #### nk_window_is_closed
    // Returns if the window with given name was closed by calling `nk_close`
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~c
    // bool nk_window_is_closed(ctx: ^Context, name: cstring);
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    //
    // Parameter   | Description
    // ------------|-----------------------------------------------------------
    // __ctx__     | Must point to an previously initialized `nk_context` 
    // __name__    | Identifier of window you want to check if it is closed
    //
    // Returns `true(1)` if current window was closed or `false(0)` window not found or not closed
    */
    window_is_closed :: proc(ctx: ^Context, name: cstring) -> bool ---

    /*
    // #### nk_window_is_hidden
    // Returns if the window with given name is hidden
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~c
    // bool nk_window_is_hidden(ctx: ^Context, name: cstring);
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    //
    // Parameter   | Description
    // ------------|-----------------------------------------------------------
    // __ctx__     | Must point to an previously initialized `nk_context` 
    // __name__    | Identifier of window you want to check if it is hidden
    //
    // Returns `true(1)` if current window is hidden or `false(0)` window not found or visible
    */
    window_is_hidden :: proc(ctx: ^Context, name: cstring) -> bool ---

    /*
    // #### nk_window_is_active
    // Same as nk_window_has_focus for some reason
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~c
    // bool nk_window_is_active(ctx: ^Context, name: cstring);
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    //
    // Parameter   | Description
    // ------------|-----------------------------------------------------------
    // __ctx__     | Must point to an previously initialized `nk_context` 
    // __name__    | Identifier of window you want to check if it is active
    //
    // Returns `true(1)` if current window is active or `false(0)` window not found or not active
    */
    window_is_active :: proc(ctx: ^Context, name: cstring) -> bool ---

    /*
    // #### nk_window_is_any_hovered
    // Returns if the any window is being hovered
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~c
    // bool nk_window_is_any_hovered(ctx: ^Context);
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    //
    // Parameter   | Description
    // ------------|-----------------------------------------------------------
    // __ctx__     | Must point to an previously initialized `nk_context` 
    //
    // Returns `true(1)` if any window is hovered or `false(0)` otherwise
    */
    window_is_any_hovered :: proc(ctx: ^Context) -> bool ---

    /*
    // #### nk_item_is_any_active
    // Returns if the any window is being hovered or any widget is currently active.
    // Can be used to decide if input should be processed by UI or your specific input handling.
    // Example could be UI and 3D camera to move inside a 3D space.
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~c
    // bool nk_item_is_any_active(ctx: ^Context);
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    //
    // Parameter   | Description
    // ------------|-----------------------------------------------------------
    // __ctx__     | Must point to an previously initialized `nk_context` 
    //
    // Returns `true(1)` if any window is hovered or any item is active or `false(0)` otherwise
    */
    item_is_any_active :: proc(ctx: ^Context) -> bool ---

    /*
    // #### nk_window_set_bounds
    // Updates position and size of window with passed in name
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~c
    // void nk_window_set_bounds(ctx: ^Context, name: cstring, bounds: Rect);
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    //
    // Parameter   | Description
    // ------------|-----------------------------------------------------------
    // __ctx__     | Must point to an previously initialized `nk_context` 
    // __name__    | Identifier of the window to modify both position and size
    // __bounds__  | Must point to a `Rect`  with the new position and size
    */
    window_set_bounds :: proc(ctx: ^Context, name: cstring, bounds: Rect) ---

    /*
    // #### nk_window_set_position
    // Updates position of window with passed name
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~c
    // void nk_window_set_position(ctx: ^Context, name: cstring, pos: Vec2);
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    //
    // Parameter   | Description
    // ------------|-----------------------------------------------------------
    // __ctx__     | Must point to an previously initialized `nk_context` 
    // __name__    | Identifier of the window to modify both position
    // __pos__     | Must point to a `Vec2`  with the new position
    */
    window_set_position :: proc(ctx: ^Context, name: cstring, pos: Vec2) ---

    /*
    // #### nk_window_set_size
    // Updates size of window with passed in name
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~c
    // void nk_window_set_size(ctx: ^Context, name: cstring, Vec2);
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    //
    // Parameter   | Description
    // ------------|-----------------------------------------------------------
    // __ctx__     | Must point to an previously initialized `nk_context` 
    // __name__    | Identifier of the window to modify both window size
    // __size__    | Must point to a `Vec2`  with new window size
    */
    window_set_size :: proc(ctx: ^Context, name: cstring, size: Vec2) ---

    /*
    // #### nk_window_set_focus
    // Sets the window with given name as active
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~c
    // void nk_window_set_focus(ctx: ^Context, name: cstring);
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    //
    // Parameter   | Description
    // ------------|-----------------------------------------------------------
    // __ctx__     | Must point to an previously initialized `nk_context` 
    // __name__    | Identifier of the window to set focus on
    */
    window_set_focus :: proc(ctx: ^Context, name: cstring) ---

    /*
    // #### nk_window_set_scroll
    // Sets the scroll offset for the current window
    // !!! WARNING
    //     Only call this function between calls `nk_begin_xxx` and `nk_end`
    //
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~c
    // void nk_window_set_scroll(ctx: ^Context, nk_uint offset_x, nk_uint offset_y);
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    //
    // Parameter    | Description
    // -------------|-----------------------------------------------------------
    // __ctx__      | Must point to an previously initialized `nk_context` 
    // __offset_x__ | The x offset to scroll to
    // __offset_y__ | The y offset to scroll to
    */
    window_set_scroll :: proc(ctx: ^Context, offset_x, offset_y: u32) ---

    /*
    // #### nk_window_close
    // Closes a window and marks it for being freed at the end of the frame
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~c
    // void nk_window_close(ctx: ^Context, name: cstring);
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    //
    // Parameter   | Description
    // ------------|-----------------------------------------------------------
    // __ctx__     | Must point to an previously initialized `nk_context` 
    // __name__    | Identifier of the window to close
    */
    window_close :: proc(ctx: ^Context, name: cstring) ---

    /*
    // #### nk_window_collapse
    // Updates collapse state of a window with given name
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~c
    // void nk_window_collapse(ctx: ^Context, name: cstring, Collapse_State state);
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    //
    // Parameter   | Description
    // ------------|-----------------------------------------------------------
    // __ctx__     | Must point to an previously initialized `nk_context` 
    // __name__    | Identifier of the window to close
    // __state__   | value out of nk_collapse_states section
    */
    window_collapse :: proc(ctx: ^Context, name: cstring, state: Collapse_States) ---

    /*
    // #### nk_window_collapse_if
    // Updates collapse state of a window with given name if given condition is met
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~c
    // void nk_window_collapse_if(ctx: ^Context, name: cstring, Collapse_State, cond: i32);
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    //
    // Parameter   | Description
    // ------------|-----------------------------------------------------------
    // __ctx__     | Must point to an previously initialized `nk_context` 
    // __name__    | Identifier of the window to either collapse or maximize
    // __state__   | value out of nk_collapse_states section the window should be put into
    // __cond__    | condition that has to be met to actually commit the collapse state change
    */
    window_collapse_if :: proc(ctx: ^Context, name: cstring, Collapse_States, cond: i32) ---

    /*
    // #### nk_window_show
    // updates visibility state of a window with given name
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~c
    // void nk_window_show(ctx: ^Context, name: cstring, Show_States);
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    //
    // Parameter   | Description
    // ------------|-----------------------------------------------------------
    // __ctx__     | Must point to an previously initialized `nk_context` 
    // __name__    | Identifier of the window to either collapse or maximize
    // __state__   | state with either visible or hidden to modify the window with
    */
    window_show :: proc(ctx: ^Context, name: cstring, state: Show_States) ---

    /*
    // #### nk_window_show_if
    // Updates visibility state of a window with given name if a given condition is met
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~c
    // void nk_window_show_if(ctx: ^Context, name: cstring, Show_States, cond: i32);
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    //
    // Parameter   | Description
    // ------------|-----------------------------------------------------------
    // __ctx__     | Must point to an previously initialized `nk_context` 
    // __name__    | Identifier of the window to either hide or show
    // __state__   | state with either visible or hidden to modify the window with
    // __cond__    | condition that has to be met to actually commit the visbility state change
    */
    window_show_if :: proc(ctx: ^Context, name: cstring, Show_States, cond: i32) ---

    /*
    // #### nk_window_show_if
    // Line for visual seperation. Draws a line with thickness determined by the current row height.
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~c
    // void nk_rule_horizontal(ctx: ^Context, color: Color, rounding: bool)
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    //
    // Parameter       | Description
    // ----------------|-------------------------------------------------------
    // __ctx__         | Must point to an previously initialized `nk_context` 
    // __color__       | Color of the horizontal line
    // __rounding__    | Whether or not to make the line round
    */
    rule_horizontal :: proc(ctx: ^Context, color: Color, rounding: bool) ---

    /*
    // #### nk_layout_set_min_row_height
    // Sets the currently used minimum row height.
    // !!! WARNING
    //     The passed height needs to include both your preferred row height
    //     as well as padding. No internal padding is added.
    //
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~c
    // void nk_layout_set_min_row_height(ctx: ^Context, f32 height);
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    //
    // Parameter   | Description
    // ------------|-----------------------------------------------------------
    // __ctx__     | Must point to an previously initialized `nk_context`  after call `nk_begin_xxx`
    // __height__  | New minimum row height to be used for auto generating the row height
    */
    layout_set_min_row_height :: proc(ctx: ^Context, height: f32) ---

    /*
    // #### nk_layout_reset_min_row_height
    // Reset the currently used minimum row height back to `font_height + text_padding + padding`
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~c
    // void nk_layout_reset_min_row_height(ctx: ^Context);
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    //
    // Parameter   | Description
    // ------------|-----------------------------------------------------------
    // __ctx__     | Must point to an previously initialized `nk_context`  after call `nk_begin_xxx`
    */
    layout_reset_min_row_height :: proc(ctx: ^Context) ---

    /*
    // #### nk_layout_widget_bounds
    // Returns the width of the next row allocate by one of the layouting functions
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~c
    // Rect nk_layout_widget_bounds(ctx: ^Context);
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    //
    // Parameter   | Description
    // ------------|-----------------------------------------------------------
    // __ctx__     | Must point to an previously initialized `nk_context`  after call `nk_begin_xxx`
    //
    // Return `Rect` with both position and size of the next row
    */
    layout_widget_bounds :: proc(ctx: ^Context) -> Rect ---

    /*
    // #### nk_layout_ratio_from_pixel
    // Utility functions to calculate window ratio from pixel size
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~c
    // f32 nk_layout_ratio_from_pixel(ctx: ^Context, f32 pixel_width);
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    //
    // Parameter   | Description
    // ------------|-----------------------------------------------------------
    // __ctx__     | Must point to an previously initialized `nk_context`  after call `nk_begin_xxx`
    // __pixel__   | Pixel_width to convert to window ratio
    //
    // Returns `Rect` with both position and size of the next row
    */
    layout_ratio_from_pixel :: proc(ctx: ^Context, pixel_width: f32) -> f32 ---

    /*
    // #### nk_layout_row_dynamic
    // Sets current row layout to share horizontal space
    // between @cols number of widgets evenly. Once called all subsequent widget
    // calls greater than @cols will allocate a new row with same layout.
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~c
    // void nk_layout_row_dynamic(ctx: ^Context, f32 height, i32 cols);
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    //
    // Parameter   | Description
    // ------------|-----------------------------------------------------------
    // __ctx__     | Must point to an previously initialized `nk_context`  after call `nk_begin_xxx`
    // __height__  | Holds height of each widget in row or zero for auto layouting
    // __columns__ | Number of widget inside row
    */
    layout_row_dynamic :: proc(ctx: ^Context, height: f32, cols: i32) ---

    /*
    // #### nk_layout_row_static
    // Sets current row layout to fill @cols number of widgets
    // in row with same @item_width horizontal size. Once called all subsequent widget
    // calls greater than @cols will allocate a new row with same layout.
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~c
    // void nk_layout_row_static(ctx: ^Context, f32 height, i32 item_width, i32 cols);
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    //
    // Parameter   | Description
    // ------------|-----------------------------------------------------------
    // __ctx__     | Must point to an previously initialized `nk_context`  after call `nk_begin_xxx`
    // __height__  | Holds height of each widget in row or zero for auto layouting
    // __width__   | Holds pixel width of each widget in the row
    // __columns__ | Number of widget inside row
    */
    layout_row_static :: proc(ctx: ^Context, height: f32, item_width, cols: i32) ---

    /*
    // #### nk_layout_row_begin
    // Starts a new dynamic or fixed row with given height and columns.
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~c
    // void nk_layout_row_begin(ctx: ^Context, fmt: Layout_Format, f32 row_height, i32 cols);
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    //
    // Parameter   | Description
    // ------------|-----------------------------------------------------------
    // __ctx__     | Must point to an previously initialized `nk_context`  after call `nk_begin_xxx`
    // __fmt__     | either `NK_DYNAMIC` for window ratio or `NK_STATIC` for fixed size columns
    // __height__  | holds height of each widget in row or zero for auto layouting
    // __columns__ | Number of widget inside row
    */
    layout_row_begin :: proc(ctx: ^Context, fmt: Layout_Format, row_height: f32, cols: i32) ---

    /*
    // #### nk_layout_row_push
    // Specifies either window ratio or width of a single column
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~c
    // void nk_layout_row_push(ctx: ^Context, f32 value);
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    //
    // Parameter   | Description
    // ------------|-----------------------------------------------------------
    // __ctx__     | Must point to an previously initialized `nk_context`  after call `nk_begin_xxx`
    // __value__   | either a window ratio or fixed width depending on @fmt in previous `nk_layout_row_begin` call
    */
    layout_row_push :: proc(ctx: ^Context, value: f32) ---

    /*
    // #### nk_layout_row_end
    // Finished previously started row
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~c
    // void nk_layout_row_end(ctx: ^Context);
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    //
    // Parameter   | Description
    // ------------|-----------------------------------------------------------
    // __ctx__     | Must point to an previously initialized `nk_context`  after call `nk_begin_xxx`
    */
    layout_row_end :: proc(ctx: ^Context) ---

    /*
    // #### nk_layout_row
    // Specifies row columns in array as either window ratio or size
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~c
    // void nk_layout_row(ctx: ^Context, nk_layout_format, f32 height, i32 cols, const f32 *ratio);
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    //
    // Parameter   | Description
    // ------------|-----------------------------------------------------------
    // __ctx__     | Must point to an previously initialized `nk_context`  after call `nk_begin_xxx`
    // __fmt__     | Either `NK_DYNAMIC` for window ratio or `NK_STATIC` for fixed size columns
    // __height__  | Holds height of each widget in row or zero for auto layouting
    // __columns__ | Number of widget inside row
    */
    layout_row :: proc(ctx: ^Context, format: Layout_Format, height: f32, cols: i32, ratio: [^]f32) ---

    /*
    // #### nk_layout_row_template_begin
    // Begins the row template declaration
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~c
    // void nk_layout_row_template_begin(ctx: ^Context, f32 row_height);
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    //
    // Parameter   | Description
    // ------------|-----------------------------------------------------------
    // __ctx__     | Must point to an previously initialized `nk_context`  after call `nk_begin_xxx`
    // __height__  | Holds height of each widget in row or zero for auto layouting
    */
    layout_row_template_begin :: proc(ctx: ^Context, row_height: f32) ---

    /*
    // #### nk_layout_row_template_push_dynamic
    // Adds a dynamic column that dynamically grows and can go to zero if not enough space
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~c
    // void nk_layout_row_template_push_dynamic(ctx: ^Context);
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    //
    // Parameter   | Description
    // ------------|-----------------------------------------------------------
    // __ctx__     | Must point to an previously initialized `nk_context`  after call `nk_begin_xxx`
    // __height__  | Holds height of each widget in row or zero for auto layouting
    */
    layout_row_template_push_dynamic :: proc(ctx: ^Context) ---

    /*
    // #### nk_layout_row_template_push_variable
    // Adds a variable column that dynamically grows but does not shrink below specified pixel width
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~c
    // void nk_layout_row_template_push_variable(ctx: ^Context, f32 min_width);
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    //
    // Parameter   | Description
    // ------------|-----------------------------------------------------------
    // __ctx__     | Must point to an previously initialized `nk_context`  after call `nk_begin_xxx`
    // __width__   | Holds the minimum pixel width the next column must always be
    */
    layout_row_template_push_variable :: proc(ctx: ^Context, min_width: f32) ---

    /*
    // #### nk_layout_row_template_push_static
    // Adds a static column that does not grow and will always have the same size
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~c
    // void nk_layout_row_template_push_static(ctx: ^Context, f32 width);
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    //
    // Parameter   | Description
    // ------------|-----------------------------------------------------------
    // __ctx__     | Must point to an previously initialized `nk_context`  after call `nk_begin_xxx`
    // __width__   | Holds the absolute pixel width value the next column must be
    */
    layout_row_template_push_static :: proc(ctx: ^Context, width: f32) ---

    /*
    // #### nk_layout_row_template_end
    // Marks the end of the row template
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~c
    // void nk_layout_row_template_end(ctx: ^Context);
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    //
    // Parameter   | Description
    // ------------|-----------------------------------------------------------
    // __ctx__     | Must point to an previously initialized `nk_context`  after call `nk_begin_xxx`
    */
    layout_row_template_end :: proc(ctx: ^Context) ---

    /*
    // #### nk_layout_space_begin
    // Begins a new layouting space that allows to specify each widgets position and size.
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~c
    // void nk_layout_space_begin(ctx: ^Context, nk_layout_format, f32 height, i32 widget_count);
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    //
    // Parameter   | Description
    // ------------|-----------------------------------------------------------
    // __ctx__     | Must point to an previously initialized `nk_context`  after call `nk_begin_xxx`
    // __fmt__     | Either `NK_DYNAMIC` for window ratio or `NK_STATIC` for fixed size columns
    // __height__  | Holds height of each widget in row or zero for auto layouting
    // __columns__ | Number of widgets inside row
    */
    layout_space_begin :: proc(ctx: ^Context, Layout_Format, height: f32, widget_count: i32) ---

    /*
    // #### nk_layout_space_push
    // Pushes position and size of the next widget in own coordinate space either as pixel or ratio
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~c
    // void nk_layout_space_push(ctx: ^Context, bounds: Rect);
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    //
    // Parameter   | Description
    // ------------|-----------------------------------------------------------
    // __ctx__     | Must point to an previously initialized `nk_context`  after call `nk_layout_space_begin`
    // __bounds__  | Position and size in laoyut space local coordinates
    */
    layout_space_push :: proc(ctx: ^Context, bounds: Rect) ---

    /*
    // #### nk_layout_space_end
    // Marks the end of the layout space
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~c
    // void nk_layout_space_end(ctx: ^Context);
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    //
    // Parameter   | Description
    // ------------|-----------------------------------------------------------
    // __ctx__     | Must point to an previously initialized `nk_context`  after call `nk_layout_space_begin`
    */
    layout_space_end :: proc(ctx: ^Context) ---
    
    /*
    // #### nk_layout_space_bounds
    // Utility function to calculate total space allocated for `nk_layout_space`
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~c
    // Rect nk_layout_space_bounds(ctx: ^Context);
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    //
    // Parameter   | Description
    // ------------|-----------------------------------------------------------
    // __ctx__     | Must point to an previously initialized `nk_context`  after call `nk_layout_space_begin`
    //
    // Returns `Rect` holding the total space allocated
    */
    layout_space_bounds :: proc(ctx: ^Context) -> Rect ---

    /*
    // #### nk_layout_space_to_screen
    // Converts vector from nk_layout_space coordinate space into screen space
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~c
    // Vec2 nk_layout_space_to_screen(ctx: ^Context, Vec2);
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    //
    // Parameter   | Description
    // ------------|-----------------------------------------------------------
    // __ctx__     | Must point to an previously initialized `nk_context`  after call `nk_layout_space_begin`
    // __vec__     | Position to convert from layout space into screen coordinate space
    //
    // Returns transformed `Vec2` in screen space coordinates
    */
    layout_space_to_screen :: proc(ctx: ^Context, vec: Vec2) -> Vec2 ---

    /*
    // #### nk_layout_space_to_local
    // Converts vector from layout space into screen space
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~c
    // Vec2 nk_layout_space_to_local(ctx: ^Context, Vec2);
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    //
    // Parameter   | Description
    // ------------|-----------------------------------------------------------
    // __ctx__     | Must point to an previously initialized `nk_context`  after call `nk_layout_space_begin`
    // __vec__     | Position to convert from screen space into layout coordinate space
    //
    // Returns transformed `Vec2` in layout space coordinates
    */
    layout_space_to_local :: proc(ctx: ^Context, vec: Vec2) -> Vec2 ---

    /*
    // #### nk_layout_space_rect_to_screen
    // Converts rectangle from screen space into layout space
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~c
    // Rect nk_layout_space_rect_to_screen(ctx: ^Context, Rect);
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    //
    // Parameter   | Description
    // ------------|-----------------------------------------------------------
    // __ctx__     | Must point to an previously initialized `nk_context`  after call `nk_layout_space_begin`
    // __bounds__  | Rectangle to convert from layout space into screen space
    //
    // Returns transformed `Rect` in screen space coordinates
    */
    layout_space_rect_to_screen :: proc(ctx: ^Context, bounds: Rect) -> Rect ---

    /*
    // #### nk_layout_space_rect_to_local
    // Converts rectangle from layout space into screen space
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~c
    // Rect nk_layout_space_rect_to_local(ctx: ^Context, Rect);
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    //
    // Parameter   | Description
    // ------------|-----------------------------------------------------------
    // __ctx__     | Must point to an previously initialized `nk_context`  after call `nk_layout_space_begin`
    // __bounds__  | Rectangle to convert from layout space into screen space
    //
    // Returns transformed `Rect` in layout space coordinates
    */
    layout_space_rect_to_local :: proc(ctx: ^Context, bounds: Rect) -> Rect ---

    /*
    // #### nk_spacer
    // Spacer is a dummy widget that consumes space as usual but doesn't draw anything
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~c
    // void nk_spacer(ctx: ^Context );
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    //
    // Parameter   | Description
    // ------------|-----------------------------------------------------------
    // __ctx__     | Must point to an previously initialized `nk_context`  after call `nk_layout_space_begin`
    //
    */
    spacer :: proc(ctx: ^Context) ---


    /*
    // #### nk_group_begin
    // Starts a new widget group. Requires a previous layouting function to specify a pos/size.
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~c
    // bool nk_group_begin(ctx: ^Context, title: cstring, Flags);
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    //
    // Parameter   | Description
    // ------------|-----------------------------------------------------------
    // __ctx__     | Must point to an previously initialized `nk_context` 
    // __title__   | Must be an unique identifier for this group that is also used for the group header
    // __flags__   | Window flags defined in the nk_panel_flags section with a number of different group behaviors
    //
    // Returns `true(1)` if visible and fillable with widgets or `false(0)` otherwise
    */
    group_begin :: proc(ctx: ^Context, title: cstring, flags: Panel_Flags) -> bool ---

    /*
    // #### nk_group_begin_titled
    // Starts a new widget group. Requires a previous layouting function to specify a pos/size.
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~c
    // bool nk_group_begin_titled(ctx: ^Context, const char *name, title: cstring, Flags);
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    //
    // Parameter   | Description
    // ------------|-----------------------------------------------------------
    // __ctx__     | Must point to an previously initialized `nk_context` 
    // __id__      | Must be an unique identifier for this group
    // __title__   | Group header title
    // __flags__   | Window flags defined in the nk_panel_flags section with a number of different group behaviors
    //
    // Returns `true(1)` if visible and fillable with widgets or `false(0)` otherwise
    */
    group_begin_titled :: proc(ctx: ^Context, name, title: cstring, flags: Panel_Flags) -> bool ---

    /*
    // #### nk_group_end
    // Ends a widget group
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~c
    // void nk_group_end(ctx: ^Context);
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    //
    // Parameter   | Description
    // ------------|-----------------------------------------------------------
    // __ctx__     | Must point to an previously initialized `nk_context` 
    */
    group_end :: proc(ctx: ^Context) ---

    /*
    // #### nk_group_scrolled_offset_begin
    // starts a new widget group. requires a previous layouting function to specify
    // a size. Does not keep track of scrollbar.
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~c
    // bool nk_group_scrolled_offset_begin(ctx: ^Context, nk_uint *x_offset, nk_uint *y_offset, title: cstring, Flags: Flags);
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    //
    // Parameter   | Description
    // ------------|-----------------------------------------------------------
    // __ctx__     | Must point to an previously initialized `nk_context` 
    // __x_offset__| Scrollbar x-offset to offset all widgets inside the group horizontally.
    // __y_offset__| Scrollbar y-offset to offset all widgets inside the group vertically
    // __title__   | Window unique group title used to both identify and display in the group header
    // __flags__   | Window flags from the nk_panel_flags section
    //
    // Returns `true(1)` if visible and fillable with widgets or `false(0)` otherwise
    */
    group_scrolled_offset_begin :: proc(ctx: ^Context, x_offset, y_offset: ^u32, title: cstring, Flags: Flags) -> bool ---

    /*
    // #### nk_group_scrolled_begin
    // Starts a new widget group. requires a previous
    // layouting function to specify a size. Does not keep track of scrollbar.
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~c
    // bool nk_group_scrolled_begin(ctx: ^Context,  nk_scroll *off, title: cstring, Flags);
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    //
    // Parameter   | Description
    // ------------|-----------------------------------------------------------
    // __ctx__     | Must point to an previously initialized `nk_context` 
    // __off__     | Both x- and y- scroll offset. Allows for manual scrollbar control
    // __title__   | Window unique group title used to both identify and display in the group header
    // __flags__   | Window flags from nk_panel_flags section
    //
    // Returns `true(1)` if visible and fillable with widgets or `false(0)` otherwise
    */
    group_scrolled_begin :: proc(ctx: ^Context, off: ^Scroll, title: cstring, flags: Flags) -> bool ---

    /*
    // #### nk_group_scrolled_end
    // Ends a widget group after calling nk_group_scrolled_offset_begin or nk_group_scrolled_begin.
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~c
    // void nk_group_scrolled_end(ctx: ^Context);
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    //
    // Parameter   | Description
    // ------------|-----------------------------------------------------------
    // __ctx__     | Must point to an previously initialized `nk_context` 
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

    /*
    // #### nk_group_set_scroll
    // Sets the scroll position of the given group.
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~c
    // void nk_group_set_scroll(ctx: ^Context, const char *id, nk_uint x_offset, nk_uint y_offset);
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    //
    // Parameter    | Description
    // -------------|-----------------------------------------------------------
    // __ctx__      | Must point to an previously initialized `nk_context` 
    // __id__       | The id of the group to scroll
    // __x_offset__ | The x offset to scroll to
    // __y_offset__ | The y offset to scroll to
    */
    group_set_scroll :: proc(ctx: ^Context, id: cstring, x_offset, y_offset: u32) ---

    /*
    #### nk_tree_push
    Starts a collapsible UI section with internal state management
    !!! WARNING
        To keep track of the runtime tree collapsible state this function uses
        defines `__FILE__` and `__LINE__` to generate a unique ID. If you want
        to call this function in a loop please use `nk_tree_push_id` or
        `nk_tree_push_hashed` instead.
    
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~c
    #define nk_tree_push(ctx, type, title, state)
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    
    Parameter   | Description
    ------------|-----------------------------------------------------------
    __ctx__     | Must point to an previously initialized `nk_context` 
    __type__    | Value from the nk_tree_type section to visually mark a tree node header as either a collapseable UI section or tree node
    __title__   | Label printed in the tree header
    __state__   | Initial tree state value out of nk_collapse_states
    
    Returns `true(1)` if visible and fillable with widgets or `false(0)` otherwise
    TODO: #define nk_tree_push(ctx, type, title, state) nk_tree_push_hashed(ctx, type, title, state, NK_FILE_LINE,nk_strlen(NK_FILE_LINE),__LINE__)
    */

    /*
    #### nk_tree_push_id
    Starts a collapsible UI section with internal state management callable in a look
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~c
    #define nk_tree_push_id(ctx, type, title, state, id)
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    
    Parameter   | Description
    ------------|-----------------------------------------------------------
    __ctx__     | Must point to an previously initialized `nk_context` 
    __type__    | Value from the nk_tree_type section to visually mark a tree node header as either a collapseable UI section or tree node
    __title__   | Label printed in the tree header
    __state__   | Initial tree state value out of nk_collapse_states
    __id__      | Loop counter index if this function is called in a loop
    
    Returns `true(1)` if visible and fillable with widgets or `false(0)` otherwise
    TODO: #define nk_tree_push_id(ctx, type, title, state, id) nk_tree_push_hashed(ctx, type, title, state, NK_FILE_LINE,nk_strlen(NK_FILE_LINE),id)
    */

    /*
    #### nk_tree_push_hashed
    Start a collapsible UI section with internal state management with full
    control over internal unique ID used to store state
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~c
    bool nk_tree_push_hashed(ctx: ^Context, Tree_Type, title: cstring, Collapse_State initial_state, const char *hash, i32 len,i32 seed);
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    
    Parameter   | Description
    ------------|-----------------------------------------------------------
    __ctx__     | Must point to an previously initialized `nk_context` 
    __type__    | Value from the nk_tree_type section to visually mark a tree node header as either a collapseable UI section or tree node
    __title__   | Label printed in the tree header
    __state__   | Initial tree state value out of nk_collapse_states
    __hash__    | Memory block or string to generate the ID from
    __len__     | Size of passed memory block or string in __hash__
    __seed__    | Seeding value if this function is called in a loop or default to `0`
    
    Returns `true(1)` if visible and fillable with widgets or `false(0)` otherwise
    */
    tree_push_hashed :: proc(ctx: ^Context, type: Tree_Type, title: cstring, initial_state: Collapse_States, hash: [^]u8, len, seed: i32) -> bool ---

    /*
    #### nk_tree_image_push
    Start a collapsible UI section with image and label header
    !!! WARNING
        To keep track of the runtime tree collapsible state this function uses
        defines `__FILE__` and `__LINE__` to generate a unique ID. If you want
        to call this function in a loop please use `nk_tree_image_push_id` or
        `nk_tree_image_push_hashed` instead.

    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~c
    #define nk_tree_image_push(ctx, type, img, title, state)
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    //
    Parameter   | Description
    ------------|-----------------------------------------------------------
    __ctx__     | Must point to an previously initialized `nk_context` 
    __type__    | Value from the nk_tree_type section to visually mark a tree node header as either a collapseable UI section or tree node
    __img__     | Image to display inside the header on the left of the label
    __title__   | Label printed in the tree header
    __state__   | Initial tree state value out of nk_collapse_states
    
    Returns `true(1)` if visible and fillable with widgets or `false(0)` otherwise
    TODO: #define nk_tree_image_push(ctx, type, img, title, state) nk_tree_image_push_hashed(ctx, type, img, title, state, NK_FILE_LINE,nk_strlen(NK_FILE_LINE),__LINE__)
    */

    /*
    #### nk_tree_image_push_id
    Start a collapsible UI section with image and label header and internal state
    management callable in a look
    
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~c
    #define nk_tree_image_push_id(ctx, type, img, title, state, id)
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    
    Parameter   | Description
    ------------|-----------------------------------------------------------
    __ctx__     | Must point to an previously initialized `nk_context` 
    __type__    | Value from the nk_tree_type section to visually mark a tree node header as either a collapseable UI section or tree node
    __img__     | Image to display inside the header on the left of the label
    __title__   | Label printed in the tree header
    __state__   | Initial tree state value out of nk_collapse_states
    __id__      | Loop counter index if this function is called in a loop
    
    Returns `true(1)` if visible and fillable with widgets or `false(0)` otherwise
    TODO: #define nk_tree_image_push_id(ctx, type, img, title, state, id) nk_tree_image_push_hashed(ctx, type, img, title, state, NK_FILE_LINE,nk_strlen(NK_FILE_LINE),id)
    */

    /*
    #### nk_tree_image_push_hashed
    Start a collapsible UI section with internal state management with full
    control over internal unique ID used to store state
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~c
    bool nk_tree_image_push_hashed(ctx: ^Context, Tree_Type, Image, title: cstring, Collapse_State initial_state, const char *hash, i32 len,i32 seed);
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    
    Parameter   | Description
    ------------|-----------------------------------------------------------
    __ctx__     | Must point to an previously initialized `nk_context` 
    __type__    | Value from the nk_tree_type section to visually mark a tree node header as either a collapseable UI section or tree node
    __img__     | Image to display inside the header on the left of the label
    __title__   | Label printed in the tree header
    __state__   | Initial tree state value out of nk_collapse_states
    __hash__    | Memory block or string to generate the ID from
    __len__     | Size of passed memory block or string in __hash__
    __seed__    | Seeding value if this function is called in a loop or default to `0`
    
    Returns `true(1)` if visible and fillable with widgets or `false(0)` otherwise
    */
    tree_image_push_hashed :: proc(ctx: ^Context, Tree_Type, Image, title: cstring, initial_state: Collapse_States, hash: cstring, len, seed: i32) -> bool ---

    /*
    #### nk_tree_pop
    Ends a collapsabale UI section
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~c
    void nk_tree_pop(ctx: ^Context);
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    
    Parameter   | Description
    ------------|-----------------------------------------------------------
    __ctx__     | Must point to an previously initialized `nk_context`  after calling `nk_tree_xxx_push_xxx`
    */
    tree_pop :: proc(ctx: ^Context) ---

    /*
    #### nk_tree_state_push
    Start a collapsible UI section with external state management
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~c
    bool nk_tree_state_push(ctx: ^Context, Tree_Type, title: cstring, Collapse_State *state);
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    
    Parameter   | Description
    ------------|-----------------------------------------------------------
    __ctx__     | Must point to an previously initialized `nk_context`  after calling `nk_tree_xxx_push_xxx`
    __type__    | Value from the nk_tree_type section to visually mark a tree node header as either a collapseable UI section or tree node
    __title__   | Label printed in the tree header
    __state__   | Persistent state to update
    
    Returns `true(1)` if visible and fillable with widgets or `false(0)` otherwise
    */
    tree_state_push :: proc(ctx: ^Context, Tree_Type, title: cstring, state: ^Collapse_States) -> bool ---

    /*
    #### nk_tree_state_image_push
    Start a collapsible UI section with image and label header and external state management
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~c
    bool nk_tree_state_image_push(ctx: ^Context, Tree_Type, Image, title: cstring, Collapse_State *state);
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    
    Parameter   | Description
    ------------|-----------------------------------------------------------
    __ctx__     | Must point to an previously initialized `nk_context`  after calling `nk_tree_xxx_push_xxx`
    __img__     | Image to display inside the header on the left of the label
    __type__    | Value from the nk_tree_type section to visually mark a tree node header as either a collapseable UI section or tree node
    __title__   | Label printed in the tree header
    __state__   | Persistent state to update
    
    Returns `true(1)` if visible and fillable with widgets or `false(0)` otherwise
    */
    tree_state_image_push :: proc(ctx: ^Context, Tree_Type, Image, title: cstring, state: ^Collapse_States) -> bool ---

    /*
    #### nk_tree_state_pop
    Ends a collapsabale UI section
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~c
    void nk_tree_state_pop(ctx: ^Context);
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    
    Parameter   | Description
    ------------|-----------------------------------------------------------
    __ctx__     | Must point to an previously initialized `nk_context`  after calling `nk_tree_xxx_push_xxx`
    */
    tree_state_pop :: proc(ctx: ^Context) ---

    // TODO: #define nk_tree_element_push(ctx, type, title, state, sel) nk_tree_element_push_hashed(ctx, type, title, state, sel, NK_FILE_LINE,nk_strlen(NK_FILE_LINE),__LINE__)
    // TODO: #define nk_tree_element_push_id(ctx, type, title, state, sel, id) nk_tree_element_push_hashed(ctx, type, title, state, sel, NK_FILE_LINE,nk_strlen(NK_FILE_LINE),id)

    tree_element_push_hashed :: proc(ctx: ^Context, Tree_Type, title: cstring, initial_state: Collapse_States, selected: ^bool, hash: cstring, len, seed: i32) -> bool ---
    tree_element_image_push_hashed :: proc(ctx: ^Context, Tree_Type, Image, title: cstring, initial_state: Collapse_States, selected: ^bool, hash: cstring, len, seed: i32) -> bool ---
    tree_element_pop :: proc(ctx: ^Context) ---

    list_view_begin :: proc(ctx: ^Context, out: ^List_View, id: cstring, Flags, row_height, row_count: i32) -> bool ---
    list_view_end :: proc(^List_View) ---

    widget :: proc(^Rect, ^Context) -> Widget_Layout_States ---
    widget_fitting :: proc(^Rect, ^Context, Vec2) -> Widget_Layout_States ---
    widget_bounds :: proc(ctx: ^Context) -> Rect ---
    widget_position :: proc(ctx: ^Context) -> Vec2 ---
    widget_size :: proc(ctx: ^Context) -> Vec2 ---
    widget_width :: proc(ctx: ^Context) -> f32 ---
    widget_height :: proc(ctx: ^Context) -> f32 ---
    widget_is_hovered :: proc(ctx: ^Context) -> bool ---
    widget_is_mouse_clicked :: proc(ctx: ^Context, buttons: Buttons) -> bool ---
    widget_has_mouse_click_down :: proc(ctx: ^Context, Buttons, down: bool) -> bool ---
    spacing :: proc(ctx: ^Context, cols: i32) ---
    widget_disable_begin :: proc(ctx: ^Context) ---
    widget_disable_end :: proc(ctx: ^Context) ---

    text :: proc(ctx: ^Context, name: [^]u8, len: i32, alignment: Text_Alignment) ---
    text_colored :: proc(ctx: ^Context, name: cstring, i: i32, flags: Flags, color: Color) ---
    text_wrap :: proc(ctx: ^Context, name: cstring, i: i32) ---
    text_wrap_colored :: proc(ctx: ^Context, name: cstring, i32, color: Color) ---
    label :: proc(ctx: ^Context, name: cstring, align: Text_Alignment) ---
    label_colored :: proc(ctx: ^Context, name: cstring, align: Flags, color: Color) ---
    label_wrap :: proc(ctx: ^Context, name: cstring) ---
    label_colored_wrap :: proc(ctx: ^Context, name: cstring, color: Color) ---
    image :: proc(ctx: ^Context, image: Image) ---
    image_color :: proc(ctx: ^Context, image: Image, color: Color) ---

    when #config(NK_INCLUDE_STANDARD_VARARGS, true)
    {
        // labelf :: proc(ctx: ^Context, nk_flags, NK_PRINTF_FORMAT_STRING const char*, ...) NK_PRINTF_VARARG_FUNC(3) ---
        // labelf_colored :: proc(ctx: ^Context, nk_flags, color: Color, NK_PRINTF_FORMAT_STRING const char*,...) NK_PRINTF_VARARG_FUNC(4) ---
        // labelf_wrap :: proc(ctx: ^Context, NK_PRINTF_FORMAT_STRING const char*,...) NK_PRINTF_VARARG_FUNC(2) ---
        // labelf_colored_wrap :: proc(ctx: ^Context, color: Color, NK_PRINTF_FORMAT_STRING const char*,...) NK_PRINTF_VARARG_FUNC(3) ---
        // labelfv :: proc(ctx: ^Context, nk_flags, NK_PRINTF_FORMAT_STRING const char*, va_list) NK_PRINTF_VALIST_FUNC(3) ---
        // labelfv_colored :: proc(ctx: ^Context, nk_flags, color: Color, NK_PRINTF_FORMAT_STRING const char*, va_list) NK_PRINTF_VALIST_FUNC(4) ---
        // labelfv_wrap :: proc(ctx: ^Context, NK_PRINTF_FORMAT_STRING const char*, va_list) NK_PRINTF_VALIST_FUNC(2) ---
        // labelfv_colored_wrap :: proc(ctx: ^Context, color: Color, NK_PRINTF_FORMAT_STRING const char*, va_list) NK_PRINTF_VALIST_FUNC(3) ---
        // value_bool :: proc(ctx: ^Context, const char *prefix, i32) ---
        // value_int :: proc(ctx: ^Context, const char *prefix, i32) ---
        // value_uint :: proc(ctx: ^Context, const char *prefix, unsigned i32) ---
        // value_float :: proc(ctx: ^Context, const char *prefix, float) ---
        // value_color_byte :: proc(ctx: ^Context, const char *prefix, color: Color) ---
        // value_color_float :: proc(ctx: ^Context, const char *prefix, color: Color) ---
        // value_color_hex :: proc(ctx: ^Context, const char *prefix, color: Color) ---
    }

    button_text :: proc(ctx: ^Context, title: [^]u8, len: i32) -> bool ---
    button_label :: proc(ctx: ^Context, title: cstring) -> bool ---
    button_color :: proc(ctx: ^Context, color: Color) -> bool ---
    button_symbol :: proc(ctx: ^Context, type: Symbol_Type) -> bool ---
    button_image :: proc(ctx: ^Context, img: Image) -> bool ---
    button_symbol_label :: proc(ctx: ^Context, type: Symbol_Type, cstring, text_alignment: Flags) -> bool ---
    button_symbol_text :: proc(ctx: ^Context, type: Symbol_Type, cstring, len: i32, alignment: Flags) -> bool ---
    button_image_label :: proc(ctx: ^Context, img: Image, cstring, text_alignment: Flags) -> bool ---
    button_image_text :: proc(ctx: ^Context, img: Image, cstring, len: i32, alignment: Flags) -> bool ---
    button_text_styled :: proc(ctx: ^Context, style: ^Style_Button, title: cstring, len: i32) -> bool ---
    button_label_styled :: proc(ctx: ^Context, style: ^Style_Button, title: cstring) -> bool ---
    button_symbol_styled :: proc(ctx: ^Context, style: ^Style_Button, type: Symbol_Type) -> bool ---
    button_image_styled :: proc(ctx: ^Context, style: ^Style_Button, img: Image) -> bool ---
    button_symbol_text_styled :: proc(ctx: ^Context, style: ^Style_Button, symbol: Symbol_Type, title: cstring, len: i32, alignment: Flags) -> bool ---
    button_symbol_label_styled :: proc(ctx: ^Context, style: ^Style_Button, symbol: Symbol_Type, title: cstring, align: Flags) -> bool ---
    button_image_label_styled :: proc(ctx: ^Context, style: ^Style_Button, img: Image, title: cstring, text_alignment: Flags) -> bool ---
    button_image_text_styled :: proc(ctx: ^Context, style: ^Style_Button, img: Image, title: cstring, len: i32, alignment: Flags) -> bool ---
    button_set_behavior :: proc(ctx: ^Context, behavior: Button_Behavior) ---
    button_push_behavior :: proc(ctx: ^Context, behavior: Button_Behavior) -> bool ---
    button_pop_behavior :: proc(ctx: ^Context) -> bool ---

    check_label :: proc(ctx: ^Context, label: cstring, active: bool) -> bool ---
    check_text :: proc(ctx: ^Context, label: cstring, len: i32, active: bool) -> bool ---
    check_text_align :: proc(ctx: ^Context, label: cstring, len: i32, active: bool, widget_alignment: Flags, text_alignment: Flags) -> bool ---
    check_flags_label :: proc(ctx: ^Context, label: cstring, flags, value: u32) -> u32 ---
    check_flags_text :: proc(ctx: ^Context, label: cstring, len: i32, flags, value: u32) -> u32 ---
    checkbox_label :: proc(ctx: ^Context, label: cstring, active: ^bool) -> bool ---
    checkbox_label_align :: proc(ctx: ^Context, label: cstring, active: ^bool, widget_alignment, text_alignment: Flags) -> bool ---
    checkbox_text :: proc(ctx: ^Context, label: cstring, len: i32, active: ^bool) -> bool  ---
    checkbox_text_align :: proc(ctx: ^Context, label: cstring, len: i32, active: ^bool, widget_alignment, text_alignment: Flags) -> bool ---
    checkbox_flags_label :: proc(ctx: ^Context, label: cstring, flags: ^u32, value: u32) -> bool ---
    checkbox_flags_text :: proc(ctx: ^Context, label: cstring, len: i32, flags: ^u32, value: u32) -> bool ---

    radio_label :: proc(ctx: ^Context, label: cstring, active: ^bool) -> bool ---
    radio_label_align :: proc(ctx: ^Context, label: cstring, active: ^bool, widget_alignment, text_alignment: Flags) -> bool ---
    radio_text :: proc(ctx: ^Context, text: cstring, len: i32, active: ^bool) -> bool ---
    radio_text_align :: proc(ctx: ^Context, text: cstring, len: i32, active: ^bool, widget_alignment, text_alignment: Flags) -> bool ---
    option_label :: proc(ctx: ^Context, label: cstring, active: bool) -> bool ---
    option_label_align :: proc(ctx: ^Context, label: cstring, active: bool, widget_alignment, text_alignment: Flags) -> bool ---
    option_text :: proc(ctx: ^Context, text: cstring, len: i32, active: bool) -> bool ---
    option_text_align :: proc(ctx: ^Context, text: cstring, len: i32, is_active: bool, widget_alignment, text_alignment: Flags) -> bool ---

    selectable_label :: proc(ctx: ^Context, label: cstring, align: Text_Alignment, value: ^bool) -> bool ---
    selectable_text :: proc(ctx: ^Context, label: [^]u8, len: i32, align: Text_Alignment, value: ^bool) -> bool ---
    selectable_image_label :: proc(ctx: ^Context, img: Image,  text: cstring, align: Flags, value: ^bool) -> bool ---
    selectable_image_text :: proc(ctx: ^Context, img: Image, text: cstring, len: i32, align: Flags, value: ^bool) -> bool ---
    selectable_symbol_label :: proc(ctx: ^Context, symbol: Symbol_Type, text: cstring, align: Flags, value: ^bool) -> bool ---
    selectable_symbol_text :: proc(ctx: ^Context, symbol: Symbol_Type, text: cstring, len: i32, align: Flags, value: ^bool) -> bool ---
    select_label :: proc(ctx: ^Context, label: cstring, align: Flags, value: ^bool) -> bool ---
    select_text :: proc(ctx: ^Context, label: [^]u8, len: i32, align: Text_Alignment, value: ^bool) -> bool ---
    select_image_label :: proc(ctx: ^Context, img: Image, text: cstring, align: Flags, value: ^bool) -> bool ---
    select_image_text :: proc(ctx: ^Context, img: Image, text: cstring, len: i32, align: Flags, value: ^bool) -> bool ---
    select_symbol_label :: proc(ctx: ^Context, symbol: Symbol_Type, text: cstring, align: Flags, value: ^bool) -> bool ---
    select_symbol_text :: proc(ctx: ^Context, symbol: Symbol_Type, text: cstring, len: i32, align: Flags, value: ^bool) -> bool ---

    slide_float :: proc(ctx: ^Context, min, val, max, step: f32) -> f32 ---
    slide_int :: proc(ctx: ^Context, min, val, max, step: i32) -> i32 ---
    slider_float :: proc(ctx: ^Context, min: f32, val: ^f32, max, step: f32) -> bool ---
    slider_int :: proc(ctx: ^Context, min, val: ^i32, max, step: i32) -> bool ---

    progress :: proc(ctx: ^Context, cur: ^Size, max: Size, modifyable: bool) -> bool ---
    prog :: proc(ctx: ^Context, cur: Size, max: Size, modifyable: bool) -> Size ---

    color_picker :: proc(ctx: ^Context, color: ColorF, format: Color_Format) -> ColorF ---
    color_pick :: proc(ctx: ^Context, color: ^ColorF, format: Color_Format) -> bool ---

    /*
    // #### nk_property_int
    // Integer property directly modifying a passed in value
    // !!! WARNING
    //     To generate a unique property ID using the same label make sure to insert
    //     a `#` at the beginning. It will not be shown but guarantees correct behavior.
    //
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~c
    // void nk_property_int(struct nk_context *ctx, const char *name, i32 min, i32 *val, i32 max, i32 step, float inc_per_pixel);
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    //
    // Parameter           | Description
    // --------------------|-----------------------------------------------------------
    // __ctx__             | Must point to an previously initialized `nk_context` struct after calling a layouting function
    // __name__            | String used both as a label as well as a unique identifier
    // __min__             | Minimum value not allowed to be underflown
    // __val__             | Integer pointer to be modified
    // __max__             | Maximum value not allowed to be overflown
    // __step__            | Increment added and subtracted on increment and decrement button
    // __inc_per_pixel__   | Value per pixel added or subtracted on dragging
    */
    property_int :: proc(ctx: ^Context, name: cstring, min: i32, val: ^i32, max, step: i32, inc_per_pixel: f32) ---

    /*
    // #### nk_property_float
    // Float property directly modifying a passed in value
    // !!! WARNING
    //     To generate a unique property ID using the same label make sure to insert
    //     a `#` at the beginning. It will not be shown but guarantees correct behavior.
    //
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~c
    // void nk_property_float(struct nk_context *ctx, const char *name, float min, float *val, float max, float step, float inc_per_pixel);
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    //
    // Parameter           | Description
    // --------------------|-----------------------------------------------------------
    // __ctx__             | Must point to an previously initialized `nk_context` struct after calling a layouting function
    // __name__            | String used both as a label as well as a unique identifier
    // __min__             | Minimum value not allowed to be underflown
    // __val__             | Float pointer to be modified
    // __max__             | Maximum value not allowed to be overflown
    // __step__            | Increment added and subtracted on increment and decrement button
    // __inc_per_pixel__   | Value per pixel added or subtracted on dragging
    */
    property_float :: proc(ctx: ^Context, name: cstring, min: f32, val: ^f32, max, step: f32, inc_per_pixel: f32) ---

    /*
    // #### nk_property_double
    // Double property directly modifying a passed in value
    // !!! WARNING
    //     To generate a unique property ID using the same label make sure to insert
    //     a `#` at the beginning. It will not be shown but guarantees correct behavior.
    //
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~c
    // void nk_property_double(struct nk_context *ctx, const char *name, double min, double *val, double max, double step, double inc_per_pixel);
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    //
    // Parameter           | Description
    // --------------------|-----------------------------------------------------------
    // __ctx__             | Must point to an previously initialized `nk_context` struct after calling a layouting function
    // __name__            | String used both as a label as well as a unique identifier
    // __min__             | Minimum value not allowed to be underflown
    // __val__             | Double pointer to be modified
    // __max__             | Maximum value not allowed to be overflown
    // __step__            | Increment added and subtracted on increment and decrement button
    // __inc_per_pixel__   | Value per pixel added or subtracted on dragging
    */
    property_double :: proc(ctx: ^Context, name: cstring, min: f64, val: ^f64, max, step: f64, inc_per_pixel: f32) ---

    /*
    // #### nk_propertyi
    // Integer property modifying a passed in value and returning the new value
    // !!! WARNING
    //     To generate a unique property ID using the same label make sure to insert
    //     a `#` at the beginning. It will not be shown but guarantees correct behavior.
    //
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~c
    // i32 nk_propertyi(struct nk_context *ctx, const char *name, i32 min, i32 val, i32 max, i32 step, float inc_per_pixel);
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    //
    // Parameter           | Description
    // --------------------|-----------------------------------------------------------
    // __ctx__             | Must point to an previously initialized `nk_context` struct after calling a layouting function
    // __name__            | String used both as a label as well as a unique identifier
    // __min__             | Minimum value not allowed to be underflown
    // __val__             | Current integer value to be modified and returned
    // __max__             | Maximum value not allowed to be overflown
    // __step__            | Increment added and subtracted on increment and decrement button
    // __inc_per_pixel__   | Value per pixel added or subtracted on dragging
    //
    // Returns the new modified integer value
    */
    propertyi :: proc(ctx: ^Context, name: cstring, min, val, max, step: i32, inc_per_pixel: f32) -> i32 ---

    /*
    // #### nk_propertyf
    // Float property modifying a passed in value and returning the new value
    // !!! WARNING
    //     To generate a unique property ID using the same label make sure to insert
    //     a `#` at the beginning. It will not be shown but guarantees correct behavior.
    //
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~c
    // float nk_propertyf(struct nk_context *ctx, const char *name, float min, float val, float max, float step, float inc_per_pixel);
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    //
    // Parameter           | Description
    // --------------------|-----------------------------------------------------------
    // __ctx__             | Must point to an previously initialized `nk_context` struct after calling a layouting function
    // __name__            | String used both as a label as well as a unique identifier
    // __min__             | Minimum value not allowed to be underflown
    // __val__             | Current float value to be modified and returned
    // __max__             | Maximum value not allowed to be overflown
    // __step__            | Increment added and subtracted on increment and decrement button
    // __inc_per_pixel__   | Value per pixel added or subtracted on dragging
    //
    // Returns the new modified float value
    */
    propertyf :: proc(ctx: ^Context, name: cstring, min, val, max, step: f32, inc_per_pixel: f32) -> f32 ---

    /*
    // #### nk_propertyd
    // Float property modifying a passed in value and returning the new value
    // !!! WARNING
    //     To generate a unique property ID using the same label make sure to insert
    //     a `#` at the beginning. It will not be shown but guarantees correct behavior.
    //
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~c
    // float nk_propertyd(struct nk_context *ctx, const char *name, double min, double val, double max, double step, double inc_per_pixel);
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    //
    // Parameter           | Description
    // --------------------|-----------------------------------------------------------
    // __ctx__             | Must point to an previously initialized `nk_context` struct after calling a layouting function
    // __name__            | String used both as a label as well as a unique identifier
    // __min__             | Minimum value not allowed to be underflown
    // __val__             | Current double value to be modified and returned
    // __max__             | Maximum value not allowed to be overflown
    // __step__            | Increment added and subtracted on increment and decrement button
    // __inc_per_pixel__   | Value per pixel added or subtracted on dragging
    //
    // Returns the new modified double value
    */
    propertyd :: proc(ctx: ^Context, name: cstring, min, val, max, step: f64, inc_per_pixel: f32) -> f64 ---

    edit_string :: proc(ctx: ^Context, flags: Edit_Flags, buffer: [^]u8, len: ^i32, max: i32, fn: Plugin_Filter) -> Flags ---
    edit_string_zero_terminated :: proc(ctx: ^Context, flags: Edit_Flags, buffer: [^]u8, max: i32, fn: Plugin_Filter) -> Flags ---
    edit_buffer :: proc(ctx: ^Context, flags: Flags, text_edit: ^Text_Edit, fn: Plugin_Filter) -> Flags ---
    edit_focus :: proc(ctx: ^Context, flags: Flags) ---
    edit_unfocus :: proc(ctx: ^Context) ---

    chart_begin :: proc(ctx: ^Context, type: Chart_Type, num: i32, min, max: f32) -> bool ---
    chart_begin_colored :: proc(ctx: ^Context, type: Chart_Type, color, active: Color, num: i32, min, max: f32) -> bool ---
    chart_add_slot :: proc(ctx: ^Context, type: Chart_Type, count: i32, min_value, max_value: f32) ---
    chart_add_slot_colored :: proc(ctx: ^Context, type: Chart_Type, color, active: Color, count: i32, min_value, max_value: f32) ---
    chart_push :: proc(ctx: ^Context, f: f32) -> Flags ---
    chart_push_slot :: proc(ctx: ^Context, f: f32, i: i32) -> Flags ---
    chart_end :: proc(ctx: ^Context) ---
    plot :: proc(ctx: ^Context, type: Chart_Type, values: [^]f32, count, offset: i32) ---
    plot_function :: proc(ctx: ^Context, type: Chart_Type, userdata: rawptr, p: proc "c" (user: rawptr, index: i32) -> f32, count, offset: i32) ---

    popup_begin :: proc(ctx: ^Context, type: Popup_Type, name: cstring, flags: Panel_Flags, bounds: Rect) -> bool ---
    popup_close :: proc(ctx: ^Context) ---
    popup_end :: proc(ctx: ^Context) ---
    popup_get_scroll :: proc(ctx: ^Context, offset_x, offset_y: ^u32) ---
    popup_set_scroll :: proc(ctx: ^Context, offset_x, offset_y: u32) ---

    combo :: proc(ctx: ^Context, items: [^]cstring, count, selected, item_height: i32, size: Vec2) -> i32 ---
    combo_separator :: proc(ctx: ^Context, items_separated_by_separator: cstring, separator, selected, count, item_height: i32, size: Vec2) -> i32 ---
    combo_string :: proc(ctx: ^Context, items_separated_by_zeros: cstring, selected, count, item_height: i32, size: Vec2) -> i32 ---
    combo_callback :: proc(ctx: ^Context, item_getter: proc "c" (rawptr, i32, [^]cstring), userdata: rawptr, selected, count, item_height: i32, size: Vec2) -> i32 ---
    combobox :: proc(ctx: ^Context, items: [^]cstring, count: i32, selected: ^i32, item_height: i32, size: Vec2) ---
    combobox_string :: proc(ctx: ^Context, items_separated_by_zeros: cstring, selected: ^i32, count, item_height: i32, size: Vec2) ---
    combobox_separator :: proc(ctx: ^Context, items_separated_by_separator: cstring, separator: i32, selected: ^i32, count, item_height: i32, size: Vec2) ---
    combobox_callback :: proc(ctx: ^Context, item_getter: proc "c"(rawptr, i32, [^]cstring), userdata: rawptr, selected: ^i32, count, item_height: i32, size: Vec2) ---

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
    combo_item_text :: proc(ctx: ^Context, text: cstring, len: i32, alignment: Flags) -> bool ---
    combo_item_image_label :: proc(ctx: ^Context, img: Image, text: cstring, alignment: Flags) -> bool ---
    combo_item_image_text :: proc(ctx: ^Context, img: Image, text: cstring, len: i32, alignment: Flags) -> bool ---
    combo_item_symbol_label :: proc(ctx: ^Context, symbol: Symbol_Type, text: cstring, alignment: Flags) -> bool ---
    combo_item_symbol_text :: proc(ctx: ^Context, symbol: Symbol_Type, text: cstring, len: i32, alignment: Flags) -> bool ---
    combo_close :: proc(ctx: ^Context) ---
    combo_end :: proc(ctx: ^Context) ---

    contextual_begin :: proc(ctx: ^Context, flags: Flags, v: Vec2, trigger_bounds: Rect) -> bool ---
    contextual_item_text :: proc(ctx: ^Context, text: cstring, len: i32, align: Flags) -> bool ---
    contextual_item_label :: proc(ctx: ^Context, text: cstring, align: Flags) -> bool ---
    contextual_item_image_label :: proc(ctx: ^Context, img: Image, text: cstring, alignment: Flags) -> bool ---
    contextual_item_image_text :: proc(ctx: ^Context, img: Image, text: cstring, len: i32, alignment: Flags) -> bool ---
    contextual_item_symbol_label :: proc(ctx: ^Context, symbol: Symbol_Type, text: cstring, alignment: Flags) -> bool ---
    contextual_item_symbol_text :: proc(ctx: ^Context, symbol: Symbol_Type, text: cstring, len: i32, alignment: Flags) -> bool ---
    contextual_close :: proc(ctx: ^Context) ---
    contextual_end :: proc(ctx: ^Context) ---

    tooltip :: proc(ctx: ^Context, str: cstring) ---

    when #config(NK_INCLUDE_STANDARD_VARARGS, false)
    {
        // tooltipf :: proc(ctx: ^Context, NK_PRINTF_FORMAT_STRING const char*, ...) NK_PRINTF_VARARG_FUNC(2);
        // tooltipfv :: proc(ctx: ^Context, NK_PRINTF_FORMAT_STRING const char*, va_list) NK_PRINTF_VALIST_FUNC(2);
    }

    tooltip_begin :: proc(ctx: ^Context, width: f32) -> bool ---
    tooltip_end :: proc(ctx: ^Context) ---

    menubar_begin :: proc(ctx: ^Context) ---
    menubar_end :: proc(ctx: ^Context) ---
    menu_begin_text :: proc(ctx: ^Context, str: cstring, title_len: i32, align: Flags, size: Vec2) -> bool ---
    menu_begin_label :: proc(ctx: ^Context, str: cstring, align: Text_Alignment, size: Vec2) -> bool ---
    menu_begin_image :: proc(ctx: ^Context, str: cstring, img: Image, size: Vec2) -> bool ---
    menu_begin_image_text :: proc(ctx: ^Context, str: cstring, len: i32, align: Flags, img: Image, size: Vec2) -> bool ---
    menu_begin_image_label :: proc(ctx: ^Context, str: cstring, align: Flags, img: Image, size: Vec2) -> bool ---
    menu_begin_symbol :: proc(ctx: ^Context, str: cstring, symbol: Symbol_Type, size: Vec2) -> bool ---
    menu_begin_symbol_text :: proc(ctx: ^Context, str: cstring, len: i32, align: Flags, symbol: Symbol_Type, size: Vec2) -> bool ---
    menu_begin_symbol_label :: proc(ctx: ^Context, str: cstring, align: Flags, symbol: Symbol_Type, size: Vec2) -> bool ---
    menu_item_text :: proc(ctx: ^Context, str: cstring, len: i32, align: Flags) -> bool ---
    menu_item_label :: proc(ctx: ^Context, str: cstring, alignment: Flags) -> bool ---
    menu_item_image_label :: proc(ctx: ^Context, img: Image, str: cstring, alignment: Flags) -> bool ---
    menu_item_image_text :: proc(ctx: ^Context, img: Image, str: cstring, len: i32, alignment: Flags) -> bool ---
    menu_item_symbol_text :: proc(ctx: ^Context, symbol: Symbol_Type, str: cstring, i32, alignment: Flags) -> bool ---
    menu_item_symbol_label :: proc(ctx: ^Context, symbol: Symbol_Type, str: cstring, alignment: Flags) -> bool ---
    menu_close :: proc(ctx: ^Context) ---
    menu_end :: proc(ctx: ^Context) ---

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

    handle_ptr :: proc(ptr: rawptr) -> Handle ---
    handle_id :: proc(id: i32) -> Handle ---
    image_handle :: proc(handle: Handle) -> Image ---
    image_ptr :: proc(ptr: rawptr) -> Image ---
    image_id :: proc(id: i32) -> Image ---
    image_is_subimage :: proc(img: ^Image) -> bool ---
    subimage_ptr :: proc(ptr: rawptr, w, h: u16, sub_region: Rect) -> Image ---
    subimage_id :: proc(id: i32, w, h: u16, sub_region: Rect) -> Image ---
    subimage_handle :: proc(handle: Handle, w, h: u16, sub_region: Rect) -> Image ---

    nine_slice_handle :: proc(handle: Handle, l, t, r, b: u16) -> Nine_Slice ---
    nine_slice_ptr :: proc(ptr: rawptr, l, t, r, b: u16) -> Nine_Slice ---
    nine_slice_id :: proc(id: i32, l, t, r, b: u16) -> Nine_Slice ---
    nine_slice_is_sub9slice :: proc(img: ^Nine_Slice) -> i32 ---
    sub9slice_ptr :: proc(ptr: rawptr, w, h: u16, sub_region: Rect, l, t, r, b: u16) -> Nine_Slice ---
    sub9slice_id :: proc(i32, w, h: u16, sub_region: Rect, l, t, r, b: u16) -> Nine_Slice ---
    sub9slice_handle :: proc(handle: Handle, w, h: u16, sub_region: Rect, l, t, r, b: u16) -> Nine_Slice ---

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

    strlen :: proc(str: cstring) -> i32 ---
    stricmp :: proc(s1, s2: cstring) -> i32 ---
    stricmpn :: proc(s1, s2: cstring, n: i32) -> i32 ---
    strtoi :: proc(str: cstring, endptr: [^]cstring) -> i32 ---
    strtof :: proc(str: cstring, endptr: [^]cstring) -> f32 ---

    when #config(NK_STRTOD, true)
    {
        strtod :: proc(str: cstring, endptr: [^]cstring) -> f64 ---
    }

    strfilter :: proc(text, regexp: cstring) -> i32 ---
    strmatch_fuzzy_string :: proc(str, pattern: cstring, out_score: ^i32) -> i32 ---
    strmatch_fuzzy_text :: proc(txt: cstring, txt_len: i32, pattern: cstring, out_score: ^i32) -> i32 ---

    utf_decode :: proc(cstring, ^rune, i32) -> i32 ---
    utf_encode :: proc(rune, ^u8, i32) -> i32 ---
    utf_len :: proc(cstring, byte_len: i32) -> i32 ---
    utf_at :: proc(buffer: cstring, length, index: i32, unicode: ^rune, len: ^i32) -> cstring ---

    /* some language glyph codepoint ranges */
    font_default_glyph_ranges :: proc() -> ^rune ---
    font_chinese_glyph_ranges :: proc() -> ^rune ---
    font_cyrillic_glyph_ranges :: proc() -> ^rune ---
    font_korean_glyph_ranges :: proc() -> ^rune ---

    when INCLUDE_FONT_BAKING
    {
        when INCLUDE_FONT_BAKING
        {
            font_atlas_init_default :: proc(^Font_Atlas) ---
        }

        font_atlas_init :: proc(^Font_Atlas, ^Allocator) ---
        font_atlas_init_custom :: proc(atlas: ^Font_Atlas, persistent, transient: ^Allocator) ---
        font_atlas_begin :: proc(^Font_Atlas) ---

        font_config :: proc(pixel_height: f32) -> Font_Config ---
        font_atlas_add :: proc(^Font_Atlas, ^Font_Config) -> ^Font ---

        when INCLUDE_DEFAULT_FONT
        {
            font_atlas_add_default :: proc(atlas: ^Font_Atlas, height: f32, config: ^Font_Config) -> ^Font
        }

        font_atlas_add_from_memory :: proc(atlas: ^Font_Atlas, memory: rawptr, size: Size, height: f32, config: ^Font_Config) -> ^Font ---

        when INCLUDE_STANDARD_IO
        {
            font_atlas_add_from_file :: proc(atlas: ^Font_Atlas, file_path: cstring, height: f32, config: ^Font_Config) -> ^Font ---
        }

        font_atlas_add_compressed :: proc(atlas: ^Font_Atlas, memory: rawptr, size: Size, height: f32, config: ^Font_Config) -> ^Font ---
        font_atlas_add_compressed_base85 :: proc(atlas: ^Font_Atlas, data: cstring, height: f32, config: ^Font_Config) -> ^Font ---
        font_atlas_bake :: proc(atlas: ^Font_Atlas, width, height: ^i32, fmt: Font_Atlas_Format) -> rawptr
        font_atlas_end :: proc(atlas: ^Font_Atlas, tex: Handle, null: ^Draw_Null_Texture) ---
        font_find_glyph :: proc(font: ^Font, unicode: rune) -> ^Font_Glyph ---
        font_atlas_cleanup :: proc(atlas: ^Font_Atlas) ---
        font_atlas_clear :: proc(atlas: ^Font_Atlas) ---
    }

    when INCLUDE_DEFAULT_ALLOCATOR
    {
        buffer_init_default :: proc(^Buffer) ---
    }

    buffer_init :: proc(buffer: ^Buffer, allocator: ^Allocator, size: Size) ---
    buffer_init_fixed :: proc(buffer: ^Buffer, memory: rawptr, size: Size) ---
    buffer_info :: proc(status: ^Memory_Status, buffer: ^Buffer) ---
    buffer_push :: proc(buffer: ^Buffer, type: Buffer_Allocation_Type, memory: rawptr, size, align: Size) ---
    buffer_mark :: proc(buffer: ^Buffer, type: Buffer_Allocation_Type) ---
    buffer_reset :: proc(buffer: ^Buffer, type: Buffer_Allocation_Type) ---
    buffer_clear :: proc(buffer: ^Buffer) ---
    buffer_free :: proc(buffer: ^Buffer) ---
    buffer_memory :: proc(buffer: ^Buffer) -> rawptr ---
    buffer_memory_const :: proc(buffer: ^Buffer) -> rawptr ---
    buffer_total :: proc(buffer: ^Buffer) -> Size ---

    when INCLUDE_DEFAULT_ALLOCATOR
    {
        str_init_default :: proc(str: ^Str) ---
    }

    str_init :: proc(str: ^Str, allocator: ^Allocator, size: Size) ---
    str_init_fixed :: proc(str: ^Str, memory: rawptr, size: Size) ---
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

    when INCLUDE_DEFAULT_ALLOCATOR
    {
        textedit_init_default :: proc(edit: ^Text_Edit) ---
    }

    textedit_init :: proc(edit: ^Text_Edit, allocator: ^Allocator, size: Size) ---
    textedit_init_fixed :: proc(edit: ^Text_Edit, memory: rawptr, size: Size) ---
    textedit_free :: proc(edit: ^Text_Edit) ---
    textedit_text :: proc(edit: ^Text_Edit, cstr: cstring, total_len: i32) ---
    textedit_delete :: proc(edit: ^Text_Edit, where_, len: i32) ---
    textedit_delete_selection :: proc(edit: ^Text_Edit) ---
    textedit_select_all :: proc(edit: ^Text_Edit) ---
    textedit_cut :: proc(edit: ^Text_Edit) -> bool ---
    textedit_paste :: proc(edit: ^Text_Edit, cstr: cstring, len: i32) -> bool ---
    textedit_undo :: proc(edit: ^Text_Edit) ---
    textedit_redo :: proc(edit: ^Text_Edit) ---

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

    when INCLUDE_VERTEX_BUFFER_OUTPUT
    {
        draw_list_init :: proc(list: ^Draw_List) ---
        draw_list_setup :: proc(list: ^Draw_List, cfg: ^Convert_Config, cmds, vertices, elements: ^Buffer, line_aa,shape_aa: Anti_Aliasing) ---
        
        _draw_list_begin :: proc(list: ^Draw_List, buffer: ^Buffer) -> ^Draw_Command ---
        _draw_list_next :: proc(cmd: ^Draw_Command, buffer: ^Buffer, list: ^Draw_List) -> ^Draw_Command ---
        _draw_list_end :: proc(list: ^Draw_List, buffer: ^Buffer) -> ^Draw_Command ---
        
        draw_list_path_clear :: proc(list: ^Draw_List) ---
        draw_list_path_line_to :: proc(list: ^Draw_List, pos: Vec2) ---
        draw_list_path_arc_to_fast :: proc(list: ^Draw_List, center: Vec2, radius: f32, a_min, a_max: i32) ---
        draw_list_path_arc_to :: proc(list: ^Draw_List, center: Vec2, radius, a_min, a_max: f32, segments: u32) ---
        draw_list_path_rect_to :: proc(list: ^Draw_List, a, b: Vec2, rounding: f32) ---
        draw_list_path_curve_to :: proc(list: ^Draw_List, p2, p3, p4: Vec2, num_segments: u32) ---
        draw_list_path_fill :: proc(list: ^Draw_List, color: Color) ---
        draw_list_path_stroke :: proc(list: ^Draw_List, color: Color, closed: Draw_List_Stroke, thickness: f32) ---

        draw_list_stroke_line :: proc(list: ^Draw_List, a, b: Vec2, color: Color, thickness: f32) ---
        draw_list_stroke_rect :: proc(list: ^Draw_List, rect: Rect, color: Color, rounding, thickness: f32) ---
        draw_list_stroke_triangle :: proc(list: ^Draw_List, a, b, c: Vec2, color: Color, thickness: f32) ---
        draw_list_stroke_circle :: proc(list: ^Draw_List, center: Vec2, radius: f32, color: Color, segs: u32, thickness: f32) ---
        draw_list_stroke_curve :: proc(list: ^Draw_List, p0, cp0, cp1, p1: Vec2, color: Color, segments: u32, thickness: f32) ---
        draw_list_stroke_poly_line :: proc(list: ^Draw_List, pnts: [^]Vec2, cnt: u32, color: Color, stroke: Draw_List_Stroke, thickness: f32, aa: Anti_Aliasing) ---

        draw_list_fill_rect :: proc(list: ^Draw_List, rect: Rect, color: Color, rounding: f32) ---
        draw_list_fill_rect_multi_color :: proc(list: ^Draw_List, rect: Rect, left, top, right, bottom: Color) ---
        draw_list_fill_triangle :: proc(list: ^Draw_List, a, b, c: Vec2, color: Color) ---
        draw_list_fill_circle :: proc(list: ^Draw_List, center: Vec2, radius: f32, color: Color, segs: u32) ---
        draw_list_fill_poly_convex :: proc(list: ^Draw_List, points: [^]Vec2, count: u32, color: Color, aa: Anti_Aliasing) ---

        draw_list_add_image :: proc(list: ^Draw_List, texture: Image, rect: Rect, color: Color) ---
        draw_list_add_text :: proc(list: ^Draw_List, font: ^User_Font, rect: Rect, text: cstring, len: i32, font_height: f32, color: Color) ---

        when INCLUDE_COMMAND_USERDATA
        {
            draw_list_push_userdata :: proc(list: ^Draw_List, userdata: Handle) ---
        }
    }

    style_item_color :: proc(color: Color) -> Style_Item ---
    style_item_image :: proc(img: Image) -> Style_Item ---
    style_item_nine_slice :: proc(slice: Nine_Slice) -> Style_Item ---
    style_item_hide :: proc() -> Style_Item ---
}
    
INCLUDE_FONT_BAKING :: #config(NK_INCLUDE_FONT_BAKING, false)
INCLUDE_DEFAULT_ALLOCATOR :: #config(NK_INCLUDE_DEFAULT_ALLOCATOR, false)
INCLUDE_DEFAULT_FONT :: #config(NK_INCLUDE_DEFAULT_FONT, false)
INCLUDE_STANDARD_IO :: #config(NK_INCLUDE_STANDARD_IO, false)


import "core:strings"
import "core:fmt"

text_string :: #force_inline proc(ctx: ^Context, name: string, alignment: Text_Alignment)
{
    text(ctx, raw_data(name), cast(i32)len(name), alignment)
}

label_string :: proc(ctx: ^Context, name: string, align: Text_Alignment)
{
    cstr_name, err := strings.clone_to_cstring(name, context.temp_allocator)
    if err != .None do return
    label(ctx, cstr_name, align)
}

label_args :: proc(ctx: ^Context, align: Text_Alignment, args: ..any, sep := " ")
{
    b: strings.Builder
    strings.builder_init_len_cap(&b, 0, 1024, context.temp_allocator)
    fmt.sbprint(&b, args = args, sep = sep)
    strings.write_byte(&b, 0)
    data := strings.to_string(b)
    label(ctx, transmute(cstring)raw_data(data), align)
}

checkbox_text_args :: proc(ctx: ^Context, active: ^bool, args: ..any, sep := " ") -> bool
{
    b: strings.Builder
    strings.builder_init_len_cap(&b, 0, 1024, context.temp_allocator)
    fmt.sbprint(&b, args = args, sep = sep)
    strings.write_byte(&b, 0)
    data := strings.to_string(b)
    return checkbox_label(ctx, transmute(cstring)raw_data(data), active)
}

selectable_text_string :: #force_inline proc "contextless" (ctx: ^Context, label: string, align: Text_Alignment, value: ^bool) -> bool
{
    return selectable_text(ctx, raw_data(label), cast(i32)len(label), align, value)
}

@(deferred_in=widget_disable_end)
widget_quick_disable :: proc(ctx: ^Context)
{
    widget_disable_begin(ctx)
}

tree_push_string :: proc(ctx: ^Context, type: Tree_Type, title: string, initial_state: Collapse_States, caller_location := #caller_location) -> bool
{
    cstr_title, cstr_title_allocation_error := strings.clone_to_cstring(title, context.temp_allocator)
    if cstr_title_allocation_error != .None do return false
    return tree_push_hashed(ctx, type, cstr_title, initial_state, raw_data(caller_location.procedure), cast(i32)len(caller_location.procedure), caller_location.line)
}

tree_push_string_hash_args :: proc(ctx: ^Context, type: Tree_Type, title: string, initial_state: Collapse_States, hash_args: ..any, hash_args_sep := " ", caller_location := #caller_location) -> bool
{
    cstr_title, cstr_title_allocation_error := strings.clone_to_cstring(title, context.temp_allocator)
    if cstr_title_allocation_error != .None do return false

    b: strings.Builder
    strings.builder_init_len_cap(&b, 0, 1024, context.temp_allocator)
    fmt.sbprint(&b, args = hash_args, sep = hash_args_sep)
    strings.write_byte(&b, 0)
    args_string := strings.to_string(b)

    return tree_push_hashed(ctx, type, cstr_title, initial_state, raw_data(args_string), cast(i32)len(args_string), caller_location.line)
}