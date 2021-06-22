# photon-lib
photon-lib

fork from lib "Photon_rs" https://silvia-odwyer.github.io/photon/ Image processing on browser
this fork implemented methods (open_image_from_uint8array, resize_image_from_uint8array, to_jpeg_uint8array, decode_image_from_uint8array) for manipulate Uint8Array of image file

### example in "purejs" directory

```html
<!DOCTYPE html>
<html>

<head>
    <title>teste</title>
    <script id="script-photon" src="photon_rs.js"></script>
    <script>
        var downloadBlob, downloadURL;
        downloadBlob = function (data, fileName, mimeType) {
            var blob, url;
            blob = new Blob([data], {
                type: mimeType
            });
            url = window.URL.createObjectURL(blob);
            downloadURL(url, fileName);
            setTimeout(function () {
                return window.URL.revokeObjectURL(url);
            }, 1000);
        };
        downloadURL = function (data, fileName) {
            var a;
            a = document.createElement('a');
            a.href = data;
            a.download = fileName;
            document.body.appendChild(a);
            a.style = 'display: none';
            a.click();
            a.remove();
        };

        window.photon;
        async function initPhoton() {
            var scri = document.querySelector('#script-photon');
            var url = scri.src.replace(/\.js$/, '_bg.wasm');
            window.photon = await wasm_bindgen(url);
        }
        //initialize photon lib
        initPhoton();

        function filterImage() {
            // Create a canvas and get a 2D context from the canvas
            var canvas = document.getElementById("canvas");
            var ctx = canvas.getContext("2d");
            var newimg = document.getElementById('img');

            // Draw the image element onto the canvas
            ctx.drawImage(newimg, 0, 0);

            // Convert the ImageData found in the canvas to a PhotonImage (so that it can communicate with the core Rust library)
            let image = photon.open_image(canvas, ctx);

            // Filter the image, the PhotonImage's raw pixels are modified
            window.photon.filter(image, "radio");

            // Place the modified image back on the canvas
            window.photon.putImageData(canvas, ctx, image);
        }

        window.onload = function (e) {
            var inputFile = document.getElementById('file');
            inputFile.onchange = async function (e) {
                let t1 = performance.now();
                //convert one image file in ArrayBuffer
                var buf = await readFileAsArrayBuffer(inputFile.files[0]);
                console.log(performance.now() - t1);
                //let buf = await fetch("original.jpeg", { referrer: "" }).then(r => r.arrayBuffer()); // huge jpg              
                //process resize ArrayBuffer of image file
                let array = photon.resize_image_from_uint8array(new Uint8Array(buf), 1024, 1024, 80);
                downloadBlob(array, 'some-file.jpg', 'image/jpeg');
                console.log(performance.now() - t1);
            }
        };

        async function readFileAsArrayBuffer(file) {
            let result_base64 = await new Promise((resolve) => {
                let fileReader = new FileReader();
                fileReader.onload = (e) => resolve(fileReader.result);
                fileReader.readAsArrayBuffer(file);
            });
            return result_base64;
        }

        async function readFileAsDataURL(file) {
            let result_base64 = await new Promise((resolve) => {
                let fileReader = new FileReader();
                fileReader.onload = (e) => resolve(fileReader.result);
                fileReader.readAsDataURL(file);
            });
            return result_base64;
        }


    </script>
</head>

<body>
    <h1>teste</h1>
    <input type="file" id="file"><br>
    <img id="img" src="original.jpeg" width="640" height="480">
    <canvas id="canvas" width="640" height="480"></canvas>
</body>

</html>
```

compiled with:

```console
//for inline javascript without modules
 wasm-pack build --target=no-modules --out-dir=purejs --release   
//for ecmascript js modules
 wasm-pack build --target=web --out-dir=jsmodule --release 
```
serve with:

```console
 http .\pkg\
```
#### to fix bug on generated no-modules version: change this lines of photon_rs.js in purejs version
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