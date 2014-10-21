require 'spec_helper'


describe "ExerciceFingers #{relative_path __FILE__}" do
  
  before :all do
    Etude::verbose = false
    Etude::verbose_html = true
  end
  
  before :each do
    Etude::instance_variable_set('@data', {})
  end
  
  describe 'Instanciation' do
    it 'instancier l’exercice sans ligne produit une erreur' do
      expect{ExerciceFingers::new}.to raise_error ArgumentError
    end
    it 'on peut instancier un exercice avec sa ligne' do
      expect{ExerciceFingers::new "1 2 3 4 5"}.to_not raise_error
      res = ExerciceFingers::new "1 2 3 4 5"
      expect(res).to be_instance_of ExerciceFingers
    end
    it 'on peut instancier un exercice avec une ligne vierge' do
      expect(ExerciceFingers::new "").to be_instance_of ExerciceFingers
    end
  end
  
  
  describe 'Méthodes d’instance' do
    def exercice
      @exercice ||= @ex
    end
    before :each do
      @ex = ExerciceFingers::new "1 2 3 4 *12 . 5 4 3 2 . 3 2"
    end
    
    describe 'etudie' do
      it 'répond' do
        expect(exercice).to respond_to :etudie
      end
      context 'avec une définition simple' do
        it 'produit le bon résultat' do
          exer = ExerciceFingers::new "1 2 3 . 2 1"
          exer.etudie
          d = Etude::data
          ["1-2", "2-3", "3-2", "2-1"].each do |fg|
            expect(d).to have_key fg
          end
          expect(d["1-2"][:nombre]).to eq(1)
          expect(d["2-3"][:nombre]).to eq(1)
          expect(d["3-2"][:nombre]).to eq(1)
          expect(d["2-1"][:nombre]).to eq(1)
        end
      end
      context 'avec un exercice avec phrases répétées' do
        it 'produit l’etude de l’exercice' do
          exer = ExerciceFingers::new "1 2 3 2 3 *2 . 2 1"
          exer.etudie
          d = Etude::data
          fgs = {
            "1-2" => 2,
            "2-3" => 4,
            "3-2" => 3,
            "3-1" => 2,
            "2-1" => 1,
            
            "1-4" => 0,
            "1-1" => 0
          }
          fgs.each do |fg, nb|
            if nb == 0
              expect(d).to_not have_key fg
            else
              expect(d).to have_key fg
              expect(d[fg][:nombre]).to eq(nb)
            end
          end
          # L'étude ne doit pas contenir d'autres doigtés
          Etude::data.each do |combi, data_combi|
            expect(fgs).to have_key combi
          end
          
        end
      end
      
      context 'Avec une phrase s’achevant et commençant sur le même doigté' do
        it 'produit la bonne étude' do
          exer = ExerciceFingers::new "1 2 3 1-3 *2 . 2 1"
          exer.etudie
          d = Etude::data
          fgs = {
            "1-2" => 3,
            "2-3" => 2,
            "3-1" => 2,
            "2-1" => 1,
            
            "1-1" => 0
          }
          fgs.each do |fg, nb|
            if nb == 0
              expect(d).to_not have_key fg
            else
              expect(d).to have_key fg
              expect(d[fg][:nombre]).to eq(nb)
            end
          end
          # L'étude ne doit pas contenir d'autres doigtés
          Etude::data.each do |combi, data_combi|
            expect(fgs).to have_key combi
          end
          
        end
      end
      
      context 'Avec un phrase s’achevant par le même doigt que la phrase suivante' do
        it 'produit une bonne étude en ne liant pas les deux phrases' do
          exer = ExerciceFingers::new "1 2 3 2-3 *2 . 2 1"
          exer.etudie
          d = Etude::data         
          fgs = {
            "1-2" => 2,
            "2-3" => 2,
            "3-2" => 2,
            "2-1" => 3,
            
            "2-2" => 0
          }
          fgs.each do |fg, nb|
            if nb == 0
              expect(d).to_not have_key fg
            else
              expect(d).to have_key fg
              expect(d[fg][:nombre]).to eq(nb)
            end
          end
          # L'étude ne doit pas contenir d'autres doigtés
          Etude::data.each do |combi, data_combi|
            expect(fgs).to have_key combi
          end
          
        end
      end
      
      context 'Avec une phrase se terminant par une note entre parenthèses' do
        it 'produit une bonne étude avec la note précédente enchainée à la mesure suivante' do
          exer = ExerciceFingers::new "1 2 3 (1-3) *2 . 4 1"
          exer.etudie
          d = Etude::data
          fgs = {
            "1-2" => 2,
            "2-3" => 2,
            "3-1" => 2,
            "3-4" => 1,
            "4-1" => 1,
            
            "1-4" => 0,
            "1-1" => 0
          }
          fgs.each do |fg, nb|
            if nb == 0
              expect(d).to_not have_key fg
            else
              expect(d).to have_key fg
              expect(d[fg][:nombre]).to eq(nb)
            end
          end
          # L'étude ne doit pas contenir d'autres doigtés
          Etude::data.each do |combi, data_combi|
            expect(fgs).to have_key combi
          end
        end
      end
      
      context 'Avec deux phrases s’enchainant avec : " 4 (5) . 4"' do
        it 'produit une bonne étude sans liaison entre les deux phrases' do
          exer = ExerciceFingers::new "1 2 4 (1-3) *3 . 4 1"
          exer.etudie
          d = Etude::data
          fgs = {
            "1-2" => 3,
            "2-4" => 3,
            "4-1" => 4,
            "4-4" => 0,
            "1-1" => 0
          }
          fgs.each do |fg, nb|
            if nb == 0
              expect(d).to_not have_key fg
            else
              expect(d).to have_key fg
              expect(d[fg][:nombre]).to eq(nb)
            end
          end
          # L'étude ne doit pas contenir d'autres doigtés
          Etude::data.each do |combi, data_combi|
            expect(fgs).to have_key combi
          end
        end
      end
    end

    describe '#empty?' do
      it 'répond' do
        expect(exercice).to respond_to :empty?
      end
      it 'retourne true si l’exercice est une ligne vide' do
        expect(ExerciceFingers::new "").to be_empty
      end
      it 'retourne false si l’exercice contient des doigté' do
        expect(ExerciceFingers::new "1 2 3").to_not be_empty
      end
    end
    describe '#phrases' do
      it 'répond' do
        expect(@ex).to respond_to :phrases
      end
      it 'retourne les phrases de l’exercice' do
        res = @ex.phrases
        expect(res).to be_instance_of Array
        expect(res.count).to eq(3)
        expect(res.first).to be_instance_of Phrase
      end
    end
    
    describe '#coda' do
      it 'répond' do
        expect(@ex).to respond_to :coda
      end
      it 'retourne la dernière phrase' do
        expect(@ex.coda).to eq(exercice.phrases.last)
      end
    end
  end
end