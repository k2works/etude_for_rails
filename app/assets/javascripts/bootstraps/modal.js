$(document).on("turbolinks:load", function() {
    $('#myalert').on('close.bs.alert', function(e) {
        if(!confirm('閉じてよろしいですか？'))
        {
            e.preventDefault();
        }
    });
    $('#mymodal4').on('hide.bs.modal', function(e) {
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

    $(function () {
        return $(".modal-show").click(function (e) {
            e.preventDefault();
            return $('#mymodal').modal('show');
        })
    });

    $(function () {
        return $(".modal-hide").click(function (e) {
            e.preventDefault();
            return $('#mymodal').modal('hide');
        })
    })
});