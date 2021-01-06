
SRC=../ogl_srd5
LI=-Ilib -rlaconico

all: md html
c: all

md_spells:
	#cat ${SRC}/10.spells.md > mds/spells.md
	ruby ${LI} -e "make_spells('${SRC}')"
md_monsters:
	ruby ${LI} -e "make_monsters('${SRC}')"
md_classes:
	ruby ${LI} -e "make_class('${SRC}', 'Fighter')" > mds/fighter.md
	ruby ${LI} -e "make_class('${SRC}', 'Rogue')" > mds/rogue.md
	ruby ${LI} -e "make_class('${SRC}', 'Wizard')" > mds/wizard.md
md_races:
	ruby ${LI} -e "make_race('${SRC}', 'Human')" > mds/human.md
	ruby ${LI} -e "make_race('${SRC}', 'Elf')" > mds/elf.md
	ruby ${LI} -e "make_race('${SRC}', 'Dwarf')" > mds/dwarf.md
md_rules:
	ruby ${LI} -e "make_rules('${SRC}')"
md_ogl:
	echo "# LEGAL INFORMATION" > mds/ogl.md
	tail -52 ${SRC}/legal.md >> mds/ogl.md

md: md_ogl md_races md_classes md_rules md_spells md_monsters

html_monsters:
	ruby ${LI} -e "make_html('Monsters', 'monsters.md', MonsterHtmlRender)" \
      > htmls/monsters.html
	ruby ${LI} -e "make_html('Monsters Statistics', 'monster_statisticss.md')" \
      > htmls/monster_statistics.html
html_spells:
	ruby ${LI} -e "make_html('Spell Lists', 'spell_lists.md')" \
      > htmls/spell_lists.html
	ruby ${LI} -e "make_html('Spells', 'spells.md', SpellHtmlRender)" \
      > htmls/spells.html
html_classes:
	ruby ${LI} -e "make_html('Fighter', 'fighter.md')" > htmls/fighter.html
	ruby ${LI} -e "make_html('Rogue', 'rogue.md')" > htmls/rogue.html
	ruby ${LI} -e "make_html('Wizard', 'wizard.md')" > htmls/wizard.html
html_races:
	ruby ${LI} -e "make_html('Human', 'human.md')" > htmls/human.html
	ruby ${LI} -e "make_html('Elf', 'elf.md')" > htmls/elf.html
	ruby ${LI} -e "make_html('Dwarf', 'dwarf.md')" > htmls/dwarf.html
html_rules:
	ruby ${LI} -e "make_html('Abilities', 'abilities.md')" \
      > htmls/abilities.html
	ruby ${LI} -e "make_html('Combat', 'combat.md')" \
      > htmls/combat.html
	ruby ${LI} -e "make_html('Conditions', 'conditions.md')" \
      > htmls/conditions.html
	ruby ${LI} -e "make_html('Weapons', 'weapons.md')" \
      > htmls/weapons.html
	ruby ${LI} -e "make_html('Armor', 'armor.md')" \
      > htmls/armor.html
	ruby ${LI} -e "make_html('Gear', 'gear.md')" \
      > htmls/gear.html
	ruby ${LI} -e "make_html('Adventuring', 'adventuring.md')" \
      > htmls/adventuring.html
	ruby ${LI} -e "make_html('Spellcasting', 'spellcasting.md')" \
      > htmls/spellcasting.html
html_ogl:
	ruby ${LI} -e "make_html('Legal Information', 'ogl.md')" > htmls/ogl.html

html_index:
	ruby ${LI} -e "make_html('laconi.co', 'index.md')" \
      > htmls/index.html
	ruby ${LI} -e "make_html('laconi.co - motivation', 'motivation.md')" \
      > htmls/motivation.html
	ruby ${LI} -e "make_html('laconi.co - colophon', 'colophon.md')" \
      > htmls/colophon.html

html: html_index html_ogl html_races html_classes html_rules html_spells html_monsters

s:
	ruby -run -ehttpd htmls/ -p7003

publish:
	rsync -azv --delete --delete-excluded \
      --exclude *.swp \
      htmls/ shooto:/var/www/htdocs/laconi.co/
p: publish

log:
	ssh -t shooto cat /var/www/logs/laconico_access.log | ruby26 lib/log.rb
tail:
	ssh -t shooto tail -f /var/www/logs/laconico_access.log | ruby26 lib/tail.rb

.PHONY: md md_clear md_rules md_spells md_monsters html

