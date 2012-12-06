jQuery ->
  email = $("input:text").data()

  if email.emailConfirmed == true
    $("form").trigger("submit")
