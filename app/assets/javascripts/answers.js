$(document).on('turbolinks:load', function(){
   $('.answers').on('click', '.edit-answer-link', function(e) {
       e.preventDefault();
       $(this).hide();
       var answerId = $(this).data('answerId');
       console.log(answerId);
       $('form#edit-answer-' + answerId).removeClass('hidden');
   })

   $('form.new-answer').on('ajax:success', function(e) {
       var xhr = e.detail[2];

       $('.answers').append(xhr.responseText);
   })
       .on('ajax:error', function (e) {
           var xhr = e.detail[2];

           $('.answer-errors').html(xhr.responseText);
       })
});