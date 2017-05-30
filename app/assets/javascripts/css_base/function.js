$(document).on("turbolinks:load", function() {
    $(function(){
        $("#toggle").click(function(){
            $("#nav ul.cc-nav-level-0").toggle();
            return false;
        });
        $(window).resize(function(){
            var win = $(window).width();
            var p = 767;
            if(win > p){
                $("#nav ul.cc-nav-level-0").show();
            } else {
                $("#nav ul.cc-nav-level-0").hide();
            }
        });
    }());

    $(function(){
        $(".pagearw").click(function() {
            $(this).parent("li").find("ul").toggle();
            return false;
        });
    }());
});
