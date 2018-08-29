var landingPageApp_ns = landingPageApp_ns || {};

$(document).ready(function () {

    // Default dialog box implementation
    $(".dialog").dialog({
        autoOpen: false, // Prevents the dialog from from opening when the page loads.
        //modal: true, // Prevents interaction of elements outside the dialog box.
        closeOnEscape: true, // Allows closing of the dialog box by pressing the escape (ESC) key.
        width: 600,

        // Fades in or out the shadow overlay
        open: function (event, ui) {
            $("div#overlay").toggle("fade");
        },
        beforeClose: function (event, ui) {
            $("div#overlay").toggle("fade");
            // Updates the dialog's update panel...
            var updatePanelID = $(this).children("div").attr("id");
            if (updatePanelID !== undefined && updatePanelID !== null && updatePanelID.startsWith("UP_")) __doPostBack(updatePanelID, "");
        },
        close: function (event, ui) {
            // ...so the dialog box can be reset
            $(this).find("input[type='text'], input[type='password'], input[type='email']").removeAttr("value");
            $(this).find("input[type='checkbox']").removeAttr("checked");
            $(this).find(".errorMsg").html("");
            $(this).find(".url").attr("value", "https://");
        },

        // Show/hide animations
        show: { effect: "drop", direction: "up", duration: 350 },
        hide: { effect: "drop", direction: "up", duration: 350 },

        appendTo: "#form1"
    });

    $(".dialogButton").click(function (event) {
        $(this).blur(); // Removes the tooltip when the dialog opens

        var dialog = $("div#" + $(this).attr("id") + "Dialog");
        $(dialog).dialog("option", "width", $(window).width() * 0.6);
        $(dialog).dialog("open");
        event.preventDefault();
    });

    $("#confirmDialog").dialog({
        resizable: false,
        width: 500,
        buttons: {
            "Yes": function () {
                $(this).dialog("close");
            },
            "No": function () {
                $(this).dialog("close");
            }
        }
    });

    $.extend(true, landingPageApp_ns, {
        common_ns: {
            confirmDialog: function (title_arg, message_arg, warning_arg, eventTarget, eventArg) {
                $("#confirmDialog p.message").html(message_arg);
                $("#confirmDialog p.warning b").html(warning_arg);
                $("#confirmDialog").dialog({
                    title: title_arg,
                    buttons: {
                        "Yes": function () {
                            __doPostBack(eventTarget, eventArg);
                            $(this).dialog("close");
                        },
                        "No": function () {
                            $(this).dialog("close");
                        }
                    }
                });
                $("#confirmDialog").dialog("open");
                return false;
            }
        }
    });

    //$("#form1").append($(".dialog").parent());

});