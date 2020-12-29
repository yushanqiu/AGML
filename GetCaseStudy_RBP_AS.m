function [F] = GetCaseStudy_RBP_AS(AR, AA, RBP, AS, Y)
    
    % compute the Gaussian Interaction Profile
    [KA, KR] = GaussianKernel(Y', 1, 1);
        
    KR(logical(eye(size(KR)))) = 0;
    KA(logical(eye(size(KA)))) = 0;
    AR(size(AR, 2) + 1) = {KR};
    AA(size(AA, 2) + 1) = {KA};
        
    F = MultiViewPrediction_RBP_AS(AR, AA, RBP, AS, Y);
    
end