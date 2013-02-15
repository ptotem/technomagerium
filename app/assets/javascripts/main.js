/**
 * Created with JetBrains RubyMine.
 * User: arijit
 * Date: 18/1/13
 * Time: 5:56 PM
 * To change this template use File | Settings | File Templates.
 */

function preload(images) {
    if (document.images) {
        var i = 0;
        var imageArray = new Array();
        imageArray = images.split(',');
        var imageObj = new Image();
        for (i = 0; i <= imageArray.length - 1; i++) {
            //document.write('<img src="' + imageArray[i] + '" />');// Write to page (uncomment to check images)
            imageObj.src = imageArray[i];
        }
    }
}

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
            }, 'fast');

        });
        $('.alchemy_elements').unbind("click");
        $('.alchemy_elements').css("cursor", "auto");
        $('#alchemy_center').css("cursor", "auto");
        $('#alchemy_center').unbind("click");
    });
    $.ajax({
        url:"/games/" + gon.game_id + "/clue_status/explanation",
        type:"get",
        success:function (returning_data) {

            $('#actual_content').css("height", "200px");
            show_unlocked("explanation", returning_data.split("||")[1]);
            $('#target_back').fadeOut();
            $('#reward_table').fadeOut();
            $('#content_block').css({
                "height":"250px",
                "backgroundImage":"none",
                "color":"white",
                "marginTop":"-60px",
                "fontWeight":"bold"
            });
            $('#puzzlename').animate({
                'color':'white'
            });
            $('#game_wrapper').append("<div class='next_puzzle'><a href='" + returning_data.split("||")[2] + "'><img src='/assets/continue.png'></a></div>")
            $('.next_puzzle').animate({
                "right":"145px"
            }, 'fast');
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
                //postGame();
//  $('#game_wrapper').prepend("<span class='callout' id='nowork'><img src='/assets/donecallout.png'></span>");
            } else {
                $('#game_wrapper').prepend("<span class='callout' id='nowork'><img src='/assets/callout.png'></span>");
                setTimeout(function () {
                    $('#nowork').fadeOut('fast', function () {
                        $(this).remove();
                    });
                }, 2000);
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
    var imageObj = new Image();

    for (var i = 0; i < gon.count; i++) {
        $('<div/>', {
            'class':'field',
            'html':'<a href="#" ><img src="/assets/elements/' + alchemy_element_array[i] + '-off.png" class="alchemy_elements" id="' + i + '"/></a>'
        }).appendTo(container);
        imageObj.src = '/assets/elements/' + alchemy_element_array[i] + '-on.png';
    }
}

// Distribute the elements around the circle
function distributeFields(start_angle) {
    var fields = $('.field'), container = $('#alchemy_container'),
        width = container.width(), height = container.height(),
        angle = start_angle, step = (2 * Math.PI) / fields.length,
        field_side = (width * Math.sin(Math.PI / fields.length)) / (1 + Math.sin(Math.PI / fields.length)),
        centerx = width / 2, centery = height / 2, radius = (width - field_side) / 2;


    $('.field').css({
        'width':field_side,
        'height':field_side
    });
    $('.alchemy_elements').css('width', field_side);


    fields.each(function () {
        var x = Math.round(centerx + radius * Math.cos(angle) - $(this).width() / 2);
        var y = Math.round(centery + radius * Math.sin(angle) - $(this).height() / 2);
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
        gon.checker = replaceAt(gon.checker, parseInt($(this).attr("id")), "0");
    } else {
        this.src = this.src.replace("-off", "-on");
        gon.checker = replaceAt(gon.checker, parseInt($(this).attr("id")), "1");
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
        $('#actual_content').append('<br/><button class="clue_button styled_button" onclick="unlock_clue(\'' + name + '\')">Buy</button> for ' + gon.clue_costs[index] + ' <img class="wallet_icon" src="/assets/' + gon.costs_in + '.png" alt="">');
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
        } else {
            if (name == "explanation") {
                index = 4;
            }
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
            case 4:
                $('#actual_content').append(data);
                break;
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
                        $('#actual_content').append('<img class="clue_image" src="/assets/' + parsed_return[3] + '_magic.png">');
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

