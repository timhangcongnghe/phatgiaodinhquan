var $doc = jQuery(document),
    $html = jQuery("html"),
    $body = jQuery("body");
    
    $doc.ready(function ($) {
    var $popup = jQuery("#tie-popup-demos"),
        $popupContent = $popup.find(".container-wrapper");
    $doc.on("click", "#demos-aside-open", function (event) {
        event.preventDefault();
        $body.addClass("popup-demos-is-opend");
        $html.css({ overflow: "hidden" });
        if (!$popup.hasClass("lazyLoad-completed")) {
            $popup
                .addClass("lazyLoad-completed")
                .find(".demo-lazy-img")
                .each(function () {
                    jQuery(this).attr("src", jQuery(this).attr("data-demosrc")).removeAttr("data-demosrc");
                });
        }
        $popup.fadeIn("fast");
    });
    
    $doc.keyup(function (event) {
        if (event.which == "27") {
            close_popup();
        }
    });
    $popup.on("click", function (event) {
        if (jQuery(event.target).is(".popup-content")) {
            event.preventDefault();
            close_popup();
        }
    });
    jQuery(".panel-btn-close").on("click", function () {
        close_popup();
        return false;
    });
    function close_popup() {
        $popup.fadeOut("fast", function () {
            $html.removeAttr("style");
        });
        $body.removeClass("popup-demos-is-opend");
    }
});