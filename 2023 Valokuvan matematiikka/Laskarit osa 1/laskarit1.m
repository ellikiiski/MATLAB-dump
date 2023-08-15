%% Laskarit osa 1
% Valokuvan matematiikka 2023
% Elli Kiiski
%
% Tämä skripti löytyy myös osoitteesta
% https://github.com/ellikiiski/MATLAB-dump/tree/main/2023%20Valokuvan%20matematiikka/Laskarit%20osa%201

clear all;
close all;

%% TEHTÄVÄ 1

% A
% avataan kuva
im = imread('kuvat input/kamui-vaasassa-1.jpg');
% katsotaan kuva
imshow(im)

% B
% luetaan kuvan dimensiot
[row,col,tmp] = size(im);
% tsekataan dimensiot
row % korkeus 960 riviä (pikseliä)
col % leveys 1280 saraketta (pikseliä)

% C
% rajataan kuvasta neliö
% (tehtävänantoa vastoin tallennetaan se uuteen muuttujaan
% seuraavaa tehtävää silmällä pitäen)
imedit = im(:,20:row+19,:);

% D
% suurennetaan kuva 1024x1024 kokoiseksi
imedit = imresize(imedit,[1024,1024]);
% katsotaan taas kuva
imshow(imedit)
% tarkistetaan, että ollaan oikeassa kansiossa
scriptfolder = pwd
% tallennetaan uusi kuva output kansioon
mkdir('kuvat output');
imwrite(imedit,'kuvat output/isoi-kamui-vaasassa.jpg');

%% TEHTÄVÄ 2

% A
% avataan toinen kuva
im2 = imread('kuvat input/kamui-vaasassa-2.jpg');

% B
% valitaan vihreä värikanava molemmista kuvista
green1 = im(:,:,2);
green2 = im2(:,:,2);
% lasketaan/muodostetaan erotuskuva
greendif = im-im2;

% C
% katsotaan erotuskuvaa
imshow(greendif)
% Vastaus kysymykseen:
% Selvästi ihmiset ja kamera ovat liikkuneet, 
% mutta maiseman taivas ja vesi sekä kuvaajan sormi ovat melko ennallaan.
% Tämä siis huomataan siitä, 
% että niissä kohdissa pikselit ovat lähellä mustaa eli arvoa 0.

% haluun vielä tallentaa tän
imwrite(greendif,'kuvat output/taidekamui-vaasassa.jpg');

%% TEHTÄVÄ 3

% A
% muutetaan floating-point hommeliks tää kuva
imd = double(imedit);

% B
% erotellaan eri värikanavat omiksi kuviksi
imR = imd(:,:,1);
imG = imd(:,:,2);
imB = imd(:,:,3);

% C
% pistetään vierekkäin kaikki värikanavat
figure
subplot(1,3,1);
imagesc(imR);
subplot(1,3,2);
imagesc(imG);
subplot(1,3,3);
imagesc(imB);
% onks tää siis tarkoituksella keltasininen?

% D
% valitaan 128x128 pikseliä kustakin värikanavasta
% haravoidaan ensin punakanavasta ellin naama
x1 = 180;
y1 = 360;
elli = imR(y1:y1+127,x1:x1+127,:);
% seuraavaksi viherkanavasta viivin kasvot
x2 = 300;
y2 = 360;
viivi = imG(y2:y2+127,x2:x2+127,:);
% vielä sinikanavasta jennan pärstä
x3 = 440;
y3 = 420;
jenna = imG(y3:y3+127,x3:x3+127,:);
% piirretään taas kuvat
figure
subplot(1,3,1);
imagesc(elli);
subplot(1,3,2);
imagesc(viivi);
subplot(1,3,3);
imagesc(jenna);

% E
% avataan tärähtänyt kuva pikku lunnista
im3 = imread('kuvat input/puffin-shift.png');
% erotellaan eri värikanavat
puffR = im3(:,:,1);
puffG = im3(:,:,2);
puffB = im3(:,:,3);
% koitetaan rajata kustakin väristä 300x300 pikselin osa, 
% jossa lunnin nokka on aivan alakulmassa, 
% jotta saadaan määriteltyä siirtymät
imsize = 300;
x = [388,348,388];
y = [38,38,94];
miniR = puffR(y(1):y(1)+imsize,x(1):x(1)+imsize,:);
miniG = puffG(y(2):y(2)+imsize,x(2):x(2)+imsize,:);
miniB = puffB(y(3):y(3)+imsize,x(3):x(3)+imsize,:);
% saatiin kohdennettua kerrokset
% minimoidaan siirtymät
x = x - min(x) + 1;
y = y - min(y) + 1;
% asetetaan kuvan kooksi sen maksimi
[row,col,tmp] = size(im3);
imsize = min(row,col) - max([x y]);
% rajataan kustakin värikanavasta oikein kohdennettu osa
puffR = puffR(y(1):y(1)+imsize,x(1):x(1)+imsize,:);
puffG = puffG(y(2):y(2)+imsize,x(2):x(2)+imsize,:);
puffB = puffB(y(3):y(3)+imsize,x(3):x(3)+imsize,:);
% yhdistetään värikanavat takaisin kokonaiseksi kuvaksi
puffin = cat(3,puffR,puffG,puffB);
% katsellaan upeaa lopputulosta
figure
imagesc(puffin)
% tallennetaankin se toki vielä
imwrite(puffin,'kuvat output/puffin-straight.png');

%% TEHTÄVÄ 4

% avataan kuva ja rajataan vähän
im4 = imread('kuvat input/provinssi2023.jpg');
im4 = im4(:,180:1140,:);

% A
% tehdään kuvasta mustavalkoinen keskiarvon avulla
bwaverage = im4(:,:,1)*0.333 + im4(:,:,2)*0.333 + im4(:,:,3)*0.333;

% B
% koitetaan seuraavaksi NTSC painotusta eri väreille
bwntsc = im4(:,:,1)*0.299 + im4(:,:,2)*0.587 + im4(:,:,3)*0.114;

% C
% yritetään itse keksiä paremmat kertoimet
% oikeastaan eron huomaa silmällä vain siinä tapauksessa, 
% että sinisen kerrtoin on iso, joten tehdään mieluummin niin
r = 0.123;
g = 0.123;
b = 1-r-g;
bwoma = im4(:,:,1)*r + im4(:,:,2)*g + im4(:,:,3)*b;
% tarkastellaan kolmea eri tapaa vierekkäin
figure
subplot(1,3,1);
imshow(bwaverage);
subplot(1,3,2);
imshow(bwntsc);
subplot(1,3,3);
imshow(bwoma);

%% TEHTÄVÄ 5

% käytetään samaa kuvaa kuin edellisessä tehtävässä
% mutta floating-pointtina
im5 = double(im4);
% normalisoidaan välille 0-1
im5 = rescale(im5);

% A
% muunnetaan RGB-arvot HSV-arvoiksi
im5hsv = rgb2hsv(im5);

% B
% vähän gamma correctionia saturaatio kanavann
H = im5hsv(:,:,1);
S = im5hsv(:,:,2);
V = im5hsv(:,:,3);
Snew = S.^(0.5);
im5hsv = cat(3,H,Snew,V);

% C
% muutetaan takaisin RGBksi
im5new = hsv2rgb(im5hsv);

% D
% verrataan
figure
subplot(1,2,1);
imshow(im5);
subplot(1,2,2);
imshow(im5new);
% hyh tulipa punainen naama kaikille

%% TEHTÄVÄ 6




