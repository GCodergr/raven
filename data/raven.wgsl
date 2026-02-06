struct Global_Constants {
    time        : f32,
    delta_time  : f32,
    frame       : u32,
    resolution  : vec2<i32>,
    rand_seed   : u32,
    param0      : u32,
    param1      : u32,
    param2      : u32,
    param3      : u32,
};

struct Batch_Constants {
    instance_offset : u32,
    vertex_offset   : u32,
};

struct Layer_Constants {
    view_proj : mat4x4<f32>,
    cam_pos   : vec3<f32>,
};

@group(0) @binding(8)
var<uniform> rv_global : Global_Constants;

@group(0) @binding(9)
var<uniform> layer_consts : Layer_Constants;

@group(0) @binding(10)
var<uniform> batch_consts : Batch_Constants;

struct Vertex {
    pos    : vec3<f32>,
    uv     : vec2<f32>,
    normal : u32,
    col    : u32,
};

struct Sprite_Inst {
    pos: vec3<f32>,
    col: u32,
    mat_x: vec3<f32>,
    uv_min: u32,
    mat_y: vec3<f32>,
    uv_size: u32,
    add_col: u32,
    param: u32,
    tex_slice: u32,
    _pad0: u32,
};

struct Mesh_Inst {
    pos: vec3<f32>,
    col: u32,
    mat_x: vec3<f32>,
    add_col: u32,
    mat_y: vec3<f32>,
    tex_slice_vert_offs: u32,
    mat_z: vec3<f32>,
    param: u32,
};

struct VS_Out {
    @builtin(position) pos : vec4<f32>,
    @location(0) world_pos : vec3<f32>,
    @location(1) normal    : vec3<f32>,
    @location(2) uv        : vec2<f32>,
    @location(3) col       : vec4<f32>,
    @location(4) add_col   : vec4<f32>,
    @location(5)  @interpolate(flat) tex_slice : u32,
};

fn unpack_unorm8(val : u32) -> vec4<f32> {
    return vec4<f32>(
        f32((val      ) & 0xFFu),
        f32((val >>  8) & 0xFFu),
        f32((val >> 16) & 0xFFu),
        f32((val >> 24) & 0xFFu),
    ) * (1.0 / 255.0);
}

fn unpack_unorm16(val : u32) -> vec2<f32> {
    return vec2<f32>(
        f32((val      ) & 0xFFFFu),
        f32((val >> 16) & 0xFFFFu),
    ) * (1.0 / 65535.0);
}


fn unpack_signed_color_unorm8(val : u32) -> vec4<f32> {
    return unpack_unorm8(val) * 4.0f - 2.0f;
}

fn unpack_uv_unorm16(val : u32) -> vec2<f32> {
    return unpack_unorm16(val) * 16.0f - 8.0f;
}
