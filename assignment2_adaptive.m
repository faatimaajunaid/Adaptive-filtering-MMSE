
%inputfile = 'cameraman.tif'; 
%inputfile = 'coins.png'; 
%inputfile = 'moon.tif'; 
inputfile = 'liftingbody.png'; 

A = imread(inputfile);
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
kernel = 9;
threshold = 0.6;
y = floor(kernel/2);
Output=double(B);
for i=y+1:rows-y
    for j=y+1:columns-y
        while true
        X = B(i-y:i+y,j-y:j+y);
        X=X(:);
        X=double(X);
        average = mean(X); 
        variance = var(X);
        if noise_variance/variance >= threshold
            y = floor(kernel/2);
            break;
        end
        
        y=y-1;
        if y==0
            y = floor(kernel/2);
            break;
        end
        
        end
        Output(i,j) = double(B(i,j)) - double(noise_variance)/double(variance) * (double(B(i,j)) - double(average));

        
        
    end
end


Output=uint8(Output);
hold on
figure
imshow(Output)
outstr=strcat('adaptive_output_noisevariance_',int2str(noise_variance),'_kernel_',int2str(kernel),'_threshold_',int2str(threshold),inputfile);
imwrite(Output,outstr);
title(outstr);

figure
imshow(B)
hold off
