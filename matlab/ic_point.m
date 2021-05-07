% INTERMITTENT CONTROL OF MOUSE MOVEMENTS.
%
% This file generates the time-series and
% phase plots for all participants and
% conditions.
%
% By Alberto Álvarez-Martín.
% University of Glasgow. School of Engineering.

clear all;
full_length = false;
init = point.initialVariables();
f = point.plotParams();
load(point.dataFile())
point.printMode()

% ======== TIME-SERIES AND PHASE PLANES ======== %

for v = 1:init.part_no
    subj_no = sprintf('%d',v);
    title_fig = ['POSITION (FULL TRIAL) - Subject: ' , subj_no];
    figure('name',title_fig,'Color',f.bgcolor,'Position',[100,100,800,800],'NumberTitle','off');

    for j = 1:init.cond_no
        [dist,dist_mm,width,ID] = point.selectCondition(j);    % Select conditions
        out_best = sim_data(v,j).out_best;                     % Extract the simulation results from structure
        final_time = out_best.tsim(end);                       % Final simulation time
        t_range = find(out_best.tsim == final_time);           % Get the range
        t_tau_range = out_best.tsim(t_range);
        if ~full_length
            t_range = find(out_best.tsim == init.min_range);
            t_tau_range = out_best.tsim(t_range);
        end
        taus = find(out_best.ttrig<t_tau_range);               % Open-loop intervals

        subplot_tight(4,2,j,f.sub_margins)
        ylim = [-0.25 0.25];
        for jj = 1:taus(end)
            b = line([out_best.ttrig(jj),out_best.ttrig(jj)],ylim,'color',f.gray,'linewidth',1);
        end
        hold on;
        s1 = plot(out_best.tsim(1:t_range,1),out_best.y(1:t_range,1),'b',f.linewidth_ops{:}); hold on;
        s2 = plot(out_best.tsim(1:t_range,1),out_best.ysim(1:t_range,1),'r',f.linewidth_ops{:}); hold on;
        s3 = plot(out_best.tsim(1:t_range,1),out_best.wsim(1:t_range,1),'color',f.w_color,f.linewidth_ops{:}); hold on;

        title([f.fig_labels{j}, dist_mm , ' - ID ', ID],f.latex_ops{:});
        set(gca,'box','off'); set(gca,f.gca_ops{:}); yF(f.fig) = gca;
        if j == 1 || j == 3 || j == 5 || j == 7, ylabel({'Pos. (m)'},f.latex_ops{:}); end
        if j == 7 || j == 8, xlabel({'Time (s)'},f.latex_ops{:}); end
        if j == 2
            lg = legend([b s1 s2 s3],{'event','$y_{exp}$','$y_{opt}$','target'},'FontWeight','normal','FontSize',10,'interpreter','latex');
            set(lg, 'Position', [0.92 0.95 0.01 0.01]);
            set(lg,'box','off');
        end
        ax1 = findall(gca,'type','axes'); set(ax1,'ylim',ylim);
    end
    sgt = sgtitle(sprintf('Pointer position for participant %.0d', v),'FontWeight','normal','FontSize',14,'interpreter','latex');

    title_fig = ['PHASE PLANES (FULL TRIAL) - Subject: ' , subj_no];
    figure('name',title_fig,'Color',f.bgcolor,'Position',[100,100,800,800],'NumberTitle','off');

    for j = 1:init.cond_no
        [dist,dist_mm,width,ID] = point.selectCondition(j);   % Select conditions
        out_best = sim_data(v,j).out_best;                    % Extract the simulation results from structure
        final_time = out_best.tsim(end);                      % Final simulation time
        t_range = find(out_best.tsim == final_time);          % Get the range
        t_tau_range = out_best.tsim(t_range);

        subplot_tight(4,2,j,f.sub_margins)
        xlim = [-0.25 0.25];
        s1 = plot(out_best.y(:,1),1/0.002*gradient(out_best.y(:,1)),'b',f.linewidth_ops{:}); hold on;
        s2 = plot(out_best.xsim(:,1),out_best.xsim(:,2),'r',f.linewidth_ops{:}); hold on;
        s1.Color(4) = 0.5; s2.Color(4) = 0.5;
        line([out_best.targetleft(1,1) out_best.targetleft(1,1)], [-1.8 1.8],'color',f.w_color,'LineWidth',1); hold on;
        line([out_best.targetright(1,1) out_best.targetright(1,1)], [-1.8 1.8],'color',f.w_color,'LineWidth',1); hold on;
        line([-out_best.targetleft(1,1) -out_best.targetleft(1,1)], [-1.8 1.8],'color',f.w_color,'LineWidth',1); hold on;
        line([-out_best.targetright(1,1) -out_best.targetright(1,1)], [-1.8 1.8],'color',f.w_color,'LineWidth',1); hold off;

        title([f.fig_labels{j}, dist_mm , ' - ID ', ID],f.latex_ops{:});
        set(gca,'box','off'); set(gca,f.gca_ops{:}); yF(f.fig) = gca;
        if j == 1 || j == 3 || j == 5 || j == 7, ylabel({'Vel. (m/s)'},f.latex_ops{:}); end
        if j == 7 || j == 8, xlabel({'Pos. (m)'},f.latex_ops{:}); end
        if j == 2
            lg = legend({'exp','opt','targets'},'FontWeight','normal','FontSize',10,'interpreter','latex');
            set(lg, 'Position', [0.92 0.93 0.01 0.01]);
            set(lg,'box','off');
        end
        ax1 = findall(gca,'type','axes'); set(ax1,'xlim',xlim);
    end
    sgt = sgtitle(sprintf('Phase-planes for participant %.0d', v),'FontWeight','normal','FontSize',14,'interpreter','latex');
