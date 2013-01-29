Submarine::Mallet.import_data(File.join(File.dirname(__FILE__), "classifiers/my_submarine.mallet"), File.join(File.dirname(__FILE__), "training_data"))
Submarine::Mallet::Classifier.train(File.join(File.dirname(__FILE__), "classifiers/my_submarine.classifier"), File.join(File.dirname(__FILE__), "classifiers/my_submarine.mallet"))

trainer = Submarine::AnnotatorTrainer.new(File.join(File.dirname(__FILE__), "training_data"), File.join(File.dirname(__FILE__), "annotators"))

trainer.train 'artist', :in => 'music'
trainer.train 'song', :in => 'music'

trainer.train 'team', :in => 'sports'
trainer.train 'when', :in => 'sports'
trainer.train 'question', :in => 'sports'