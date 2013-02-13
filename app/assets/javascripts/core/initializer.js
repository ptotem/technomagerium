function initialize() {

}
function clearPanel() {
    // You can put some code in here to do fancy DOM transitions, such as fade-out or slide-in.
}

// Put in the pages and the Ajax calls here. Make sure commenting is done well to make the routes.
function initialize_routes() {
    Path.map("#/users").to(function () {
        alert("Users!");
    });

    Path.map("#/comments").to(
        function () {
            alert("Comments!");
        }).enter(clearPanel);

    Path.map("#/posts").to(
        function () {
            alert("Posts!");
        }).enter(clearPanel);

    Path.root("#/posts");

    Path.listen();

}
