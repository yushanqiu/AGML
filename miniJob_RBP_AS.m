function [S,P] = miniJob_RBP_AS(viewWeight, mvMatrix, R, F, eta, xi)

    num = size(mvMatrix{1}, 1);
    viewNum = size(viewWeight, 2);
    
    psize = 100;
mu = 50;
lamda = 100;
k_w = 20;
t_w = 50;
k_s = 80;
R=R';
    H = eye(size(R,2))-1/(size(R,2))*ones(size(R,2),size(R,2));
    option = [];
option.NeighborMode = 'KNN';
option.WeightMode = 'HeatKernel';
option.k = k_w;
option.t = t_w;
W = constructW(R',option);
W = full(W); % Convert from sparse metrix
D = diag(sum(W,2));
L = D-(W+W')./2;

XHX=R*H*R';
% Initialize P
eig_matrix =R*L*R'+lamda*eye(size(R,1));
[P,~] = eigs(double(eig_matrix),double(XHX),psize,'SM');
P = single(P');

PX=P*R;
k=k_s;
% Initialize weighted distance
distX_initial =  L2_distance_1(PX,PX);
%[distXs, idx] = sort(distX_initial,2);
distX = distX_initial;
% S = single(zeros(n_x));
% rr = single(zeros(n_x,1));
    S = zeros(num); % S is the optimal matrix to be learned         
    distd = L2_distance_1(F', F');
    save distd distd;
    save distX distX;
    for i = 1:num
        a0 = zeros(1, num);
        for v = 1:viewNum
            temp = mvMatrix{v};
            a0 = a0 + viewWeight(1, v) * temp(i, :);
        end
           
        idxa0 = find(a0 > 0);
        % idxa0 = 1:num;
        ai = a0(idxa0);
        di = distd(i, idxa0);    
        ki=distX(i,idxa0);
 
        %di = distXs(i,2:k+2);
        ad = (ai - 0.5 * eta * di-0.5*xi*ki) / sum(viewWeight);
        S(i, idxa0) = EProjSimplex(ad);
%         eig_matrix =R*L*R'+lamda*eye(size(R,1));
%        [P,~] = eigs(double(eig_matrix),double(XHX),psize,'SM');
%        P = single(P');
    end
    
end

   
   