/**
 * Created with JetBrains RubyMine.
 * User: arijit
 * Date: 18/1/13
 * Time: 5:56 PM
 * To change this template use File | Settings | File Templates.
 */

//TODO: Check if the combo is completed
function check_combo(checker) {
    alert(checker);
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

// User clicks on the Counter Clue
function counter_clue_taken(game_id, theme) {
    $.ajax({
        url:"/games/" + game_id + "/take_counter_clue",
        type:"post",
        success:function (returning_data) {
            $("#counter_block").find('img').attr('src', '/assets/' + returning_data + '_' + theme + ".png");
        }})
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
    $('.content_block').hide();
    if ($('.clue.active').length == 1) {
        $('.clue.active').animate({
            "width":"64px"
        }, "fast", function () {
            $('.clue').removeClass('active');
            $('img#' + name + '_button.clue').addClass('active').animate({
                "width":"+=10px"
            }, "slow");
        });
    } else {
        $('img#' + name + '_button.clue').addClass('active').animate({
            "width":"+=10px"
        }, "slow");
    }
}

function clue_deselect() {
    $('.clue.active').animate({
        "width":"64px"
    }, 'slow');
    $('.clue').removeClass('active');
    $('.content_block').fadeOut();
}

function lore_clue_taken() {
    if ($('img#lore_button.clue').hasClass('active')) {
        clue_deselect();
    } else {
        clue_select('lore');
        $('#lore_content').fadeIn('slow');
    }
}

function count_clue_taken() {
    if ($('img#count_button.clue').hasClass('active')) {
        clue_deselect();
    } else {
        clue_select('count');
        $('#count_content').fadeIn('slow');
    }
}
function chance_clue_taken() {
    if ($('img#chance_button.clue').hasClass('active')) {
        clue_deselect();
    } else {
        clue_select('chance');
        $('#chance_content').fadeIn('slow');
    }
}