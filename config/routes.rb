Rails.application.routes.draw do

  get("/", { :controller => "macros", :action => "blank_form" })

  post("/process_form", { :controller => "macros", :action => "process_form" })

  # Solutions below. Don't peek until you try it yourself and get stuck!

  get("/solutions/blank_form", { :controller => "solutions", :action => "display_form" })
  
  post("/solutions/process_form", { :controller => "solutions", :action => "process_inputs" })
  
end
