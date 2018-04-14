clear;
clc

row = 1292;
col = 964;
head = 180/2;
posX = 400;
posY = 1140;
Length = 150;
stX=posX-Length-1;
stY=posY-Length-1;

fin = fopen('3.raw','r');
I = fread(fin,'uint16=>uint16');

for i = 1:1:8
    if i<=8
        It = I((row*col)*(i-1)+head+1:row*col*i+head);
    elseif (8<i)&&(i<=16)
        It = I((row*col)*(i-1)+head*2+1:row*col*i+head*2);
    end    
    % 归一化，灰度范围为设置到0到255
    ItMax = max(It);
    temp = round(ItMax/256+0.5);
    It = It/temp;
    t = max(It);
    
    %2矩阵元素对256求余
    %It = mod(It,256);
    
    It = uint8(It);
    zt = reshape(It,row,col);
    zt = zt';
    switch i
        case 2 %522nm 左右翻转
            zt = fliplr(zt);
        case 3 %553nm 左右翻转
            %zt = fliplr(zt);
        case 4 %575nm 无
            zt = fliplr(zt);
        case 5 %680nm 180
            zt = fliplr(zt);
            %zt = rot90(zt,2);
        case 6 %723nm 上下
            %zt = flipud(zt);
        case 7 %760nm 180
            %zt = rot90(zt,2);
        case 8 %900nm 上下
            %zt = flipud(zt);  
            zt = fliplr(zt);
        case 10
            zt = fliplr(zt);
    end
    %S(:,:,i) = zt;%将八幅图片存储到S三维数组
    %figure,k = imshow(zt);title(['img',num2str(i)]);% 显示图片
       
    %计算圆心
    Ipart1=zt(posX-Length:posX+Length,posY-Length:posY+Length);
    figure,imshow(Ipart1);title(['img',num2str(i)]);
    hold on;
    Ipart2 = im2bw(Ipart1,0.3);%转为二值
    stats = regionprops(Ipart2,'centroid','MajorAxisLength','MinorAxisLength','Eccentricity');
    centers  = cat(1, stats.Centroid);
    diameters = (cat(1,stats.MajorAxisLength)+cat(1,stats.MinorAxisLength))/2;
    radii = diameters/2;
    YD= cat(1,stats.MinorAxisLength)./cat(1,stats.MajorAxisLength);
    
    YD1=YD(1);
    Xmax=centers(1,2);
    Ymax=centers(1,1);
    
    viscircles(centers(1,:),radii(1),'LineStyle',':','LineWidth',0.2);
    plot(ones(201,1)*posY-stY,((posX-100):(posX+100))-stX,'g-');
    plot(((posY-100):(posY+100))-stY,ones(201,1)*posX-stX,'g-');
    plot(Ymax,Xmax,'r+');
    plot(Ymax,Xmax,'ro');
    
    %     %将坐标打印到控制台
    %     fprintf('X坐标= %d \n',Xmax-posX+stX);
    %     fprintf('Y坐标= %d \n',Ymax-posY+stY);
    %     fprintf('圆度= %d \n',YD1);
    %坐标输入到图片上
    text(2,8,['X:',num2str(Xmax-posX+stX-45.4144)],'Color','red','FontSize',14);
    text(2,27,['Y:',num2str(Ymax-posY+stY-37.1615)],'Color','red','FontSize',14);
    text(2,46,['YD:',num2str(YD1)],'Color','red','FontSize',14);
    
    hold off;
    
    
end
%figure,imshowpair(S(:,:,1),S(:,:,3));title('差异图像');













