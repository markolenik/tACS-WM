tACS-WM
=======

It's all a little messy with a couple of unnecessary files but if you follow this readme you shouldn't get lost.

Here we go:

- The main file for running the analysis is main.m. Here I run all subjects and all conditions and save the results.
- The important function in main.m is run_session. It runs the signal processing on one session (by session I mean one experiment, we did 3 for each subject, one for each condition). In run_session you'll find every step required for analysis and the coresponding functions.
The functions are
1. read_datafile
2. filtEEG
3. definetrials
4. remove_trials
5. ICA
6. WPLI
Most of them are commented and it should be clear what they are for.

Everything else in this repository are helper functions or testing scripts etc.

That's it! If you have questions, please don't hesitate to ask.

Mark
