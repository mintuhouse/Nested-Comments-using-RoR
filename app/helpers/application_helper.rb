module ApplicationHelper

	#Return a title on per-page basis
	def title
		base_title="RoR Sample App"
		if @title.nil?
			base_title
		else
		 	"#{base_title} | #{@title}"
		end
	end

	def logo
    image_tag("logo.png", :alt => "Sample App", :class => "round")
  end
  
  def home?
    ((controller_name == 'pages') && (action_name == 'home')) 
  end
end

