%% Laskarit osa 4
% Valokuvan matematiikka 2023
% Elli Kiiski
%
% Tämä skripti löytyy myös osoitteesta
% https://github.com/ellikiiski/Valokuvan-matematiikka-2023/tree/main/Laskarit%20osa%203
% (repositorion nimi muuttunut)

close all;
clear all;

%% TEHTÄVÄ 1

% käytetään pohjana seuraavaa pois kommentoitua
% Samuli Siltasen koodinpätkää
%
% % Illustration of 2D FFT for low-pass and high-pass filtering.
% %
% % Samuli Siltanen Nov 2015
% 
% % Read in the image
% im = imread('BigBen.jpg','jpg');
% im = double(im);
% 
% % Compute the FFT
% imF = fft2(im);
% 
% % Modify the transform (filtering)
% imF2 = fftshift(imF);
% tmp  = imF2;
% tmp(...
%     round(0.4*end):round(0.6*end),...
%     round(0.4*end):round(0.6*end)) = 0;
% imF2 = imF2-tmp;
% imF2 = fftshift(imF2); % Low-pass filtering
% %imF2 = fftshift(tmp); % High-pass filtering
% 
% 
% % Inverse transform
% result = real(ifft2(imF2));
% 
% % Show image and FFT
% figure(1)
% clf
% subplot(1,3,1)
% imagesc(im)
% colormap gray
% axis equal
% axis off
% subplot(1,3,2)
% imagesc(log(abs(fftshift(imF2))))
% colormap gray
% axis equal
% axis off
% subplot(1,3,3)
% imagesc(result)
% colormap gray
% axis equal
% axis off

% A
% muokataan koodia niin että filtteröidäänkin ympyrä
% luetaan ensin kuva
im = imread('kuvat input/BigBen.jpg','jpg');
im = double(im);
% lasketaan FFT
imF = fft2(im);
% luodaan apuhommelit ympyrää varten
[N,M,S] = size(imF);
[X, Y] = meshgrid([-N/2:(N/2-1)]);
R = N/20; % säde
% luodaan ympyräfiltteri
imF2 = fftshift(imF);
tmpA  = imF2;
tmpA(sqrt(X.^2+Y.^2)<R)= 0;
% filtteröidään kuva
imF2A = imF2-tmpA;
imF2A = fftshift(imF2A);
% tehdään käänteismuunnos
result = real(ifft2(imF2A));
% katsellaan alkuperäistä kuvaa, FFT-muunnosfilletriä ja lopputulosta
figure
clf
subplot(1,3,1)
imagesc(im)
colormap gray
axis equal
axis off
subplot(1,3,2)
imagesc(log(abs(fftshift(imF2A))))
colormap gray
axis equal
axis off
subplot(1,3,3)
imagesc(result)
colormap gray
axis equal
axis off

% B
% luodaan kolme "nauha"filtteriä
% ympyröiden säteet
R1 = N/8; 
R2 = N/4;
R3 = N/2;
% filtterit FFT-muunnoksiin
% pikkuympyrä
tmpB1 = imF2;
tmpB1(sqrt(X.^2+Y.^2)<R1 & sqrt(X.^2+Y.^2)>R1/2)= 0;
imF2B1 = imF2-tmpB1;
imF2B1 = fftshift(imF2B1);
% keskikokoinen ympyrä
tmpB2 = imF2;
tmpB2(sqrt(X.^2+Y.^2)<R2 & sqrt(X.^2+Y.^2)>R2/2)= 0;
imF2B2 = imF2-tmpB2;
imF2B2 = fftshift(imF2B2);
% iso ympyrä
tmpB3 = imF2;
tmpB3(sqrt(X.^2+Y.^2)<R3 & sqrt(X.^2+Y.^2)>R3/2)= 0;
imF2B3 = imF2-tmpB3;
imF2B3 = fftshift(imF2B3);
% katsotaan miltä näyttää
figure
clf
subplot(1,3,1)
imagesc(log(abs(fftshift(imF2B1))))
colormap gray
axis equal
axis off
subplot(1,3,2)
imagesc(log(abs(fftshift(imF2B2))))
colormap gray
axis equal
axis off
subplot(1,3,3)
imagesc(log(abs(fftshift(imF2B3))))
colormap gray
axis equal
axis off
% miksköhän noi on noin rakeisia...

