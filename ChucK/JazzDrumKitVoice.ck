// JazzBassVoice provides a jazz drum kit voice using
// samples for each supported note.
// Author(s): Zack Brown <zacharyb@cs.washington.edu>
// Revised 2011-03-04

public class JazzDrumKitVoice extends ISampleDrivenVoice{
	
	1.0::second => release;
	
	["Resources/Drum1/OverH_Stick_002eogg.wav",
	"Resources/Drum1/OverH_Stick_002dogg.wav",
	"Resources/Drum1/Overhead Snare B L_003ogg.wav",
	"Resources/Drum1/Overhead Snare B L_004ogg.wav",
	"Resources/Drum1/Overhead Snare B R_004ogg.wav",

	"Resources/Drum1/Overhead FlamA_01.wav",
	"Resources/Drum1/OverLowerTom_002dogg.wav",
	"Resources/Drum1/OverLowTom_002dogg.wav",
	"Resources/Drum1/OverMidTom_002dogg.wav",
	"Resources/Drum1/OverHiTom_002dogg.wav",

	"Resources/Drum1/Overhead Ride2_002ogg.wav",
	"Resources/Drum1/Overhead Ridebell2_004ogg.wav",
	"Resources/Drum1/OverH_Open_002aogg.wav",
	"Resources/Drum1/OverH_Ped_002cogg.wav",
	"Resources/Drum2/FLS_Hatpd 02.wav",


	"Resources/Drum1/OverH_Kick_002eogg.wav",
	"Resources/Drum2/FLS_Kick 02.wav",
	"Resources/Drum2/FLS_Kick 01.wav",
	"Resources/Drum2/FPC_CaribShake_007.wav",
	"Resources/Drum2/FPC_Pap_Open TriangleII.wav"] @=> samples;
	
	init();
}