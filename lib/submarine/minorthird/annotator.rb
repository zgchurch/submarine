require 'java'
require 'minorthird_20080611.jar'

module Submarine
  module Minorthird
    class Annotator
      import 'edu.cmu.minorthird.util.IOUtil'
      import 'edu.cmu.minorthird.text.FancyLoader'
      import 'edu.cmu.minorthird.text.BasicTextBase'
      import 'edu.cmu.minorthird.text.BasicTextLabels'
      import 'edu.cmu.minorthird.ui.Recommended'
      import 'edu.cmu.minorthird.classify.sequential.CRFLearner'
      import 'edu.cmu.minorthird.text.learn.InsideOutsideReduction'
      import 'edu.cmu.minorthird.text.learn.TextLabelsAnnotatorTeacher'

      attr_reader :annotator

      def self.load(annotator_path, options={})
        new.tap do |annotator|
          annotator.instance_eval { @annotator = IOUtil.load_serialized(java.io.File.new(annotator_path)) }
        end
      end
      
      def self.train(span_type, annotator_path, training_data_path)
        annotator = TextLabelsAnnotatorTeacher.new(labels_for_training(training_data_path), span_type, nil).train(learner);
        IOUtil.saveSerialized(annotator, java.io.File.new(annotator_path));
      end
      
      def self.labels_for_training(training_data_path)
        FancyLoader.loadTextLabels(training_data_path);
      end

      def labels_for_query(query)
        tb = BasicTextBase.new
        tb.load_document '1', query
        BasicTextLabels.new(tb)
      end
      
      def self.learner
        Recommended::VPHMMLearner.new.tap do |learner|
          learner.setSequenceClassifierLearner(CRFLearner.new)
          learner.setSpanFeatureExtractor(Recommended::MultitokenSpanFE.new)
          learner.setTaggingReduction(InsideOutsideReduction.new)
        end
      end
      
      def query(query)
        result = annotator.annotated_copy(labels_for_query(query)).instance_iterator('_prediction')

        if result = result.next
          result = result.as_string
        end
      end
    end
  end
end
