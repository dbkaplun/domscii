#!/usr/bin/env node

var url = require('url');
var path = require('path');
var fs = require('fs');

var test = require('tape');
var express = require('express');
var Nightmare = require('nightmare');

test("domscii", function (t) {
    var app = express();
    app.use(express.static(path.join(__dirname, '..')));
    var server = app.listen(0);
    var nightmare = Nightmare();

    t.on('end', function () {
        nightmare
            .end()
            .then(function () { server.close(); }); // .then() is required or nightmare never closes
    });

    nightmare
        .goto(url.format({
            protocol: 'http',
            hostname: 'localhost',
            port: server.address().port,
            pathname: 'spec'
        }))
        .then(function () {
            t.test("encodes an <img> correctly", function (st) {
                st.plan(1);

                var src = 'fixtures/afghan-girl-portrait_1563_990x742.jpg';

                nightmare
                    .evaluate(function (src) {
                        var img = document.createElement('img');
                        img.src = src;
                        document.body.appendChild(img);
                        img.onload = function () {
                            domscii(img).then(function (text) {
                                img.parentElement.removeChild(img);
                                var pre = document.createElement('pre');
                                pre.id = 'out';
                                pre.innerHTML = text;
                                document.body.appendChild(pre);
                            });
                        };
                    }, src)
                    .wait('#out')
                    .evaluate(function () {
                        var out = document.querySelector('#out');
                        var text = out.innerHTML;
                        out.parentElement.removeChild(out);
                        return text;
                    })
                    .then(function (text) {
                        st.equal(trim(text), trim(fs.readFileSync(path.join(__dirname, src+'.defaults.out'), 'utf8')));
                    });
            });
        });
});

trim.surroundingWhitespaceRegex = /^\s+|\s+$/g;
function trim (str) {
    return str.replace(trim.surroundingWhitespaceRegex, '');
}
