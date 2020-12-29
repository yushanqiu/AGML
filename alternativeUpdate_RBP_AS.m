function [SR, SA, PR,PA, F] = alternativeUpdate_RBP_AS(ARweight, AR, AAweight, AA, RBP, AS, Y, ...
                                 alpha, beta, mu,lamda, gamma)

    NITER = 50;
    thresh = 10^-10;
    
    F_old = Y;
%     F = zeros(size(Y));
    F = Y;
    SR = zeros(size(AR{1}));
    SA = zeros(size(AA{1}));
   

    for iter = 1:NITER
        
        [SR,PR] = miniJob_RBP_AS(ARweight, AR, RBP, F, alpha, mu);
         [SA,PA] = miniJob_RBP_AS(AAweight, AA, AS, F', beta, lamda);
%           SR = miniJob(ARweight, AR,  F, alpha, mu);
%         SA = miniJob(AAweight, AA,  F', beta, lamda);
       
        
        % fix SM and SD, update F
        SM0 = SR - diag(diag(SR));
        SM1 = (SM0 + SM0') / 2; % in case the similarity matrix is not symmetric
        DM = diag(sum(SM1));
%         LSM = DM - SM1;
        idM = eye(size(SM1, 1));
        SM2 = diag(1 ./ diag(sqrtm(DM)));
        LSM = idM - SM2 * SM1 * SM2;
        
        SD0 = SA - diag(diag(SA));
        SD1 = (SD0 + SD0') / 2; % in case the similarity matrix is not symmetric
        DD = diag(sum(SD1));
%         LSM = DM - SM1;
        idD = eye(size(SD1, 1));
        SD2 = diag(1 ./ diag(sqrtm(DD)));
        LSD = idD - SD2 * SD1 * SD2;
        
        F = sylvester(2 * alpha * LSM + gamma * idM, 2 * beta * LSD, gamma * Y);
        
        diff = abs(sum(sum(abs(F) - abs(F_old))));
        if diff < thresh
            break;
        end
        
        F_old = F;
        
    end


end