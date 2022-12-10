%% Load data
%%% Remove the '%' in the month you want to work with and run the program

%% Get User data
% userd = 1;
% 
% while userd == 1
%     date_start = input("Enter the start date: ");   %watch-out for weekends
%     month_start = input("Enter the start month(Jun/Jul/Aug): ",'s'); % Enter the month you loaded
%     date_end = input("Enter the end date: ");
%     month_end = input("Enter the end month(Jun/Jul/Aug): ",'s'); %Enter the month you loaded
% 
%     if month_start =="Aug"
%         stk_haba = load('stk_aug07.mat', 'stk_haba');
%         userd = 2;
%     elseif month_start == "Jun"
%         stk_haba = load('stk_jun07.mat','stk_haba');
%         userd = 2;
%     elseif month_start == "Jul"
%         stk_haba = load('stk_jul07.mat','stk_haba');
%         userd = 2;
%     else
%         disp("Month entered is wrong")
%     end
% end


% Hard data
%TODO: - get month and date from user with data validation
month_start = "Aug"; % Enter the month you loaded
month_end = "Aug"; %Enter the month you loaded
date_start = "1";   %watch-out for weekends
date_end = "17";     %watch-out for weekends
%TODO: - Manipulate start and end time as well

 load('stk_aug07.mat', 'stk_haba');
%jun_sdata = load('stk_jun07.mat','stk_haba');
%load('stk_jul07.mat','stk_haba');

%% Process Data

[probe_start,probe_end,probe_dates,date_time]= getDates(stk_haba,month_start,month_end,date_start,date_end);
probe_prices = getPrices(stk_haba,probe_start,probe_end,month_start,month_end,date_start,date_end);
mid_price = getMidPrice(probe_prices,month_start,month_end,date_start,date_end);
[returns,cum_ret] = getReturn(mid_price,month_start,month_end,date_start,date_end);
[VWAP_bid,VWAP_ask] = getVWAP(stk_haba,date_time);

%%%%%%%%%%%%%%%%%%%   Date   %%%%%%%%%%%%%%%%%%%%%%%%
%date = stk_haba.order_book.date_time;  //get data from struct

function [probe_start,probe_end,probe_dates,date_time] = getDates(stk_haba,month_start,month_end,date_start,date_end)
    date_time = datetime(datestr(stk_haba.order_book.date_time));
    probe_start = find(date_time == datetime(date_start+'-'+month_start+'-2007 08:05:00'));
    probe_end = find(date_time == datetime(date_end+'-'+month_end+'-2007 16:25:00'));
    probe_dates = (date_time(probe_start : probe_end));
end

%%%%%%%%%%%%%%%%%%%   Price  %%%%%%%%%%%%%%%%%%%%%%%%
%price = cell2mat(stk_haba.order_book.price);   //get price from struct

function probe_prices = getPrices(stk_haba,probe_start,probe_end,month_start,month_end,date_start,date_end)
    probe_prices = cell2mat(stk_haba.order_book.price(probe_start: probe_end));

    %TODO: Check how to display dates on x-axis to show only specific time of day for each day 
    figure; %Price plot
    plot(probe_prices,'lineWidth',2);
    xlim([0,length(probe_prices)])
    xlabel('Date');
    ylabel('Price');
    title('Price for '+ month_start+' '+date_start+' - '+month_end+' '+date_end);
    legend("Bids","Asks");

end

%%%%%%%%%%%%%%%%%%%   Mid-Price   %%%%%%%%%%%%%%%%%%%%%%%%
function mid_price = getMidPrice(probe_prices,month_start,month_end,date_start,date_end)
    mid_price = mean(probe_prices, 2);

    figure; %Mid price plot
    plot(mid_price,'lineWidth',2);
    xlim([0,length(mid_price)])
    xlabel('Date');
    ylabel('Price');
    title('Mid-Price for '+ month_start+' '+date_start+' - '+month_end+' '+date_end);
    legend("Mid Price");
end

