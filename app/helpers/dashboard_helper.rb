module DashboardHelper
  def recipient_explain(warning)
    warning_explanations = {
      :address => "We can not send a gift to this person until we have the shipping address.",
      :age => "While a birthday isn't required, it will help us make age-appropriate gift recommendations for this person."
    }

    return warning_explanations[:address] if warning.include? "Address"
    return warning_explanations[:age] if warning.include? "Birthday"
  end
end
