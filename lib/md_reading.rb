
def extract_md_section(path, level, title)

  s = File.read(path)

  i = s.index(/^#{'#' * level} #{title}\n/)
  return nil unless i

  j = (1..level).collect { |l| s.index(/^#{'#' * l} /, i + 1) }.min || -1

  s[i..j - 1].rstrip + "\n"
end

def extract_md_monster(path, name, morale=nil)

  s =
    extract_md_section(path, 2, name) ||
    extract_md_section(path, 3, name)

  s.sub!(/### #{name}\n/, "## #{name}\n")

  if morale
    i = s.index(/^\*\*Speed\*\* /)
    s.insert(i, "**Morale** #{morale}\n\n")
  end

  "\n" + s
end

