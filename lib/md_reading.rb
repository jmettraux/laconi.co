
def extract_md_section(path, level, title)

  s = File.read(path)
  i = s.index(/^#{'#' * level} #{title}\n/)
  j = s.index(/^#{'#' * level} /, i + 1) || 0

  s[i..j - 1]
end

