
local gtk = require("lgi").require("Gtk", "3.0")
local dialog = gtk.MessageDialog { text = 'This is a text message.' }
dialog:show_all()
gtk.main()