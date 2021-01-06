
def index_spells(source_dir_or_source)

  spells =
    source_dir_or_source.index("\n") ?
    source_dir_or_source :
    File.read(File.join(source_dir_or_source, '10.spells.md'))

  lists = extract_md_section(spells, 1, 'SPELLS')

  by_class = {}
  by_name = {}
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
    #else
    #  p l
    end
  end

  [ by_class,
    by_name.keys.sort.inject({}) { |h, k| h[k] = by_name[k]; h },
    classes ]
end

def make_spells(source_dir)

  by_class, by_name, classes =
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
        f.print("**#{l}**")
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
      f.print("**#{k}**")
      v.each { |n| f.print(" [#{n}](##{neutralize_name(n)})") }
      f.puts; f.puts
    end

    by_name.each do |k, v|
      s = extract_md_section(spells, 4, k).sub(/^#+ /, '#')
      s.sub!(/\n\*\*C/, "\n**Classes** #{by_name[k][1..-1].join(', ')}\n\n**C")
      f.puts s
    end
  end

  File.open('mds/spells/index.md', 'wb') do |f|

    f.puts('# SPELLS')
    f.puts

    by_a_and_name.each do |k, v|

      f.print("**#{k}**")
      v.each { |n| f.print(" [#{n}](#{neutralize_name(n)}.html)") }
      f.puts; f.puts
    end
  end

  # TODO
  File.open('mds/spells/by_class.md', 'wb') do |f|
  end

  by_name.each do |k, v|

    s = extract_md_section(spells, 4, k).sub(/^#+ /, '#')
    s.sub!(/\n\*\*C/, "\n**Classes** #{by_name[k][1..-1].join(', ')}\n\n**C")

    File.open("mds/spells/#{neutralize_name(k)}.html", 'wb') do |f|
      f.puts s
    end
  end
end

