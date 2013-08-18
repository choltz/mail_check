class ShowNotifier
  def call(options={})
    options = { :messages => [] }.update(options)
    `DISPLAY=:0.0 XAUTHORITY=~/.Xauthority notify-send 'New Mail' 'You have #{options[:messages].length} unread messages.\nDebug: #{options[:messages]}' -t 4000`
  end
end
