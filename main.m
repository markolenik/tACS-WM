% pseudocode zur übersicht, was wir haben, was wir brauchen
%
% GRUNDLEGENDES:                                                           
% - paths hinzufügen
% - toolbox hinzufügen
% 
% AUSWERTUNG PRO SESSION:
% loop über alle sessions (als dateiordner)
%   - session-ordner auf vollständigkeit prüfen                            initialize.m (done(alex) - ungetestet)
%   - 'loop' über beide EEG-Aufnahmen (pre_stim und dur_post_stim)         prepare_datafiles.m (in progress(alex) - ungetestet)
%       - ft_definetrial (1 trial, events)
%       - filtern                                                          filtEEG.m (done?(mark) - ungetestet)
%       - (ICA)                                                            ICA.m (angefangen(alex) - ungetestet)
%       - [trl] definieren                                                 definetrial.m (?(mark) - ?)
%       - ft_redefinetrial (trl-matrix)                                    
%       - trials mit falscher antwort entfernen                            remove_trials.m
%       - trials mit RT > 2*stddev innerhalb der session entfernen         remove_trials.m
%       - trials mit peaktopeak <2uV >100uV entfernen                      artifact_rejection_threshold.m
%       - trials mit artefakten entfernen                                  
%   - EEG-files appenden                                                             
%   - WPLI                                                                 WPLI.m (beta-done(mark) - test eher schlecht)
%   - ANOVA                                                                
