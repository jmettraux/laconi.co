
#
# Specifying laconi.co
#
# Fri Jan  1 17:36:36 JST 2021
#

require 'spec_helper'


describe 'md_reading.rb' do

  #def extract_md_section(path, level, title)
    #
  describe 'extract_md_section' do

    it 'works' do

      s = extract_md_section('../ogl_srd5/01.races.md', 1, 'Elf')

      expect(s).to match(/\A# Elf\n/)
      expect(s).to match(/\n\z/)
      expect(s.length).to eq(2940)
    end

    it 'stops when the section ends' do

      s = extract_md_section('../ogl_srd5/13.monsters.md', 2, 'Azer')

      expect(s).to match(/\A## Azer\n/)
      expect(s).to match(/plus 3 \(1d6\) fire damage\.\n\z/)
      expect(s.length).to eq(1116)
    end
  end
end

