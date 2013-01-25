/**
 * Created with JetBrains RubyMine.
 * User: arijit
 * Date: 18/1/13
 * Time: 5:56 PM
 * To change this template use File | Settings | File Templates.
 */

function solved() {
    var elems = $('.alchemy_elements:not(.img-swap)'), i = 0;
    (function fadePlz() {
        $(elems[i++]).fadeOut('fast', fadePlz);
    })();
    $('.clue').hide();
    $('.closing_cross').hide();

    $('#alchemy_center').fadeOut('slow', function () {
        $('#alchemy_center img').remove();
        $('.target_image').appendTo($('#alchemy_center'));
        $('#alchemy_center').css({
            "marginLeft":"4px",
            "marginTop":"3px",
            "width":"150px",
            "height":"150px",
            "border":"2px solid black",
            "borderRadius":"50%"
        });
        $('#alchemy_center img').css({
            "marginLeft":"-20px",
            "marginTop":"-20px",
            "width":"200px",
            "height":"200px"
        });
        $('#alchemy_center').fadeIn("slow", function () {
            $('#game_wrapper').append("<div class='complete'>Complete</div>")
            $('.complete').animate({
                "left":"+=200px"
            }, 'fast')
        });
        $('.alchemy_elements').unbind("click");
        $('.alchemy_elements').css("cursor", "auto");
        $('#alchemy_center').css("cursor", "auto");
        $('#alchemy_center').unbind("click");
    });
    $.ajax({
        url:"/games/" + gon.game_id + "/clue_status/lore",
        type:"get",
        success:function (returning_data) {
            $('#content_block').css("height", "250px");
            $('#actual_content').css("height", "200px");
            show_unlocked("lore", returning_data.split("||")[1]);
        }
    });

}

// Check if the combo is completed
function check_combo(checker) {
    $.ajax({
        url:"/games/" + gon.game_id + "/check/" + checker,
        type:"post",
        success:function (returning_data) {
            if (returning_data.split("||")[0] == "y") {
                solved();
                $('#magic_wallet').text(returning_data.split("||")[1]);
                $('#techno_wallet').text(returning_data.split("||")[2]);
            } else {
                alert("Try Again!!");
            }
        }
    });
}

// Replace the 'n'th character of 's' with 't'
function replaceAt(s, n, t) {
    return s.substring(0, n) + t + s.substring(n + 1);
}

// Create the circles for the elements
function createFields(alchemy_element_array) {
    $('.field').remove();
    var container = $('#alchemy_container');

    for (var i = 0; i < 8; i++) {
        $('<div/>', {
            'class':'field',
            'html':'<a href="#" title=' + alchemy_element_array[i] + '><img src="/assets/elements/' + alchemy_element_array[i] + '-off.png" class="alchemy_elements" id="' + i + '"/></a>'
        }).appendTo(container);
    }
}

// Distribute the elements around the circle
function distributeFields(radius, start_angle) {
    var fields = $('.field'), container = $('#alchemy_container'),
        width = container.width(), height = container.height(),
        angle = start_angle, step = (2 * Math.PI) / fields.length;
    fields.each(function () {
        var x = Math.round(width / 2 + radius * Math.cos(angle) - $(this).width() / 2);
        var y = Math.round(height / 2 + radius * Math.sin(angle) - $(this).height() / 2);
        $(this).css({
            left:x + 'px',
            top:y + 'px'
        });
        angle += step;
    });
}

function switch_element() {
    if ($(this).hasClass("img-swap")) {
        this.src = this.src.replace("-on", "-off");
        checker = replaceAt(checker, parseInt($(this).attr("id")), "0");
    } else {
        this.src = this.src.replace("-off", "-on");
        checker = replaceAt(checker, parseInt($(this).attr("id")), "1");
    }
    $(this).toggleClass("img-swap");
}


function clue_select(name) {
    $('#content_block').hide();
    if ($('.clue.active').length == 1) {
        $('.clue.active').animate({
            "width":"64px"
        }, "fast", function () {
            $('.clue').removeClass('active');
            $('img#' + name + '.clue').addClass('active').animate({
                "width":"+=10px"
            }, "slow");
        });
    } else {
        $('img#' + name + '.clue').addClass('active').animate({
            "width":"+=10px"
        }, "slow");
    }
}

function clue_deselect() {
    $('.clue.active').animate({
        "width":"64px"
    }, 'slow');
    $('.clue').removeClass('active');
    $('#content_block').fadeOut();
}

