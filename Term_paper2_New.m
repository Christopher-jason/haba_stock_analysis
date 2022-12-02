
%clear all;
load('stk_aug07.mat','stk_haba')

%% ******************************************************************************************************************

%% Calculate and Plot Stock returns 3 days and Find peaks and Troghs
%% ******************************************************************************************************************

startDate = datenum('2007-08-01 8:05:00');
endDate=datenum('2007-08-31 16:25:00');

k = stk_haba.order_book.date_time;
Aug_date_string = datestr(k);
Day_14_sample = datestr(k(910:1010)); %,'HH:MM')
%First5dayaug07 = datestr(k(1:505),'DD:HH:MM');
price =cell2mat(stk_haba.order_book.price);
price_Day_14 = cell2mat(stk_haba.order_book.price(910:1010));

%%  mid price calculation

mid_price=mean(price,2);
%calculate cumulative return
r=[0; diff(log(mid_price))];
cum_r = cumsum(r);
[maxtab, mintab] = peakdet(cum_r,0.0025);

figure
%subplot(221)
hold on; plot(mintab(:,1), mintab(:,2), 'g*');
plot(maxtab(:,1), maxtab(:,2), 'r*' );
plot(cum_r,'b','lineWidth',2);
xlabel('Time')
ylabel ('Cumulative Return(%)')
legend('Trough','Peak','Cumulative Return','Location','Northwest')
title('Peaks and Troughs in 14th August 2007')
%xdate = Day_14_sample;
%datetick('x','HH:MM PM')

%return

mid_price_Day_14 = mean(price_Day_14,2);

%% take log of price and calculate the return
%r=[0; diff(log(mid_price))];
r_Day_14=[diff(log(mid_price_Day_14))];

%% calculate cumulative return
%cum_r = cumsum(r);
cum_r_Day_14 = cumsum(r_Day_14);

%% find the indices of peaks and troghs that are at leastr 25bps in return
%[maxtab, mintab] = peakdet(cum_r, 0.0025);
[maxtab14, mintab14] = peakdet(cum_r_Day_14,0.0025);

figure
%subplot(221)
hold on; plot(mintab14(:,1), mintab14(:,2), 'g*');
plot(maxtab14(:,1), maxtab14(:,2), 'r*' );
plot(cum_r_Day_14,'b','lineWidth',2);
xlabel('Time')
ylabel ('Cumulative Return(%)')
legend('Trough','Peak','Cumulative Return','Location','Northwest')
title('Peaks and Troughs in 14th August 2007')
%xdate = Day_14_sample;
%datetick('x','HH:MM:SS PM')


%% ************************************ 15th August 2007*******************************************************
%% ************************************************************************************************************

%startDate = datenum('2007-08-01 8:05:00');
%endDate=datenum('2007-08-01 16:25:00');

%k = stk_haba.order_book.date_time;
Day_15_sample = datestr(k(1011:1111),'HH:MM');
%price =cell2mat(stk_haba.order_book.price);
price_Day_15 = cell2mat(stk_haba.order_book.price(1011:1111));

%%  mid price calculation
%mid_price=mean(price,2);
mid_price_Day_15 = mean(price_Day_15,2);

%figure
%plot(mid_price_Day_15)

%% take log of price and calculate the return
%r=[0; diff(log(mid_price))];
r_Day_15=[diff(log(mid_price_Day_15))];

%% calculate cumulative return
%cum_r = cumsum(r);
cum_r_Day_15 = cumsum(r_Day_15);

%% find the indices of peaks and troghs that are at leastr 25bps in return
%[maxtab, mintab] = peakdet(cum_r, 0.0025);
[maxtab15, mintab15] = peakdet(cum_r_Day_15,0.0025);

figure
%subplot(222)
hold on; plot(mintab15(:,1), mintab15(:,2), 'g*');
plot(maxtab15(:,1), maxtab15(:,2), 'r*');
plot(cum_r_Day_15,'b','lineWidth',2);
xlabel('Time')
ylabel ('Cumulative Return(%)')
legend('Trough','Peak','Cumulative Return','Location','Northwest')
title('Peaks and Troughs in 15th August 2007')
%xdate= (Day_15_sample)
%datetick('x','HHPM')

%% ************************************ 16th August 2007*******************************************************
%% ************************************************************************************************************

%startDate = datenum('2007-08-01 8:05:00');
%endDate=datenum('2007-08-01 16:25:00');

%k = stk_haba.order_book.date_time;
Day_16_sample = datestr(k(1112:1212),'HH:MM');
%price =cell2mat(stk_haba.order_book.price);
price_Day_16 = cell2mat(stk_haba.order_book.price(1112:1212));

%%  mid price calculation
%mid_price=mean(price,2);
mid_price_Day_16 = mean(price_Day_16,2);

%figure
%plot(mid_price_Day_16)

%% take log of price and calculate the return
%r=[0; diff(log(mid_price))];
r_Day_16=[diff(log(mid_price_Day_16))];

%% calculate cumulative return
%cum_r = cumsum(r);
cum_r_Day_16 = cumsum(r_Day_16);

%% find the indices of peaks and troghs that are at leastr 25bps in return
%[maxtab, mintab] = peakdet(cum_r, 0.0025);
[maxtab16, mintab16] = peakdet(cum_r_Day_16,0.0025);

figure
%subplot (223)
hold on; plot(mintab16(:,1), mintab16(:,2), 'g*');
plot(maxtab16(:,1), maxtab16(:,2), 'r*');
plot(cum_r_Day_16,'b','lineWidth',2);
xlabel('Time')
ylabel ('Cumulative Return(%)')
legend('Trough','Peak','Cumulative Return','Location','Northwest')
title('Peaks and Troughs in 16th August 2007')
%xdate= (Day_16_sample)
%datetick('x','HHPM')


