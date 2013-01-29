MySubmarine = Submarine::Robot.new do
  classifier File.join(File.dirname(__FILE__), 'classifiers/my_submarine.classifier')
  annotator_path File.join(File.dirname(__FILE__), 'annotators')

  classification 'music' do
    annotation 'artist'
    annotation 'song'
  end

  classification 'sports' do
    annotation 'team'
    annotation 'when'
    annotation 'question'
  end
end
