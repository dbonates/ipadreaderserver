module ApplicationHelper

  # Generate Fieldset with name for association. 
  # Used while ajax-generation of form for adding previews and content lines in issue.
	def link_to_add_fields(name, f, association)
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.fields_for(association, new_object, child_index: id) do |builder|
      render(association.to_s.singularize+"_fields", f:builder)
    end
    link_to(name, '#', class: "add_fields", data:{id: id, fields: fields.gsub("\n", "")})
	end

  def kramdown(text)
    require 'kramdown'
    return sanitize Kramdown::Document.new(text).to_html
  end

  
end
