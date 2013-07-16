$(document).ready(function() {

  $('.btn-primary').click(function() {
    $("tr#loader").removeClass('hidden');
  });

  $(document).on('ajax:success', '.btn-danger', function() {  
      $(this).closest('tr').fadeOut();  
  });  
});