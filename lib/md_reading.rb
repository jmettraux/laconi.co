
def extract_md_section(path_or_content, level, title)

  s =
    path_or_content.index("\n") ?
    path_or_content :
    File.read(path_or_content)

  t = title.sub(/\(/, '\(').sub(/\)/, '\)')
  i = s.index(/^#{'#' * level} #{t}\n/)
  return nil unless i

  j = (1..level).collect { |l| s.index(/^#{'#' * l} /, i + 1) }.min || -1

  s[i..j - 1].rstrip + "\n"
end