%% ************************************ 14th August 2007*******************************************************
%% ************************************************************************************************************
%% Time Stamp 1 14th August 2007
%% BIDS SIDE
t1=datenum('2007-08-14 11:10:00');
idx1=find(stk_haba.order_book.date_time>=t1,1,'first');
bids1=stk_haba.order_book.bids{947};
tval1=cumsum(bids1(:,1).*bids1(:,2));
tvol1=cumsum(bids1(:,2))
NVWAP1=tval1./tvol1;
figure
subplot(421)
plot(tvol1,NVWAP1, 'r','lineWidth',2);
hold
%% ASKS SIDE
asks1=stk_haba.order_book.asks{947};
tval1=cumsum(asks1(:,1).*asks1(:,2));
tvol1=cumsum(asks1(:,2));
NVWAP1=tval1./tvol1;
subplot(421)
plot(tvol1,NVWAP1, 'b','lineWidth',2);
xlabel('Cumulative Volume')
ylabel ('NVWAP')
legend('birds','asks','Location','Northwest')
title('Start Downtrend 2007-08-14 11:10:00')

hold on;


%% Time Stamp 2 14th August 2007
%% BIDS SIDE
t2=datenum('2007-08-14 12:00:00');
idx2=find(stk_haba.order_book.date_time>=t2,1,'first');
bids2=stk_haba.order_book.bids{idx2};
tval2=cumsum(bids2(:,1).*bids2(:,2));
tvol2=cumsum(bids2(:,2));
NVWAP2=tval2./tvol2;
subplot(422)
plot(tvol2,NVWAP2, 'r','lineWidth',2);
hold
%% ASKS SIDE
asks2=stk_haba.order_book.asks{idx2};
tval2=cumsum(asks2(:,1).*asks2(:,2));
tvol2=cumsum(asks2(:,2));
NVWAP2=tval2./tvol2;
subplot(422)
plot(tvol2,NVWAP2, 'b','lineWidth',2);
xlabel('Cumulative Volume_2')
ylabel ('NVWAP_2')
legend('birds','asks','Location','Northwest')
title('End Downtrend 2007-08-14 12:00:00')
hold on;

%% BIDS SIDE
t2=datenum('2007-08-14 12:00:00');
idx2=find(stk_haba.order_book.date_time>=t2,1,'first');
bids2=stk_haba.order_book.bids{idx2};
tval2=cumsum(bids2(:,1).*bids2(:,2));
tvol2=cumsum(bids2(:,2));
NVWAP2=tval2./tvol2;
subplot(423)
plot(tvol2,NVWAP2, 'r','lineWidth',2);
hold
%% ASKS SIDE
asks2=stk_haba.order_book.asks{idx2};
tval2=cumsum(asks2(:,1).*asks2(:,2));
tvol2=cumsum(asks2(:,2));
NVWAP2=tval2./tvol2;
subplot(423)
plot(tvol2,NVWAP2, 'b','lineWidth',2);
xlabel('Cumulative Volume_2')
ylabel ('NVWAP_2')
legend('birds','asks','Location','Northwest')
title('Start Uptrend 2007-08-14 12:00:00')
hold on;


%% Time Stamp 3 14th August 2007
%% BIDS SIDE
t3=datenum('2007-08-14 12:40:00');
idx3=find(stk_haba.order_book.date_time>=t3,1,'first');
bids3=stk_haba.order_book.bids{idx3};
tval3=cumsum(bids3(:,1).*bids3(:,2));
tvol3=cumsum(bids3(:,2));
NVWAP3=tval3./tvol3;
subplot(424)
plot(tvol3,NVWAP3, 'r','lineWidth',2);
hold
%% ASKS SIDE
asks3=stk_haba.order_book.asks{idx3};
tval3=cumsum(asks3(:,1).*asks3(:,2));
tvol3=cumsum(asks3(:,2));
NVWAP3=tval3./tvol3;
subplot(424)
plot(tvol3,NVWAP3, 'b','lineWidth',2);
xlabel('Cumulative Volume_3')
ylabel ('NVWAP_3')
legend('birds','asks','Location','Northwest')
title('End Uptrend 2007-08-14 12:40:00')

hold on;

%% BIDS SIDE
t3=datenum('2007-08-14 12:40:00');
idx3=find(stk_haba.order_book.date_time>=t3,1,'first');
bids3=stk_haba.order_book.bids{idx3};
tval3=cumsum(bids3(:,1).*bids3(:,2));
tvol3=cumsum(bids3(:,2));
NVWAP3=tval3./tvol3;
subplot(425)
plot(tvol3,NVWAP3, 'r','lineWidth',2);
hold
%% ASKS SIDE
asks3=stk_haba.order_book.asks{idx3};
tval3=cumsum(asks3(:,1).*asks3(:,2));
tvol3=cumsum(asks3(:,2));
NVWAP3=tval3./tvol3;
subplot(425)
plot(tvol3,NVWAP3, 'b','lineWidth',2);
xlabel('Cumulative Volume_3')
ylabel ('NVWAP_3')
legend('birds','asks','Location','Northwest')
title('Start Downtrend 2007-08-14 12:40:00 ')

hold on;


%% Time Stamp 4 14th August 2007
%% BIDS SIDE
t4=datenum('2007-08-14 13:30:00');
idx4=find(stk_haba.order_book.date_time>=t4,1,'first');
bids4=stk_haba.order_book.bids{idx4};
tval4=cumsum(bids4(:,1).*bids4(:,2));
tvol4=cumsum(bids4(:,2));
NVWAP4=tval4./tvol4;
subplot(426)
plot(tvol4,NVWAP4, 'r','lineWidth',2);
hold
%% ASKS SIDE
asks4=stk_haba.order_book.asks{idx4};
tval4=cumsum(asks4(:,1).*asks4(:,2));
tvol4=cumsum(asks4(:,2));
NVWAP4=tval4./tvol4;
subplot(426)
plot(tvol4,NVWAP4, 'b','lineWidth',2);
xlabel('Cumulative Volume_4')
ylabel ('NVWAP_4')
legend('birds','asks','Location','Northwest')
title('End Downtrend 2007-08-14 13:30:00')
hold on

