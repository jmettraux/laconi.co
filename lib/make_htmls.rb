
class HtmlRender < Redcarpet::Render::HTML

  def initialize(opts)

    super

    @in_article = false
    @in_section = false
  end

  def header(title, level)

    a = []

    if level == 1 && title.match(/^[A-Z]+$/)
      a << "\n</section>" if @in_section; @in_section = false
      a << "\n</article>" if @in_article; @in_article = true
      a << "\n<article>"
      a << "<h#{level}>#{title}</h#{level}>"
    elsif level == 1
      a << "\n</section>" if @in_section; @in_section = true
      a << "\n<section>"
      a << "<h#{level}>#{title}</h#{level}>"
    else
      a << "\n<section>" if ! @in_section; @in_section = true
      a << "<h#{level}>#{title}</h#{level}>"
    end

    a.join
  end

  def doc_footer

    a = []

    a << "\n</section>" if @in_section
    a << "\n</article>" if @in_article

    a.join
  end

  #def preprocess(full_doc)
  #end
  #def postprocess(full_doc)
  #end
end

def make_html(md)

  c = File.read(File.join('mds', md))

  renderer =
    Redcarpet::Markdown.new(
      #Redcarpet::Render::HTML.new({}),
      HtmlRender.new({}),
      { tables: true })

  puts make_html_head('rules')
  puts renderer.render(c)
  puts make_html_foot
end

def make_html_head(title)

  s = File.read(File.join(__dir__, 'head.html'))
  s.sub!('$TITLE', title)

  s
end

def make_html_foot

  '</body></html>'
end

