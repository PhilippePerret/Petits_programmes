require "spec_helper"

describe "Finger #{relative_path __FILE__}" do
  def exercice
    @exercice ||= ExerciceFingers::new "1 2 3 4 (5) * 12 . 5 4 3-3 2"
  end
  def phrase
    @phrase ||= exercice.phrases.first
  end
  def finger1
    @finger1 ||= phrase.fingers.first
  end
  alias :finger :finger1
  def finger2
    @finger2 ||= phrase.fingers[1]
  end
  def last_finger
    @last_finger ||= phrase.fingers.last
  end
  
  before :each do
    
  end
  
  describe 'Instanciation' do
    it 'produit une erreur si aucun argument' do
      expect{Finger::new}.to raise_error ArgumentError
    end
    it 'produit une erreur si le premier argument n’est pas la phrase' do
      ["string", 12, {:un => "hash"}, Fixnum].each do |type|
        expect{Finger::new type, ""}.to raise_error "Le premier argument doit être la phrase du doigté"
      end
    end
    it 'produit une instance Finger si les arguments sont bons' do
      expect{Finger::new phrase, "(1)"}.to_not raise_error
      res = Finger::new phrase, "(1)"
      expect(res).to be_instance_of Finger
    end
  end
  
  describe 'Propriétés d’instance' do
    describe '#phrase' do
      it 'répond' do
        expect(finger).to respond_to :phrase
      end
      it 'retourne la phrase du doigté' do
        expect(finger.phrase).to eq(phrase)
      end
    end
    describe '#exercice' do
      it 'répond' do
        expect(finger).to respond_to :exercice
      end
      it 'retourne l’exercice du doigté' do
        expect(finger.exercice).to eq(exercice)
      end
    end
    describe '#indice' do
      it 'répond' do
        expect(finger).to respond_to :indice
      end
      it 'retourne l’indice du doigté dans la phrase' do
        expect(finger1.indice).to eq(0)
        expect(finger2.indice).to eq(1)
      end
    end
  end
  describe 'Méthodes d’instance' do
    
    describe '#finger' do
      it 'répond' do
        expect(finger).to respond_to :finger
      end
      it 'retourne le doigté seul' do
        ["5", "(5)", "5-3", "(5-4)"].each do |fg|
          fing = Finger::new phrase, fg
          expect(fing.finger).to eq(5)
        end
      end
    end
    
    describe '#intervalle' do
      it 'répond' do
        expect(finger).to respond_to :intervalle
      end
      it 'retourne 1 si l’intervalle n’est pas spécifié explicitement' do
        expect(Finger::new(phrase, "4").intervalle).to eq(1)
      end
      it 'retourne l’intervalle s’il est spécifié' do
        expect(Finger::new(phrase, "4-6").intervalle).to eq(6)
      end
    end
    
    describe '#in_parentheses?' do
      it 'répond' do
        expect(finger).to respond_to :in_parentheses?
      end
      it 'retourne true si le doigté est entre parenthèses' do
        expect(Finger::new(phrase, "(4)")).to be_in_parentheses
        expect(Finger::new(phrase, "(4-5)")).to  be_in_parentheses
      end
      it 'retourne false si le doigté n’est pas entre parenthèses' do
        expect(Finger::new(phrase, "4")).to_not be_in_parentheses
        expect(Finger::new(phrase, "4-3")).to_not be_in_parentheses
      end
    end
    
    describe '#prev' do
      it 'répond' do
        expect(finger).to respond_to :prev
      end
      it 'retourne nil si pas de doigté avant dans la phrase' do
        expect(finger1.prev).to eq(nil)
      end
      it 'retourne le doigté avant s’il existe' do
        expect(finger2.prev).to eq(finger1)
      end
    end
    
    describe '#next' do
      it 'répond' do
        expect(finger).to respond_to :next
      end
      it 'retourne nil si pas de doigté après dans la phrase' do
        expect(last_finger.next).to eq(nil)
      end
      it 'retourne le doigté suivant s’il existe' do
        expect(finger1.next).to eq(finger2)
      end
    end
  end
end