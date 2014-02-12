Mail Check
==========

This is an Email notifier with code based on the publish/subscribe model. It is designed to run in the background at a scheduled interval; play a sound and display a popup notice when new mail arrives. The code here is by no means turn-key, but the setup steps are described below.

The primary motivation behind this project was to become more familiar with publish and subscribe architecture patterns. Secondarily, I'm using [mu4e](http://www.djcbsoftware.nl/code/mu/mu4e.html) pattern. as an email front end and wanted a custom tool to pull and display new mail alerts.

The project folder structure is fairly simple:

  actions
  Contains all subscriber classes. The MailUpdater class publishes a message to these classes when new mail arrives.
