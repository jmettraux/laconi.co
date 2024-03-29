
def make_race(source_dir, name)

  races = File.read(File.join(source_dir, '01.races.md'))

  puts extract_md_section(races, 1, name, true)
end

def make_class(source_dir, name)

  classes = File.read(File.join(source_dir, '02.classes.md'))

  puts extract_md_section(classes, 1, name, true)
end

def make_rules(source_dir)

  equipment = File.read(File.join(source_dir, '05.equipment.md'))
  abilities = File.read(File.join(source_dir, '06.abilities.md'))
  adventuring = File.read(File.join(source_dir, '07.adventuring.md'))
  combat = File.read(File.join(source_dir, '08.combat.md'))
  spellcasting = File.read(File.join(source_dir, '09.spellcasting.md'))
  mastering = File.read(File.join(source_dir, '11.gamemastering.md'))

  File.open('mds/abilities.md', 'wb') do |f|
    f.puts abilities
  end

  File.open('mds/combat.md', 'wb') do |f|
    f.puts combat
  end
  File.open('mds/conditions.md', 'wb') do |f|
    f.puts extract_md_section(mastering, 1, 'Conditions', true)
  end

  File.open('mds/adventuring.md', 'wb') do |f|
    f.puts adventuring
  end

  File.open('mds/armor.md', 'wb') do |f|
    f.puts extract_md_section(equipment, 1, 'Armor', true)
  end
  File.open('mds/weapons.md', 'wb') do |f|
    f.puts extract_md_section(equipment, 1, 'Weapons', true)
  end
  File.open('mds/gear.md', 'wb') do |f|
    f.puts extract_md_section(equipment, 1, 'Adventuring Gear', true)
  end

  File.open('mds/spellcasting.md', 'wb') do |f|
    f.puts spellcasting
  end
end

