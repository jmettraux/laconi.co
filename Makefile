
SRC=../ogl_srd5
SRC_M=../ogl_srd5/13.monsters.md
LI=-Ilib -rlaconico

md: md_rules md_spells md_monsters
	cat mds/rules.md mds/spells.md mds/monsters.md > mds/srd.md

md_rules:
	ruby ${LI} -e "make_rules('${SRC}')" > mds/rules.md

md_spells:
	echo "" > mds/spells.md
	cat ${SRC}/10.spells.md >> mds/spells.md

md_monsters:
	echo "" > mds/monsters.md
	echo "# MONSTERS\n" >> mds/monsters.md
	ruby ${LI} \
      -e "puts extract_md_section('${SRC_M}', 1, 'Monster Statistics')" \
        >> mds/monsters.md
	ruby ${LI} \
      -e "puts extract_md_section('${SRC_M}', 1, 'Legendary Creatures')" \
        >> mds/monsters.md
	ruby ${LI} \
      -e "make_monsters('${SRC_M}')" \
        >> mds/monsters.md

html_rules:
	ruby ${LI} -e "make_html('rules.md')" > htmls/rules.html
html: html_rules

s:
	ruby -run -ehttpd htmls/ -p7003

.PHONY: md md_clear md_rules md_spells md_monsters html

