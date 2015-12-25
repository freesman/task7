#-------- MODEL ------------
Person = Backbone.Model.extend(
  defaults:
    name: ''
    lastName: ''
    phone: ''
    mail: ''
    date: ''
)

#------- MODEL VIEW---------
PersonView = Backbone.Epoxy.View.extend(
  el:'.doc'
  model: new Person(JSON.parse(localStorage.getItem('person')))
  initialize: ->
    this.listenTo(this.model, 'change', this.localSave)
    this.aliases()
    this.render()
  render: ->
    this.$('.name').inputmask('name')
    this.$('.lastName').inputmask('name')
    this.$('.phone').inputmask('myPhone')
    this.$('.mail').inputmask('myEmail')
    this.$('.date').inputmask('myDate')
  events:
    'click #submitBut': 'submiting'
    'click #clearBut': 'clearing'
    'click .close': 'closeAlert'
  submiting: ->
    this.$submit = 0
    this.$warn = 'fields not complete:'
    this.validator('name', 1, '')
    this.validator('lastName', 1, '')
    this.validator('phone', 16, '_')
    this.validator('mail', 1, '_')
    this.validator('date', 10, '[dmy]')
    if this.$submit > 0 then this.alert('warning')
    else this.alert('success')
  validator: (attr, valLength, char) -> # valid test for submiting
    value = this.model.get(attr)
    #if !value then this.checkMask()
    replacer = new RegExp(char, 'gi')
    if char then value = value.replace(replacer, '')
    if attr == 'mail'
      testMas = value.split('@')
      if testMas[0] != '' and testMas[1] != '' then return false
      else value = ''
    if value.length < valLength
      this.$warn += " '" + attr + "'"
      this.$submit++
  clearing: ->
    this.closeAlert()
    this.model.set(this.model.defaults)
  localSave: ->
    localStorage.setItem('person', JSON.stringify(this.model.toJSON()))
  aliases: -> # mask templates for each attribute
    Inputmask.extendAliases(
      'name':
        mask: 'a{1,20}'
        onincomplete: (e) -> $(e.currentTarget).css('border-color', '#A9A9A9')
        oncomplete: (e)-> $(e.currentTarget).css('border-color', 'green')
    )
    Inputmask.extendAliases(
      'myPhone':
        mask: '+7(999)999-99-99'
        onincomplete: (e) ->personView.checkMask($(e.currentTarget))
        oncomplete: (e) -> $(e.currentTarget).css('border-color', 'green')
    )
    Inputmask.extendAliases(
      'myEmail':
        alias: 'email'
        onincomplete: (e) -> personView.checkMask($(e.currentTarget))
        oncomplete: (e) -> $(e.currentTarget).css('border-color', 'green')
    )
    Inputmask.extendAliases(
      'myDate':
        alias: 'date'
        onincomplete: (e) -> personView.checkMask($(e.currentTarget))
        oncomplete: (e) -> $(e.currentTarget).css('border-color', 'green')
    )
  checkMask: (element, status) ->
    switch status
      when 'clear' then element.css('border-color', '#A9A9A9')
      when 'incomplete' then element.css('border-color', 'red')
      when 'complete' then element.css('border-color', 'green')
  alert: (switcher) ->
    this.closeAlert()
    if switcher == 'warning'
      $('#alertWarn').fadeIn(0)
      $('.WarningMes').text(this.$warn)
    if switcher == 'success'
      $('#alertSuccess').fadeIn(650).delay(1300).fadeOut(650)
  closeAlert: ->
    $('#alertWarn').fadeOut(0)
)

personView = new PersonView()
