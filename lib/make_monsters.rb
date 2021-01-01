
def extract_md_monster(path_or_content, name, morale=nil)

  s =
    extract_md_section(path_or_content, 2, name) ||
    extract_md_section(path_or_content, 3, name)

  n = name.sub(/\(/, '\(').sub(/\)/, '\)')
  s.sub!(/### #{name}\n/, "## #{name}\n")

  if morale
    i = s.index(/^\*\*Speed\*\* /)
    s.insert(i, "**Morale** #{morale}\n\n")
  end

  "\n" + s
end

MORALES = {
  'Animated Armor' => 12,
  'Basilisk' => 9,
  'Behir' => 9,
  'Bugbear' => 9,
  'Centaur' => 8,
  'Chimera' => 9,
  'Cockatrice' => 7,
  'Couatl' => 12,
  'Barbed Devil' => 10,
  'Erinyes' => 10,
  'Horned Devil' => 10,
  'Imp' => 7,
  'Lemure' => 5,
  'Black Dragon' => 8,
  'Blue Dragon' => 9,
  'Green Dragon' => 9,
  'Red Dragon' => 10,
  'White Dragon' => 8,
  'Brass Dragon' => 9,
  'Bronze Dragon' => 9,
  'Copper Dragon' => 9,
  'Gold Dragon' => 10,
  'Silver Dragon' => 10,
  'Dragon Turtle' => 10,
  'Dryad' => 6,
  'Duergar' => '8 (10 with leader)',
  'Elf, Drow' => '8 (10 with leader)',
  'Ettin' => 11,
  'Gargoyle' => 11,
  'Djinni' => 12,
  'Efreeti' => 12,
  'Ghost' => 9,
  'Ghast' => 9,
  'Ghoul' => 9,
  'Cloud Giant' => 10,
  'Fire Giant' => 9,
  'Frost Giant' => 9,
  'Hill Giant' => 9,
  'Stone Giant' => 9,
  'Storm Giant' => 10,
  'Gnome, Deep (Svirfneblin)' => '8 (10 with leader)',
  'Goblin' => '7 (9 with leader)',
  'Clay Golem' => 12,
  'Flesh Golem' => 12,
  'Iron Golem' => 12,
  'Stone Golem' => 12,
  'Gorgon' => 8,
  'Griffon' => 8,
  'Green Hag' => 12,
  #'Night Hag' => 11,
  #'Sea Hag' => 8,
  'Harpy' => 7,
  'Hell Hound' => 9,
  'Hippogriff' => 8,
  'Hobgoblin' => '8 (10 with leader)',
  'Homunculus' => 12,
  'Hydra' => 9,
  'Invisible Stalker' => 12,
  'Kobold' => '6 (8 with leader)',
  'Kraken' => 11,
  'Lamia' => 12,
  'Lich' => 12,
  'Lizardfolk' => 12,
  'Werebear' => 10,
  'Wereboar' => 9,
  'Wererat' => 8,
  'Weretiger' => 9,
  'Werewolf' => 8,
  'Manticore' => 9,
  'Medusa' => 8,
  'Merfolk' => 8,
  #'Mimic' => 12,
  'Minotaur' => 12,
  'Mummy' => 12,
  #'Mummy Lord' => 12,
  'Guardian Naga' => 12,
  'Spirit Naga' => 11,
  'Nightmare' => 11,
  'Ogre' => 10,
  'Oni' => 11,
    }

def make_monsters(path, morales=MORALES)

  c = File.read(path)

  morales.each do |n, m|

#$stderr.puts("    * #{n} => #{m}")
    puts(extract_md_monster(c, n, m))
  end
end

