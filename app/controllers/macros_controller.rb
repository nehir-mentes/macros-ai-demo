class MacrosController < ApplicationController

  def blank_form
    render({ :template => "macros_templates/blank_form" })
  end

  def process_form
    @the_image = params["image_param"]
    # or you can handle nulls with @the_image = params.fetch("image_param", nil)
    @the_description = params.fetch("description_param")
    

c = OpenAI::Chat.new
c.model = "o3"

c.system("You are a nutritionist.The user will give you an image and/or a description of a meal. Your job is to estimate the amount of macronutrients and calories in it.")

c.schema = {
  "name": "nutrition_values",
  "strict": true,
  "schema": {
    "type": "object",
    "properties": {
      "fat": {
        "type": "number",
        "description": "The amount of fat in grams."
      },
      "protein": {
        "type": "number",
        "description": "The amount of protein in grams."
      },
      "carbs": {
        "type": "number",
        "description": "The amount of carbohydrates in grams."
      },
      "total_calories": {
        "type": "number",
        "description": "The total calories calculated based on fat, protein, and carbohydrates."
      },
      "notes": {
        "type": "string",
        "description": "A breakdown of how you arrived at the values, and additional notes."
      }
    },
    "required": [
      "fat",
      "protein",
      "carbs",
      "total_calories",
      "notes"
    ],
    "additionalProperties": false
  }
}

c.user("Here is an image", image: @the_image)

c.user(@the_description)

# Now convert it to JSON string
structured_input_json = structured_input.to_json

# Then pass it
@structured_output = c.assistant!(structured_input: structured_input_json)


@g_carbs = @structured_output.fetch("carbs")
@g_protein = @structured_output.fetch("protein")
@g_fat = @structured_output.fetch("fat")
@total_calories = @structured_output.fetch("total_calories")
@notes = @structured_output.fetch("notes")

c.assistant!

    render({ :template => "macros_templates/process_form" })
  end

end
