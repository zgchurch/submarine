module Submarine
  module Mallet
    def self.import_data(mallet_data_path, training_directory)
      run("cc.mallet.classify.tui.Text2Vectors", "--input #{training_directory}/*", "--output #{mallet_data_path}")
    end

    def self.run(klass, *args)
      `java -Xmx1g -ea -Djava.awt.headless=true -Dfile.encoding=UTF-8 -server -classpath #{cp} #{klass} #{args.join(' ')}`
    end

    def self.cp
      deps = File.join(File.dirname(__FILE__), '..', 'mallet-deps.jar')
      mallet = File.join(File.dirname(__FILE__), '..', 'mallet.jar')
      "#{deps}:#{mallet}"
    end
  end
end
