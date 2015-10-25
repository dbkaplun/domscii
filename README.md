# domscii &bull; [demo](http://dbkaplun.github.io/domscii/)
Convert arbitrary DOM elements to ASCII

## Installation

```html
<script src="https://cdnjs.cloudflare.com/ajax/libs/html2canvas/0.5.0-beta1/html2canvas.min.js"></script>
<script src="https://dbkaplun.github.io/domscii/domscii.js"></script>
```

## Usage

```js
function handleASCII (ascii) { console.log(ascii); }
domscii(opts).then(handleASCII);
// or
domscii(el).then(handleASCII);
```

### Options

```js
domscii({
    el: undefined, // The element to render to ASCII. (No default value.)

    template: '<span style="color:${color}">${char}</span>', // How each character is formatted. Replaces '${color}' with an RGB value, and '${char}' with a representative ASCII character. For plaintext rendering, use '${char}'.
    chars: '@#$=*!;:~-,.', // The ASCII characters to use for rendering, darkest to lightest. This can also be an array of strings.
    newline: '\n', // The string to use for starting a new line of ASCII.
    scaleX: 7.875, // Determines how many pixels are used for one ASCII character, horizontally.
    scaleY: 15 // Determines how many pixels are used for one ASCII character, vertically.
});
```