%% BIDS SIDE
t4=datenum('2007-08-14 13:30:00');
idx4=find(stk_haba.order_book.date_time>=t4,1,'first');
bids4=stk_haba.order_book.bids{idx4};
tval4=cumsum(bids4(:,1).*bids4(:,2));
tvol4=cumsum(bids4(:,2));
NVWAP4=tval4./tvol4;
subplot(427)
plot(tvol4,NVWAP4, 'r','lineWidth',2);
hold
%% ASKS SIDE
asks4=stk_haba.order_book.asks{idx4};
tval4=cumsum(asks4(:,1).*asks4(:,2));
tvol4=cumsum(asks4(:,2));
NVWAP4=tval4./tvol4;
subplot(427)
plot(tvol4,NVWAP4, 'b','lineWidth',2);
xlabel('Cumulative Volume_4')
ylabel ('NVWAP_4')
legend('birds','asks','Location','Northwest')
title('Start Uptrend 2007-08-14 13:30:00')
hold on

%% Time Stamp 5 14th August 2007
%% BIDS SIDE
t5=datenum('2007-08-14 14:30:00');
idx5=find(stk_haba.order_book.date_time>=t5,1,'first');
bids5=stk_haba.order_book.bids{idx5};
tval5=cumsum(bids5(:,1).*bids5(:,2));
tvol5=cumsum(bids5(:,2));
NVWAP5=tval5./tvol5;
subplot(428)
plot(tvol5,NVWAP5, 'r','lineWidth',2);
hold
%% ASKS SIDE
asks5=stk_haba.order_book.asks{idx5};
tval5=cumsum(asks5(:,1).*asks5(:,2));
tvol5=cumsum(asks5(:,2));
NVWAP5=tval5./tvol5;
subplot(428)
plot(tvol5,NVWAP5, 'b','lineWidth',2);
xlabel('Cumulative Volume_5')
ylabel ('NVWAP_5')
legend('birds','asks','Location','Northwest')
title('End Uptrend 2007-08-14 14:30:00')

hold on;

%% *********************************************************************************************
%% Time Stamp 1 15th August 2007
 
%% BIDS SIDE
t6=datenum('2007-08-15 10:45:00');
idx6=find(stk_haba.order_book.date_time>=t6,1,'first');
bids6=stk_haba.order_book.bids{idx6};
tval6=cumsum(bids6(:,1).*bids6(:,2));
tvol6=cumsum(bids6(:,2));
NVWAP6=tval6./tvol6;
figure
subplot(421)
plot(tvol6,NVWAP6, 'r','lineWidth',2);
hold
%% ASKS SIDE
asks6=stk_haba.order_book.asks{idx6};
tval6=cumsum(asks6(:,1).*asks6(:,2));
tvol6=cumsum(asks6(:,2));
NVWAP6=tval6./tvol6;
subplot(421)
plot(tvol6,NVWAP6, 'b','lineWidth',2);
xlabel('Cumulative Volume_6')
ylabel ('NVWAP_6')
legend('birds','asks','Location','Northwest')
title('Start Downtrend 2007-08-15 10:45:00')
hold on

%% Time Stamp 2 15th August 2007
%% BIDS SIDE
t7=datenum('2007-08-15 11:30:00');
idx7=find(stk_haba.order_book.date_time>=t7,1,'first');
bids7=stk_haba.order_book.bids{idx7};
tval7=cumsum(bids7(:,1).*bids7(:,2));
tvol7=cumsum(bids7(:,2));
NVWAP7=tval7./tvol7;
subplot(422)
plot(tvol7,NVWAP7, 'r','lineWidth',2);
hold
%% ASKS SIDE
asks7=stk_haba.order_book.asks{idx7};
tval7=cumsum(asks7(:,1).*asks7(:,2));
tvol7=cumsum(asks7(:,2));
NVWAP7=tval7./tvol7;
subplot(422)
plot(tvol7,NVWAP7, 'b','lineWidth',2);
xlabel('Cumulative Volume_7')
ylabel ('NVWAP_7')
legend('birds','asks','Location','Northwest')
title('End Downtrend 2007-08-15 11:30:00 ')

%% %%%%%%%%%%%
%% BIDS SIDE
t7=datenum('2007-08-15 11:30:00');
idx7=find(stk_haba.order_book.date_time>=t7,1,'first');
bids7=stk_haba.order_book.bids{idx7};
tval7=cumsum(bids7(:,1).*bids7(:,2));
tvol7=cumsum(bids7(:,2));
NVWAP7=tval7./tvol7;
subplot(423)
plot(tvol7,NVWAP7, 'r','lineWidth',2);
hold
%% ASKS SIDE
asks7=stk_haba.order_book.asks{idx7};
tval7=cumsum(asks7(:,1).*asks7(:,2));
tvol7=cumsum(asks7(:,2));
NVWAP7=tval7./tvol7;
subplot(423)
plot(tvol7,NVWAP7, 'b','lineWidth',2);
xlabel('Cumulative Volume_7')
ylabel ('NVWAP_7')
legend('birds','asks','Location','Northwest')
title('Start Uptrend 2007-08-15 11:30:00')


