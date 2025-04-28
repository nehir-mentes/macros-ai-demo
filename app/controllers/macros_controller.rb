class MacrosController < ApplicationController

  def blank_form
    render({ :template => "macros_templates/blank_form" })
  end

  def process_form
    render({ :template => "macros_templates/process_form" })
  end

end
