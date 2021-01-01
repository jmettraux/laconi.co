
def extract_md_monster(path_or_content, name, morale=nil)

  s =
    extract_md_section(path_or_content, 2, name) ||
    extract_md_section(path_or_content, 3, name)

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
  'Duergar' => 8,
  'Elf, Drow' => 8,
  'Ettin' => 11,
    }

def make_monsters(path, morales=MORALES)

  c = File.read(path)

  morales.each do |n, m|

    puts(extract_md_monster(c, n, m))
  end
end

