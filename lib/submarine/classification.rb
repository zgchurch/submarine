module Submarine
  class Classification
    def initialize(annotator_path, &block)
      @annotator_path = annotator_path
      @annotations = {}
      instance_eval &block
    end

    def get_annotations(query)
      @annotations.inject({}) do |result, (name, annotation)|
        result[name.to_sym] = annotation.annotate query
        result
      end
    end

    private
    
    def annotation(name, &block)
      @annotations[name] = Annotation.new(name, @annotator_path, &block)
    end
  end
end
