
def make_html(md)

  c = File.read(File.join('mds', md))

  renderer =
    Redcarpet::Markdown.new(
      Redcarpet::Render::HTML.new({}),
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

