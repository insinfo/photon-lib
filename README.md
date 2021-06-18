# photon-test
photon-test

test the lib "Photon_rs" to verify feasibility of integration with an AngularDart app

compiled with:

```console
 wasm-pack build --target no-modules --debug
```
serve with:

```console
 http-server .\pkg\
```

npm install -g dart_js_facade_gen
dart_js_facade_gen --destination=D:\MyRustProjects\photon\crate\pkg\ --base-path=D:\MyRustProjects\photon\crate\pkg\ D:\MyRustProjects\photon\crate\pkg\photon_rs_bg.wasm.d.ts