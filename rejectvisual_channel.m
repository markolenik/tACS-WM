function data = rejectvisual_channel( input_data )
%REJECTVISUAL Remove corrupted channels.
%
%   data = rejectvisual(input_data);
%

cfg = [];
cfg.method = 'channel';
cfg.keepchannel = 'nan'; % or better remove channel?

data = ft_rejectvisual(cfg, input_data);


end

