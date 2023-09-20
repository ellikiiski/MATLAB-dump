%% Laskarit osa 2
% Valokuvan matematiikka 2023
% Elli Kiiski
%
% Tämä skripti löytyy osoitteesta
% https://github.com/ellikiiski/Valokuvan-matematiikka-2023/tree/main/Laskarit%20osa%202

close all;
clear all;

%% TEHTÄVÄ 1

% A
% ladataan kuvat
P1_og = imread('kuvat input/eero-kukkien-kera.jpg');
P2_og = imread('kuvat input/roinaa-meresta.jpg');
% muutetaan mustavalkoiseksi ottamalla vaikka vihree
P1 = P1_og(:,:,2);
P2 = P2_og(:,:,2);
% muutetaan pikselien arvot välille 0-1
P1 = rescale(P1);
P2 = rescale(P2);
% summataan kuvat
Psum = P1 + P2;
% muistetaan normalisoida
Psum = rescale(Psum);
% katsotaan tulos
figure
imshow(Psum)

% B
% alustetaan parit muuttujat
Pblend = Psum;
[N, M, s] = size(Pblend);
x = 0.7;
% käydään kuva läpi pikseli pikseliltä ja lasketaan tulos kaavan mukaan
for i = 1:N
    for j = 1:M
        Pblend(i,j) = x*P1(i,j) + (1-x)*P2(i,j);
    end
end
% katsotaan tulos
figure
imshow(Pblend)
% x:n arvolla 0.5 tulos olisi sama kuin A-kohdassa
% nyt näytetään vähän enemmän eeroa kuin roinaa

%% TEHTÄVÄ 2

% A
% piirretään histogrammeja
% määritellään ensin rajat, otetaan jokainen kokonaisluku erikseen
edges = [0:255];
% punainen histogrammi
figure
histoR = histogram(P1_og(:,:,1),edges);
set(histoR,'FaceColor','r');
set(histoR,'EdgeColor','#A2142F')
% vihreä histogrammi
figure
histoG = histogram(P1_og(:,:,2),edges);
set(histoG,'FaceColor','g');
set(histoG,'EdgeColor','#77AC30')
% sininen histogrammi
figure
histoB = histogram(P1_og(:,:,3),edges);
set(histoB,'FaceColor','b');
set(histoB,'EdgeColor','#4DBEEE')
% piirretään vielä ne samaan kuvaan
% haloo en osaa tehdä muuten ku luoda uusiks samanlaiset eri nimellä
figure
hold on
histoR2 = histogram(P1_og(:,:,1),edges);
set(histoR2,'FaceColor','r');
set(histoR2,'EdgeColor','#A2142F')
histoG2 = histogram(P1_og(:,:,2),edges);
set(histoG2,'FaceColor','g');
set(histoG2,'EdgeColor','#77AC30')
histoB2 = histogram(P1_og(:,:,3),edges);
set(histoB2,'FaceColor','b');
set(histoB2,'EdgeColor','#4DBEEE')
% laitetaan vähän läpinäkyvyyttä niin näkyy erot paremmin
set(histoR2, 'FaceAlpha', 0.1)
set(histoG2, 'FaceAlpha', 0.1)
set(histoB2, 'FaceAlpha', 0.1)
title('värijakama kun oksu-eero ojentaa kukkakimppua')

%% TEHTÄVÄ 3

% A
% luodaan maski ohjeiden mukaan
mask_left = [];
mask_left(1:1024,1:128) = 1;
mask_left(1:1024,256:1024) = 0;
liuku = 255:-1:129;
liuku_double = rescale(liuku);
for i = 1:length(liuku)
    mask_left(1:1024,liuku(end+1-i)) = liuku_double(i);
end

% B
mask_right = 1 - mask_left;

% C
% katsellaan mitä tuli tehtyä
figure
subplot(2,2,1)
imagesc(mask_left)
subplot(2,2,2)
imagesc(mask_right)
subplot(2,2,3)
mesh(mask_left)
subplot(2,2,4)
mesh(mask_right)

%% TEHTÄVÄ 4

% A
% ladataan huonosti valoittunut kuva
K = imread('kuvat input/lago-di-garda.jpg');
K = rescale(K);
Kr = K(:,:,1);
Kg = K(:,:,2);
Kb = K(:,:,3);

