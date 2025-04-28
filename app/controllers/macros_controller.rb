class MacrosController < ApplicationController

  def blank_form
    render({ :template => "macros_templates/blank_form" })
  end

  def process_form
    @the_image = params["image_param"]
    # or you can handle nulls with @the_image = params.fetch("image_param", nil)
    @the_description = params.fetch("description_param")
    
    render({ :template => "macros_templates/process_form" })
  end

end
