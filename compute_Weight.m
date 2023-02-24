function W = compute_Weight(C, S, E, wc, ws, we)

    W = (C.^wc) .* (S.^ws) .* (E.^we);
    W = abs(W);
    W = W + 1e-12;

end