package raven_example_hello_minimal

import "core:log"
import "core:math"
import rv "../.."

main :: proc() {
    context = rv.default_context()
    context.logger = log.create_console_logger()

    rv.init("Raven Hello Example")
    defer rv.shutdown()

    for rv.new_frame() {
        rv.set_layer_params(0, rv.make_screen_camera())

        rv.bind_texture("thin")
        rv.bind_depth_test(false)
        rv.bind_fill(.All)

        rv.draw_text("Hello World!",
            rv.get_viewport() * {0.5, 0.5, 0} + {0, math.sin_f32(rv.get_time()) * 100, 0},
            anchor = 0.5,
            scale = 4,
        )

        state.num += 1

        rv.upload_gpu_layers()

        rv.render_gpu_layer(0, rv.DEFAULT_RENDER_TEXTURE,
            clear_color = rv.Vec3{0, 0, 0.5},
            clear_depth = true,
        )
    }
}
