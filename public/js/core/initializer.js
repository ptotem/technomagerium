var list = [];

var script_set = [
    "jquery",
    "/js/bin/jquery-ui-1.10.0.custom.min.js",
    "/js/bin/path.js",
    "/js/bin/bootstrap.min.js",
    "/js/bin/jquery.easing.1.3.js",
    "/js/core/storage.js",
    "/js/core/routes.js",
    "/js/core/main.js"
];

require(script_set, function ($) {
    $(function () {
        load_data();
        $('body').on('load_complete', function () {
            $('img').each(function () {
                var $this = $(this);
                $(this).attr("src", "/img/" + $this.attr("src"));
            });
            initialize_routes();
            Path.listen();
            initialize();
            console.log(list[0]);
            console.log(list[1]);
        });
    });
});




