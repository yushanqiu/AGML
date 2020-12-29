function [F] = MultiViewPrediction_RBP_AS(AR, AA, RBP, AS, Y)
% AD£ºthe multi-view disease-disease similarity matrix
% AM: the multi-view miRNA-miRNA similarity matrix
% Y : the ground truth (the known miRNA-disease associations)
% F : the result predicted by our method

    ARview = size(AR, 2);
    AAview = size(AA, 2);
    
    ARweight = 1 / ARview * ones(1, ARview);
    AAweight = 1 / AAview * ones(1, AAview);
    
    alpha = 0.0001;  
    beta = 0.0001;
    mu=0.0001;
    lamda=0.0001;
    gamma = 1;

    NITER = 15;
    thresh = 10^-12;      % Iterative terminating condition
       
    for iter = 1:NITER
        
        % update SM, SD and F;
        [SM, SD, PR, PA, F] = alternativeUpdate_RBP_AS(ARweight, AR, AAweight, AA,RBP,AS, Y, ...
                            alpha, beta, mu, lamda, gamma);
        
        % update view weights and calculate obj;
        obj = 0;
        for v = 1:ARview
            curValue = norm(SM - AR{v}, 'fro');
            ARweight(1, v) = 0.5 / curValue;
            obj = obj + curValue;
        end
        
        for v = 1:AAview
            curValue = norm(SD - AA{v}, 'fro');
            AAweight(1, v) = 0.5 / curValue;
            obj = obj + curValue;
        end
       
        obj = obj + norm(F - Y, 'fro');
        Obj(iter) = obj;
      
        if(iter > 1 && abs(Obj(iter - 1) - Obj(iter)) < thresh)
            fprintf('Iteration stops at %d step.\n', iter);
            break;
        end
    end
end


   