%%%%%%%%%%%%%%%%%%%   Returns   %%%%%%%%%%%%%%%%%%%%%%%%
function [returns,cum_ret] = getReturn(mid_price,month_start,month_end,date_start,date_end)

    returns = [0;diff(log(mid_price))];
    ret_skew = skewness(returns);
    ret_kurt = kurtosis(returns);

    figure; %Returns plot
    plot(returns,'r','lineWidth',2);
    hold("on")

    cum_ret = cumsum(returns);
    cum_ret_skew = skewness(cum_ret);
    cum_ret_kurt = kurtosis(cum_ret);

    plot(cum_ret,'b','lineWidth',2);
    xlim([0,length(returns)])
    xlabel('Date');
    ylabel('Price');
    title('Returns for '+ month_start+' '+date_start+' - '+month_end+' '+date_end);
    legend("Return","Cumulative Returns");
    hold("off")
end


%% Volume Weighted Average Price

%Calculate the VWAP for bid price ((cumsum(price * volume))/cumsum(volume))


function [VWAP_bid,VWAP_ask] = getVWAP(stk_haba,date_time)
    
    month_start = "Aug"; 
    month_end = "Aug"; 
    date_start = "17";   
    date_end = "17";
    hour_min_start = "12:00";
    hour_min_end = "13:35";
    probe_start = find(date_time == datetime(date_start+'-'+month_start+'-2007 '+hour_min_start+':00'));
    probe_end = find(date_time == datetime(date_end+'-'+month_end+'-2007 '+hour_min_end+':00'));



    probe_bids_cells = stk_haba.order_book.bids(probe_start:probe_end);
    probe_asks_cells = stk_haba.order_book.asks(probe_start:probe_end);
    [time_range,~] = size(probe_bids_cells);

%%%%%%%%%%%%%%%%  All individual intervals within a time frame %%%%%%%%%%%%%%%
    figure;
    for i = 1:time_range   %remove when smaller range is found
        bid_data = cell2mat(probe_bids_cells(i));
        b_val = cumsum(bid_data(:,1).*bid_data(:,2));
        b_vol = cumsum(bid_data(:,2));
        VWAP_bid = b_val./b_vol;
        ask_data = cell2mat(probe_asks_cells(i));
        a_val = cumsum(ask_data(:,1).*ask_data(:,2));
        a_vol = cumsum(ask_data(:,2));
        VWAP_ask = a_val./a_vol;
        c_sub = 5;
        r_sub = ceil(time_range/c_sub);
        y = probe_start+i;
        z = datestr(date_time(y));
        subplot(r_sub,c_sub,i)
        hold("on")
        plot(b_vol,VWAP_bid,'r','LineWidth',2)
        plot(a_vol,VWAP_ask,'b','LineWidth',2)
        title("Orderbook at "+z)
        hold("off")
    end

end

%% Average Daily Volume
% cumulative volume / no.of days

function ADV = getADV(stk_haba)

    month = "Aug";
    date_start = "1";
    date_end = "30";

    %Have to use traded volume
    %Have to use traded volume
trade_dt = datestr(stk_haba.trade_date_time);
trade_price = stk_haba.trade_price;
trade_size = stk_haba.trade_size;

%% Get 5 day moving average price
%get days start and end indexes
days = zeros(31,3);
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
avg_price = zeros(5,1);
avg_size = zeros(5,1);
for i = 1:n
    if daycount == moving_avg+1
        probe_price = trade_price(moving_s:moving_e);
        probe_size = trade_size(moving_s:moving_e);
        figure;
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
        plot(avg_price,'r')
        xlabel('Time')
        ylabel('Price')
        title('Average Price')
        subplot(2,2,4)
        plot(avg_size,'b')
        xlabel('Time')
        ylabel('Price')
        title('Average Size')
        daycount = 1;
        moving_s = moving_e+1;
    end
    if days(i,2)~=0
        moving_e = max(moving_e,days(i,3));
        avg_price(daycount) = (sum(trade_price(moving_s:moving_e))/daycount);
        avg_size(daycount) = (sum(trade_size(moving_s:moving_e))/daycount);
        daycount = daycount + 1;
    end
end


end






