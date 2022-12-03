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

month = "Aug";
date_start = "1";
date_end = "31";

%Have to use traded volume
trade_date_time = datetime(datestr(stk_haba.trade_date_time));
trade_price = stk_haba.trade_price;
trade_size = stk_haba.trade_size;
probe_start = find(trade_date_time == datetime(date_start+'-'+month+'-2007 08:00:08'));
probe_end = find(trade_date_time == datetime(date_end+'-'+month+'-2007 16:29:58'));
probe_dates = cellstr(datestr(trade_date_time));
%date_plot = categorical(probe_dates);   //Crashes the program
% probe_price = trade_price(probe_start(1):probe_end(end));
% probe_size = trade_size(probe_start(1):probe_end(end));

figure;
subplot (2,1,1);
plot(trade_price,'r')
xlabel('Time')
ylabel('Price')
title('Trade Price')
%set(gca,probe_dates)
%xtickformat('dd-MMM-yyyy HH:MM:SS')
subplot (2,1,2);
plot(trade_size,'b', "lineWidth",2)
xlabel('Time')
ylabel('Volume')
title('Trade Volume')


