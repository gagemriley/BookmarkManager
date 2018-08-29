var landingPageApp_ns = landingPageApp_ns || {};

$.widget("landingPageApp_ns.richText", {
    /*options: {
        // Text formatting
        bold: true,
        italic: true,
        underline: true
    },*/

    _create: function () {
        var editor = this.element;
        $(editor).addClass("ui-richText", "ui-widget ui-widget-content");

        // Toolbar
        var toolbarList = $("<ul />", {class: "richText-toolbar"});
        var toolbarElement = $("<li />");

        var btnBold = $("<button />", {
            class: "richtext-button",
            "data-cmd": "bold",
            "title": "Bold",
            html: "<span class='richText-bold'>B</span>"
        });
        var btnItalic = $("<button />", {
            class: "richText-button",
            "data-cmd": "italic",
            "title": "Italic",
            html: "<span class='richText-italic'>I</span>"
        });
        var btnUnderline = $("<button />", {
            class: "richText-button",
            "data-cmd": "underline",
            "title": "Underline",
            html: "<span class='richText-underline'>U</span>"
        });

        $(toolbarList).append(toolbarElement.clone().append(btnBold));
        $(toolbarList).append(toolbarElement.clone().append(btnItalic));
        $(toolbarList).append(toolbarElement.clone().append(btnUnderline));

        // Text area
        //var textArea = $()

        $(editor).append(toolbarList);
    }
});