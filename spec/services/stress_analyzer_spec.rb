require 'rails_helper'

RSpec.describe StressAnalyzer, type: :model do
  context 'converting' do
    it 'strips stress symbols' do
      analyzer = StressAnalyzer.new "а`вторулево'й"
      expect(analyzer.body).to eq('авторулевой')
    end

    it 'converts «"» to ё' do
      analyzer = StressAnalyzer.new 'похле"бка'
      expect(analyzer.body).to eq('похлёбка')
    end

    it 'ignores *' do
      analyzer = StressAnalyzer.new '*абы'
      expect(analyzer.body).to eq('абы')
    end
  end

  context 'stressing' do
    it 'counts vowels as syllables' do
      analyzer = StressAnalyzer.new "зака'лка"
      expect(analyzer.stress.length).to eq(3)
    end

    it 'sets vowel-less word stress to nil' do
      analyzer = StressAnalyzer.new 'в'
      expect(analyzer.stress).to be_nil
    end

    it 'sets stressed vowel as 2, semi-stressed as 1 and unstressed as 0' do
      analyzer = StressAnalyzer.new "а`вторулево'й"
      expect(analyzer.stress).to eq('10002')
    end

    it 'sets ё as 2' do
      analyzer = StressAnalyzer.new 'свёкла'
      expect(analyzer.stress).to eq('20')
    end
  end
end
