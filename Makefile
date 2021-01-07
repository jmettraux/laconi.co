
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
md_document:
	ruby ${LI} -e "make_document" > mds/document.md

md: md_ogl md_races md_classes md_rules md_spells md_monsters md_document

html:
	ruby ${LI} -e "make_htmls"

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

