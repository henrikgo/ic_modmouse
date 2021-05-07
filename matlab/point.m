% POINT CLASS. COLLECTION OF USEFUL FUNCTIONS.
%
% By Alberto Álvarez-Martín.
% University of Glasgow. School of Engineering.

classdef point
    methods (Static)
        function [init] = initialVariables( )
            init.cond_no = 8;                % Total number of conditions
            init.part_no = 12;               % Total number of participants
            init.min_range = 11.4;           % Time in seconds, for plotting tau
            root = [pwd, '/../'];
            addpath([root 'matlab'])
            addpath([root 'matlab/data'])
            addpath([root 'matlab/helper'])
        end
        function [filename] = dataFile( )
            filename = 'sim_20200128T172241.mat';
        end
        function [dist,dist_mm,width,ID] = selectCondition(condition)
            switch condition
                case 1
                   dist = '765'; dist_mm = '212 mm'; width = '255'; ID = '2';
                case 2
                   dist = '1275'; dist_mm = '353 mm'; width = '425'; ID = '2';
                case 3
                   dist = '765'; dist_mm = '212 mm'; width = '51'; ID = '4';
                case 4
                   dist = '1275'; dist_mm = '353 mm'; width = '85'; ID = '4';
                case 5
                   dist = '765'; dist_mm = '212 mm'; width = '12'; ID = '6';
                case 6
                   dist = '1275'; dist_mm = '353 mm'; width = '20'; ID = '6';
                case 7
                   dist = '765'; dist_mm = '212 mm'; width = '3'; ID = '8';
                case 8
                   dist = '1275'; dist_mm = '353 mm'; width = '5'; ID = '8';
                otherwise
                   dist = '765'; dist_mm = '212 mm'; width = '3'; ID = '8';
            end
        end
        function [par] = plotParams( )
            par.fig = 1;
            par.fontsize = 12;
            par.bgcolor = [1 1 1];
            par.linewidth_signal = 1;
            par.w_color = [0.1797 0.5430 0.3398];
            par.gray = [0.8242 0.8242 0.8242];
            par.linewidth_ops = {'linewidth',par.linewidth_signal};
            par.latex_ops = {'FontWeight','normal','FontUnits','points','FontSize',10,'interpreter','latex'};
            par.gca_ops = {'Layer','top','FontUnits','points','FontSize',10};
            par.fig_labels = {'(A) ','(B) ','(C) ','(D) ','(E) ','(F) ','(G) ','(H) ','(I) ','(J) ','(K) ','(L) ','(M) ','(N) ','(O) ','(P) '};
            par.sub_margins = [0.1,0.08];
        end
        function printMode( )
            fprintf('----------------------------------------------------\n')
            fprintf('IC - GENERATING TRAJECTORIES. \n')
        end
        function printEnd( )
            fprintf('----------------------------------------------------\n')
            fprintf('DONE. \n')
            fprintf('----------------------------------------------------\n')
        end
    end
end