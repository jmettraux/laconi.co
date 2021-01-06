
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
      i = level < 3 ? " id=\"t\"" : ''
      a << "\n<section>" if ! @in_section; @in_section = true
      a << "<h#{level}#{i}>#{title}</h#{level}>"
    end

    a.join
  end

  def paragraph(text)

    a = []

    a << "\n<section>\n" if ! @in_section; @in_section = true
    a << "<p>#{text}</p>\n"

    a.join
  end
  #def paragraph(text)
  #  return super unless @post_index
  #  if m = text.match(/\A<strong>(.+)<\/strong>(.+)\z/)
  #    "<p class=\"entry\"><strong>#{m[1]}</strong>" +
  #    "<span class=\"post-key\">#{m[2]}</span>" +
  #    "</p>"
  #  elsif text.match(/\A<em>.+<\/em>\z/)
  #    "<p>#{text}</p>"
  #  else
  #    "<p class=\"entry\"><strong></strong>" +
  #    "<span class=\"post-key\">#{text}</span></p>"
  #  end
  #end

  def doc_footer

    a = []

    a << "\n</section>" if @in_section
    a << "\n</article>" if @in_article

    a.join
  end

  def table(header, body)

    c = header.match?(/<th>STR<\/th>/) ? 'abilities' : nil

    a = []

    a << (c ? "<table class=\"#{c}\">\n" : "<table>\n")
    a << "<thead>#{header}</thead>\n"
    a << "<tbody>#{body}</tbody>\n"
    a << "</table>\n"

    a.join
  end

  #def preprocess(full_doc)
  #end
  #def postprocess(full_doc)
  #end
end


def make_html(title, md, render=HtmlRender, out=$stdout)

  c =
    md.index("\n") ?
    md :
    File.read(File.join('mds', md))

  renderer =
    Redcarpet::Markdown.new(render.new({}), { tables: true })

  out.puts make_html_head(title)
  out.puts renderer.render(c)

  if ! %w[ ogl.md index.md motivation.md colophon.md ].include?(md)
    r = Redcarpet::Markdown.new(HtmlRender.new({}), { tables: true })
    out.puts
    out.puts r.render(File.read('mds/ogl.md'))
    out.puts
  end

  out.puts make_html_foot
end

def make_html_head(title)

  s = File.read(File.join(__dir__, 'head.html'))
  s.sub!('$TITLE', title)

  s
end

def make_html_foot

  #'<div id="client-width"></div>' +
  '</body></html>'
end

def make_html_dir(dir)

  Dir["mds/#{dir}/*.md"].each do |pa|

    c = File.read(pa)
    title = c.split("\n", 2).first
    next if title.nil? || title.match?(/^# [A-Z][A-Z]+/)
#p [ pa, title, title[2..-1] ]
    title = title[2..-1]

    File.open("htmls/spells/#{neutralize_name(title)}.html", 'wb') do |f|

      make_html(title, c, HtmlRender, f)
    end
  end
end

