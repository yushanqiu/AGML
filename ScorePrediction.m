clc;              
clear;            % clear all workspace variables
close all;        % close all windows
  
currentFolder = pwd;              
addpath(genpath(currentFolder));

load('data/FSP.mat');
load('data/FS.mat');
load('data/interaction.mat');
load('data/SS.mat');
load('data/SSP.mat');
load('data/RBP.mat');
load('data/AS.mat');

% set the diagonal elements to 0
FSP(logical(eye(size(FSP)))) = 0;
FS(logical(eye(size(FS)))) = 0;
SS(logical(eye(size(SS)))) = 0;
SSP(logical(eye(size(SSP)))) = 0;
AS(isnan(AS))=0;
k=0;
for i=1:size(interaction,1)
            if sum(interaction(i,:))==0
            k=k+1;
            index(k)=i;
            end
end
interaction(index,:)=[];
        FS(index,:)=[];
        FS(:,index)=[];
        FSP(index,:)=[];
        FSP(:,index)=[];
        RBP(index,:)=[];
    kk=0;
for i=1:size(interaction,2)
            if sum(interaction(:,i))==0
            kk=kk+1;
            index1(kk)=i;
            end
end
interaction(:,index1)=[];
        SS(index1,:)=[];
        SS(:,index1)=[];
        SSP(index1,:)=[];
        SSP(:,index1)=[];
        AS(index1,:)=[];
            
interaction(logical(eye(size(interaction)))) = 0;
SS=SS(1:100,1:100);
SSP=SSP(1:100,1:100);
interaction=interaction(:,1:100);
% construct a cell for convenience
AR(1) = {FSP};
AR(2) = {FS};
 AA(1)= {SS};

AA(2) = {SSP};



predRes_RBP_AS = GetCaseStudy_RBP_AS(AR, AA, RBP, AS,interaction);


save('output/case_study_RBP_AS.mat', 'predRes_RBP_AS');

     
        

fprintf('Case study process completed.');
