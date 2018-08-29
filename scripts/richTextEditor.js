$(document).ready(function () {
    $(".richText-button").tooltip({
        classes: {
            "ui-tooltip": "richText-tooltip"
        },
        position: {
            my: "center top",
            at: "center bottom+3"
            /*using: function (position, feedback) {
                $(this).css(position);
                $("<div>").addClass("arrow").addClass(feedback.vertical).addClass(feedback.horizontal).appendTo(this);
            }*/
        },
        show: false,
        hide: false
    });
});