@group(0) @binding(16)
var<storage, read> instances : array<Sprite_Inst>;

@vertex
fn vs_main(
    @builtin(vertex_index)   vid     : u32,
    @builtin(instance_index) inst_id : u32,
) -> VS_Out {

    let inst : Sprite_Inst =
        instances[inst_id + batch_consts.instance_offset];

    let local_uv = vec2<f32>(f32(vid & 1u), f32(vid >> 1u));
    let local_pos = local_uv * 2.0 - vec2<f32>(1.0, 1.0);

    let world_pos = inst.pos + inst.mat_x * local_pos.x + inst.mat_y * local_pos.y;

    let uv_min = unpack_uv_unorm16(inst.uv_min);
    let uv_size = unpack_uv_unorm16(inst.uv_size);

    var o : VS_Out;
    o.pos = layer_consts.view_proj * vec4<f32>(world_pos, 1.0);
    o.world_pos = world_pos;
    o.normal = cross(inst.mat_x, inst.mat_y);
    o.uv = uv_min + uv_size * local_uv;
    o.col = unpack_signed_color_unorm8(inst.col);
    o.add_col = unpack_signed_color_unorm8(inst.add_col);
    o.tex_slice = inst.tex_slice;

    return o;
}