% C
% rajataan kuvasta alue jossa on paljon yksityiskohtia
im = imread('kuvat input/BigBen.jpg','jpg');
shiftx = 330;
shifty = 100;
im_small = im(1+shifty:200+shifty,1+shiftx:200+shiftx,:);
im_small = double(im_small);
% copypastetaan koodit yltä
% lasketaan FFT
imF_small = fft2(im_small);
% luodaan apuhommelit ympyrää varten
[n,m,s] = size(imF_small);
[x, y] = meshgrid([-n/2:(n/2-1)]);
% ympyröiden säteet
r1 = n/8;
r2 = n/4;
r3 = n/2;
% filtterit FFT-muunnoksiin
imF2_small = fftshift(imF_small);
% pikkuympyrä
tmpC1 = imF2_small;
tmpC1(sqrt(x.^2+y.^2)<r1 & sqrt(x.^2+y.^2)>r1/2)= 0;
imF2C1 = imF2_small-tmpC1;
imF2C1 = fftshift(imF2C1);
% keskikokoinen ympyrä
tmpC2 = imF2_small;
tmpC2(sqrt(x.^2+y.^2)<r2 & sqrt(x.^2+y.^2)>r2/2)= 0;
imF2C2 = imF2_small-tmpC2;
imF2C2 = fftshift(imF2C2);
% iso ympyrä
tmpC3 = imF2_small;
tmpC3(sqrt(x.^2+y.^2)<r3 & sqrt(x.^2+y.^2)>r3/2)= 0;
imF2C3 = imF2_small-tmpC3;
imF2C3 = fftshift(imF2C3);
% tehdään käänteismuunnokset
result1 = real(ifft2(imF2C1));
result2 = real(ifft2(imF2C2));
result3 = real(ifft2(imF2C3));
% katsellaan alkuperäistä kuvaa, FFT-muunnosfilletreitä ja lopputuloksia
figure
clf
% pikkuympyrä
subplot(3,3,1)
imagesc(im_small)
colormap gray
axis equal
axis off
subplot(3,3,2)
imagesc(log(abs(fftshift(imF2C1))))
colormap gray
axis equal
axis off
subplot(3,3,3)
imagesc(result1)
colormap gray
axis equal
axis off
% keskikokoinen ympyrä
subplot(3,3,4)
imagesc(im_small)
colormap gray
axis equal
axis off
subplot(3,3,5)
imagesc(log(abs(fftshift(imF2C2))))
colormap gray
axis equal
axis off
subplot(3,3,6)
imagesc(result2)
colormap gray
axis equal
axis off
% pikkuympyrä
subplot(3,3,7)
imagesc(im_small)
colormap gray
axis equal
axis off
subplot(3,3,8)
imagesc(log(abs(fftshift(imF2C3))))
colormap gray
axis equal
axis off
subplot(3,3,9)
imagesc(result3)
colormap gray
axis equal
axis off

%% TEHTÄVÄ 2

% ladataan kuva ja luodaan psf kernel
im = imread('kuvat input/BigBen.jpg');
[a,b,c] = size(im)
im_double = double(im);
PSF = [1, 2, 2, 1;
       2, 4, 4, 2;
       2, 4, 4, 2;
       1, 2, 2, 1];
PSF = PSF / sum(PSF(:));

% A
% lasketaan konvoluutio PSF-kernelillä
im1 = conv2(im_double,PSF);
% % katsellaan vierekkäin alkuperäisen kanssa
% figure
% subplot(1,2,1)
% imagesc(im)
% subplot(1,2,2)
% imagesc(im1)
% colormap gray

% B
% lasketaan konvoluutio FFT-muunnoksien kautta
% muokataan ensin PSF-kerneliä saman kokoiseksi
help1 = zeros(a/2-2,b);
help2 = zeros(4,b/2-2);
PSF2 = [help1;
    help2,PSF,help2;
    help1];
im2 = fftshift(ifft2(fft2(im_double).*fft2(PSF2)));
% katsellaan kaikkia vierekkäin
figure
subplot(1,3,1)
imagesc(im)
subplot(1,3,2)
imagesc(im1)
colormap gray
subplot(1,3,3)
imagesc(im2)
colormap gray

%% TEHTÄVÄ 3

% A
% ladataan kuva kuusta
im = imread('kuvat input/lunar2.jpg');
im_double = double(im);
[a,b,c] = size(im)
% luodaan FFT-muunnos
imF = fft2(im_double);
imF2 = fftshift(imF);
% keskipystyakselilta pitäisi saada pisteitä pois
% kokeillaan
mask = imF2;
i = 134;
while i < a-134
    if i > a/2-20 & i < a/2+20
        i = i + 26;
    end
    mask(i:i+4,b/2-2:b/2+2,:) = 0;
    i = i + 19;
end
% tehdään käänteismuunnos
result = real(ifft2(mask));

