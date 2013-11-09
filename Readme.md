HCObjectSwitch
==============

A simple way to implement object based switch-like statements in Objective-C using blocks.
Any object that conforms to `NSCopying` can be switched on.

Example
-------
	
	id inVariable = /* ... */;
	__block id outVariable;
	
	Switch (segue.identifier)
	{
	    Case (@"EmbedLoginViewController")
		{
	        self.loginViewController = segue.destinationViewController;
	        outVariable = @"Embed";
			
	        FallThroughToDefault();
	    }, // each case statement needs to be wrapped in parenthesees and terminated with a comma
	    
	    Case (@"ShowSettingsViewController")
		{
	        HCSettingsViewController *settingsViewController = segue.destinationViewController;
			settingsViewController.delegate = self;
			settingsViewController.title = inVariable;
			
			outVariable = @"Show";
			
			FallThroughToDefault();
	    },
	    
	    Default
		{
			// The _object_ object is the object that was used in the switch statement.
			// This is available automatically.
	        NSLog(@"Segue '%@' triggered by: %@", _object_, sender);
	    },
	}; // The ; is required
	
Usage
-----

The syntaxt for `HCObjectSwitch` is very close to the standard `switch` statement. All keywords start with a capital letter.

- `Switch (object)`       Starts a switch clause on `object`
- `Case (option)`         Code executed if the object matches option. This is implemented through blocks under the hood, thus when writing to variables in the enclosing scope they need to be `__block`.
- `Default`               Code executed in the default case
- `fallthroughTo(option)` Fall through to the option case. Cases can be skipped.
- `fallThroughToDefault`  Fall through to the default case. Cases can be skipped.

Parentheses around `Switch` and `Case` statements are required, as is the comma at the end of the parenthesis.
