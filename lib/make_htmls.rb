
class HtmlRender < Redcarpet::Render::HTML

  def initialize(opts)

    super

    @in_article = false
    @in_section = false
  end

  def header(title, level)

    a = []
    t = neutralize_name(title)

    if level == 1 && title.match(/^[A-Z .]+$/)
      a << "\n</section>" if @in_section; @in_section = false
      a << "\n</article>" if @in_article; @in_article = true
      a << "\n<article id=\"article-#{title.downcase.gsub(/[ .]/, '-')}\">"
      a << "<h#{level} id=\"#{t}\">#{title}</h#{level}>"
    elsif level == 1
      a << "\n</section>" if @in_section; @in_section = true
      a << "\n<section class=\"section-#{t.downcase}\">"
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

    if level == 1 && title == 'Index'
      @post_index = true
      return super
    end
    if level == 1 && title == 'Monster Statistics'
      @post_index = false
      return super
    end

    return super unless @post_index# && level == 2

    a = []

    if level == 1
      a << "\n</section>" if @in_section; @in_section = true
      a << "\n<section class=\"monster\">"
      a << "<h1 id=\"#{neutralize_name(title)}\" class=\"monster\">"
      a << title
      a << "</h1>\n"
    else
      a << "<h2>#{title}</h2>\n"
    end

    a.join
  end

  def table(header, body)

    c = header.match?(/<th>STR<\/th>/) ? 'abilities' : nil

    a = []

    #a << "<p><strong>Abilities</strong><span class=\"post-strong\"><span></p>\n" if c

    a << (c ? "<table class=\"#{c}\">" : '<table>')
    a << "<thead>#{header}</thead>"
    a << "<tbody>#{body}</tbody>"
    a << "</table>\n"

    a.join
  end

  def paragraph(text)

    return super unless @post_index

    if m = text.match(/\A<strong>(.+)<\/strong>(.+)\z/)
      "<p class=\"entry\"><strong>#{m[1]}</strong>" +
      "<span class=\"post-key\">#{m[2]}</span>" +
      "</p>"
    elsif text.match(/\A<em>.+<\/em>\z/)
      "<p>#{text}</p>"
    else
      "<p class=\"entry\"><strong></strong>" +
      "<span class=\"post-key\">#{text}</span></p>"
    end
  end
end

def make_html(title, md, render=HtmlRender)

  c = File.read(File.join('mds', md))

  renderer =
    Redcarpet::Markdown.new(render.new({}), { tables: true })

  puts make_html_head(title)
  puts renderer.render(c)

  if ! %w[ ogl.md index.md motivation.md colophon.md ].include?(md)
    r = Redcarpet::Markdown.new(HtmlRender.new({}), { tables: true })
    puts
    puts r.render(File.read('mds/ogl.md'))
    puts
  end

  puts make_html_foot
end

def make_html_head(title)

  s = File.read(File.join(__dir__, 'head.html'))
  s.sub!('$TITLE', title)

  s
end

def make_html_foot

  '<div id="client-width"></div>' +
  '</body></html>'
end

