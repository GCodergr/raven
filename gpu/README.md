# Raven GPU

This is a GPU abstraction layer which can be used independently from all the other Raven packages.

The goal is to have an abstraction layer on a similar level to D3D11, but support more platforms.

Currently the following APIs are supported:
- D3D11
- WebGPU (both native and web)

Features
- Explicit pipelines, but there is internal cache for immediate-mode API
- No retained-mode creation of resources like blend modes, samplers, rasterizers states or depth stencil. It's fully immediate-mode.
- Simple validation layer