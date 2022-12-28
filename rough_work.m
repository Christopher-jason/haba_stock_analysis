% june_weekend = [2,3,9,10,16,17,23,24,30];
% july_weekend = [1,7,8,14,15,21,22,28,29];
% august_weekend = [4,5,11,12,18,19,25,26];
% while true
%     month = input("Enter month (Jun,Jul,Aug): ","s"); %Input the month you selected to load.
%     date_start = input("Enter start date (watch out for weekend): ","s");  %watch out for dates in a weekend.
%     date_end = input("Enter end date (watch out for weekend): ","s");
%     if month == "Jun"
%         if find(june_weekend == date_start)~=0
%             if find(june_weekend == date_end)~=0
%                 disp("The dates entered are on a weekend");
%             else
%                 disp("The dates are correct");
%             end
%         end
%     end
% end

%load('stk_aug07.mat', 'stk_haba');

%{
month = 'Aug';
date_start = '1';
date_end = '31';

%Have to use traded volume
trade_dt = datestr(stk_haba.trade_date_time);
trade_price = stk_haba.trade_price;
trade_size = stk_haba.trade_size;
average_price = movmean(trade_price,5);
average_size = movmean(trade_size,5);

%% Get 5 day moving average price
%get days start and end indexes
days = zeros(str2double(date_end)-str2double(date_start),3);
for i = str2double(date_start):str2double(date_end)
    if(i<10)
        probe_string = ['0',num2str(i),'-',month,'-2007'];
    else
        probe_string = [num2str(i),'-',month,'-2007'];
    end
    day_index = strmatch(probe_string,trade_dt);
    days(i,1) = i;
    if isempty(day_index)
        days(i,2) = 0;
        days(i,3) = 0;
    else
        days(i,2) = day_index(1);
        days(i,3) = day_index(end);
    end
end


%plot for 5/n days moving  //assumes first 5 which are recorded and does not
%move in a paticular week
[n,~] = size(days);
daycount = 1;
moving_avg = 5;
moving_s = 1;
moving_e = 0;
dt = datetime(trade_dt);
for i = 1:n
    if daycount == moving_avg+1
        plot_moving_average(moving_s,moving_e,trade_price,trade_size,average_price,average_size,dt)
        daycount = 1;
        moving_s = moving_e+1;
    end
    if days(i,2)~=0
        %moving_s = min(moving_s,days(i,2));
        moving_e = max(moving_e,days(i,3));
        daycount = daycount + 1;
    end
    if i==n && daycount < moving_avg
        plot_moving_average(moving_s,moving_e,trade_price,trade_size,average_price,average_size,dt)
    end

end

function probe_price = plot_moving_average(moving_s,moving_e,trade_price,trade_size,average_price,average_size,dt)
    probe_price = trade_price(moving_s:moving_e);
        probe_size = trade_size(moving_s:moving_e);
        probe_avg_price = average_price(moving_s:moving_e);
        probe_avg_size = average_size(moving_s:moving_e);
        rolling_start = datestr(dt(moving_s));
        rolling_end = datestr(dt(moving_e));
        figure('Name', "Price Data from "+rolling_start+" to "+rolling_end);
        subplot(2,2,1)
        plot(probe_price,'r')    
        xlabel('Time')
        ylabel('Price')
        title('Trade Price')
        subplot (2,2,2);
        plot(probe_size,'b', 'LineWidth',2)
        xlabel('Time')
        ylabel('Volume')
        title('Trade Volume')
        subplot(2,2,3)
        plot(probe_avg_price,'r')
        xlabel('Time')
        ylabel('Price')
        title('Average Price')
        subplot(2,2,4)
        plot(probe_avg_size,'b')
        xlabel('Time')
        ylabel('Price')
        title('Average Size')
end
%}


