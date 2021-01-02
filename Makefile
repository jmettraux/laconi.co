
SRC=../ogl_srd5
LI=-Ilib -rlaconico

md: md_rules md_spells md_monsters
	cat mds/rules.md mds/spells.md mds/monsters.md > mds/srd.md

md_rules:
	ruby ${LI} -e "make_rules('${SRC}')" > mds/rules.md

md_spells:
	cat ${SRC}/10.spells.md > mds/spells.md

md_monsters:
	ruby ${LI} -e "make_monsters('${SRC}')" > mds/monsters.md

html_rules:
	ruby ${LI} -e "make_html('rules.md')" > htmls/rules.html

html: html_rules

s:
	ruby -run -ehttpd htmls/ -p7003

.PHONY: md md_clear md_rules md_spells md_monsters html

