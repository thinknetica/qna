$(document).on('turbolinks:load', function(){
   $('.answers').on('click', '.edit-answer-link', function(e) {
       e.preventDefault();
       $(this).hide();
       var answerId = $(this).data('answerId');
       console.log(answerId);
       $('form#edit-answer-' + answerId).removeClass('hidden');
   })

   $('form.new-answer').on('ajax:success', function(e) {
       var answer = e.detail[0];

       $('.answers').append('<p>' + answer.body + '</p>');
   })
       .on('ajax:error', function (e) {
           var errors = e.detail[0];

           $.each(errors, function(index, value) {
               $('.answer-errors').append('<p>' + value + '</p>');
           })

       })
});