end

for j = 1:init.cond_no
    title_fig = ['PHASE PLANES COMPARISON FOR ONE ID ACROSS ALL PARTICIPANTS'];
    figure('name',title_fig,'Color',f.bgcolor,'Position',[100,100,800,800],'NumberTitle','off');
    for v = 1:init.part_no
        subj_no = sprintf('%d',v);
        [dist,dist_mm,width,ID] = point.selectCondition(j);   % Select conditions
        out_best = sim_data(v,j).out_best;                    % Extract the simulation results from structure

        subplot_tight(4,3,v,f.sub_margins)
        xlim = [-0.25 0.25];
        l1 = line([out_best.targetleft(1,1) out_best.targetleft(1,1)], [-1.8 1.8],'color',f.w_color,'LineWidth',1); hold on;
        l2 = line([out_best.targetright(1,1) out_best.targetright(1,1)], [-1.8 1.8],'color',f.w_color,'LineWidth',1); hold on;
        l3 = line([-out_best.targetleft(1,1) -out_best.targetleft(1,1)], [-1.8 1.8],'color',f.w_color,'LineWidth',1); hold on;
        l4 = line([-out_best.targetright(1,1) -out_best.targetright(1,1)], [-1.8 1.8],'color',f.w_color,'LineWidth',1); hold on;
        s1 = plot(out_best.y(:,1),1/0.002*gradient(out_best.y(:,1)),'b',f.linewidth_ops{:}); hold on;
        s2 = plot(out_best.xsim(:,1),out_best.xsim(:,2),'r',f.linewidth_ops{:}); hold on;
        s1.Color(4) = 0.7; s2.Color(4) = 0.7;

        title([f.fig_labels{v},' - P', subj_no],f.latex_ops{:});
        set(gca,'box','off'); set(gca,f.gca_ops{:}); yF(f.fig) = gca;
        if v == 1 || v == 4 || v == 7 || v == 10, ylabel({'Vel. (m/s)'},f.latex_ops{:}); end
        if v == 10 || v == 11 || v == 12, xlabel({'Pos. (m)'},f.latex_ops{:}); end
        if v == 3, lg = legend([s1,s2,l4],'exp','opt','targets'); set(lg,'box','off','FontWeight','normal','FontSize',10,'interpreter','latex'); end
        ax1 = findall(gca,'type','axes'); set(ax1,'xlim',xlim);
        set(lg, 'Position', [0.92 0.93 0.01 0.01])
    end
title_text = ['Phase-planes for all participants - Distance: ' dist_mm ' - ID: ' ID];
sgt = sgtitle(title_text,'FontWeight','normal','FontSize',14,'interpreter','latex');
end
point.printEnd()