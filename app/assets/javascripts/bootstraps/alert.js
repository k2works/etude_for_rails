$(document).on("turbolinks:load", function() {
    $('#myalert').on('close.bs.alert', function(e) {
        if(!confirm('閉じてよろしいですか？'))
        {
            e.preventDefault();
        }
    });

    $(function() {
        return $(".alert-close").click(function(e) {
            e.preventDefault();
            return $('#myalert').alert('close');
        });
    });
});