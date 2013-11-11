#HCObjectSwitch

A simple way to implement object based switch-like statements in Objective-C using blocks.
Any object that conforms to `NSCopying` can be switched on.

##Example
    
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
    
##Usage

The syntaxt for `HCObjectSwitch` is very close to the standard `switch` statement. All keywords start with a capital letter.

- `Switch (object)`       Starts a switch clause on `object`
- `Case (option)`         Code executed if the object matches option. This is implemented through blocks under the hood, thus when writing to variables in the enclosing scope they need to be `__block`.
- `Default`               Code executed in the default case
- `FallthroughTo(option)` Fall through to the option case. Cases can be skipped.
- `FallThroughToDefault`  Fall through to the default case. Cases can be skipped.

Parentheses around `Switch` and `Case` statements are required, as is the comma at the end of the parenthesis.

`Switch (nil)` will execute the `Default` case, even if one of the other cases is nil. The `Default` case is not required.

* Since version 1.1, having a case evaluate to `nil` does not cause an exception. The case will not be executed though.

##License

Copyright (c) 2013 Hypercrypt Solutions Ltd. - Released under The MIT License.

Permission is hereby granted, free of charge, to any person
obtaining a copy of this software and associated documentation
files (the "Software"), to deal in the Software without
restriction, including without limitation the rights to use,
copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following
conditions:

*The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.*

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.