%% Time Stamp 3 15th August 2007
%% BIDS SIDE
t8=datenum('2007-08-15 12:55:00');
idx8=find(stk_haba.order_book.date_time>=t8,1,'first');
bids8=stk_haba.order_book.bids{idx8};
tval8=cumsum(bids8(:,1).*bids8(:,2));
tvol8=cumsum(bids8(:,2));
NVWAP8=tval8./tvol8;
subplot(424)
plot(tvol8,NVWAP8, 'r','lineWidth',2);
hold
%% ASKS SIDE
asks8=stk_haba.order_book.asks{idx8};
tval8=cumsum(asks8(:,1).*asks8(:,2));
tvol8=cumsum(asks8(:,2));
NVWAP8=tval8./tvol8;
subplot(424)
plot(tvol8,NVWAP8, 'b','lineWidth',2);
xlabel('Cumulative Volume_8')
ylabel ('NVWAP_8')
legend('birds','asks','Location','Northwest')
title('End Uptrend 2007-08-15 12:55:00 ')

%% BIDS SIDE
t8=datenum('2007-08-15 12:55:00');
idx8=find(stk_haba.order_book.date_time>=t8,1,'first');
bids8=stk_haba.order_book.bids{idx8};
tval8=cumsum(bids8(:,1).*bids8(:,2));
tvol8=cumsum(bids8(:,2));
NVWAP8=tval8./tvol8;
subplot(425)
plot(tvol8,NVWAP8, 'r','lineWidth',2);
hold
%% ASKS SIDE
asks8=stk_haba.order_book.asks{idx8};
tval8=cumsum(asks8(:,1).*asks8(:,2));
tvol8=cumsum(asks8(:,2));
NVWAP8=tval8./tvol8;
subplot(425)
plot(tvol8,NVWAP8, 'b','lineWidth',2);
xlabel('Cumulative Volume_8')
ylabel ('NVWAP_8')
legend('birds','asks','Location','Northwest')
title('Start Downtrend 2007-08-15 12:55:00')

%% Time Stamp 4 15th August 2007
%% BIDS SIDE
t9=datenum('2007-08-15 13:35:00');
idx9=find(stk_haba.order_book.date_time>=t9,1,'first');
bids9=stk_haba.order_book.bids{idx9};
tval9=cumsum(bids9(:,1).*bids9(:,2));
tvol9=cumsum(bids9(:,2));
NVWAP9=tval9./tvol9;
subplot(426)
plot(tvol9,NVWAP9, 'r','lineWidth',2);
hold
%% ASKS SIDE
asks9=stk_haba.order_book.asks{idx9};
tval9=cumsum(asks9(:,1).*asks9(:,2));
tvol9=cumsum(asks9(:,2));
NVWAP9=tval9./tvol9;
subplot(426)
plot(tvol9,NVWAP9, 'b','lineWidth',2);
xlabel('Cumulative Volume_9')
ylabel ('NVWAP_9')
legend('birds','asks','Location','Northwest')
title('End Downtrend 2007-08-15 13:35:00')

%% BIDS SIDE
t9=datenum('2007-08-15 13:35:00');
idx9=find(stk_haba.order_book.date_time>=t9,1,'first');
bids9=stk_haba.order_book.bids{idx9};
tval9=cumsum(bids9(:,1).*bids9(:,2));
tvol9=cumsum(bids9(:,2));
NVWAP9=tval9./tvol9;
subplot(427)
plot(tvol9,NVWAP9, 'r','lineWidth',2);
hold
%% ASKS SIDE
asks9=stk_haba.order_book.asks{idx9};
tval9=cumsum(asks9(:,1).*asks9(:,2));
tvol9=cumsum(asks9(:,2));
NVWAP9=tval9./tvol9;
subplot(427)
plot(tvol9,NVWAP9, 'b','lineWidth',2);
xlabel('Cumulative Volume_9')
ylabel ('NVWAP_9')
legend('birds','asks','Location','Northwest')
title('Start Uptrend 2007-08-15 13:35:00')

%% Time Stamp 5 15th August 2007
%% BIDS SIDE
t10=datenum('2007-08-15 14:10:00');
idx10=find(stk_haba.order_book.date_time>=t10,1,'first');
bids10=stk_haba.order_book.bids{idx10};
tval10=cumsum(bids10(:,1).*bids10(:,2));
tvol10=cumsum(bids10(:,2));
NVWAP10=tval10./tvol10;
subplot(428)
plot(tvol10,NVWAP10, 'r','lineWidth',2);
hold
%% ASKS SIDE
asks10=stk_haba.order_book.asks{idx10};
tval10=cumsum(asks10(:,1).*asks10(:,2));
tvol10=cumsum(asks10(:,2));
NVWAP10=tval10./tvol10;
subplot(428)
plot(tvol10,NVWAP10, 'b','lineWidth',2);
xlabel('Cumulative Volume_10')
ylabel ('NVWAP_10')
legend('birds','asks','Location','Northwest')
title('End Uptrend 2007-08-15 14:10:00')
 
%% BIDS SIDE
t10=datenum('2007-08-15 14:10:00');
idx10=find(stk_haba.order_book.date_time>=t10,1,'first');
bids10=stk_haba.order_book.bids{idx10};
tval10=cumsum(bids10(:,1).*bids10(:,2));
tvol10=cumsum(bids10(:,2));
NVWAP10=tval10./tvol10;
figure
subplot(321)
plot(tvol10,NVWAP10, 'r','lineWidth',2);
hold
%% ASKS SIDE
asks10=stk_haba.order_book.asks{idx10};
tval10=cumsum(asks10(:,1).*asks10(:,2));
tvol10=cumsum(asks10(:,2));
NVWAP10=tval10./tvol10;
subplot(321)
plot(tvol10,NVWAP10, 'b','lineWidth',2);
xlabel('Cumulative Volume_10')
ylabel ('NVWAP_10')
legend('birds','asks','Location','Northwest')
title('Start Downtrend 2007-08-15 14:10:00')

