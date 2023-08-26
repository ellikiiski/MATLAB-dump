%% Laskarit osa 3
% Valokuvan matematiikka 2023
% Elli Kiiski
%
% Tämä skripti löytyy myös osoitteesta
% https://github.com/ellikiiski/MATLAB-dump/tree/main/2023%20Valokuvan%20matematiikka/Laskarit%20osa%203
% 
% KOMMENTTI: tehtävänannoissa olisi parantamisen varaa,
% aika monesti en vielä tehtävää tehtyänikään ole varma 
% ns. vastasinko kysymykseen
% JA erityisesti jos pitää ladata noita toolboxeja se
% olisi kiva tiedottaa tehtävän alussa

close all;
clear all;

%% TEHTÄVÄ 1

% A
% luodaan shakkilauta
N = 256;
black = zeros(N/8);
white = ones(N/8);
odd_row = [white, black, white, black, white, black, white, black];
even_row = [black, white, black, white, black, white, black, white];
cboard = [odd_row; even_row; odd_row; even_row;
    odd_row; even_row; odd_row; even_row];

% B & D
% lisätään kohinaa
% teen nyt samalla molemmat kohinakuvat
% (näemmä for-luupin käyttö tuli selkärangasta, 
% vaikka varmasti nopeemmin olisi tullut muuten)
cboard_n1 = cboard;
cboard_n2 = cboard;
for i = 1:256
    for j = 1:256
        cboard_n1(i,j) = 0.01*randn+cboard_n1(i,j);
        cboard_n2(i,j) = 0.2*randn+cboard_n2(i,j);
    end
end
% tsekataan kuvat vierekkäin
subplot(1,3,1)
imshow(cboard)
subplot(1,3,2)
imshow(cboard_n1)
subplot(1,3,3)
imshow(cboard_n2)

% C & E
% verrataan suoraan kaikkia histogrammeja
edges = 0:0.001:1;
figure
subplot(1,3,1)
histogram(cboard,edges);
subplot(1,3,2)
histogram(cboard_n1,edges);
subplot(1,3,3)
histogram(cboard_n2,edges);
% huomataan kuinka paljon enemmän arvot vaihtelee kun kohinaa on enemmän

%% TEHTÄVÄ 2

% A, D & E
% käytetään samaa shakkilautaa ja simuloidaan nyt poisson-kohinaa
cboard_p1 = cboard;
cboard_n3 = cboard;
cboard_p2 = cboard;
cboard_n4 = cboard;
for i = 1:256
    for j = 1:256
        cboard_p1(i,j) = poissrnd(100)+cboard_p1(i,j);
        cboard_n3(i,j) = 100*randn+100+cboard_n3(i,j);
        cboard_p2(i,j) = poissrnd(10000)+cboard_p2(i,j);
        cboard_n4(i,j) = 10000*randn+10000+cboard_n4(i,j);
    end
end
% normalisoin nyt nämä kuvat koska muuten näkyy pelkkää valkoista...
% varmaan tein jotain väärin jo mutta koitetaan onnea
cboard_p1 = rescale(cboard_p1);
cboard_n3 = rescale(cboard_n3);
cboard_p2 = rescale(cboard_p2);
cboard_n4 = rescale(cboard_n4);

% B, D & E
% lasketaan kekihajonnat
std(cboard_p1)
std(cboard_n3)

% C, D & E
% katsellaan kohinallisia shakkilautoja
figure
subplot(2,2,1)
imshow(cboard_p1)
title('Poisson \lambda = 100')
subplot(2,2,2)
imshow(cboard_p2)
title('Poisson \lambda = 10000')
subplot(2,2,3)
imshow(cboard_n3)
title('Gaussian \mu = 100, \sigma = 100')
subplot(2,2,4)
imshow(cboard_n4)
title('Gaussian \mu = 10000, \sigma = 10000')
% katsellaan histogrammeja
figure
subplot(1,4,1)
histogram(cboard_p1,edges);
title('Poisson \lambda = 100')
subplot(1,4,2)
histogram(cboard_p2,edges);
title('Poisson \lambda = 10000')
subplot(1,4,3)
histogram(cboard_n3,edges);
title('Gaussian \mu = 100, \sigma = 100')
subplot(1,4,4)
histogram(cboard_n4,edges);
title('Gaussian \mu = 10000, \sigma = 10000')
% saadaan hienot kellokäyrät kaikista kohinoista
% ekassa tosin kaikki arvot eivät ole edustettuna
% en viisti alkaa tekemään syvempää analyysiä
% kun ei ole hajuakaan teinkö edes oikein :D

