module AutoBlog
  class MarkdownParser
    def convert_paragraph content
      flatten = content.gsub(/\n+/, "\n").split("\n")
      result = []
      flatten.each do |paragraph|
        result << "<p>#{paragraph}</p>\n"
      end
      result.join('').chomp
    end
    def convert_header1 line
      line.sub(/^#\s+(.*)/, '<h1>\1</h1>')
    end
    def convert_header2 line
      line.sub(/^##\s+(.*)/, '<h2>\1</h2>')
    end
    def convert_header3 line
      line.sub(/^###\s+(.*)/, '<h3>\1</h3>')
    end
    def convert_bold line
      line.gsub(/\*\*(\S[^*]*\S?)\*\*/, '<strong>\1</strong>')
    end
  end
end
