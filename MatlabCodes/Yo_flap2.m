% FN = input('enter the excel file name with xtension'); 

% A = [];
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
fps =500;       % frame rate
 for f=1:24
     Ar = xlsread(FN(f,:));


%A low-pass Butterworth filter is applied to each of the first 21 columns of data to remove high-frequency noise:

%calculating wing-vectors and rotation matrices

f_cutoff = 45; % cutoff frequency at least 5 times the WBF
fnorm =f_cutoff/(fps/2);
[b1,a1] = butter(4,fnorm,'low');
for j=1:21
A(:,j) = filtfilt(b1,a1,Ar(:,j));
end

%For each row of data, the code calculates vectors a and b representing wing orientations, normalizes them, 
%and computes the normal vector n. It then constructs a rotation matrix 'M' using these vectors.



%Transforming Data to Wing Coordinate System:
%Using the rotation matrix M, points from the data are transformed into the wing coordinate system. 
%The transformed points are then normalized by the length of vector a.

[r,c] =size(A);
for i=1:r
    % finding the wing axes in the camera frame of reference
    a(i,1:3) = A(i,4:6)-A(i,1:3);   % wing length
    b(i,1:3) = A(i,7:9)-A(i,1:3);
    a(i,4) = sqrt(a(i,1).^2+a(i,2).^2+a(i,3).^2);
    b(i,4) = sqrt(b(i,1).^2+b(i,2).^2+b(i,3).^2);
    a(i,5:7) = a(i,1:3)./a(i,4);
    b(i,5:7) = b(i,1:3)./b(i,4);
    n(i,1:3) = cross(a(i,5:7),b(i,5:7));    % normal to the wing
    n(i,4) = sqrt(n(i,1).^2+n(i,2).^2+n(i,3).^2);
    n(i,5:7) = n(i,1:3)./n(i,4);
    c(i,1:3) = cross(n(i,5:7),a(i,5:7));  % pointing towards the leading edge
    % defining the rotation matrix
    M = [a(i,5:7)
        c(i,1:3)
        n(i,5:7)];
    %rotating points 4-7 to the wing coordinate system
    for j=3:3:12
      W(i,j-2:j)= (M*(A(i,j+7:j+9)'))';
      Wn(i,j-2) = W(i,j-2)./a(i,4);
      Wn(i,j-1) = W(i,j-1)./a(i,4);
      Wn(i,j) = W(i,j)./a(i,4);


    end     % of the j
end    % of the i
% for g=1:12
% Wn(:,g) = W(:,g)./a(:,4);
% end


Res(f).data = Wn;
% Res(f).data = W;
clearvars -except f FN Res fps
end
% plot(W(:,3), 'b')
% hold on
% plot(W(:,9), 'r')
% plot(W(:,12),'k')
% plot(W(:,6), 'g') 

%The transformed and normalized data for each file is stored in the structure Res. After processing each file, 
%intermediate variables are cleared to prepare for the next iteration.

