terminator-music-glove
======================

This is a project completed in March 2011 that uses a custom-hardware glove with pressure sensors attached to the fingertips to pass data through an Arduino to a computer running a webcam and the code in this repository to enable a user to create music.

Many people who saw the glove in action said it looked like a "Terminator Glove," so that's what we ended up calling it.

This project was a collaboration between Soyoung Shin, Andrew Smith, Tom Sommerville, and Zack Brown.


    ASC-hematic

    The Arduino is mounted to the back of the
    baseball glove along with a prototype breadboard
    containing the necessary circuitry.

    -------------         -------------        -------------
    |           |         |           |        | Pressure  |
    |   Glove   |=========|  Arduino  |========| sensors,  |
    |           |         |           |        | Circuitry |
    -------------         -------------        -------------
          ^                     |
          | The user wears      | The Arduino communicates over USB
          | the glove on a      | with the PC by a custom serial driver
          | plain surface       | that translates binary data representing
          | with a webcam       | finger press eventsinto OSC signals 
          | mounted overhead.   | that are usable by ChucK.
          |                     |
          |                     v
    -------------         -------------    OpenCV project performing
    |           |         |           |  / color-tracking
    |  Webcam   |<------->|    PC     |==
    |           |         |           |  \ ChucK project performing
    -------------         -------------    audio synthesis
                                |
                                | The PC synthesizes the music using
                                | the ChucK programming language with
                                | pressure inputs from the glove and
                                | positional location from OpenCV and
                                | the webcam in order to output audio
                                | through the PC sound card to speakers
                                v
                          -------------
                          | Speakers  |
                          -------------



