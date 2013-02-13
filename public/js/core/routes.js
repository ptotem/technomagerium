/**
 * Created with JetBrains RubyMine.
 * User: arijit
 * Date: 13/2/13
 * Time: 4:15 PM
 * To change this template use File | Settings | File Templates.
 */

// Put in the pages and the Ajax calls here. Make sure commenting is done well to make the routes.
function initialize_routes() {

    // Route to the Library with id being the chapter

    Path.map("#/library/:id").to(function () {
        window.location="/lib/library.html?="+this.params["id"]
    }).enter(clearPanel);

//    Path.root("#/posts");
}

function clearPanel() {
    // You can put some code in here to do fancy DOM transitions, such as fade-out or slide-in.
}