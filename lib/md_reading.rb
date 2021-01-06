
def extract_md_section(path_or_content, level, title, capitalize=false)

  s =
    path_or_content.index("\n") ?
    path_or_content :
    File.read(path_or_content)

  i = s.index("#{'#' * level} #{title}\n")
  return nil unless i

  j = (1..level)
    .collect { |l| s.index(/^#{'#' * l} /, i + 1) }
    .compact
    .min ||
      -1

  s = s[i..j - 1].rstrip + "\n"

  s = s.gsub("#{'#' * level} #{title}\n", "#{'#' * level} #{title.upcase}\n") \
    if capitalize

  s
end

