class MacrosController < ApplicationController

  def blank_form
    render({ :template => "macros_templates/blank_form" })
  end

end
