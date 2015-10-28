<domscii-demo>
  <div class="domscii-demo-header">
    <h2>Demo</h2>
    <select value={viewing} onchange={updateViewing}>
      <option value="dom">  DOM</option>
      <option value="ascii">ASCII</option>
    </select>
  </div
  ><textarea value={html} onkeyup={updateHTML} rows="5" cols="80" />
  <domscii html={html} onrender={onDomsciiRender} onmousemove={setMouse} onmouseout={clearMouse} />

  <style>
    domscii-demo { display: block; }
    domscii-demo .domscii-demo-header { display: inline-block; vertical-align: top; margin-right: 20px; }
    domscii-demo h2 { margin: 0 0 5px 0; }
    domscii-demo domscii div { margin-top: 20px; }
  </style>

  var self = this;
  self.viewing = 'ascii';
  self.html = '<img src="spec/fixtures/googlelogo_color_272x92dp.png">';
  self._chars = [];
  self.updateHTML = function (evt) {
    self.html = self.tags.domscii.opts.html = evt.target.value;
    self.tags.domscii.render();
  };
  self.onDomsciiRender = function () {
    self._chars = [].slice.call(self.tags.domscii.root.querySelectorAll('pre span'));
    self.renderCloseToMouse();
  };
  self.updateViewing = function (evt) {
    self.viewing = evt.target.value;
    self.renderCloseToMouse();
  };
  self.setMouse = function (evt) {
    self.mouseEvt = evt;
    self.renderCloseToMouse();
  };
  self.clearMouse = self.setMouse.bind(self, null);
  self.renderCloseToMouse = function () {
    requestAnimationFrame(function () {
      if (self.mouseEvt) {
        var x = self.mouseEvt.offsetX || self.mouseEvt.layerX;
        var y = self.mouseEvt.offsetY || self.mouseEvt.layerY;
      }
      self._chars.forEach(function (span) {
        var closeToMouse = !!self.mouseEvt && Math.sqrt(
          Math.pow(span.offsetLeft - x, 2) +
          Math.pow(span.offsetTop  - y, 2)
        ) < 50;
        span.style.visibility = closeToMouse === (self.viewing === 'dom')
          ? 'visible'
          : 'hidden';
      });
    });
  };
</domscii-demo>