% C
% tsekataan miten onnistui tämä köykäinen yritelmä
figure
subplot(1,3,1)
imagesc(im_double)
colormap gray
axis equal
axis off
subplot(1,3,2)
imagesc(log(abs((mask))))
colormap gray
axis equal
axis off
subplot(1,3,3)
imagesc(log(abs((result))))
colormap gray
axis equal
axis off

%% TEHTÄVÄ 4

% ladataan taas kuva
im = imread('kuvat input/BigBen.jpg');
im = double(im);

% A
% lasketaan SVD
[U,S,V] = svd(im);

% B
% napataan singulaariarvot
singular_values = diag(S);
% piirretään logaritmiseen asteikkoon
figure;
semilogy(singular_values);
grid on;

% C
% asetetaan ns. lower rank
k = 200;
% laitetaan pineimmät singulaariarvot nollaan
S(k+1:end, k+1:end) = 0;

% D
% kokeillaan eri arvoja k yllä
% rekonstruoidaan kuva
reconstructed_im = U*S*V';
% verrataan kuvia
figure;
subplot(1, 2, 1);
imshow(im, []);
subplot(1, 2, 2);
imshow(reconstructed_im, []);

% E
% lasketaan SSIM
ssim_value = ssim(im, reconstructed_im)

% F
% muutetaan takaisin uint8-muotoon tallentamista varten
reconstructed_im = uint8(U*S*V');
im = uint8(im);
% tallennetaan alkuperäinen kuva sekä rekonstruoitu kuva kumpikin 
% sekä png- että jpg-muodossa
mkdir('kuvat output');
imwrite(im, 'kuvat output/og_lossless.png');
imwrite(reconstructed_im, 'kuvat output/reconstructed_lossless.png');
imwrite(im, 'kuvat output/og_lossy.jpg', 'Quality', 90);
imwrite(reconstructed_im, 'kuvat output/reconstructed_lossy.jpg', 'Quality', 90);
% tsekataan vielä tiedostojen koot
og_lossless_size = dir('kuvat output/og_lossless.png').bytes;
reconstructed_lossless_size = dir('kuvat output/reconstructed_lossless.png').bytes;
og_lossy_size = dir('kuvat output/og_lossy.jpg').bytes;
reconstructed_lossy_size = dir('kuvat output/reconstructed_lossy.jpg').bytes;
% printataan ne jotta voi tarkastella
fprintf('alkuperäinen lossless: %d tavua\n', og_lossless_size);
fprintf('rekonstruoitu lossless: %d tavua\n', reconstructed_lossless_size);
fprintf('alkuperäinen lossy: %d tavua\n', og_lossy_size);
fprintf('rekontruoitu lossy: %d tavua\n', reconstructed_lossy_size);
% meniköhän tää nyt ihan oikein kun toi rekonstruoitu on aina isompi...

%% TEHTÄVÄ 5

% A
% palikan koko
N = 8;
% määritellään koordinaatit
nvec = 0:(N-1);
mvec = 0:(N-1);
[nmat, mmat] = meshgrid(nvec, mvec);

% B
% rakennetaan palikat DCT funktioiden avulla
num_of_blocks = N*N;
blocks = zeros(N,N,num_of_blocks);
for i = 0:(N-1)
    for j = 0:(N-1)
        block = cos(pi*(2*nmat+1)*i/(2*N)).*cos(pi*(2*mmat+1)*j/(2*N));
        blocks(:,:,i*N+j+1)=block;
    end
end
% katsotaan mitä saatiin aikaan
figure
for i = 1:num_of_blocks
    subplot(sqrt(num_of_blocks),sqrt(num_of_blocks),i);
    imshow(blocks(:,:,i),[]);
end
% uijuma!

%% TEHTÄVÄ 6
% BONUS

% A
% tsekataan, että palikat on otrhonormaaleja
M1 = blocks(:,:,8);
M2 = blocks(:,:,24);
sum(sum(M1.*M2)) % on kyllä pirun lähellä nollaa

% B
% keksitään päästä matriisi
B = [8,8,24,24,8,8,33,33;
    1,4,1,2,2,0,1,6;
    -666,69,420,-42,8,8,8,8;
    2,7,0,8,2,0,2,3;
    8,8,8,8,8,8,8,8;
    1,2,3,4,5,6,7,8;
    -9,-8,-7,-6,-5,-4,-2,-1;
    3,1,4,1,5,9,2,6];
% B = ones(8);
% koitetaan tehdä se uudestaan palikoilla
B_new = zeros(size(B));
for i = 1:num_of_blocks
    M = blocks(:, :, i);
    in_prod = sum(sum(B .* M));
    B_new = B_new + in_prod * M;
end
% tästä ei näytä tulevan sama vaikka en kyllä ymmärrä miksi :(((((
