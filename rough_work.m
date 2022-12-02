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

load('stk_aug07.mat', 'stk_haba');

month = "Aug";
date_start = "1";
date_end = "30";

%Have to use traded volume
trade_date_time = datetime(datestr(stk_haba.trade_date_time));
trade_price = stk_haba.trade_price;
trade_size = stk_haba.trade_size;
probe_start = find(trade_date_time == datetime(date_start+'-'+month+'-2007 08:05:00'));
probe_end = find(trade_date_time == datetime(date_end+'-'+month+'-2007 16:25:00'));
probe_dates = datestr(trade_date_time(probe_start:probe_end));
probe_price = trade_price(probe_start:probe_end);
probe_size = trade_size(probe_start:probe_end);

figure;
plot(probe_price,'r', "lineWidth",2)
plot(probe_size,'b', "lineWidth",2)


