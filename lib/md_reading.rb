
def extract_md_section(path, level, title)

  s = File.read(path)

  i = s.index(/^#{'#' * level} #{title}\n/)

  #j = s.index(/^#{'#' * level} /, i + 1) || 0
  j = (1..level).collect { |l| s.index(/^#{'#' * l} /, i + 1) }.min

  s[i..j - 1].rstrip + "\n"
end

