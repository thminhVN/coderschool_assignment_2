$(document).ready(function(){
  $(".btn-add").click(function(e){
    current_button = $(this);
    current_button.button('loading');
    $.ajax({
      url: '/add-friend',
      type: 'post',
      data: {
        to_id: current_button.data('id')
      },
      beforeSending: function(){

      },
      success: function(data){
        if(data.status == 1){
          current_button.text('Added')
          current_button.attr('class', 'btn btn-warning disabled')
        } else {
          alert(data.message)
        }
      }
    })
  })
})