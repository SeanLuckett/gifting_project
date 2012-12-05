jQuery ->
  email = $("input:text").val()

  if email
    $("form").trigger("submit")
