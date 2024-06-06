%Defining File Names and Frame Ranges:

FN = ['H2_3.xlsx'
    'H2_5.xlsx'
    'H2_7.xlsx'
    'H2_9.xlsx'
    'O2_3.xlsx'
    'O2_5.xlsx'
    'O2_7.xlsx'
    'O2_9.xlsx'
    'V1_3.xlsx'
    'V1_5.xlsx'
    'V1_7.xlsx'
    'V1_9.xlsx'
    'H3_3.xlsx'
    'H3_5.xlsx'
    'H3_7.xlsx'
    'H3_9.xlsx'
    'O3_3.xlsx'
    'O3_5.xlsx'
    'O3_7.xlsx'
    'O3_9.xlsx'
    'V3_3.xlsx'
    'V3_5.xlsx'
    'V3_7.xlsx'
    'V3_9.xlsx'
    ];

fr = [3
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


%Setting Up the Figure:
%Calculating Wing Trajectory:



figure(3)
for i=1:24
    A = xlsread(FN(i,:));
    WT = A(fr(i,1):Efr(i,1),4:6)-A(fr(i,1):Efr(i,1),1:3);
% WT = A(fr(i,1):end,4:6)-A(fr(i,1):end,1:3);

%For each file, it calculates the wing trajectory (WT) by subtracting the coordinates of the base of the wing (columns 1 to 3) 
%from the coordinates of the wing tip (columns 4 to 6) for the specified frame range.



%Calculating the Angle (Theta):
%The angle of the wing trajectory (Tet) is calculated using the atan2 function, which computes the arctangent of the quotient of its arguments. 
%This function considers both the x and y coordinates (WT(:,1) and WT(:,2)) to determine the angle in the plane.

Tet = atan2(WT(:,2),WT(:,1));
    subplot(5,5,i)
    plot(Tet)
    title(strcat('File# ',num2str(i)))
    clearvars -except FN fr i Efr
end

%The angle (Tet) is plotted in a subplot. Each subplot corresponds to one of the 24 files. The subplot layout is a 5x5 grid (with one empty subplot).
%The title of each subplot indicates the file number. After processing each file, intermediate variables are cleared to prepare for the next iteration.
