//= require helpers/email_form
$ ->
  options =
    formElement: $('#register_watcher')
    emailInput: $('#register_watcher_email')
    submitButton: $('#register_watcher_button')
    noticeDiv: $('#register_watcher_message')
  
  emailForm = new App.Helpers.EmailForm(options)
  emailForm.initialize()