
def make_rules(source_dir)

  races = File.read(File.join(source_dir, '01.races.md'))
  classes = File.read(File.join(source_dir, '02.classes.md'))
  equipment = File.read(File.join(source_dir, '05.equipment.md'))
  abilities = File.read(File.join(source_dir, '06.abilities.md'))
  adventuring = File.read(File.join(source_dir, '07.adventuring.md'))
  combat = File.read(File.join(source_dir, '08.combat.md'))
  spellcasting = File.read(File.join(source_dir, '09.spellcasting.md'))
  mastering = File.read(File.join(source_dir, '11.gamemastering.md'))

  puts; puts extract_md_section(races, 1, 'RACES')
  puts; puts extract_md_section(races, 1, 'Human')

  puts; puts extract_md_section(classes, 1, 'CLASSES')
  puts; puts extract_md_section(classes, 1, 'Fighter')
  puts; puts extract_md_section(classes, 1, 'Rogue')
  puts; puts extract_md_section(classes, 1, 'Wizard')

  puts; puts abilities

  puts; puts combat

  puts; puts adventuring # short and long rest...

  puts; puts extract_md_section(equipment, 1, 'EQUIPMENT')
  puts; puts extract_md_section(equipment, 2, 'Coinage')
  puts; puts extract_md_section(equipment, 1, 'Armor')
  puts; puts extract_md_section(equipment, 1, 'Weapons')
  puts; puts extract_md_section(equipment, 1, 'Adventuring Gear')

  puts; puts spellcasting

  puts; puts extract_md_section(mastering, 1, 'GAMEMASTERING')
  puts; puts extract_md_section(mastering, 1, 'Conditions')
  #puts; puts extract_md_section(mastering, 1, 'Situational Rules')
  puts; puts '# Situational Rules'
  s = extract_md_section(mastering, 2, 'Traps')
  i = s.index("\n### Sample Traps")
  puts; puts s[0..i]
  puts; puts extract_md_section(mastering, 2, 'Objects')
end

