function [] = save_files( session_folder, step )
%SAVE_FILES Saves the files after [step] in [session_folder/log/]
%   files to save are:
%       - data
%       - params

    save( [session_folder, filesep, 'log', filesep, 'workspace_', step, '.mat'], ...
        'data', 'params' );
    write_to_log( 'C:\project', ['written files after ', step] );

end