%% Time Stamp 6 15th August 2007
%% BIDS SIDE
t11=datenum('2007-08-15 14:35:00');
idx11=find(stk_haba.order_book.date_time>=t11,1,'first');
bids11=stk_haba.order_book.bids{idx11};
tval11=cumsum(bids11(:,1).*bids11(:,2));
tvol11=cumsum(bids11(:,2));
NVWAP11=tval11./tvol11;
subplot(322)
plot(tvol11,NVWAP11, 'r','lineWidth',2);
hold
%% ASKS SIDE
asks11=stk_haba.order_book.asks{idx11};
tval11=cumsum(asks11(:,1).*asks11(:,2));
tvol11=cumsum(asks11(:,2));
NVWAP11=tval11./tvol11;
subplot(322)
plot(tvol11,NVWAP11, 'b','lineWidth',2);
xlabel('Cumulative Volume')
ylabel ('NVWAP')
legend('birds','asks','Location','Northwest')
title('End Downtrend 2007-08-15 14:35:00')

%% BIDS SIDE
t11=datenum('2007-08-15 14:35:00');
idx11=find(stk_haba.order_book.date_time>=t11,1,'first');
bids11=stk_haba.order_book.bids{idx11};
tval11=cumsum(bids11(:,1).*bids11(:,2));
tvol11=cumsum(bids11(:,2));
NVWAP11=tval11./tvol11;
subplot(323)
plot(tvol11,NVWAP11, 'r','lineWidth',2);
hold
%% ASKS SIDE
asks11=stk_haba.order_book.asks{idx11};
tval11=cumsum(asks11(:,1).*asks11(:,2));
tvol11=cumsum(asks11(:,2));
NVWAP11=tval11./tvol11;
subplot(323)
plot(tvol11,NVWAP11, 'b','lineWidth',2);
xlabel('Cumulative Volume')
ylabel ('NVWAP')
legend('birds','asks','Location','Northwest')
title('Start Uptrend 2007-08-15 14:35:00')


%% Time Stamp 7 15th August 2007
%% BIDS SIDE
t12=datenum('2007-08-15 14:50:00');
idx12=find(stk_haba.order_book.date_time>=t12,1,'first');
bids12=stk_haba.order_book.bids{idx12};
tval12=cumsum(bids12(:,1).*bids12(:,2));
tvol12=cumsum(bids12(:,2));
NVWAP12=tval12./tvol12;
subplot(324)
plot(tvol12,NVWAP12, 'r','lineWidth',2);
hold
%% ASKS SIDE
asks12=stk_haba.order_book.asks{idx12};
tval12=cumsum(asks12(:,1).*asks12(:,2));
tvol12=cumsum(asks12(:,2));
NVWAP12=tval12./tvol12;
subplot(324)
plot(tvol12,NVWAP12, 'b','lineWidth',2);
xlabel('Cumulative Volume')
ylabel ('NVWAP')
legend('birds','asks','Location','Northwest')
title('End Uptrend 2007-08-15 14:50:00')


%% BIDS SIDE
t12=datenum('2007-08-15 14:50:00');
idx12=find(stk_haba.order_book.date_time>=t12,1,'first');
bids12=stk_haba.order_book.bids{idx12};
tval12=cumsum(bids12(:,1).*bids12(:,2));
tvol12=cumsum(bids12(:,2));
NVWAP12=tval12./tvol12;
subplot(325)
plot(tvol12,NVWAP12, 'r','lineWidth',2);
hold
%% ASKS SIDE
asks12=stk_haba.order_book.asks{idx12};
tval12=cumsum(asks12(:,1).*asks12(:,2));
tvol12=cumsum(asks12(:,2));
NVWAP12=tval12./tvol12;
subplot(325)
plot(tvol12,NVWAP12, 'b','lineWidth',2);
xlabel('Cumulative Volume')
ylabel ('NVWAP')
legend('birds','asks','Location','Northwest')
title('Start Downtrend 2007-08-15 14:50:00')

%% Time Stamp 8 15th August 2007
%% BIDS SIDE
t13=datenum('2007-08-15 15:05:00');
idx13=find(stk_haba.order_book.date_time>=t13,1,'first');
bids13=stk_haba.order_book.bids{idx13};
tval13=cumsum(bids13(:,1).*bids13(:,2));
tvol13=cumsum(bids13(:,2));
NVWAP13=tval13./tvol13;
subplot(326)
plot(tvol13,NVWAP13, 'r','lineWidth',2);
hold
%% ASKS SIDE
asks13=stk_haba.order_book.asks{idx13};
tval13=cumsum(asks13(:,1).*asks13(:,2));
tvol13=cumsum(asks13(:,2));
NVWAP13=tval13./tvol13;
subplot(326)
plot(tvol13,NVWAP13, 'b','lineWidth',2);
xlabel('Cumulative Volume')
ylabel ('NVWAP')
legend('birds','asks','Location','Northwest')
title('End Downtrend 2007-08-15 15:05:00')

hold on;


%% **********************************************************************************
%% 16 th August 2007
%% **********************************************************************************

%% Time Stamp 1 16th August 2007
%% BIDS SIDE
t17=datenum('2007-08-16 08:55:00');
idx17=find(stk_haba.order_book.date_time>=t17,1,'first');
bids17=stk_haba.order_book.bids{idx17};
tval17=cumsum(bids17(:,1).*bids17(:,2));
tvol17=cumsum(bids17(:,2));
NVWAP17=tval17./tvol17;
figure
subplot(421)
plot(tvol17,NVWAP17, 'r','lineWidth',2);
hold
%% ASKS SIDE
asks17=stk_haba.order_book.asks{idx17};
tval17=cumsum(asks17(:,1).*asks17(:,2));
tvol17=cumsum(asks17(:,2));
NVWAP17=tval17./tvol17;
subplot(421)
plot(tvol17,NVWAP17, 'b','lineWidth',2);
xlabel('Cumulative Volume')
ylabel ('NVWAP')
legend('birds','asks','Location','Northwest')
title('Start Downtrend 2007-08-16 08:55:00')

