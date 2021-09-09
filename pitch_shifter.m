function new_data = pitch_shifter( data ,sr, ratio )
%���ܣ������������Ƶ���ݱ任Ƶ�ʲ����
%       dataΪ������Ƶ���� 
%       srΪ������Ƶ�Ĳ�����
%       ratioΪ����Ƶ�ʱ任����������ratio>1��ʾ����Ƶ�ʣ�ratio<1��ʾ����Ƶ��
%       new_dataΪ����任�����Ƶ����

win = hamming(128); 
len_win = length(win);
win = [win(len_win/2+1:end);win(1:len_win/2)];%���·�תhamming����Ϊ�������Ӵ���Ƶ�ɷ�����
per_time = 0.1;%ÿһС����Ƶ����ʱ��(s)

total_time = length(ratio)*per_time;%�����Ƶdata����
temp = 0;%��ǰ�任����λ�ñ�����ʼ��Ϊ0
per_sr = per_time*sr;%ÿһ����Ƶ�����ݳ���
time = floor(total_time/per_time);%�ܵ�С����Ƶ����
new_data=zeros(floor(sr*total_time),1);%��ʼ�������Ƶ����

for i = [1:time]
    temp_data = resample(data,floor(ratio(i)*sr),sr);%�ز���
    temp_data1 = [temp_data;temp_data];%�ظ��ز������ݣ���ֹ����λ����ռ��������
    %ƽ�����Ӵ�
    temp_data1(length(temp_data)-100:length(temp_data)+100) = smooth(temp_data1(length(temp_data)-100:length(temp_data)+100));
    %ʹ�ñ任���hamming��ѹ�͸�Ƶ�ɷ�
    temp_data1(length(temp_data)-63:length(temp_data)+64) = temp_data1(length(temp_data)-63:length(temp_data)+64).*win;
    
    new_data((i-1)*per_sr+1:per_sr*i) = temp_data1(ceil(length(temp_data)*temp)+1:per_sr+ceil(length(temp_data)*temp));
    if i ~=1
        new_data((i-1)*per_sr-100:(i-1)*per_sr+100) = smooth(new_data((i-1)*per_sr-100:(i-1)*per_sr+100),'sgolay');
        new_data((i-1)*per_sr-len_win/2+1:(i-1)*per_sr+len_win/2) = new_data((i-1)*per_sr-len_win/2+1:(i-1)*per_sr+len_win/2).*win;
    end
    %���µ�ǰλ����ռ������ע�����ܴ���1
      temp = (per_sr+length(temp_data)*temp)/length(temp_data) - floor((per_sr+length(temp_data)*temp)/length(temp_data));
end

end

