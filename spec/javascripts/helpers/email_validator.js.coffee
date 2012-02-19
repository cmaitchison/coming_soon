//= require helpers/email_form

class App.Helpers.EmailValidator
  beforeEach ->
    @validator = new App.Helpers.EmailValidator()
  it 'works', ->
    expect(@validator.validate('a@b.com')).toBeTruthy()
    expect(@validator.validate('a@b')).toBeFalsy()