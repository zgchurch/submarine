module Submarine
  class Annotation
    def initialize(name, annotator_path, &block)
      @annotators = []
      @annotator_path = annotator_path
      if block
        instance_eval &block
      else
        annotator(name)
      end
    end
    
    def annotator(name)
      @annotators << Minorthird::Annotator.load(File.join(@annotator_path, "#{name}.ann"))
    end
    
    def annotate(query)
      result = nil
      @annotators.find{|annotator| result = annotator.query(query)}
      result
    end
  end
end
