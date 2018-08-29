$(document).ready(function () {
    $("#newFav, #newPolicy").button({
        icon: "ui-icon-plusthick",
        showLabel: false
    });
    $("#newFav, #newPolicy").tooltip({
        content: "Add New",
        items: "a",
        show: 200,
        hide: 200,
        track: true
    });
    $("#editFav, #editPolicy").button({
        icon: "ui-icon-wrench",
        showLabel: false
    });
    $("#editFav, #editPolicy").tooltip({
        content: "Edit",
        items: "a",
        show: 200,
        hide: 200,
        track: true
    });
});