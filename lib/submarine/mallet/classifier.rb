require 'java'
require 'mallet-deps.jar'
require 'mallet.jar'

module Submarine
  module Mallet
    class Classifier
      import 'cc.mallet.classify.tui.Csv2Classify'
      import 'java.io.ObjectInputStream'
      import 'java.io.BufferedInputStream'
      import 'java.io.FileInputStream'

      attr_reader :classifier
      
      def self.load(classifier_path, options={})
        new.tap do |classifier|
          ois = ObjectInputStream.new(
                              BufferedInputStream.new(
                              FileInputStream.new(classifier_path)))

          classifier.instance_eval { @classifier = ois.read_object }

          ois.close
        end
      end

      def self.train(classifier_path, mallet_data_path)
        Mallet.run("cc.mallet.classify.tui.Vectors2Classify", "--input #{mallet_data_path}", "--output-classifier #{classifier_path}")
      end

      def query(query)
        result = classifier.classify(query).get_labeling
        result.best_label.to_string
      end
    end
  end
end
