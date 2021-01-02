
class HtmlRender < Redcarpet::Render::HTML

  def initialize(opts)

    super

    @in_article = false
    @in_section = false
  end

  def header(title, level)

    a = []
    t = neutralize_name(title)

    if level == 1 && title.match(/^[A-Z]+$/)
      a << "\n</section>" if @in_section; @in_section = false
      a << "\n</article>" if @in_article; @in_article = true
      a << "\n<article>"
      a << "<h#{level} id=\"#{t}\">#{title}</h#{level}>"
    elsif level == 1
      a << "\n</section>" if @in_section; @in_section = true
      a << "\n<section>"
      a << "<h#{level} id=\"#{t}\">#{title}</h#{level}>"
    else
      level = 3 if level > 3
      a << "\n<section>" if ! @in_section; @in_section = true
      a << "<h#{level}>#{title}</h#{level}>"
    end

    a.join
  end

  def paragraph(text)

    a = []

    a << "\n<section>\n" if ! @in_section; @in_section = true
    a << "<p>#{text}</p>\n"

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

class MonsterHtmlRender < HtmlRender

  def initialize(opts)

    super

    @post_index = false
  end

  def header(title, level)

    @post_index = true if level == 1 && title == 'Index'

    return super unless @post_index && level == 2

    a = []

    level = 3 if level > 3
    a << "\n<section>" if ! @in_section; @in_section = true
    a << "<h#{level} id=\"#{neutralize_name(title)}\" class=\"monster\">"
    a << title
    a << "</h#{level}>"

    a.join
  end
end

def make_html(md, render=HtmlRender)

  c = File.read(File.join('mds', md))

  renderer =
    Redcarpet::Markdown.new(render.new({}), { tables: true })

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

