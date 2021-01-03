
var clog = console.log;
var cerr = console.err;

function elt(start, sel) {
  if ( ! sel) { sel = start; start = null; }
  if ( ! start && typeof sel !== 'string') return sel;
  return (start || document).querySelector(sel); };
function elts(start, sel) {
  if ( ! sel) { sel = start; start = null; }
  if ( ! start && typeof sel !== 'string') return [ sel ];
  return Array.from((start || document).querySelectorAll(sel)); }
function on(start, sel, eventName, callback) {
  if (typeof eventName == 'function') {
    callback = eventName; eventName = sel; sel = start; start = null; }
  var es = elts(start, sel);
  es.forEach(function(e) { e.addEventListener(eventName, callback); });
  return es; }
function onDocumentReady(f) {
  if (document.readyState != 'loading') f();
  else document.addEventListener('DOMContentLoaded', f); };
    //
    // from https://github.com/jmettraux/h.js

onDocumentReady(function() {

  on(
    '#article-monsters h1', 'click',
    function() { window.location.href = '#Index'; });
});

