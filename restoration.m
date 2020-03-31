img = imread('DSC_1114.jpg');

psf = fspecial('motion');
blurred_img = imfilter(img, psf, 'circular');
noise = 0.1*randn(size(img))/20.0;
blurred_img = im2double(blurred_img);
blurred_noisy_img = blurred_img+noise;

np = abs(fftn(noise)).^2;
ncorr = fftshift(real(ifftn(np)));
ip = abs(fftn(blurred_noisy_img));
icorr = fftshift(real(ifftn(ip)));
restored = deconvwnr(blurred_noisy_img, psf, ncorr, icorr);

subplot(2,2,1), imshow(img), title('Original image');
subplot(2,2,2), imshow(blurred_img), title('Blurred image');
subplot(2,2,3), imshow(blurred_noisy_img), title('Blurred and noisy image');
subplot(2,2,4), imshow(restored), title('Restored image');