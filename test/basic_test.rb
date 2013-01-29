require File.join(File.dirname(__FILE__), 'test_helper')

class BasicTest < MiniTest::Unit::TestCase
  def test_sports_classification
    assert_equal 'sports', MySubmarine.query("what's the score")[:classification]
  end
  
  def test_music_classification
    assert_equal 'music', MySubmarine.query("play my favorite song")[:classification]
  end
  
  def test_artist_annotation
    assert_equal 'foster the people', MySubmarine.query("play music by foster the people")[:annotations][:artist]
  end

  def test_song_annotation
    assert_equal "I'm on a boat", MySubmarine.query("play I'm on a boat")[:annotations][:song]
  end
end