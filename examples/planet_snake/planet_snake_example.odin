package raven_planet_snake_example

import rv "../.."

state: ^State

State :: struct {

}

main :: proc() {
    rv.run_main_loop(_module_api())
}

@export _module_api :: proc "contextless" () -> (rv.Module_API) {
    return {
        state_size = size_of(State),
        init = transmute(rv.Init_Proc)_init,
        shutdown = transmute(rv.Shutdown_Proc)_shutdown,
        update = transmute(rv.Update_Proc)_update,
    }
}

_init :: proc() -> ^State {
    state = new(State)


}