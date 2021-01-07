
def extract_md_monster(path_or_content, name, key, morale)

#$stderr.puts [ name, key, morale ].inspect
  s =
    extract_md_section(path_or_content, 2, name) ||
    extract_md_section(path_or_content, 3, name) ||
    extract_md_section(path_or_content, 4, name) ||
    extract_md_section(path_or_content, 1, name)

  i =
    s.index("\n")
  s =
    "# #{key}\n" +
    s[i + 1..-1]
      .gsub(/^(#+) /) { |m| m[1, 2] + ' ' }
      .gsub(/\*\*\*\./, '.***')
      .gsub(/\*\*\./, '.**')

  i = s.index(/^\*\*Speed\*\* /)
  s.insert(i, "**Morale** #{morale}\n\n")

  "\n" + s
end

MONSTERS = YAML.load_file('etc/monsters.yaml')
CREATURES = YAML.load_file('etc/creatures.yaml')
CHARACTERS = YAML.load_file('etc/characters.yaml')


def make_monsters(src_dir)

  MONSTERS.each { |k, v|
    v << File.read(File.join(src_dir, '13.monsters.md')) }
  CREATURES.each { |k, v|
    v << File.read(File.join(src_dir, '14.creatures.md')) }
  CHARACTERS.each { |k, v|
    v << File.read(File.join(src_dir, '15.npcs.md')) }

  cs = {}
    .merge(MONSTERS).merge(CREATURES).merge(CHARACTERS)
  azs = cs
    .inject(('A'..'Z').inject({}) { |h, k| h[k] = []; h }) { |h, (k, _)|
      a = k[0]; h[a] << k; h[a].sort!; h }
    .select { |k, v|
      v.any? }

  File.open('mds/monsters.md', 'wb') do |f|

    f.puts '# MONSTERS'

    #f.puts "\n## Index"

    f.puts "\n"
    azs
      .each { |k, ns|
        f.print "\n**#{k}** "
        ns.each { |n| f.print "[#{n}](##{neutralize_name(n)}) " }
        f.puts "\n" }
    f.puts

    azs
      .each { |k, ns|
#$stderr.puts("* #{k} => #{ns[0, 2]}")
        ns.each { |n|
          k, m, s = cs[n]
#$stderr.puts([ n, k, m ].inspect)
          f.puts(extract_md_monster(s, k, n, m)) } }
  end

  cs.each do |n, (k, m, s)|

    File.open("mds/monsters/#{neutralize_name(n)}.md", 'wb') do |f|

      f.puts(extract_md_monster(s, k, n, m))
    end
  end

  File.open('mds/monsters_by_name.md', 'wb') do |f|

    f.puts('# MONSTERS')
    f.puts('<p class="subtitle">by name</a>')
    f.puts

    azs.each do |k, ns|

      f.print("<strong class=\"key\">#{k}</strong>")
      ns.each { |n| f.print(" [#{n}](monsters/#{neutralize_name(n)}.html)") }
      f.puts; f.puts
    end
  end


  File.open('mds/monster_statistics.md', 'wb') do |f|

    monsters = File.read(File.join(src_dir, '13.monsters.md'))

    f.puts extract_md_section(monsters, 1, 'Monster Statistics')
    f.puts extract_md_section(monsters, 1, 'Legendary Creatures')
  end
end

