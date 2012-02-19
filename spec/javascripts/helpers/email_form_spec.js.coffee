//= require helpers/email_form

describe 'App.Helpers.EmailForm', ->
  
  beforeEach ->
    @formElement = $('<form action="/someurl"></form>')
    @emailInput = $('<input></input>')
    @submitButton = $('<button></button')
    @noticeDiv = $('<div></div')
    
    @form = new App.Helpers.EmailForm(
      emailInput: @emailInput
      submitButton: @submitButton
      noticeDiv: @noticeDiv
      formElement: @formElement
    )
    @form.initialize()
    
  it 'gives a default value to the emailInput', ->
    expect(@emailInput.val()).toEqual('Enter your email')
  
  it 'gives emailInput a class of default', ->
    expect(@emailInput).toHaveClass('default')
  
  it 'gives the notice div a class of notice', ->
    expect(@noticeDiv).toHaveClass('notice')
    
  describe 'when no text has been entered', ->
    it 'disables the submit button', ->
      expect(@submitButton).toBeDisabled()
      
  describe 'when the input field is clicked for the first time', ->
    beforeEach ->
      @emailInput.click()
    
    it 'empties the field', ->
      expect(@emailInput.val()).toEqual('')
      
    it 'removes the default class', ->
      expect(@emailInput).not.toHaveClass('default')
    
    describe 'when submitting the form', ->
      beforeEach ->
        @keypressSpy = jasmine.createSpy('keypress')
        @emailValidator = jasmine.createSpyObj('emailValidator', ['validate'])
        @form._emailValidator = => @emailValidator    
      
      itGivesTheNoticeDivAClassOfError = ->
        it 'gives the notice div a class of error', ->
          expect(@noticeDiv).toHaveClass('error')
          expect(@noticeDiv).not.toHaveClass('warning')
          expect(@noticeDiv).not.toHaveClass('success')
  
      pressEnterKey = (context) ->
        context.emailInput.bind('keypress', context.keypressSpy)
        context.emailInput.press(13)
        
      itPreventsTheDefaultActionOfTheEnterKey = ->
        it 'prevents the default action of the enter key', ->
          expect(@keypressSpy.mostRecentCall.args[0].isDefaultPrevented()).toBeTruthy()
        
      describe 'when an invalid email is entered', ->
        beforeEach ->
          @emailValidator.validate.andReturn false
  
        itGivesTheNoticeDivAnErrorMessage = ->
          
          itGivesTheNoticeDivAClassOfError()
          
          it 'gives the notice div an error message', ->
            expect(@noticeDiv.html()).toEqual("Whooops... that doesn't look like a valid email address")
          
        describe 'when enter is pressed', ->
          beforeEach ->
            pressEnterKey(@)
          itGivesTheNoticeDivAnErrorMessage()
          itPreventsTheDefaultActionOfTheEnterKey()

        describe 'when the submit button is clicked', ->
          beforeEach ->
            @submitButton.click()
          itGivesTheNoticeDivAnErrorMessage()
        
      describe 'when a valid email is entered', ->
        beforeEach ->
          @noticeDiv.html('stuff')
          @emailInput.val('a@b.com')
          @emailValidator.validate.andReturn true
          spyOn($,'ajax').andCallFake((options) =>
            expect(options.url).toEqual('/someurl')
            expect(options.type).toEqual('POST')
            expect(options.data).toEqual(email:'a@b.com')
            expect(options.dataType).toEqual('json')
            @successCallback = options.success
            @errorCallback = options.error
          )
        
        describeWhenTheFormIsSubmitted = ->
          it 'posts the data', ->
            expect($.ajax).toHaveBeenCalled()
            
          it 'clears the notice div', ->
            expect(@noticeDiv.html()).toEqual('')
          
          it 'gives the form a class of sending', ->
            expect(@formElement).toHaveClass('sending')
          
          itRemovesTheSendingClassFromTheForm = ->
            it 'removes the sending class from the form', ->
              expect(@formElement).not.toHaveClass('sending')
            
          describe 'when the server returns a 200', ->
            beforeEach ->
              spyOn(@emailInput,'blur')
              @successCallback()

            itRemovesTheSendingClassFromTheForm()

            it 'gives a success message', ->
              expect(@noticeDiv.html()).toEqual("Nice one! Please check your inbox. :D")
            
            it 'gives the notice div a class of success', ->
              expect(@noticeDiv).toHaveClass('success')
              expect(@noticeDiv).not.toHaveClass('warning')
              expect(@noticeDiv).not.toHaveClass('error')
              
            it 'blurs the input field', ->
              expect(@emailInput.blur).toHaveBeenCalled()
              
          describe 'when the server returns a 400', ->
            beforeEach ->
              @errorCallback({}, "400")

            itRemovesTheSendingClassFromTheForm()

            it 'gives the notice div a class of warning', ->
              expect(@noticeDiv).toHaveClass('warning')
              expect(@noticeDiv).not.toHaveClass('error')
              expect(@noticeDiv).not.toHaveClass('success')
            
            it 'tells the user that the email already exists', ->
              expect(@noticeDiv.html()).toEqual("Sweet, looks like we already have your email. Stay tuned :)")
              
           describe 'when the server returns a 500', ->
              beforeEach ->
                @errorCallback({}, "500")
                
              itRemovesTheSendingClassFromTheForm()
              itGivesTheNoticeDivAClassOfError()
              
              it 'tells the user that there was an error', ->
                expect(@noticeDiv.html()).toEqual("Oh noes!! Something went wrong, please try again later :(")
            
        describe 'when the submit button is clicked', ->
          beforeEach ->
            @submitButton.click()
          describeWhenTheFormIsSubmitted()
          
        describe 'when enter is pressed', ->
          beforeEach ->
            pressEnterKey(@)
          describeWhenTheFormIsSubmitted()
          itPreventsTheDefaultActionOfTheEnterKey()