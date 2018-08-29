var landingPageApp_ns = landingPageApp_ns || {};

$.extend(true, landingPageApp_ns, {
    common_ns: {
        createFavicon: function (contentTag, imgSrc) {
            var img = document.createElement("img");
            img.alt = "Icon";
            img.height = "22";
            img.width = "22";
            $(img).css("margin", "auto 1em auto 0.5em");

            // Changes the "src" attribute of the "img" tag to the default image if unable to load the provided one
            // Works in: Chrome, Firefox, Edge
            // Does not work in: Internet Explorer (Promise is undefined in this browser's library)
            // Untested in: Safari, Opera
            try {
                landingPageApp_ns.common_ns.testImageURL(imgSrc).then(
                    function resolve(){
                        img.src = imgSrc;
                    },
                    function reject() {
                        img.src = "https://png.icons8.com/ios-glyphs/50/000000/file.png"; //"Styles/images/default_img.PNG";
                    }
                );
            } catch (error) {
                // Do nothing; if the browser doesn't support Promise, we'll just let it use its own default image
            }

            $(contentTag).prepend(img);
        },
        refreshFavicons: function () {
            var common_ns = landingPageApp_ns.common_ns;
            //$("a.bookmark").find("img").remove();
            $("a.bookmark").not(function () {
                return $(this).find("img").length !== 0;
            }).each(function () {
                var href = $(this).attr("href");
                href = href.endsWith("/") ? href.slice(0, -1) : href;
                common_ns.createFavicon($(this), href + "/favicon.ico");
            });
        }
    }
});

$(document).ready(function () {
    var common_ns = landingPageApp_ns.common_ns;

    common_ns.refreshFavicons();

    // TODO: Detect what type of document it is and display an icon based on it
    /*$("a.document").each(function () {
        common_ns.createFavicon($(this), ???);
    });*/
});