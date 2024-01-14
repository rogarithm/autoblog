module AutoBlog
  class MarkdownParser
    def convert_paragraph content
      "<p>#{content}</p>"
    end
    def convert_header1 line
      line.sub(/^#(.*)/, '<h1>\1</h1>')
    end
    def convert_header2 line
      line.sub(/^##(.*)/, '<h2>\1</h2>')
    end
    def convert_header3 line
      line.sub(/^###(.*)/, '<h3>\1</h3>')
    end
  end
end
