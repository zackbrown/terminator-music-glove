// GloveEvent provides a custom event for encapsulating data
// and handling signals from the glove.
// Author(s): Zack Brown <zacharyb@cs.washington.edu>
// Revised 2011-03-04

public class GloveEvent extends Event{
	int finger;
	string startStop;
	float pressure;
	NoteEvent noteEvent;
	int handled;
}