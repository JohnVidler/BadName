// ==UserScript==
// @name         Insultinator
// @namespace    http://tampermonkey.net/
// @version      0.1
// @description  Universally insulting text, see articles through the eyes of non-english-speakers with dirty minds :)
// @author       John Vidler
// @match        
// @grant        none
// @require http://code.jquery.com/jquery-latest.js
// ==/UserScript==
/* jshint -W097 */
'use strict';

// Your code here...

function textNodesUnder(node){
  var all = [];
  for (node=node.firstChild;node;node=node.nextSibling){
    if (node.nodeType==3) all.push(node);
    else all = all.concat(textNodesUnder(node));
  }
  return all;
}

var localDB = new Array();
$.get('https://raw.githubusercontent.com/Betawolf/BadName/master/data/swears.csv', function(data) {
    var lines = data.split("\n");
    for( var l = 0; l < lines.length; l++ ) {
        var parts = lines[l].split(",");
        if( parts && parts.length > 2 ) {
            var entry = { query:parts[0], insult:parts[2] };
            localDB.push( entry );
        }
    }
    
    console.log( "Processing..." );
    replaceText();
    console.log( "Done!" );
});

function replaceText() {
    for( var i=0; i<localDB.length; i++ ) {
        var nodes = $("*:contains('" +localDB[i].query+ "')", $("body")).each( function() {
            var content = $(this).html().replace( new RegExp(localDB[i].query, "gi"), localDB[i].insult.toUpperCase() );
            $(this).html( content );
        });
    }
}
