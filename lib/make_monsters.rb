
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

ms = {
  'Animated Armor' => 12,
  'Basilisk' => 9,
  'Behir' => 9,
  'Bugbear' => 9,
  'Centaur' => 8,
  'Chimera' => 9,
  'Cockatrice' => 7,
  'Couatl' => 12,
  'Barbed Devil' => [ 'Devil, Barbed', 10 ],
  'Erinyes' => 10,
  'Horned Devil' => [ 'Devil, Horned', 10 ],
  'Imp' => 7,
  'Lemure' => 5,
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
  'Cloud Giant' => [ 'Giant, Cloud', 10 ],
  'Fire Giant' => [ 'Giant, Fire', 9 ],
  'Frost Giant' => [ 'Giant, Frost', 9 ],
  'Hill Giant' => [ 'Giant, Hill', 9 ],
  'Stone Giant' => [ 'Giant, Stone', 9 ],
  'Storm Giant' => [ 'Giant, Storm', 10 ],
  'Gnome, Deep (Svirfneblin)' => [ 'Svirfneblin', '8 (10 with leader)' ],
  'Goblin' => '7 (9 with leader)',
  'Clay Golem' => [ 'Golem, Clay', 12 ],
  'Flesh Golem' => [ 'Golem, Flesh', 12 ],
  'Iron Golem' => [ 'Golem, Iron', 12 ],
  'Stone Golem' => [ 'Golem, Stone', 12 ],
  'Gorgon' => 8,
  'Griffon' => 8,
  'Green Hag' => [ 'Hag, Green', 12 ],
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
  'Guardian Naga' => [ 'Naga, Guardian', 12 ],
  'Spirit Naga' => [ 'Naga, Spirit', 11 ],
  'Nightmare' => 11,
  'Ogre' => 10,
  'Oni' => 11,
  #'Black Pudding' => 12,
  #'Gelatinous Cube' => 12,
  #'Gray Ooze' => 12,
  #'Ochre Jelly' => 12,
  'Orc' => '6 (8 with leader)',
  'Pegasus' => 8,
  'Pseudodragon' => 11,
  'Purple Worm' => [ 'Worm, Purple', 10 ],
  'Rakshasa' => 11,
  #'Remorhaz' => 9,
  'Roc' => '10 (12 in lair)',
  #'Roper' => 10,
  #'Rust Monster' => 7,
  #'Sahuagin' => 7,
  'Salamander' => 8,
  'Satyr' => 8,
  'Shadow' => 12,
  'Shambling Mound' => 9,
  #'Shield Guardian' => 12,
  'Skeleton' => 12,
  #'Minotaur Skeleton' => 12,
  'Warhorse Skeleton' => [ 'Skeleton, Warhorse', 12 ],
  'Specter' => 11,
  'Androsphinx' => [ 'Sphinx, Androshpinx', 12 ],
  'Gynosphinx' => [ 'Sphinx, Gynoshpinx', 12 ],
  'Sprite' => 7,
  #'Stirge' => 9,
  'Succubus/Incubus' => 10,
  'Tarrasque' => 10,
  'Treant' => 9,
  'Troll' => '10 (8 fear of fire)',
  'Unicorn' => 7,
  'Vampire' => 11,
  'Vampire Spawn' => 9,
  'Wight' => 12,
  'Will-o\'-Wisp' => 12,
  'Wraith' => 12,
  'Wyvern' => 9,
  'Zombie' => 12,
    }
{ 'Black' => 8,
  'Blue' => 9,
  'Green' => 9,
  'Red' => 10,
  'White' => 8,
  'Brass' => 9,
  'Bronze' => 9,
  'Copper' => 9,
  'Gold' => 10,
  'Silver' => 10 }
    .each { |c, m|
      %w[ Ancient Adult Young Wyrmling ]
        .each { |a| ms["#{a} #{c} Dragon"] = [ "Dragon #{c} #{a}", m ] }
      %w[ Wyrmling ]
        .each { |a| ms["#{c} Dragon #{a}"] = [ "Dragon #{c} #{a}", m ] } }
MONSTERS = ms
  .inject({}) { |h, (k, v)|
    n, m = v.is_a?(Array) ? v : [ k, v ]; h[n] = [ k, m ]; h }

