
SRC=../ogl_srd5
LI=-Ilib -rlaconico

all: md html

md_monsters:
	ruby ${LI} -e "make_monsters('${SRC}')" > mds/monsters.md
md_spells:
	cat ${SRC}/10.spells.md > mds/spells.md
md_classes:
	ruby ${LI} -e "make_classes('${SRC}')" > mds/classes.md
md_races:
	ruby ${LI} -e "make_races('${SRC}')" > mds/races.md
md_rules:
	ruby ${LI} -e "make_rules('${SRC}')" > mds/rules.md

md: md_races md_classes md_rules md_spells md_monsters
	cat \
      mds/races.md mds/classes.md \
      mds/rules.md mds/spells.md mds/monsters.md \
        > mds/srd.md

html_monsters:
	ruby ${LI} -e "make_html('Monsters', 'monsters.md', MonsterHtmlRender)" \
      > htmls/monsters.html
html_spells:
	ruby ${LI} -e "make_html('Spells', 'spells.md')" > htmls/spells.html
html_classes:
	ruby ${LI} -e "make_html('Classes', 'classes.md')" > htmls/classes.html
html_races:
	ruby ${LI} -e "make_html('Races', 'races.md')" > htmls/races.html
html_rules:
	ruby ${LI} -e "make_html('Rules', 'rules.md')" > htmls/rules.html

html: html_races html_classes html_rules html_spells html_monsters
	ruby ${LI} -e "make_html('SRD', 'srd.md')" > htmls/srd.html

s:
	ruby -run -ehttpd htmls/ -p7003

.PHONY: md md_clear md_rules md_spells md_monsters html

