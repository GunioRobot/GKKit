## Purpose
Collection of Cocoa classes and various headers I use throughout my work. Hosted for submodule support in my other projects.

## License
Don't sue me I'm poor, use as is, no warrenty, request recognition but don't really care either way, enjoy :)

## To-Do
Really need to clean up dependencies for GKDataRequest, probably my favorite and most robust class but it depends too much on a lot of things like asi-http-request
debug.h needs a huge overhaul which I've never gotten around too, ideally I want a c function that uses type modifiers to guess kind of object, be it int/float/objc_obj/etc., i started it but never finished, as well as fix changes for certain objects from mac to iOS, such as CGRect to string functions.
GKSearchController needs to be cleaned up to seperate it's uses from GKActivityView
