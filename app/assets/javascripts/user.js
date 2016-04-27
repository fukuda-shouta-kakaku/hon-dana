$(function(){
    $(document).on("click", ".book_botton button", function () {
        var review_id = $(this).data('id');
        $(".modal-footer button").attr('data-id',review_id); 
    });

    $(document).on("click","#rewrite_btn", function () {
        var review_id = $(this).data('id'); 
        review_text = $("#review_info_"+review_id).html();
        $("#review-text").val(review_text);
    });

    $(document).on('click','#dia_rewrite_btn',function(){
        var id = $(this).data("id");
        var text =  $("#review-text").val();
        console.log(text);
        $.ajax({
            type: 'POST',
            url: "/reviews/update/"+id,
            data: {
                "body": text
            },
            success: function(json){
                $("#review_info_"+id).html(json);
                $("#main_content").prepend('<div class="alert alert-success text-center">rewrite success</div>');
                $(".alert").fadeTo(2000, 500).slideUp(500);
            }
        });
        $('#rewrite_dialog').modal('hide');
        return false;
    });


    $(document).on('click','#dia_delete_btn',function(){
        var id = $(this).data("id")
        $.ajax({
            url: "/reviews/"+id,
            type: 'DELETE',
            success: function(json){
                $("#review_"+id).hide();
                $("#main_content").prepend('<div class="alert alert-success text-center">delete success</div>');
                $(".alert").fadeTo(2000, 500).slideUp(500);
            }
        });
        $('#delete_dialog').modal('hide');
        return false;
    });
});
