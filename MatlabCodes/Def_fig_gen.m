load('W_Res.mat')
frame = [3
    23
    30
    1
    14
    43
    1
    15
    21
    18
    8
    18
    6
    10
    22
    13
    4
    40
    9
    30
    30
    45
    16
    11];

Efr = [297
    218
    203
    137
    274
    232
    156
    151
    288
    210
    174
    158
    274
    212
    202
    175
    250
    232
    169
    163
    310
    238
    175
    145
    ];

Lift = [13.296
    13.330
    13.080
    13.732
    14.221
    14.082
    14.42
    13.299
    13.749
    14.118
    13.724
    13.460
    14.100
    13.799
    13.763
    13.417
    13.47
    13.471
    13.944
    13.284
    13.687
    13.632
    13.787
    13.353];
    
Lift = Lift*9.8./1000   %force in [N]
figure(1)
for i =1:12
    A(:,1:12) = Res(i).data(frame(i,1):Efr(i,1),:);
    [r,c] = size(A);
    freq(i,1) = (500.*3)./r;
    t_cap = (1:r)';
    t_cap = 3.*t_cap./r; 
 subplot(3,4,i)
 plot(t_cap,A(:,3), 'r')
 hold on
plot(t_cap,A(:,6), 'g')
plot(t_cap,A(:,9),'b')
plot(t_cap,A(:,12), 'k')
title(strcat(num2str(round(freq(i,1))),'Hz,', ' L =', num2str(Lift(i,1))));
axis([0 3 -0.8 0.7])
clearvars -except i Res frame freq Efr Lift
end
figure(2)
title('Wing2');
 for i=13:24
    A(:,1:12) = Res(i).data(frame(i,1):Efr(i,1),:);
  [r,c] = size(A);
 freq(i,1) = (500.*3)./r;
    t_cap = (1:r)';
    t_cap = 3.*t_cap./r; 
    subplot(3,4,i-12   )
plot(t_cap,A(:,3), 'r')
 hold on
plot(t_cap,A(:,6), 'g')
plot(t_cap,A(:,9),'b')
plot(t_cap,A(:,12), 'k')
title(strcat(num2str(round(freq(i,1))),' Hz,', ' L =', num2str(Lift(i,1))));
axis([0 3 -0.8 0.7])
clearvars -except i Res frame freq Efr Lift
 end
    