% B
% tehdään maskit transpooseista
mask_up  = mask_left.';
mask_lo = mask_right.';

% C
% tehdään tummempi versio kuvasta
gamma_d = 1.8;
Kr_d = Kr(:,:,1).^gamma_d;
Kg_d = Kg(:,:,1).^gamma_d;
Kb_d = Kb(:,:,1).^gamma_d;
K_d = cat(3,Kr_d,Kg_d,Kb_d);
% tehdään vaaleampi versio kuvasta
gamma_b = 0.8;
Kr_b = Kr(:,:,1).^gamma_b;
Kg_b = Kg(:,:,1).^gamma_b;
Kb_b = Kb(:,:,1).^gamma_b;
K_b = cat(3,Kr_b,Kg_b,Kb_b);

% D
% tehdään kuvasta ja maskeista samankokoiset
K_d = K_d(1:960,1:1023,:);
K_b = K_b(1:960,1:1023,:);
mask_up = mask_up(1:960,1:1023,:);
mask_lo = mask_lo(1:960,1:1023,:);
% yhtdistetään kuvat maskin kanssa ja katsotaan
K2 = mask_up.*K_d + mask_lo.*K_b;
figure
imshow(K2)
% en kerkeä nyt alkaa muokkaamaan tuosta parempaa
% toisaalta kuva on niin ylivaloittunut ja siinä on liila värivirhekin
% että en tiedä saisiko sitä mitenkään korjattua

%% TEHTÄVÄ 5

% ladataan kuvat
im_fil = imread('kuvat input/naama_filter.jpg');
im_nof = imread('kuvat input/naama_no_filter.jpg');
% rajataan kuvat
upper = 135;
lower = 707;
im_fil = im_fil(upper:lower,:,:);
im_nof = im_nof(upper:lower,:,:);
% valitaan sopiva pikseli
row = 124;
col = 124;
im_fil(row,col,1)
im_nof(row,col,1)
% normalisoidaan kuvat
im_fil = rescale(im_fil);
im_nof = rescale(im_nof);
% otetaan valitun pikselin väriarvot kummastakin kuvasta
% ensin filtterillinen kuva
pix_f_r = im_fil(row,col,1);
pix_f_g = im_fil(row,col,2);
pix_f_b = im_fil(row,col,3);
% sitten alkuperäisen
pix_n_r = im_nof(row,col,1);
pix_n_g = im_nof(row,col,2);
pix_n_b = im_nof(row,col,3);
% etsitään millä gammalla kussakin värissä alkuperäisestä saadaan
% filtterillinen
gamma_red = log(pix_f_r)/log(pix_n_r)
gamma_green = log(pix_f_g)/log(pix_n_g)
gamma_blue = log(pix_f_b)/log(pix_n_b)
% kokeillaan omakätistä filtteriä
im_own = cat(3,im_nof(:,:,1).^gamma_red,im_nof(:,:,2).^gamma_green,im_nof(:,:,3).^gamma_blue);
% vertaillaan vierekkäin alkuperäistä, instan filtteriä ja omaa filtteriä
figure
subplot(1,3,1)
imshow(im_nof)
subplot(1,3,2)
imshow(im_fil)
subplot(1,3,3)
imshow(im_own)
% selvästi instagramin filtteri käyttää muutakin toiminnallisuutta kuin
% gammakorjausta, koska omalla filtterillä kuvasta on muuttunut
% oikeanlaiseksi vain osa väreistä

%% TEHTÄVÄ 6

% A
% luodaan matriisit
G1 = [-1, 0, 1; -2, 0, 2; -1, 0, 1];
G2 = [-1, -2, -1; 0, 0, 0; 1, 2, 1];

% B
% filtteröidään niillä lisää jo aiemmin filtteröityä kuvaa
im_own_1 = convn(double(im_own),G1,'same');
im_own_2 = convn(double(im_own),G2,'same');

% C
% lasketaan magnitudi
magnitude = sqrt(im_own_1.^2 + im_own_1.^2);

yht = (im_own_1+im_own_2);
figure
subplot(1,2,1)
imshow(im_own)
subplot(1,2,2)
imagesc(yht)
