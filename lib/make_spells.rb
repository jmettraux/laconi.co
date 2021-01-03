
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
      cla = $1[0, 3].downcase
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

  [ by_class, by_name, classes ]
end

def make_spells(source_dir)

  by_class, by_name, classes =
    index_spells(source_dir)

  by_name.keys.sort.each do |k|
    lev, *clas = by_name[k]
    puts "* #{k} - #{lev} - #{clas.join(', ')}"
  end
end