%% Time Stamp 2 16th August 2007
%% BIDS SIDE
t18=datenum('2007-08-16 10:25:00');
idx18=find(stk_haba.order_book.date_time>=t18,1,'first');
bids18=stk_haba.order_book.bids{idx18};
tval18=cumsum(bids18(:,1).*bids18(:,2));
tvol18=cumsum(bids18(:,2));
NVWAP18=tval18./tvol18;
subplot(422)
plot(tvol18,NVWAP18, 'r','lineWidth',2);
hold
%% ASKS SIDE
asks18=stk_haba.order_book.asks{idx18};
tval18=cumsum(asks18(:,1).*asks18(:,2));
tvol18=cumsum(asks18(:,2));
NVWAP18=tval18./tvol18;
subplot(422)
plot(tvol18,NVWAP18, 'b');
xlabel('Cumulative Volume')
ylabel ('NVWAP')
legend('birds','asks','Location','Northwest')
title('End Downtrend 2007-08-16 10:25:00')


%% BIDS SIDE
t18=datenum('2007-08-16 10:25:00');
idx18=find(stk_haba.order_book.date_time>=t18,1,'first');
bids18=stk_haba.order_book.bids{idx18};
tval18=cumsum(bids18(:,1).*bids18(:,2));
tvol18=cumsum(bids18(:,2));
NVWAP18=tval18./tvol18;
subplot(423)
plot(tvol18,NVWAP18, 'r','lineWidth',2);
hold
%% ASKS SIDE
asks18=stk_haba.order_book.asks{idx18};
tval18=cumsum(asks18(:,1).*asks18(:,2));
tvol18=cumsum(asks18(:,2));
NVWAP18=tval18./tvol18;
subplot(423)
plot(tvol18,NVWAP18, 'b','lineWidth',2);
xlabel('Cumulative Volume')
ylabel ('NVWAP')
legend('birds','asks','Location','Northwest')
title('Start Uptrend 2007-08-16 10:25:00')

%% Time Stamp 3 16th August 2007
%% BIDS SIDE
t19=datenum('2007-08-16 11:05:00');
idx19=find(stk_haba.order_book.date_time>=t19,1,'first');
bids19=stk_haba.order_book.bids{idx19};
tval19=cumsum(bids19(:,1).*bids19(:,2));
tvol19=cumsum(bids19(:,2));
NVWAP19=tval19./tvol19;
subplot(424)
plot(tvol19,NVWAP19, 'r','lineWidth',2);
hold
%% ASKS SIDE
asks19=stk_haba.order_book.asks{idx19};
tval19=cumsum(asks19(:,1).*asks19(:,2));
tvol19=cumsum(asks19(:,2));
NVWAP19=tval19./tvol19;
subplot(424)
plot(tvol19,NVWAP19, 'b','lineWidth',2);
xlabel('Cumulative Volume')
ylabel ('NVWAP')
legend('birds','asks','Location','Northwest')
title('End Uptrend 2007-08-16 11:05:00')


%% BIDS SIDE
t19=datenum('2007-08-16 11:05:00');
idx19=find(stk_haba.order_book.date_time>=t19,1,'first');
bids19=stk_haba.order_book.bids{idx19};
tval19=cumsum(bids19(:,1).*bids19(:,2));
tvol19=cumsum(bids19(:,2));
NVWAP19=tval19./tvol19;
subplot(425)
plot(tvol19,NVWAP19, 'r','lineWidth',2);
hold
%% ASKS SIDE
asks19=stk_haba.order_book.asks{idx19};
tval19=cumsum(asks19(:,1).*asks19(:,2));
tvol19=cumsum(asks19(:,2));
NVWAP19=tval19./tvol19;
subplot(425)
plot(tvol19,NVWAP19, 'b','lineWidth',2);
xlabel('Cumulative Volume')
ylabel ('NVWAP')
legend('birds','asks','Location','Northwest')
title('Start Downtrend 2007-08-16 11:05:00')


%% Time Stamp 4 16th August 2007
%% BIDS SIDE
t20=datenum('2007-08-16 11:35:00');
idx20=find(stk_haba.order_book.date_time>=t20,1,'first');
bids20=stk_haba.order_book.bids{idx20};
tval20=cumsum(bids20(:,1).*bids20(:,2));
tvol20=cumsum(bids20(:,2));
NVWAP20=tval20./tvol20;
subplot(426)
plot(tvol20,NVWAP20, 'r','lineWidth',2);
hold
%% ASKS SIDE
asks20=stk_haba.order_book.asks{idx20};
tval20=cumsum(asks20(:,1).*asks20(:,2));
tvol20=cumsum(asks20(:,2));
NVWAP20=tval20./tvol20;
subplot(426)
plot(tvol20,NVWAP20, 'b','lineWidth',2);
xlabel('Cumulative Volume')
ylabel ('NVWAP')
legend('birds','asks','Location','Northwest')
title('End Downtrend 2007-08-16 11:35:00')
 

%% BIDS SIDE
t20=datenum('2007-08-16 11:35:00');
idx20=find(stk_haba.order_book.date_time>=t20,1,'first');
bids20=stk_haba.order_book.bids{idx20};
tval20=cumsum(bids20(:,1).*bids20(:,2));
tvol20=cumsum(bids20(:,2));
NVWAP20=tval20./tvol20;
subplot(427)
plot(tvol20,NVWAP20, 'r','lineWidth',2);
hold
%% ASKS SIDE
asks20=stk_haba.order_book.asks{idx20};
tval20=cumsum(asks20(:,1).*asks20(:,2));
tvol20=cumsum(asks20(:,2));
NVWAP20=tval20./tvol20;
subplot(427)
plot(tvol20,NVWAP20, 'b','lineWidth',2);
xlabel('Cumulative Volume')
ylabel ('NVWAP')
legend('birds','asks','Location','Northwest')
title('Start Uptrend 2007-08-16 11:35:00')

