require "spec_helper"


describe "Etude #{relative_path __FILE__}" do
  before :each do
    [:data, :bilan].each do |prop|
      Etude::instance_variable_set("@#{prop}", nil)
    end
  end
  describe 'Méthodes' do
    
    describe '::start' do
      it 'répond' do
        expect(Etude).to respond_to :start
      end
    end
    
    describe ':from_exercice' do
      it 'répond' do
        expect(Etude).to respond_to :from_exercice
      end
      it 'retourne 0 si aucun premier exercice n’est spécifié explicitement' do
        expect(Etude::from_exercice).to eq(1)
      end
      it 'retourne la valeur spécifiée' do
        Etude::instance_variable_set('@from_exercice', 12)
        expect(Etude::from_exercice).to eq(12)
      end
    end
    
    describe '::to_exercice' do
      it 'répond' do
        expect(Etude).to respond_to :to_exercice
      end
      it 'retourne le nombre d’exercices - 1 si non spécifié' do
        expect(Etude::to_exercice).to eq(Etude::lignes_exercices.count)
      end
      it 'retourne la valeur spécifiée si elle l’est' do
        Etude::instance_variable_set('@to_exercice', 13)
        expect(Etude::to_exercice).to eq(13)
      end
    end
    describe '::fingerings_path' do
      it 'répond' do
        expect(Etude).to respond_to :fingerings_path
      end
      it 'retourne le path aux data des exercices' do
        expect(Etude::fingerings_path).to eq("./fingerings.txt")
      end
    end
    
    describe '::lignes_exercices' do
      it 'répond' do
        expect(Etude).to respond_to :lignes_exercices
      end
      it 'retourne la liste des lignes d’exercices' do
        res = Etude::lignes_exercices
        expect(res).to be_instance_of Array
        expect(res.first).to be_instance_of String
      end
    end
    describe '::exercices' do
      it 'répond' do
        expect(Etude).to respond_to :exercices
      end
      it 'retourne la liste des exercices (instances Exercice)' do
        res = Etude::exercices
        expect(res).to be_instance_of Array
        expect(res.first).to be_instance_of ExerciceFingers
      end
    end
    
    describe '::bilan_path' do
      it 'répond' do
        expect(Etude).to respond_to :bilan_path
      end
      it 'retourne le bon path' do
        expect(Etude::bilan_path).to eq("./fingerings-report.txt")
      end
    end
      
    describe '::bilan' do
      it 'répond' do
        expect(Etude).to respond_to :bilan
      end
      it 'construit le bilan' do
        Etude::instance_variable_set('@bilan', nil)
        Etude::start
        Etude::bilan
        expect(Etude::instance_variable_get('@bilan')).to_not eq(nil)
      end
      describe 'Le code du bilan doit contenir' do
        def code
          @code ||= begin
            Etude::from_exercice = 4
            Etude::to_exercice   = 11
            Etude::start
            Etude::bilan
          end
        end
        it 'la marque de l’exercice de départ et de fin' do
          expect(code).to match("Exercices 4 à 11")
        end
      end
    end
    
    describe '::print_bilan' do
      it 'répond' do
        expect(Etude).to respond_to :print_bilan
      end
      it 'doit écrire le bilan dans un fichier' do
        File.unlink Etude::bilan_path if File.exists? Etude::bilan_path
        Etude::start
        Etude::bilan
        Etude::print_bilan
        expect(File).to be_exists(Etude::bilan_path)
      end
    end
  end
end