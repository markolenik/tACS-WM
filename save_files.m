function [] = save_files(session_path, step)
%SAVE_FILES Saves the files after [step] in [session_path/log/].
%   files to save are:
%       - data
%       - params
%
% SYNOPSIS
%   [] = save_files(session_path, step)
%
% INPUT
%   (string) session_path: path to session folder
%   (string) step: step of processing (e.g. filtering)
%

    save( [session_path, filesep, 'log', filesep, 'workspace_', step, '.mat'], ...
        'data', 'params' );
    write_to_log( 'C:\project', ['written files after ', step] );

end
