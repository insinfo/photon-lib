# photon-test
photon-test

test the lib "Photon_rs" to verify feasibility of integration with an AngularDart app

compiled with:

```console
//for inline javascript without modules
 wasm-pack build --target=no-modules --out-dir=purejs --release   
//for ecmascript js modules
 wasm-pack build --target=web --out-dir=jsmodule --release 
```
serve with:

```console
 http-server .\pkg\
```
#### to fix bug change this lines of photon_rs.js in purejs version
```js

    //return wasm;
    return merge_options(wasm, __exports);
}

    /**
         * Overwrites obj1's values with obj2's and adds obj2's if non existent in obj1
         * @param obj1
         * @param obj2
         * @returns obj3 a new object based on obj1 and obj2
         */
    function merge_options(obj1, obj2) {
        var obj3 = {};
        for (var attrname in obj1) { obj3[attrname] = obj1[attrname]; }
        for (var attrname in obj2) { obj3[attrname] = obj2[attrname]; }
        return obj3;
    }

    //wasm_bindgen = Object.assign(init, __exports);
    wasm_bindgen = init;

```

```console
//for generate dart wrap
npm install -g dart_js_facade_gen
dart_js_facade_gen --destination=D:\MyRustProjects\photon\crate\pkg\ --base-path=D:\MyRustProjects\photon\crate\pkg\ D:\MyRustProjects\photon\crate\pkg\photon_rs_bg.wasm.d.ts

```