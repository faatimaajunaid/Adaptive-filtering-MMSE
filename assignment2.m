%inputfile = 'cameraman.tif'; 
%inputfile = 'coins.png'; 
%inputfile = 'moon.tif'; 
inputfile = 'liftingbody.png'; 
A = imread(inputfile);
%A = imread('coins.png');
noise_variance = 1800;
[rows,columns,dim] = size(A);
B=double(A);
for i=1:rows
    for j=1:columns
        B(i,j)=A(i,j)+randn*sqrt(noise_variance);
        if B(i,j)<0
            B(i,j)=0;
        elseif B(i,j)>255
                B(i,j)=255;
        end
          
    end
    end
B=uint8(B);
kernel = 3;
y = floor(kernel/2);
Output=double(B);
for i=y+1:rows-y
    for j=y+1:columns-y
        X = B(i-y:i+y,j-y:j+y);
        X=X(:);
        X=double(X);
        average = mean(X); 
        variance = var(X);
        Output(i,j) = double(B(i,j)) - double(noise_variance)/double(variance) * (double(B(i,j)) - double(average));

        
        
    end
end


Output=uint8(Output);
hold on
figure
imshow(Output)
outstr=strcat('output_noisevariance_',int2str(noise_variance),'_kernel_',int2str(kernel),'_',inputfile);
imwrite(Output,outstr);
title(outstr);

figure
imshow(B)
outstr1=strcat('noisevariance_',int2str(noise_variance),'_',inputfile);
imwrite(B,outstr1);
title(outstr);
hold off

