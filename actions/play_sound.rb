class PlaySound
  def call(options={})
    `mpg123 --quiet ~/scripts/mail/harp.mp3`
  end
end
