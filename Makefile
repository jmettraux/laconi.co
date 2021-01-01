
SRC=../ogl_srd5
SRC_M=../ogl_srd5/13.monsters.md
LI=-Ilib -rlaconico

md: md_clear md_rules md_spells md_monsters
	cat mds/rules.md mds/spells.md mds/monsters.md > mds/srd.md

md_clear:
	echo "" > mds/rules.md
	echo "" > mds/spells.md
	echo "" > mds/monsters.md

md_rules:
	ruby ${LI} \
      -e "puts extract_md_section('${SRC}/01.races.md', 1, 'RACES')" \
        >> mds/rules.md
	echo "\n" >> mds/rules.md
	echo "#CLASSES\n" >> mds/rules.md
	ruby ${LI} \
      -e "puts extract_md_section('${SRC}/02.classes.md', 1, 'Fighter')" \
        >> mds/rules.md
	ruby ${LI} \
      -e "puts extract_md_section('${SRC}/02.classes.md', 1, 'Rogue')" \
        >> mds/rules.md
	ruby ${LI} \
      -e "puts extract_md_section('${SRC}/02.classes.md', 1, 'Wizard')" \
        >> mds/rules.md
	echo "\n" >> mds/rules.md
	cat ${SRC}/05.equipment.md >> mds/rules.md
	echo "\n" >> mds/rules.md
	cat ${SRC}/06.abilities.md >> mds/rules.md
	echo "\n" >> mds/rules.md
	cat ${SRC}/07.adventuring.md >> mds/rules.md
	echo "\n" >> mds/rules.md
	cat ${SRC}/08.combat.md >> mds/rules.md
	echo "\n" >> mds/rules.md
	cat ${SRC}/09.spellcasting.md >> mds/rules.md
	echo "\n" >> mds/rules.md
	cat ${SRC}/11.gamemastering.md >> mds/rules.md

md_spells:
	echo "\n" >> mds/spells.md
	cat ${SRC}/10.spells.md >> mds/spells.md

md_monsters:
	echo "\n" >> mds/monsters.md
	echo "#MONSTERS\n" >> mds/monsters.md
	ruby ${LI} \
      -e "puts extract_md_section('${SRC_M}', 1, 'Monster Statistics')" \
        >> mds/monsters.md
	ruby ${LI} \
      -e "puts extract_md_section('${SRC_M}', 1, 'Legendary Creatures')" \
        >> mds/monsters.md
	ruby ${LI} -e "puts extract_md_monster('${SRC_M}', 'Animated Armor', 12)" \
      >> mds/monsters.md
	#
	ruby ${LI} -e "puts extract_md_monster('${SRC_M}', 'Basilisk', 9)" \
      >> mds/monsters.md
	ruby ${LI} -e "puts extract_md_monster('${SRC_M}', 'Behir', 9)" \
      >> mds/monsters.md
	ruby ${LI} -e "puts extract_md_monster('${SRC_M}', 'Bugbear', 9)" \
      >> mds/monsters.md
	ruby ${LI} -e "puts extract_md_monster('${SRC_M}', 'Centaur', 8)" \
      >> mds/monsters.md
	ruby ${LI} -e "puts extract_md_monster('${SRC_M}', 'Chimera', 9)" \
      >> mds/monsters.md
	ruby ${LI} -e "puts extract_md_monster('${SRC_M}', 'Cockatrice', 7)" \
      >> mds/monsters.md
	ruby ${LI} -e "puts extract_md_monster('${SRC_M}', 'Couatl', 12)" \
      >> mds/monsters.md
	ruby ${LI} -e "puts extract_md_monster('${SRC_M}', 'Barbed Devil', 10)" \
      >> mds/monsters.md
	ruby ${LI} -e "puts extract_md_monster('${SRC_M}', 'Erinyes', 10)" \
      >> mds/monsters.md
	ruby ${LI} -e "puts extract_md_monster('${SRC_M}', 'Horned Devil', 10)" \
      >> mds/monsters.md
	ruby ${LI} -e "puts extract_md_monster('${SRC_M}', 'Imp', 7)" \
      >> mds/monsters.md
	ruby ${LI} -e "puts extract_md_monster('${SRC_M}', 'Lemure', 5)" \
      >> mds/monsters.md
	#
	ruby ${LI} -e "puts extract_md_monster('${SRC_M}', 'Black Dragon', 8)" \
      >> mds/monsters.md
	ruby ${LI} -e "puts extract_md_monster('${SRC_M}', 'Blue Dragon', 9)" \
      >> mds/monsters.md
	ruby ${LI} -e "puts extract_md_monster('${SRC_M}', 'Green Dragon', 9)" \
      >> mds/monsters.md
	ruby ${LI} -e "puts extract_md_monster('${SRC_M}', 'Red Dragon', 10)" \
      >> mds/monsters.md
	ruby ${LI} -e "puts extract_md_monster('${SRC_M}', 'White Dragon', 8)" \
      >> mds/monsters.md
	ruby ${LI} -e "puts extract_md_monster('${SRC_M}', 'Brass Dragon', 9)" \
      >> mds/monsters.md
	ruby ${LI} -e "puts extract_md_monster('${SRC_M}', 'Bronze Dragon', 9)" \
      >> mds/monsters.md
	ruby ${LI} -e "puts extract_md_monster('${SRC_M}', 'Copper Dragon', 9)" \
      >> mds/monsters.md
	ruby ${LI} -e "puts extract_md_monster('${SRC_M}', 'Gold Dragon', 10)" \
      >> mds/monsters.md
	ruby ${LI} -e "puts extract_md_monster('${SRC_M}', 'Silver Dragon', 10)" \
      >> mds/monsters.md
	#
	ruby ${LI} -e "puts extract_md_monster('${SRC_M}', 'Dragon Turtle', 10)" \
      >> mds/monsters.md
	ruby ${LI} -e "puts extract_md_monster('${SRC_M}', 'Dryad', 6)" \
      >> mds/monsters.md
	ruby ${LI} -e "puts extract_md_monster('${SRC_M}', 'Duergar', 8)" \
      >> mds/monsters.md
	ruby ${LI} -e "puts extract_md_monster('${SRC_M}', 'Elf, Drow', 8)" \
      >> mds/monsters.md
	ruby ${LI} -e "puts extract_md_monster('${SRC_M}', 'Ettin', 11)" \
      >> mds/monsters.md

.PHONY: md md_clear md_rules md_spells md_monsters

