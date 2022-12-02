%% Load data
%%% Remove the '%' in the month you want to work with and run the program

%TODO: - get month and date from user with data validation
month_start = "Aug"; % Enter the month you loaded
month_end = "Aug"; %Enter the month you loaded
date_start = "17";   %watch-out for weekends
date_end = "17";     %watch-out for weekends
%TODO: - Manipulate start and end time as well

 load('stk_aug07.mat', 'stk_haba');
%jun_sdata = load('stk_jun07.mat','stk_haba');
%load('stk_jul07.mat','stk_haba');

%% Process Data

%%%%%%%%%%%%%%%%%%%   Date   %%%%%%%%%%%%%%%%%%%%%%%%
%date = stk_haba.order_book.date_time;  //get data from struct


[probe_start,probe_end,probe_dates,date_time]= getDates(stk_haba,month_start,month_end,date_start,date_end);
probe_prices = getPrices(stk_haba,probe_start,probe_end,month_start,month_end,date_start,date_end);
mid_price = getMidPrice(probe_prices,month_start,month_end,date_start,date_end);
[returns,cum_ret] = getReturn(mid_price,month_start,month_end,date_start,date_end);
[VWAP_bid,VWAP_ask] = getVWAP(stk_haba,date_time);

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
    hour_min_start = "12:35";
    hour_min_end = "13:35";
    probe_start = find(date_time == datetime(date_start+'-'+month_start+'-2007 '+hour_min_start+':00'));
    probe_end = find(date_time == datetime(date_end+'-'+month_end+'-2007 '+hour_min_end+':00'));



    probe_bids_cells = stk_haba.order_book.bids(probe_start:probe_end);
    probe_asks_cells = stk_haba.order_book.asks(probe_start:probe_end);
    [date_range,~] = size(probe_bids_cells);
    i = randsample(date_range,1); %take random instance to do VWAP

    bid_data = cell2mat(probe_bids_cells(i));
    b_val = cumsum(bid_data(:,1).*bid_data(:,2));
    b_vol = cumsum(bid_data(:,2));
    VWAP_bid = b_val./b_vol;
    ask_data = cell2mat(probe_asks_cells(i));
    a_val = cumsum(ask_data(:,1).*ask_data(:,2));
    a_vol = cumsum(ask_data(:,2));
    VWAP_ask = a_val./a_vol;

    figure;
    hold("on")
    y = probe_start+i;
    z = datestr(date_time(y)); 
    plot(b_vol,VWAP_bid,'b','LineWidth',2)
    plot(a_vol,VWAP_ask,'r','LineWidth',2)
    title("Random snapshot at "+z)
    hold("off")
%%%%%%%%%%%%%%%%  All individual intervals within a time frame %%%%%%%%%%%%%%%
 
    for i = 1:date_range   %remove when smaller range is found
        bid_data = cell2mat(probe_bids_cells(i));
        b_val = cumsum(bid_data(:,1).*bid_data(:,2));
        b_vol = cumsum(bid_data(:,2));
        VWAP_bid = b_val./b_vol;
        ask_data = cell2mat(probe_asks_cells(i));
        a_val = cumsum(ask_data(:,1).*ask_data(:,2));
        a_vol = cumsum(ask_data(:,2));
        VWAP_ask = a_val./a_vol;

        figure;
        y = probe_start+i;
        z = datestr(date_time(y));
        hold("on")
        plot(b_vol,VWAP_bid,'b','LineWidth',2)
        plot(a_vol,VWAP_ask,'r','LineWidth',2)
        title("Snapshot at "+z)
        hold("off")
    end


%%%%%%%%%%%%%%% Cumulative of bids and asks in a time-frame %%%%%%%%%%%%%%%

%     [p_size , ~] = size(probe_bids_cells);
%     b_vol_day = zeros(p_size,1);
%     VWAP_bid_day = zeros(p_size,1);
%     a_vol_day = zeros(p_size,1);
%     VWAP_ask_day = zeros(p_size,1);
% 
%     for i = 1:p_size
%         %[probe_bids_i,~] = size(cell2mat(probe_bids_cells(i)));
%         %[probe_asks_i,~] = size(cell2mat(probe_asks_cells(i)));
%         %num_probe = max(probe_asks_i,probe_bids_i);
%         bid_data = cell2mat(probe_bids_cells(i));
%         b_val = sum(bid_data(:,1).*bid_data(:,2));
%         b_vol_day(i) = sum(bid_data(:,2));
%         VWAP_bid_day(i) = b_val./b_vol_day(i);
%         ask_data = cell2mat(probe_asks_cells(i));
%         a_val = sum(ask_data(:,1).*ask_data(:,2));
%         a_vol_day(i) = sum(ask_data(:,2));
%         VWAP_ask_day(i) = a_val./a_vol_day(i);
% 
% %         figure;
% %         hold("on")
% %         plot(b_vol,VWAP_bid,'b','LineWidth',2)
% %         plot(a_vol,VWAP_ask,'r','LineWidth',2)
% %         hold("off")
%     end
%     figure;
%     hold("on")
%     plot(b_vol_day,VWAP_bid_day,'b','LineWidth',2)
%     plot(a_vol_day,VWAP_ask_day,'r','LineWidth',2)
%     hold("off")


    %[n,~] = size(cell2mat(stk_haba.order_book.bids(23)))
end



% cumulative volume / no.of days