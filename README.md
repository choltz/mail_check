Mail Check
==========

This is an Email notifier with code based on the publish/subscribe model. It is designed to run in the background at a scheduled interval; play a sound and display a popup notice when new mail arrives. The code here is by no means turn-key, but the setup steps are described below.

The primary motivation behind this project was to become more familiar with publish and subscribe architecture patterns. Secondarily, I'm using [mu4e](http://www.djcbsoftware.nl/code/mu/mu4e.html) as an email front end and wanted a custom tool to pull and display new mail alerts.

The project folder structure is fairly simple:

* actions -  Contains all subscribers that receive notifications from the MailUpdater class
* bin - Contains a shell script that invokes the mail_check app
* log - Dumping ground for log files. The app logs to log/message.log
* spec - rspec tests
* sys - system files, such as shell commands, event emitter code, etc.

## Dependencies
At this point, the mail check app has only been tested on Ubuntu Linux. However, it should work on any Linux distro, provided the following are installed:

* Ruby 2.1.0 and a few gems (more on this below)
* offlineimap
* [mu](http://www.djcbsoftware.nl/code/mu/) mail indexer
* mpg123
* notify-send

## Cron
This app is designed to run at regular intervals. There is a convenience shell script in the bin folder that can be hooked into the cron file like this:

```sh
*/1 * * * * cd /home/<your home>/mail_check/; bin/mail_check >> /home/<your home>/mail_check/log/cron.log
```

Substitute the path in the example above with the path to your mail_check folder.

## Work flow
The mail check process is bootstrapped in mail_check.rb - this file:

1. Loads all dependent libraries (gems)
2. Creates an instance of the MailUpdater class
3. Registers Offlineimap as the mail source
4. Registers several listener classes (from the actions folder)

Once everything is configured, the MailUpdater starts processing messages:

1. The mail source called to retrieve new mail messages
2. If there are new mail messages, emit an event to the listeners
3. Each listener receives the mail messages and acts accordingly

Once complete, the app shuts down.

## Troubleshooting

## Miscellaneous development notes
