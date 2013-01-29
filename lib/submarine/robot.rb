module Submarine
  class Robot
    def initialize(&block)
      @classifiers = []
      @classifications = {}
      
      instance_eval &block
    end
    
    def query(query)
      classification = get_classification query
      if classification != ""
        annotations = get_annotations(classification, query)
      else
        annotations = {}
      end
      {:classification => classification, :annotations => annotations, :query => query}
    end
    
    def get_classification(query)
      result = nil
      @classifiers.find {|classifier| result = classifier.query(query)}
      result
    end
    
    def get_annotations(classification, query)
      if @classifications[classification]
        @classifications[classification].get_annotations(query)
      else
        {}
      end
    end
    
    private

    def annotator_path(path)
      @annotator_path = path
    end    

    def classifier(path, options={})
      @classifiers << Mallet::Classifier.load(path, options)
    end

    def classification(name, &block)
      @classifications[name] = Classification.new(@annotator_path, &block)
    end
  end
end
