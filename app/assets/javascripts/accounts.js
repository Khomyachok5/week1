$(document).ready(function () {
  $('#account_password_confirmation').change(function() {
    if ($('#account_password').val() != $('#account_password_confirmation').val()) {
      $('#btnSubmit').prop('disabled', true);
      $('#errors').text('passwords do not match');
    } else {
      $('#btnSubmit').prop('disabled', false);
    }
  });
});