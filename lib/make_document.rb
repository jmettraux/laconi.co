
def dump(fn)

  puts File.read("mds/#{fn}.md")
end

def make_document

  # TODO table of content!

  dump 'human'
  dump 'dwarf'
  dump 'elf'

  dump 'fighter'
  dump 'rogue'
  dump 'wizard'
end

