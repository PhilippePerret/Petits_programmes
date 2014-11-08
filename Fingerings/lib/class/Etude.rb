class Etude
  
  class << self

    attr_accessor :data
    
    attr_accessor :output_format
    attr_accessor :verbose
    attr_accessor :verbose_html
    
    def dbg code
      return unless verbose
      code = "<div>#{code}</div>" if verbose_html
      puts code
    end
    
    # = Main =
    #
    # Lance l'étude des exercices
    def start
      raise "Fichier introuvable" unless File.exists? fingerings_path
      @data = {}

      (from_exercice..to_exercice).each do |numero_exercice|
        dbg "Étude de l'exercice #{numero_exercice}"
        indice_exercice = numero_exercice - 1
        ex = exercices[indice_exercice]
        if ex.empty?
          dbg "\tL'exercice est vide, je le passe."
          next
        end
        ex.etudie
      end
      
    end
    
    # Ajoute une donnée d'étude de l'exercice
    #
    # @param  combi       La combinaison de doigté (p.e. "2-3")
    # @param  nb_fois     Le nombre de fois où cette combinaison est jouée
    # @param  intervalle  L'intervalle (en tons) pour cette combinaison
    def add_data combi, nb_fois, intervalle
      dbg "-> add_data combi:#{combi} nb_fois:#{nb_fois} intervalle:#{intervalle}"
      unless data.has_key? combi
        self.data = data.merge combi => {
          :nombre       => 0, 
          :intervalles  => {}
        }
      end
      # Incrémentation de la combinaison au nombre de fois où
      # la phrase est jouée
      data[combi][:nombre] += nb_fois
      unless data[combi][:intervalles].has_key? intervalle
        self.data[combi][:intervalles] = data[combi][:intervalles].merge intervalle => 0
      end
      self.data[combi][:intervalles][intervalle] += nb_fois
    end
    
    # = Main =
    #
    # Construit le bilan
    def bilan
      raise "Il faut lancer l'étude avec Etude::start avant de construire le bilan" if @data.nil?
      @bilan ||= begin
        c = []
        # Largeur : 26 (sans les "|")
        titre = "Exercices #{from_exercice} à #{to_exercice}"
        gauche = ((26 - titre.length).to_f / 2).floor - 1
        droite = " " * (26 - (gauche + titre.length))
        gauche = " " * gauche
        entete = <<-TXT
----------------------------
|#{gauche}#{titre}#{droite}|
----------------------------
| Doigté  | Nombre de fois |
        TXT
        c << entete.strip
        titre_section = <<-TXT
----------------------------
|      Par quantité        |
----------------------------
        TXT
        c << titre_section.strip
        nombre_max = nil
        nombre_min = nil
        nb_courant = nil
        @data.sort_by{|c, e| e[:nombre]}.reverse.each do |combi, data_combi|
          nb_courant = data_combi[:nombre]
          nombre_max = nb_courant if nombre_max.nil?
          nb = (" " * 5) << nb_courant.to_s # 16
          nb << " " * (16 - nb.length) 
          c << "|  #{combi}   | #{nb}|"
        end
        nombre_min = nb_courant
        
        titre_section = <<-TXT
----------------------------
|    Par premier doigt     |
----------------------------
        TXT
        c << titre_section.strip
        @data.sort_by{|combi, e| combi[0..0]}.each do |combi, data_combi|
          nb = data_combi[:nombre]
          nb = "#{nb} (max)" if nb == nombre_max
          nb = "#{nb} (min)" if nb == nombre_min
          nb = (" " * 5) << nb.to_s
          nb << " " * (16 - nb.length) 
          c << "|  #{combi}   | #{nb}|"
        end
        
        titre_section = <<-TXT
----------------------------
|    Par second doigt      |
----------------------------
        TXT
        c << titre_section.strip
        @data.sort_by{|combi, e| combi[2..2]}.each do |combi, data_combi|
          nb = data_combi[:nombre]
          nb = "#{nb} (max)" if nb == nombre_max
          nb = "#{nb} (min)" if nb == nombre_min
          nb = (" " * 5) << nb.to_s # 16
          nb << " " * (16 - nb.length) 
          c << "|  #{combi}   | #{nb}|"
        end
        c << "-" * 28
        c << "\n"
        c.join("\n")
      end
    end
    
    def print_bilan
      File.unlink bilan_path if File.exists? bilan_path
      File.open(bilan_path, 'wb'){|f| f.write bilan}
      if output_format == :html
        puts "<div>Fichier #{fingerings_path}</div>"
        puts "<pre>#{bilan}</pre>"
      else
        puts "Fichier : #{fingerings_path}"
        puts bilan
      end
    end
    
    
    def from_exercice
      @from_exercice ||= 1
    end
    def from_exercice= valeur
      @from_exercice = valeur
    end
    
    def to_exercice
      @to_exercice ||= exercices.count
    end
    def to_exercice= valeur
      raise "Le dernier exercice doit être supérieur au premier (#{from_exercice})" if valeur < from_exercice
      @to_exercice = valeur
    end
    
    # Liste des exercices (Array d'instances Exercices)
    def exercices
      @exercices ||= begin
        lignes_exercices.collect do |ligne_ex|
          ExerciceFingers::new ligne_ex.strip
        end
      end
    end
    
    # Retourne la liste des lignes d'exercice
    def lignes_exercices
      @lignes_exercices ||= File.read(fingerings_path).split("\n")
    end
    
    def fingerings_path
      @fingerings_path ||= './fingerings.txt'
    end
    # Pour pouvoir, à l'avenir, entrer d'autres fichiers de doigté
    def fingerings_path= valeur
      @fingerings_path = valeur
    end
    
    def bilan_path
      @bilan_path ||= "./fingerings-report.txt"
    end
  end # << self Etude
  
end