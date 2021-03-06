classdef IMMOEA_F8 < PROBLEM
% <problem> <IMMOEA>
% Benchmark MOP for IM-MOEA

%------------------------------- Reference --------------------------------
% R. Cheng, Y. Jin, K. Narukawa, and B. Sendhoff, A multiobjective
% evolutionary algorithm using Gaussian process-based inverse modeling,
% IEEE Transactions on Evolutionary Computation, 2015, 19(6): 838-856.
%------------------------------- Copyright --------------------------------
% Copyright (c) 2018-2019 BIMK Group. You are free to use the PlatEMO for
% research purposes. All publications which use this platform or any code
% in the platform should acknowledge the use of "PlatEMO" and reference "Ye
% Tian, Ran Cheng, Xingyi Zhang, and Yaochu Jin, PlatEMO: A MATLAB platform
% for evolutionary multi-objective optimization [educational forum], IEEE
% Computational Intelligence Magazine, 2017, 12(4): 73-87".
%--------------------------------------------------------------------------

    methods
        %% Initialization
        function obj = IMMOEA_F8()
            obj.Global.M = 3;
            if isempty(obj.Global.D)
                obj.Global.D = 30;
            end
            obj.Global.lower    = zeros(1,obj.Global.D);
            obj.Global.upper    = ones(1,obj.Global.D);
            obj.Global.encoding = 'real';
        end
        %% Calculate objective values
        function PopObj = CalObj(obj,X)
            D = size(X,2);
            t = X(:,3:D).^(1./(1+3*repmat(3:D,size(X,1),1)/D)) - repmat(X(:,1),1,D-2);
            g = sum(t.^2,2);
            PopObj(:,1) = cos(pi/2*X(:,1)).*cos(pi/2*X(:,2)).*(1+g);
            PopObj(:,2) = cos(pi/2*X(:,1)).*sin(pi/2*X(:,2)).*(1+g);
            PopObj(:,3) = sin(pi/2*X(:,1)).*(1+g);
        end
        %% Sample reference points on Pareto front
        function P = PF(obj,N)
            P = UniformPoint(N,3);
            P = P./repmat(sqrt(sum(P.^2,2)),1,3);
        end
    end
end