function show_locked(name) {
    var index = 0;
    if (name == "count") {
        index = 1
    } else {
        if (name == "chance") {
            index = 2
        }
    }

    if ($('img#' + name + '.clue').hasClass('active')) {
        clue_deselect();
    } else {
        clue_select(name);
        $('#actual_content').empty();
        $('#actual_content').append(gon.clue_speak[index]);
        $('#actual_content').append('<br/><button class="clue_button styled_button" onclick="unlock_clue(\'' + name + '\')">Buy</button> for ' + gon.clue_costs[index] + ' <img class="wallet_icon" src="/assets/' + gon.theme + '.png" alt="">');
        $('#content_block').fadeIn('slow');
    }
}

function show_unlocked(name, data) {
    var index = 1;
    if (name == "count") {
        index = 2;
    } else {
        if (name == "chance") {
            index = 3;
        }
    }

    if ($('img#' + name + '.clue').hasClass('active')) {
        clue_deselect();
    } else {
        clue_select(name);
        $('#actual_content').empty();
        switch (index) {
            case 1:
                $('#actual_content').addClass("lore_text").append(data);
                break;
            case 2:
                $('#actual_content').append('<img class="clue_image" src="/assets/' + data + '.png">');
                break;
            case 3:
            {
                $.each(data.split(","), function (index, value) {
                    $('#actual_content').append('<img class="clue_image" src="/assets/elements/' + value + '-on.png">');
                });
                break;
            }
        }

        $('#content_block').fadeIn('slow');
    }
}

// User clicks on the Counter Clue
function unlock_clue(name) {
    $.ajax({
        url:"/games/" + gon.game_id + "/take_clue/" + name + "/" + gon.theme,
        type:"post",
        success:function (returning_data) {
            var parsed_return = returning_data.split("||")
            if (parsed_return[0] == "x") {
                alert(parsed_return[1]);
            } else {
                $('#' + parsed_return[0] + '_wallet').html(parseInt($('#' + parsed_return[0] + '_wallet').text()) - parsed_return[1]);
                $('#' + parsed_return[2]).attr('src', "/assets/" + parsed_return[2] + ".jpg");
                $('#' + parsed_return[2]).removeClass('status_locked');
                $('#actual_content').empty();
                switch (parseInt(parsed_return[4])) {
                    case 1:
                        $('#actual_content').addClass('lore_text').append(parsed_return[3]);
                        break;
                    case 2:
                        $('#actual_content').append('<img class="clue_image" src="/assets/' + parsed_return[3]+'_'+ parsed_return[0] + '.png">');
                        break;
                    case 3:
                    {
                        $.each(parsed_return[3].split(","), function (index, value) {
                            $('#actual_content').append('<img class="clue_image" src="/assets/elements/' + value + '-on.png">');
                        });
                        break;
                    }
                }

                $('#content_block').fadeIn('slow');
            }
        }})
}

function show_content(obj) {
    if (!$("#" + obj).hasClass('status_disabled')) {
        $.ajax({
            url:"/games/" + gon.game_id + "/clue_status/" + obj,
            type:"get",
            success:function (returning_data) {
                if (returning_data.split("||")[0] == "false") {
                    show_locked(obj);
                } else {
                    show_unlocked(obj, returning_data.split("||")[1]);
                }
            }
        });
    }
}

var Page = (function () {

    var config = {
            $bookBlock:$('#bb-bookblock'),
            $navNext:$('#bb-nav-next'),
            $navPrev:$('#bb-nav-prev'),
            $navJump:$('#bb-nav-jump'),
            bb:$('#bb-bookblock').bookblock({
                speed:800,
                shadowSides:0.8,
                shadowFlip:0.7
            })
        },
        init = function () {

            initEvents();

        },
        initEvents = function () {

            var $slides = config.$bookBlock.children(),
                totalSlides = $slides.length;

            // add navigation events
            config.$navNext.on('click', function () {

                config.bb.next();
                return false;

            });

            config.$navPrev.on('click', function () {

                config.bb.prev();
                return false;

            });

            config.$navJump.on('click', function () {

                config.bb.jump(totalSlides);
                return false;

            });

            // add swipe events
            $slides.on({

                'swipeleft':function (event) {

                    config.bb.next();
                    return false;

                },
                'swiperight':function (event) {

                    config.bb.prev();
                    return false;

                }

            });

        };

    return { init:init };

})();

