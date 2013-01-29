# Submarine

is a library for training and querying a natural language request understanding system

## Requirements

* JRuby
* Doesn't support Windows at the moment (but this wouldn't be hard to fix)

## How to

* /training_data/music/1

```xml
play music by <artist>fun</artist>
```
    
* /training_data/music/2

```xml
play <song>seventeen</song> by <artist>jet</artist>
```
    
* /training_data/sports/1

```xml
<question>when</question> is <team>michigan state<team>'s next <sport>basketball</sport> game
```
    
* /training_data/sports/2

```xml
<question>where</question> are the <team>lions</team> going to play <when>next sunday</when>
```

* /my_submarine.rb

```ruby
require 'submarine'

MySubmarine = Submarine::Robot.new do
  classifier 'classifiers/my_submarine.classifier'
  annotator_path 'annotators'

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
```

* /query

```ruby
#!/usr/bin/env ruby
require 'rubygems'
require 'my_submarine'

loop do
  puts '', '', 'Type a query and press Enter'
  q = MySubmarine.query gets

  puts "", "#### Result ####", "Query: #{q[:query]}"
  puts "Classification: #{q[:classification]}"
  puts "Annotations:"
  q[:annotations].each_pair do |name, value|
    puts "  #{name}: #{value}"
  end
end
```


* /train.rb

```ruby
require 'rubygems'
require 'submarine'

Submarine::Mallet.import_data("classifiers/my_submarine.mallet", "training_data")
Submarine::Mallet::Classifier.train("classifiers/my_submarine.classifier", "classifiers/my_submarine.mallet")

trainer = Submarine::AnnotatorTrainer.new("training_data", "annotators")

trainer.train 'artist', :in => 'music'
trainer.train 'song', :in => 'music'

trainer.train 'team', :in => 'sports'
trainer.train 'when', :in => 'sports'
trainer.train 'question', :in => 'sports'
```

## Authors

* Zach Church <zgchurch@gmail.com>
