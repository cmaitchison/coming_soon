//=require base
//=require helpers/email_validator

class App.Helpers.EmailForm
  
  initialMessage: 'Enter your email'
  invalidEmailMessage: "Whooops... that doesn't look like a valid email address"
  successMessage: "Nice one! Please check your inbox. :D"
  warningMessage: "Sweet, looks like we already have your email. Stay tuned :)"
  errorMessage: "Oh noes!! Something went wrong, please try again later :("
  
  constructor: (options) ->
    @emailInput = options.emailInput
    @submitButton = options.submitButton
    @noticeDiv = options.noticeDiv
    @formElement = options.formElement
    
  initialize: ->
    @emailInput.addClass('default')
    @noticeDiv.addClass('notice')
    @emailInput.val(@initialMessage) 
    @submitButton.attr('disabled', 'disabled')
    
    @emailInput.click(@onEmailInputClicked)
    @emailInput.keypress(@onEmailInputKeypress)
    @submitButton.click(@onSubmitButtonClicked)
    
  onEmailInputClicked: =>
    @emailInput.val("") if @emailInput.val() is @initialMessage
    @emailInput.removeClass('default')
  
  onEmailInputKeypress: (e) =>
    key = e.keyCode || e.which
    if key == 13
      @submitButton.click()
      e.preventDefault()
    
  onSubmitButtonClicked: =>
    @noticeDiv.removeClass('error').removeClass('success').removeClass('warning')
    @noticeDiv.empty()
    email = @emailInput.val()
    unless @_emailValidator().validate(email)
      @noticeDiv.html(@invalidEmailMessage)
      @noticeDiv.addClass('error')
      return
      
    @formElement.addClass('sending')
    url = @formElement.attr('action')
    $.ajax
      url: url
      type: 'POST'
      dataType: 'json'    
      success: @onPostSuccess
      error: @onPostError
      data: {email: email}
    
  onPostSuccess: =>
    @formElement.removeClass('sending')
    @noticeDiv.html(@successMessage)
    @noticeDiv.addClass('success')
    @emailInput.blur()
  
  onPostError: (jqXHR, textStatus) =>
    @formElement.removeClass('sending')
    if textStatus == '400'
      @noticeDiv.addClass('warning')
      @noticeDiv.html(@warningMessage)
    else
      @noticeDiv.addClass('error')
      @noticeDiv.html(@errorMessage)
      
  _emailValidator: ->
    @emailValidator ?= new App.Helpers.EmailValidator()