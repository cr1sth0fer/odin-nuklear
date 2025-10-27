package nuklear

import "base:intrinsics"
import "base:runtime"
import "core:mem"
import "core:fmt"
import "core:math"

when ODIN_OS == .Windows && ODIN_ARCH == .amd64 {
    when ODIN_DEBUG {
        @(export) foreign import lib "nuklear_windows_amd64_debug.lib"
    } else {
        @(export) foreign import lib "nuklear_windows_amd64_release.lib"
    }
}

when ODIN_ARCH == .wasm32 || ODIN_ARCH == .wasm64p32 {
    when ODIN_DEBUG {
        @(export) foreign import lib "nuklear_wasm_debug.lib"
    } else {
        @(export) foreign import lib "nuklear_wasm_release.lib"
    }
}

@(export, link_name="nuklear_assert_handler")
nuklear_assert_handler :: proc "c" (condition, file: cstring, line: i32) {
    context = runtime.default_context()
    location := runtime.Source_Code_Location{
        file_path = string(file),
        line = line,
    }
    assert(false, string(condition), location)
}

@(export, link_name="nuklear_memset")
nuklear_memset :: proc "c" (dest: rawptr, c0: i32, size: uint) {
    runtime.memset(dest, c0, int(size))
}

@(export, link_name="nuklear_memcpy")
nuklear_memcpy :: proc "c" (dst, src: rawptr, len: uint) -> rawptr {
    intrinsics.mem_copy(dst, src, int(len))
    return dst
}

@(export, link_name="nuklear_inv_sqrt")
nuklear_inv_sqrt :: proc(n: f32) -> f32 {
    return 1.0/intrinsics.sqrt(n)
}

@(export, link_name="nuklear_sin")
nuklear_sin :: proc(x: f32) -> f32 {
    return math.sin_f32(x)
}

@(export, link_name="nuklear_cos")
nuklear_cos :: proc(x: f32) -> f32 {
    return math.cos_f32(x)
}

@(export, link_name="nuklear_atan")
nuklear_atan :: proc(x: f32) -> f32 {
    return math.atan(x)
}

@(export, link_name="nuklear_atan2")
nuklear_atan2 :: proc(y, x: f32) -> f32 {
    return math.atan2_f32(y, x)
}

@(private)
nukler_allocator_alloc_proc :: proc "c" (handle: Handle, old: rawptr, size: uint) -> rawptr {
    context = runtime.default_context()
    if old != nil {
        fmt.println("OLD IS NOT NIL")
    }
    allocator := transmute(^runtime.Allocator)handle.ptr
    ptr, error := mem.alloc(int(size), allocator = allocator^)
    return ptr
}

@(private)
nukler_allocator_free_proc :: proc "c" (handle: Handle, old: rawptr) {
    context = runtime.default_context()
    allocator := transmute(^runtime.Allocator)handle.ptr
    mem.free(old, allocator = allocator^)
}

allocator_init :: proc(nk_allocator: ^Allocator, odin_allocator: ^runtime.Allocator) {
    nk_allocator^ = {
        userdata = {ptr = odin_allocator},
        alloc = nukler_allocator_alloc_proc,
        free = nukler_allocator_free_proc,
    }
}
