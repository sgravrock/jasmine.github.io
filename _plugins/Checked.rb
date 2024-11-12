module Jekyll
  module Checked
    def checked(text)
        "plugins work!"
    end
  end
end

Liquid::Template.register_filter(Jekyll::Checked)