cs = {
  'Ape' => 7,
  'Axe Beak' => 7,
  'Baboon' => 7,
  'Badger' => 6,
  'Bat' => 8,
  'Black Bear' => 7,
  'Brown Bear' => 7,
  'Boar' => 9,
  'Camel' => 7,
  'Cat' => 6,
  'Constrictor Snake' => 9,
  'Crab' => 6,
  'Crocodile' => 7,
  'Deer' => 7,
  'Dire Wolf' => 8,
  'Draft Horse' => 6,
  'Eagle' => 7,
  'Elephant' => 8,
  'Elk' => 7,
  'Frog' => 6,
  'Giant Ape' => 8,
  'Giant Badger' => 8,
  'Giant Bat' => 8,
  'Giant Boar' => 8,
  'Giant Centipede' => 7,
  'Giant Constrictor Snake' => 8,
  'Giant Crab' => 7,
  'Giant Crocodile' => 9,
  'Giant Eagle' => 8,
  'Giant Elk' => 8,
  'Giant Fire Beetle' => 7,
  'Giant Frog' => 7,
  'Giant Goat' => 7,
  'Giant Hyena' => 8,
  'Giant Lizard' => 7,
  'Giant Octopus' => 7,
  'Giant Owl' => 7,
  'Giant Poisonous Snake' => 8,
  'Giant Rat' => 8,
  'Giant Scorpion' => 11,
  'Giant Sea Horse' => 6,
  'Giant Shark' => 7,
  'Giant Spider' => 8,
  'Giant Toad' => 6,
  'Giant Vulture' => 6,
  'Giant Wasp' => 8,
  'Giant Weasel' => 8,
  'Giant Wolf Spider' => 8,
  'Goat' => 7,
  'Hawk' => 7,
  'Hunter Shark' => 7,
  'Hyena' => 7,
  'Jackal' => 7,
  'Killer Whale' => 10,
  'Lion' => 8,
  'Lizard' => 6,
  'Mammoth' => 9,
  'Mule' => 8,
  'Octopus' => 6,
  'Owl' => 6,
  'Panther' => 8,
  'Poisonous Snake' => 7,
  'Polar Bear' => 8,
  'Pony' => 6,
  'Quipper' => 8,
  'Rat' => 5,
  'Raven' => 6,
  'Reef Shark' => 7,
  'Rhinoceros' => 6,
  'Riding Horse' => 7,
  'Saber-Toothed Tiger' => 8,
  'Scorpion' => 9,
  'Sea Horse' => 6,
  'Spider' => 6,
  'Swarm of Bats' => 8,
  'Swarm of Insects' => 8,
  'Swarm of Poisonous Snakes' => 9,
  'Swarm of Quippers' => 10,
  'Swarm of Rats' => 10,
  'Swarm of Ravens' => 9,
  'Tiger' => 8,
  'Vulture' => 6,
  'Warhorse' => 9,
  'Weasel' => 7,
  'Winter Wolf' => 8,
  'Wolf' => '6 (8 in pack)',
  'Worg' => 8,
    }
CREATURES = cs
  .inject({}) { |h, (k, m)|
    n =
      case k
      when 'Giant Wolf Spider' then 'Spider, Giant Wolf'
      when 'Giant Poisonous Snake' then 'Snake, Giant Poisonous'
      when 'Giant Constrictor Snake' then 'Snake, Giant Constrictor'
      when /^Giant (.+)$/ then "#{$1}, Giant"
      when /^Swarm of (.+)$/ then "#{$1}, Swarm"
      when /^(.+) Bear$/ then "Bear, #{$1}"
      when /^(.+) Wolf$/ then "Wolf, #{$1}"
      when /^(.+) Shark$/ then "Shark, #{$1}"
      when /^(.+) Whale$/ then "Whale, #{$1}"
      when /^(.+) Snake$/ then "Snake, #{$1}"
      else k
      end
    h[n] = [ k, m ]
    h }

cs = {
  'Archmage' => 10,
  'Bandit' => 8,
  'Bandit Captain' => 9,
  'Commoner' => 6,
  'Druid' => 9,
  'Gladiator' => 10,
  'Guard' => 8,
  'Knight' => 10,
  'Mage' => 9,
  'Noble' => 7,
  'Scout' => 6,
  'Thug' => 7,
  'Tribal Warrior' => 8,
  'Veteran' => 8,
    }
CHARACTERS = cs
  .inject({}) { |h, (k, v)|
    n, m = v.is_a?(Array) ? v : [ k, v ]; h[n] = [ k, m ]; h }

def make_monsters(src_dir)

  monsters = File.read(File.join(src_dir, '13.monsters.md'))
  creatures = File.read(File.join(src_dir, '14.creatures.md'))
  characters = File.read(File.join(src_dir, '15.npcs.md'))

  MONSTERS.each { |k, v| v << monsters }
  CREATURES.each { |k, v| v << creatures }
  CHARACTERS.each { |k, v| v << characters }

  cs = {}
    .merge(MONSTERS).merge(CREATURES).merge(CHARACTERS)
  azs = cs
    .inject(('A'..'Z').inject({}) { |h, k| h[k] = []; h }) { |h, (k, _)|
      a = k[0]; h[a] << k; h[a].sort!; h }
    .select { |k, v|
      v.any? }

  File.open('mds/monsters.md', 'wb') do |f|

    f.puts '# MONSTERS'

    f.puts "\n## Index"

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

  File.open('mds/monster_statisticss.md', 'wb') do |f|

    f.puts extract_md_section(monsters, 1, 'Monster Statistics')
    f.puts extract_md_section(monsters, 1, 'Legendary Creatures')
  end
end

