<domscii>
  <div>
    <div id="dom" />
    <pre id="ascii" />
  </div>

  <style>
    domscii { position: relative; display: block; }
    domscii pre { position: absolute; top: 0; left: 0; margin: 0; }
  </style>

  var self = this;
  self.render = function () {
    requestAnimationFrame(function () {
      self.dom.innerHTML = self.opts.html;
      domscii({el: self.dom}).then(function (ascii) {
        self.ascii.innerHTML = ascii;
        if (typeof self.opts.onrender === 'function') self.opts.onrender();
      });
    });
  };
  self.imagesLoaded = imagesLoaded(self.root);
  self.imagesLoaded.on('always', self.render);
  self.on('mount', self.render);
</domscii>
