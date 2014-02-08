// JazzTenorSaxVoice provides a jazz tenor sax voice using
// samples for each supported note.  It is constrained to
// a C Jazz Scale (left two columns) and F jazz scale
// (right two columns)
// Author(s): Zack Brown <zacharyb@cs.washington.edu>
// Revised 2011-03-04

public class JazzTenorSaxVoice extends ISampleDrivenVoice{
	
	.2::second => release;
	
	//C jazz scale
	["Resources/TenorSax/10_TSAX_LONG F2ogg.wav",
	"Resources/TenorSax/13_TSAX_LONG G#2ogg.wav",
	"Resources/TenorSax/15_TSAX_LONG A#2ogg.wav",
	"Resources/TenorSax/16_TSAX_LONG B2ogg.wav",
	"Resources/TenorSax/17_TSAX_LONG C3ogg.wav",
	"Resources/TenorSax/20_TSAX_LONG D#3ogg.wav",
	"Resources/TenorSax/22_TSAX_LONG F3ogg.wav",
	"Resources/TenorSax/25_TSAX_LONG G#3ogg.wav",
	"Resources/TenorSax/27_TSAX_LONG A#3ogg.wav",
	"Resources/TenorSax/28_TSAX_LONG B3ogg.wav",

	//F jazz scale
	"Resources/TenorSax/05_TSAX_LONG C2ogg.wav",
	"Resources/TenorSax/08_TSAX_LONG D#2ogg.wav",
	"Resources/TenorSax/10_TSAX_LONG F2ogg.wav",
	"Resources/TenorSax/11_TSAX_LONG F#2ogg.wav",
	"Resources/TenorSax/12_TSAX_LONG G2ogg.wav",
	"Resources/TenorSax/15_TSAX_LONG A#2ogg.wav",
	"Resources/TenorSax/17_TSAX_LONG C3ogg.wav",
	"Resources/TenorSax/20_TSAX_LONG D#3ogg.wav",
	"Resources/TenorSax/22_TSAX_LONG F3ogg.wav",
	"Resources/TenorSax/23_TSAX_LONG F#3ogg.wav"] @=> samples;
	
	init();
}