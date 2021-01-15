
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
      i = level < 3 ? " id=\"#{t}\"" : ''
      a << "\n<section>" if ! @in_section; @in_section = true
      a << "<h#{level}#{i}>#{title}</h#{level}>"
    end

    a.join
  end

  def paragraph(text)

    return text if text.match(/<p class="subtitle"/)

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


def make_html(title, md, out=$stdout)

  c =
    md.index("\n") ?
    md :
    File.read(File.join('mds', md))

  renderer =
    Redcarpet::Markdown.new(HtmlRender.new({}), { tables: true })

  out.puts make_html_head(title)

  t =
    "t is a thirty feet stick (6 squares)\n" +
    "F is a fourty feet stick (8 squares)\n" +
    "\n" +
    "t-2 means '30 feet minus 2 squares' (20ft)\n" +
    "FFt means '40 + 40 + 30 feet' (110ft)\n" +
    "15F means '15 times 40 feet' (600ft)"

  b = renderer.render(c)
  if
    (c.match?(/^\*\*Armor Class\*\*\s/) && c.match?(/^| STR /)) ||
    (c.match?(/^\*\*Classes:\*\*\s/) && c.match?(/^\*\*Components:\*\*\s/))
  then
    b = FeetExpander.expand(b) { |s|
      s.match?(/\dsq_/) ?
        "<span class=\"distance\" title=\"#{t}\">#{s}</span>" :
        "<span class=\"distance\">#{s}</span>" }
  end
  out.puts b

  if ! [
    'LEGAL INFORMATION', 'LACONI.CO', 'laconi.co colophon',
    'laconi.co motivation'
  ].include?(title) then
#p [ :ogl, title ]
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

def make_htmls

  Dir['mds/**/*.md'].each do |pa|

    hpa = pa.gsub(/^mds\//, 'htmls/').gsub(/\.md$/, '.html')

    content = File.read(pa)

    title = content.strip.split("\n", 2).first; next unless title
    title = title.gsub(/^#+ /, '')

    File.open(hpa, 'wb') do |f|

      make_html(title, content, f)
    end
  end
end