%% Time Stamp 5 16th August 2007
%% BIDS SIDE
t21=datenum('2007-08-16 11:55:00');
idx21=find(stk_haba.order_book.date_time>=t21,1,'first');
bids21=stk_haba.order_book.bids{idx21};
tval21=cumsum(bids21(:,1).*bids21(:,2));
tvol21=cumsum(bids21(:,2));
NVWAP21=tval21./tvol21;
subplot(428)
plot(tvol21,NVWAP21, 'r','lineWidth',2);
hold
%% ASKS SIDE
asks21=stk_haba.order_book.asks{idx21};
tval21=cumsum(asks21(:,1).*asks21(:,2));
tvol21=cumsum(asks21(:,2));
NVWAP21=tval21./tvol21;
subplot(428)
plot(tvol21,NVWAP21, 'b','lineWidth',2);
xlabel('Cumulative Volume')
ylabel ('NVWAP')
legend('birds','asks','Location','Northwest')
title('End Uptrend 2007-08-16 11:55:00')

%% BIDS SIDE
t21=datenum('2007-08-16 11:55:00');
idx21=find(stk_haba.order_book.date_time>=t21,1,'first');
bids21=stk_haba.order_book.bids{idx21};
tval21=cumsum(bids21(:,1).*bids21(:,2));
tvol21=cumsum(bids21(:,2));
NVWAP21=tval21./tvol21;
figure
subplot(421)
plot(tvol21,NVWAP21, 'r','lineWidth',2);
hold
%% ASKS SIDE
asks21=stk_haba.order_book.asks{idx21};
tval21=cumsum(asks21(:,1).*asks21(:,2));
tvol21=cumsum(asks21(:,2));
NVWAP21=tval21./tvol21;
subplot(421)
plot(tvol21,NVWAP21, 'b','lineWidth',2);
xlabel('Cumulative Volume')
ylabel ('NVWAP')
legend('birds','asks','Location','Northwest')
title('Start Downtrend 2007-08-16 11:55:00')

%% Time Stamp 6 16th August 2007
%% BIDS SIDE
t22=datenum('2007-08-16 12:50:00');
idx22=find(stk_haba.order_book.date_time>=t22,1,'first');
bids22=stk_haba.order_book.bids{idx22};
tval22=cumsum(bids22(:,1).*bids22(:,2));
tvol22=cumsum(bids22(:,2));
NVWAP22=tval22./tvol22;
subplot(422)
plot(tvol22,NVWAP22, 'r','lineWidth',2);
hold
%% ASKS SIDE
asks22=stk_haba.order_book.asks{idx22};
tval22=cumsum(asks22(:,1).*asks22(:,2));
tvol22=cumsum(asks22(:,2));
NVWAP22=tval22./tvol22;
subplot(422)
plot(tvol22,NVWAP22, 'b','lineWidth',2);
xlabel('Cumulative Volume')
ylabel ('NVWAP')
legend('birds','asks','Location','Northwest')
title('End Downtrend 2007-08-16 12:50:00')

%% BIDS SIDE
t22=datenum('2007-08-16 12:50:00');
idx22=find(stk_haba.order_book.date_time>=t22,1,'first');
bids22=stk_haba.order_book.bids{idx22};
tval22=cumsum(bids22(:,1).*bids22(:,2));
tvol22=cumsum(bids22(:,2));
NVWAP22=tval22./tvol22;
subplot(423)
plot(tvol22,NVWAP22, 'r','lineWidth',2);
hold
%% ASKS SIDE
asks22=stk_haba.order_book.asks{idx22};
tval22=cumsum(asks22(:,1).*asks22(:,2));
tvol22=cumsum(asks22(:,2));
NVWAP22=tval22./tvol22;
subplot(423)
plot(tvol22,NVWAP22, 'b','lineWidth',2);
xlabel('Cumulative Volume')
ylabel ('NVWAP')
legend('birds','asks','Location','Northwest')
title('Start Uptrend 2007-08-16 12:50:00')

%% Time Stamp 7 16th August 2007
%% BIDS SIDE
t23=datenum('2007-08-16 14:40:00');
idx23=find(stk_haba.order_book.date_time>=t23,1,'first');
bids23=stk_haba.order_book.bids{idx23};
tval23=cumsum(bids23(:,1).*bids23(:,2));
tvol23=cumsum(bids23(:,2));
NVWAP23=tval23./tvol23;
subplot(424)
plot(tvol23,NVWAP23, 'r','lineWidth',2);
hold
%% ASKS SIDE
asks23=stk_haba.order_book.asks{idx23};
tval23=cumsum(asks23(:,1).*asks23(:,2));
tvol23=cumsum(asks23(:,2));
NVWAP23=tval23./tvol23;
subplot(424)
plot(tvol23,NVWAP23, 'b','lineWidth',2);
xlabel('Cumulative Volume')
ylabel ('NVWAP')
legend('birds','asks','Location','Northwest')
title('End Uptrend 2007-08-16 14:40:00 ')

