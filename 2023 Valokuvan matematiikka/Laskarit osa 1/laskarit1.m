%% Laskarit osa 1
% Valokuvan matematiikka 2023
% Elli Kiiski
%
% Tämä skripti löytyy myös osoitteesta
% https://github.com/ellikiiski/MATLAB-dump/tree/main/2023%20Valokuvan%20matematiikka/Laskarit%20osa%201

%% TEHTÄVÄ 1

% A
% avataan kuva
im = imread('kamui-vaasassa.jpg');
% katsotaan kuva
imshow(im)

% B
% luetaan kuvan dimensiot
[row,col,tmp] = size(im)
% tsekataan dimensiot
row % korkeus 960 riviä (pikseliä)
col % leveys 1280 saraketta (pikseliä)

% C
% rajataan kuvasta neliö
% mutta ei ihan vasemmasta reunasta
im = im(:,20:row+19,:);

% D
% suurennetaan kuva 1024x1024 kokoiseksi
im = imresize(im,[1024,1024]);
% katsotaan taas kuva
imshow(im)
% tallennetaan uusi kuva
% ensin pikku temput että menee oikeeseen kansioon
scriptfolder = mfilename('fullpath');
newpic = append(scriptfolder,'-isoi-kamui-vaasassa.jpg');
% tallennetaan uusi kuva
imwrite(im,newpic);
