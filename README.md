tACS-WM
=======

Analysis scripts for tACS Working Memory study.

Here we go:

- The main file for running the analysis is `main.m`, it runs all subjects and all conditions and saves the results.
- The important function in `main.m` is `run_session`. It runs the signal processing on one session (by session I mean one experiment, we did 3 for each subject, one for each condition). In `run_session` we find every step required for the analysis. 

The analysis steps are:
1. Read data: `read_datafile`
2. Filter data: `filtEEG`
3. Identify trials: `definetrials`
4. Clean data: `remove_trials`
5. Dimensionality reduction: `ICA`
6. Identify brain connectivity: `WPLI`

Everything else in this repository are helper functions or testing scripts etc.
