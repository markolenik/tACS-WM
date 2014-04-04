function E = trl_energy(sig)
% calc energly of input trl

E = mean(sum(abs(sig).^2,2));

end