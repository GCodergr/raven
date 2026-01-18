package raven_example_hello

import "core:log"
import "core:math"
import rv "../.."

state: ^State
State :: struct {
    num:    i32,
    raven:  ^rv.State,
}

main :: proc() {
    rv.run_main_loop(cast(rv.Step_Proc)_step)
}

@export _step :: proc "contextless" (prev_state: ^State) -> ^State {
    context = rv.default_context()
    // THIS LEAKS THE LOGGER FUCK
    context.logger = log.create_console_logger()

    state = prev_state
    if state == nil {
        rv.init("Raven Hello Example")
        state = new(State)
        state.raven = rv.get_state_ptr()
    }

    rv.set_state_ptr(state.raven)

    if !rv.new_frame() {
        return nil
    }

    rv.set_layer_params(0, rv.make_screen_camera())

    rv.bind_texture("thick")

    rv.draw_text("Hello World!",
        rv.get_viewport() * {0.5, 0.5, 0} + {0, math.sin_f32(rv.get_time()) * 100, 0},
        anchor = 0.5,
        spacing = 1,
        scale = 4,
    )

    state.num += 1

    rv.upload_gpu_layers()

    rv.render_gpu_layer(0, rv.DEFAULT_RENDER_TEXTURE,
        clear_color = rv.Vec3{0, 0, 0.5},
        clear_depth = true,
    )

    return state
}
