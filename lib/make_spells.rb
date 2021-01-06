
def index_spells(source_dir_or_source)

  spells =
    source_dir_or_source.index("\n") ?
    source_dir_or_source :
    File.read(File.join(source_dir_or_source, '10.spells.md'))

  lists = extract_md_section(spells, 1, 'SPELLS')

  by_class = {}
  by_name = {}
  by_level = {}
  classes = []
    #
  cla = nil
  lev = nil
    #
  lists.split("\n").drop(1).each do |l|
    if l.match(/^## (.+) Spells/)
      #cla = $1[0, 3].downcase
      cla = $1
      classes << $1
    elsif l.match(/^#### .*(\d+)/)
      lev = $1.to_i
    elsif l.match(/^- (.+)$/)
      ((by_class[cla] ||= {})[lev] ||= []) << $1
      (by_name[$1] ||= [ lev ]) << cla
      (by_level[lev] ||= []) << $1
    #else
    #  p l
    end
  end

  by_level.each { |_, v| v.sort!.uniq! }

  [ by_class,
    by_name.keys.sort.inject({}) { |h, k| h[k] = by_name[k]; h },
    by_level,
    classes ]
end

def make_spells(source_dir)

  by_class, by_name, by_level, classes =
    index_spells(source_dir)

  by_a_and_name = by_name
    .inject({}) { |h, (k, _)| (h[k[0,1]] ||= []) << k; h }

  File.open('mds/spell_lists.md', 'wb') do |f|

    f.puts('# SPELL LISTS')
    f.puts

    cls = [ 'Wizard' ] + (classes - [ 'Wizard' ]).sort

    cls.each do |k|

      f.puts("## #{k}")
      f.puts

      by_class[k].each do |l, ns|
        f.print("<strong class=\"key\">#{l}</strong>")
        ns.each do |name|
          n = neutralize_name(name)
          f.print(" [#{name}](spells.html##{n})")
        end
        f.puts; f.puts
      end
      f.puts
    end
  end

  spells = File.read(File.join(source_dir, '10.spells.md'))

  File.open('mds/spells.md', 'wb') do |f|

    f.puts('# SPELLS')
    f.puts

    by_a_and_name.each do |k, v|
      f.print("<strong class=\"key\">#{k}</strong>")
      v.each { |n| f.print(" [#{n}](##{neutralize_name(n)})") }
      f.puts; f.puts
    end

    by_name.each do |k, v|
      s = extract_md_section(spells, 4, k).sub(/^#+ /, '# ')
      s.sub!(/\n\*\*C/, "\n**Classes:** #{by_name[k][1..-1].join(', ')}\n\n**C")
      f.puts s
    end
  end

  #File.open('mds/spells/index.md', 'wb') do |f|
  #  f.puts('# SPELLS')
  #  f.puts
  #  f.puts('[Top](../index.html)')
  #  f.puts
  #  f.puts('[By Name](by_name.html)')
  #  f.puts('[By Level](by_level.html)')
  #  f.puts('[By Class](by_class.html)')
  #  f.puts
  #end

  File.open('mds/spells_by_name.md', 'wb') do |f|

    f.puts('# SPELLS')
    f.puts('<p class="subtitle">by name</a>')
    f.puts

    by_a_and_name.each do |k, v|

      f.print("<strong class=\"key\">#{k}</strong>")
      v.each { |n| f.print(" [#{n}](spells/#{neutralize_name(n)}.html)") }
      f.puts; f.puts
    end
  end

  File.open('mds/spells_by_level.md', 'wb') do |f|

    f.puts('# SPELLS')
    f.puts('<p class="subtitle">by level</a>')
    f.puts

    by_level.each do |k, v|

      f.print("<strong class=\"key\">#{k}</strong>")
      v.each { |n| f.print(" [#{n}](spells/#{neutralize_name(n)}.html)") }
      f.puts; f.puts
    end
  end

  File.open('mds/spells_by_class.md', 'wb') do |f|

    f.puts('# SPELLS')
    f.puts('<p class="subtitle">by class</a>')
    f.puts

    cls = [ 'Wizard' ] + (by_class.keys - [ 'Wizard' ])

    cls.each do |c|

      f.print("## #{c}\n")

      by_class[c].each do |k, ns|

        f.print("<strong class=\"key\">#{k}</strong>")
        ns.each { |n| f.print(" [#{n}](spells/#{neutralize_name(n)}.html)") }
        f.puts; f.puts
      end
    end
  end

  by_name.each do |k, v|

    s = extract_md_section(spells, 4, k).sub(/^#+ /, '# ')
    s.sub!(/\n\*\*C/, "\n**Classes:** #{by_name[k][1..-1].join(', ')}\n\n**C")

    File.open("mds/spells/#{neutralize_name(k)}.md", 'wb') do |f|
      f.puts s
    end
  end
end

