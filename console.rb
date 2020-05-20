require('pry')
require_relative('models/album')
require_relative('models/artist')

Album.delete_all()
Artist.delete_all()

artist1 = Artist.new({
  'name' => 'Madonna'
  })
artist2 = Artist.new({
  'name' => 'Mars Volta'
  })

artist1.save()
artist2.save()

album1 = Album.new({
  'title' => 'Music',
  'year' => 2000,
  'artist_id'=> artist1.id
  })
album2 = Album.new({
  'title'=>'True Blue',
  'year' => 1986,
  'artist_id'=> artist1.id
  })

album3 =Album.new({
  'title'=>'De-Loused in the Comatorium',
  'year' => 2003,
  'artist_id'=> artist2.id
  })

album4 =Album.new({
  'title'=>'Fances the Mute',
  'year' => 2005,
  'artist_id'=> artist2.id
  })

album1.save()
album2.save()
album3.save()
album4.save()

binding.pry

Album.all()

Artist.all()

artist1.find_all_albums()
album1.find_artist()

binding.pry
nil
