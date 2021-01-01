
SRC=../ogl_srd5
SRC_M=../ogl_srd5/13.monsters.md

md: md_clear md_rules md_spells md_monsters
	cat mds/rules.md mds/spells.md mds/monsters.md > mds/srd.md

md_clear:
	echo "" > mds/rules.md
	echo "" > mds/spells.md
	echo "" > mds/monsters.md

md_rules:
	ruby -Ilib -rlaconico \
      -e "puts extract_md_section('${SRC}/01.races.md', 1, 'RACES')" \
        >> mds/rules.md
	echo "\n" >> mds/rules.md
	echo "#CLASSES\n" >> mds/rules.md
	ruby -Ilib -rlaconico \
      -e "puts extract_md_section('${SRC}/02.classes.md', 1, 'Fighter')" \
        >> mds/rules.md
	ruby -Ilib -rlaconico \
      -e "puts extract_md_section('${SRC}/02.classes.md', 1, 'Rogue')" \
        >> mds/rules.md
	ruby -Ilib -rlaconico \
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
	ruby -Ilib -rlaconico \
      -e "puts extract_md_section('${SRC_M}', 1, 'Monster Statistics')" \
        >> mds/monsters.md
	ruby -Ilib -rlaconico \
      -e "puts extract_md_section('${SRC_M}', 1, 'Legendary Creatures')" \
        >> mds/monsters.md
	ruby -Ilib -rlaconico \
      -e "puts extract_md_section('${SRC_M}', 2, 'Animated Objects')" \
        >> mds/monsters.md
	ruby -Ilib -rlaconico -e \
      "puts; puts extract_md_section('${SRC_M}', 2, 'Basilisk')" \
        >> mds/monsters.md
	ruby -Ilib -rlaconico -e \
      "puts; puts extract_md_section('${SRC_M}', 2, 'Behir')" \
        >> mds/monsters.md

.PHONY: md md_clear md_rules md_spells md_monsters

