function showImage(noise_levels,method_list,field,row,label_title,label_x,label_y)
box('on');
hold('all');

for i= 1:length(method_list)
    plot(noise_levels,method_list(i).(field)(row,:),'marker',method_list(i).marker,...
        'color',method_list(i).color,...
        'markerfacecolor',method_list(i).markerfacecolor,...
        'displayname',method_list(i).names, ...
        'LineWidth',2,'MarkerSize',8);
end

title(label_title,'FontSize',12,'FontName','Arial');
xlabel(label_x,'FontSize',11);
ylabel(label_y,'FontSize',11);
legend(method_list.names,'Location','NorthWest');
end
