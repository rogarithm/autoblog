module AutoBlog
  class MarkdownParser
    def convert_paragraph content
      "<p>#{content}</p>"
    end
  end
end