%% BIDS SIDE
t23=datenum('2007-08-16 14:40:00');
idx23=find(stk_haba.order_book.date_time>=t23,1,'first');
bids23=stk_haba.order_book.bids{idx23};
tval23=cumsum(bids23(:,1).*bids23(:,2));
tvol23=cumsum(bids23(:,2));
NVWAP23=tval23./tvol23;
subplot(425)
plot(tvol23,NVWAP23, 'r','lineWidth',2);
hold
%% ASKS SIDE
asks23=stk_haba.order_book.asks{idx23};
tval23=cumsum(asks23(:,1).*asks23(:,2));
tvol23=cumsum(asks23(:,2));
NVWAP23=tval23./tvol23;
subplot(425)
plot(tvol23,NVWAP23, 'b','lineWidth',2);
xlabel('Cumulative Volume')
ylabel ('NVWAP')
legend('birds','asks','Location','Northwest')
title('Start Downtrend 2007-08-16 14:40:00')


%% Time Stamp 8 16th August 2007
%% BIDS SIDE
t24=datenum('2007-08-16 15:30:00');
idx24=find(stk_haba.order_book.date_time>=t24,1,'first');
bids24=stk_haba.order_book.bids{idx24};
tval24=cumsum(bids24(:,1).*bids24(:,2));
tvol24=cumsum(bids24(:,2));
NVWAP24=tval24./tvol24;
subplot(426)
plot(tvol24,NVWAP24, 'r','lineWidth',2);
hold
%% ASKS SIDE
asks24=stk_haba.order_book.asks{idx24};
tval24=cumsum(asks24(:,1).*asks24(:,2));
tvol24=cumsum(asks24(:,2));
NVWAP24=tval24./tvol24;
subplot(426)
plot(tvol24,NVWAP24, 'b','lineWidth',2);
xlabel('Cumulative Volume')
ylabel ('NVWAP')
legend('birds','asks','Location','Northwest')
title('End Downtrend 2007-08-16 15:30:00')

%% BIDS SIDE
t24=datenum('2007-08-16 15:30:00');
idx24=find(stk_haba.order_book.date_time>=t24,1,'first');
bids24=stk_haba.order_book.bids{idx24};
tval24=cumsum(bids24(:,1).*bids24(:,2));
tvol24=cumsum(bids24(:,2));
NVWAP24=tval24./tvol24;
subplot(427)
plot(tvol24,NVWAP24, 'r','lineWidth',2);
hold
%% ASKS SIDE
asks24=stk_haba.order_book.asks{idx24};
tval24=cumsum(asks24(:,1).*asks24(:,2));
tvol24=cumsum(asks24(:,2));
NVWAP24=tval24./tvol24;
subplot(427)
plot(tvol24,NVWAP24, 'b','lineWidth',2);
xlabel('Cumulative Volume')
ylabel ('NVWAP')
legend('birds','asks','Location','Northwest')
title('Start Uptrend 2007-08-16 15:30:00')

%% Time Stamp 9 16th August 2007
%% BIDS SIDE
t25=datenum('2007-08-16 16:05:00');
idx25=find(stk_haba.order_book.date_time>=t25,1,'first');
bids25=stk_haba.order_book.bids{idx25};
tval25=cumsum(bids25(:,1).*bids25(:,2));
tvol25=cumsum(bids25(:,2));
NVWAP25=tval25./tvol25;
subplot(428)
plot(tvol25,NVWAP25, 'r','lineWidth',2);
hold
%% ASKS SIDE
asks25=stk_haba.order_book.asks{idx25};
tval25=cumsum(asks25(:,1).*asks25(:,2));
tvol25=cumsum(asks25(:,2));
NVWAP25=tval25./tvol25;
subplot(428)
plot(tvol25,NVWAP25, 'b','lineWidth',2);
xlabel('Cumulative Volume')
ylabel ('NVWAP')
legend('birds','asks','Location','Northwest')
title('End Uptrend 2007-08-16 16:05:00')


%% @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
%% **************************************************************************************
%% **************************************************************************************


%% Find the Index of the timestamp

stock=stk_haba;
order_book = stk_haba.order_book;
n=length(order_book.date_time);
adv=stock.adv;
b0=NaN(n,2);
b1=NaN(n,2);
rsquare=NaN(n,2);
q=NaN(n,2);
min_pos=5;


for k = 1:length(order_book.date_time);
    best_limit = order_book.price{k};
    if numel(best_limit) ~= 0 && best_limit(2) > best_limit(1)
        bid = order_book.bids{k};
        ask = order_book.asks{k};
        date_time_vec = datevec(order_book.date_time(k,:));
        time = date_time_vec(4) + date_time_vec(5)/60;
         if (~isempty(bid) && ~isempty(ask) && time >= (8+1/60) && time <= 16.5)
            bids_cumvol = cumsum(bid(:,2));
            bids_cumval = cumsum(bid(:,1) .* bid(:,2));
            bids_nvwap = bids_cumval ./ bids_cumvol;
             asks_cumvol = cumsum(ask(:,2));
            asks_cumval = cumsum(ask(:,1) .* ask(:,2));
            asks_nvwap = asks_cumval ./ asks_cumvol;
         
            q(k,:) = [sum(bid(:,2)) sum(ask(:,2))];
            if length(best_limit)==2
                x = bids_cumvol./adv*100;
                y = (bids_nvwap-mean(best_limit))/mean(best_limit)*10000;
                if length(x) >= min_pos
                    try
                        [b,bint,r,rint,gof] = regress(log(-y),[ones(size(x)) (x)]);
                        b0(k,1) = b(1);
                        b1(k,1) = b(2);
                        rsquare(k,1) = gof(1);
                    catch ME
                        ME.message;
                    end
                end
                 x = asks_cumvol./adv*100;
                y = (asks_nvwap-mean(best_limit))/mean(best_limit)*10000;
                if length(x) >= min_pos
                    try
                        [b,bint,r,rint,gof] = regress(log(y),[ones(size(x)) (x)]);
                        b0(k,2) = b(1);
                        b1(k,2) = b(2);
                        rsquare(k,2) = gof(1);
                    catch ME
                        ME.message;
                    end
                end
            end    
        end
    end
end
return


