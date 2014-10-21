require "spec_helper"

describe "Phrase #{relative_path __FILE__}" do
  def exercice; @exercice end
  def phrase;   @phrase   end
  alias :phrase1 :phrase
  def phrase2
    @phrase2 ||= @exercice.phrases[1]
  end
  
  before :all do
    @exercice = ExerciceFingers::new "1 2 3 4 5 (1-5) *12 . 5 4 3 2 1 . 1 5-4"
  end
  
  describe 'Instanciation' do
    it 'produit une erreur si aucun argument' do
      expect{Phrase::new}.to raise_error ArgumentError
    end
    it 'produit une erreur si le premier argument n’est pas un exercice' do
      ["string", 12, {:un => "hash"}, Fixnum].each do |type|
        expect{Phrase::new type, ""}.to raise_error "Le premier argument doit être l'exercice"
      end
    end
    it 'produit une instance Phrase si les arguments sont bons' do
      expect{Phrase::new @exercice, "1 2 3 4 5 *12"}.to_not raise_error
      expect(Phrase::new @exercice, "1 2 3 4 5 *12").to be_instance_of Phrase
    end
  end
  
  describe 'Propriétés-méthodes d’instance' do
    before :each do
      @phrase = @exercice.phrases[0]
      @phrase_une_fois = @exercice.phrases[1]
    end
    
    describe '#indice' do
      it 'répond' do
        expect(phrase).to respond_to :indice
      end
      it 'retourne l’indice de la phrase' do
        expect(phrase1.indice).to eq(0)
        expect(phrase2.indice).to eq(1)
      end
    end
    describe '#nombre_fois' do
      it 'répond' do
        expect(phrase).to respond_to :nombre_fois
      end
      it 'retourne la bonne valeur' do
        expect(phrase.nombre_fois).to eq(12)
        expect(@phrase_une_fois.nombre_fois).to eq(1)
      end
    end
    describe '#fingers_str' do
      it 'répond' do
        expect(phrase).to respond_to :fingers_str
      end
      it 'retourne la bonne valeur' do
        expect(phrase.fingers_str).to eq("1 2 3 4 5 (1-5)")
        expect(@phrase_une_fois.fingers_str).to eq("5 4 3 2 1")
      end
    end
    
    describe '#fingers' do
      it 'répond' do
        expect(phrase).to respond_to :fingers
      end
      it 'retourne un Array d’instances Finger' do
        res = phrase.fingers
        expect(res).to be_instance_of Array
        expect(res.first).to be_instance_of Finger
      end
    end
  end
  
  describe 'Méthodes d’instance' do
    before :each do
      @phrase = @exercice.phrases[0]
      @phrase_une_fois = @exercice.phrases[1]
    end
    
    describe '#analyse' do
      it 'répond' do
        expect(phrase).to respond_to :analyse
      end
      it 'a analysé le nombre de fois où la phrase était jouée' do
        expect(phrase.nombre_fois).to eq(12)
        expect(@phrase_une_fois.nombre_fois).to eq(1)
      end
      it 'a défini les doigtés' do
        expect(phrase.fingers_str).to eq("1 2 3 4 5 (1-5)")
        expect(@phrase_une_fois.fingers_str).to eq("5 4 3 2 1")
      end
    end
    
    describe 'coda?' do
      it 'répond' do
        expect(phrase).to respond_to :coda?
      end
      it 'retourne true si la phrase est la coda de l’exercice' do
        expect(exercice.phrases.last).to be_coda
      end
      it 'retourne false si la phrase n’est pas la dernière de l’exercice' do
        expect(exercice.phrases.first).to_not be_coda
      end
    end
    
    describe '#real_last_finger' do
      it 'répond' do
        expect(phrase).to respond_to :real_last_finger
      end
      it 'retourne le dernier doigté s’il n’est pas entre parenthèses' do
        phr = Phrase::new exercice, "1 2 3 4"
        expect(phr.real_last_finger.finger).to eq(4)
      end
      it 'retourne l’avant-dernier doigté si le dernier est entre parenthèses' do
        phr = Phrase::new exercice, "1 2 3 (4)"
        expect(phr.real_last_finger.finger).to_not eq(4)
        expect(phr.real_last_finger.finger).to eq(3)
      end
    end
    describe '#next' do
      it 'répond' do
        expect(phrase).to respond_to :next
      end
      it 'retourne la phrase suivante si ce n’est pas la dernière' do
        expect(phrase1.next).to eq(phrase2)
      end
      it 'retourne nil si c’est la coda (dernière phrase)' do
        expect(@exercice.coda.next).to eq(nil)
      end
    end
    
    describe '#prev' do
      it 'répond' do
        expect(phrase).to respond_to :prev
      end
      it 'retourne nil si c’est la première phrase' do
        expect(phrase.prev).to eq(nil)
      end
      it 'retourne la phrase précédente si ce n’est pas la première phrase' do
        expect(phrase2.prev).to eq(phrase1)
      end
    end
  end
  
end