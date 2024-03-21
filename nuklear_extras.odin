package nuklear

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