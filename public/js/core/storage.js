/**
 * Created with JetBrains RubyMine.
 * User: arijit
 * Date: 13/2/13
 * Time: 3:59 PM
 * To change this template use File | Settings | File Templates.
 */

    //Your script goes here
    //some-dependency.js is fetched.
    //then your script is executed

localStorage.chapter = 1;
localStorage.help_on = true;
localStorage.magic_wallet = 0;
localStorage.techno_wallet = 0;

function load_data() {
    var json_list = ["tomes", "puzzles"];
    load_the_json(json_list, 0); // On completion it will trigger a "load_complete" event
}

var load_the_json = function (jlist, index) {
    var item = jlist[0];
    $.getJSON("/lib/data/" + item + ".json", function (data) {
        list[index] = data;
        if (jlist.length == 1) {
            $('body').trigger("load_complete");
        } else {
            jlist.splice(0, 1);
            load_the_json(jlist, index + 1)
        }
    });
};

