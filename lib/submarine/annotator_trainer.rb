module Submarine
  class AnnotatorTrainer
    def initialize(training_path, annotators_path)
      @training_path = training_path
      @annotators_path = annotators_path
    end

    def combine_training_data(source_categories, &block)
      path = 'tmp/combined'
      source_categories.each do |category|
        `rsync -avz #{File.join(@training_path, category, '*')} #{path}`
      end

      yield path

      `rm -rf tmp/combined`
    end

    def train(span_type, options={})
      puts "=== Training annotator for #{span_type} ==="
      if options[:in].is_a? Array
        combine_training_data(options[:in]) do |combined_training_data_path|
          Submarine::Minorthird::Annotator.train(span_type,
            File.join(@annotators_path, "#{span_type}.ann"),
            combined_training_data_path)
        end
      else
        Submarine::Minorthird::Annotator.train(span_type,
          File.join(@annotators_path, "#{span_type}.ann"),
          File.join(@training_path, options[:in]))
      end
    end
  end
end