%% TEHTÄVÄ 3
% tämän ajaminen vie jonkin verran aikaa

% A
% luodaan blurrausmatriisi
msize = 3;
kernel = ones(msize)/msize^2;
% ladataan ja blurrataan kuva
im = imread('kuvat input/golden_gate.jpg');
im = rescale(im);
im_blurr = convn(im,kernel,'same');
im_blurr = rescale(im_blurr);
% koitetaan terävöitystä isolla ja pienellä arvolla amount
amount1 = 100;
amount2 = 0.1;
im_sharp1 = im+im_blurr*amount1;
im_sharp1 = rescale(im_sharp1);
im_sharp2 = im+im_blurr*amount2;
im_sharp2 = rescale(im_sharp2);
% tarkastellaan eroja
figure
subplot(1,2,1)
imshow(im_sharp1)
title('amount = 100')
subplot(1,2,2)
imshow(im_sharp2)
title('amount = 0.1')
% huomataan, että arvolla alle 1 saadaan terävän näköinen kuva

% B
% epäblurrataan blurrattu kuva samaan tapaan ensin blurraamalla sitä lisää
im_doulbe_blurr = convn(im_blurr,kernel,'same');
im_doulbe_blurr = rescale(im_doulbe_blurr);
% käytetään pienempää amount arvoa tarkennukseen
im_back_to_og = im_blurr+im_doulbe_blurr*amount2;
im_back_to_og = rescale(im_back_to_og);
% ei musta kyllä tullut kovin tarkka...

% C
% koitetaan dekonvoluutiota
im_deconv = deconvblind(im_blurr,kernel);
im_deconv = rescale(im_deconv);
% verrataan omin kätösin deblurrattua dekonvoloituun
figure
subplot(1,2,1)
imshow(im_back_to_og)
title('itse terävöity')
subplot(1,2,2)
imshow(im_deconv)
title('deconvblind')
% hmmm deconv tuotti tarkemman mutta tummuusaste meni presiilleen

%% THETÄVÄ 4

% rajataan ensin kuva neliöksi
shift_y = 110;
N = 960;
im_square = im(1+shift_y:N+shift_y,1:N,:);

%A
% luodaan vingentti maski
% okei yritin käyttää meshgrid juttuja,
% mutta en tähän hätään ymmärrä miten helvetissä siihen saa ton liukuvärin, 
% joten turvaudun vanhaan kunnon brute forceen
v_mask = zeros(N);
center = N/2;
r = 300; % sisäympyrän säde (sisäpuolella valkoista)
R = 600; % ulkoympyrän säde (ulkopuolella mustaa)
a = (R-r)/N; % tavallaan kuin liukuvärikerroin
for i = 1:N
    for j = 1:N
        dist_from_center = abs(center-i)^2+abs(center-j)^2;
        if dist_from_center > r^2 && dist_from_center < R^2
            v_mask(i,j) = 1-(dist_from_center-r^2)*a;
        end
    end
end
v_mask = rescale(v_mask);
for i = 1:N
    for j = 1:N
        dist_from_center = abs(center-i)^2+abs(center-j)^2;
        if dist_from_center < r^2
            v_mask(i,j) = 1;
        elseif dist_from_center > R^2
            v_mask(i,j) = 0;
        end
    end
end

% B
% laitetaan vingentti kuvaan
im_v = im_square.*v_mask;
% katsellaan maskia ja kuvaa vierekkäin
figure
subplot(1,2,1)
imshow(v_mask)
subplot(1,2,2)
imshow(im_v)
% yllättävän hyvin onnistui tällä spagettikoodilla

%% TEHTÄVÄ 5

% hitto tuli kiire niin en kerennyt tekemään 
% vaikka vaikutti hauskalta tehtävältä
